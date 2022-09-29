import json
from dataclasses import dataclass
from typing import Iterable

import edgedb
import ifcopenshell
import logging
import toposort

from ifcdb.database.queries import introspect_db
from ifcdb.database.remove import EdgeFilter, EdgeRemove
from ifcdb.database.select import EdgeSelect
from ifcdb.database.utils import clean_name
from ifcdb.entities import Entity
from ifcdb.schema.new_model import DbEntityModel
from ifcdb.utils import change_case


@dataclass
class DbContent:
    db_entity_model: DbEntityModel
    client: edgedb.Client

    def wipe_db(self, delete_in_sequence: bool, max_attempts: int):
        empty = False
        attempt_no = 0
        selects = self._get_selects_for_all_instances(include_props=False)

        while empty is False:
            results = self._query_all_selects(selects)
            instantiated_classes = list(filter(lambda x: len(x) != 0, [getattr(results, s.name) for s in selects]))
            if len(instantiated_classes) == 0:
                print(f"Database is completely wiped")
                return None
            selects.reverse()

            for select in selects:
                rem = EdgeRemove(select)
                remove_str = rem.to_edql_str(embed_select=True, assign_to_variable=False)

                try:
                    self.client.execute(remove_str)
                    print(remove_str)
                except edgedb.ConstraintViolationError as e:
                    logging.info(e)

            attempt_no += 1
            if attempt_no > max_attempts:
                logging.error(f"Unable to wipe database in maximum number of attempts={max_attempts}")
                break

    def get_db_content_as_ifcopenshell_object(self) -> ifcopenshell.file:
        insert_map = dict()
        f = ifcopenshell.file(schema=self.db_entity_model.config.ifc_schema_version)
        for entity in self.perform_query_and_iterate_entities():
            links = {}
            for key, value in entity.links.items():
                if isinstance(value, (tuple, list)):
                    if len(value) == 0:
                        links[key] = None
                    else:
                        links[key] = tuple([insert_map[x.uuid] for x in value])
                else:
                    links[key] = insert_map[value.uuid]

            for key, value in entity.props.items():
                if isinstance(value, (tuple, list)):
                    if len(value) == 0:
                        entity.props[key] = None

            wrapped_value = entity.props.get(entity.name)
            if wrapped_value is not None:
                insert_map[entity.uuid] = f.create_entity(entity.name, wrapped_value)
            else:
                insert_map[entity.uuid] = f.create_entity(entity.name, **entity.props, **links)

        return f

    def perform_query_and_iterate_entities(self) -> Iterable[Entity]:
        selects = self._get_selects_for_all_instances(include_props=True)
        results = self._query_all_selects(selects)

        class_types_map = {x.name: x.entity_top.name for x in selects}
        uuid_map = dict()
        for select_name, class_name in class_types_map.items():
            db_entity = self.db_entity_model.entities.get(class_name)
            result = getattr(results, select_name)
            if len(result) == 0:
                continue
            for instance in result:
                uuid = str(instance.id)
                props = {pkey: getattr(instance, pkey) for pkey in db_entity.get_all_props(skip_links=True).keys()}
                links = dict()
                for lkey in db_entity.get_all_props(skip_props=True).keys():
                    link_obj = getattr(instance, lkey)
                    if link_obj is None:
                        continue
                    if isinstance(link_obj, edgedb.Set):
                        links[lkey] = [str(set_obj.id) for set_obj in link_obj]
                    else:
                        links[lkey] = str(link_obj.id)
                uuid_map[uuid] = Entity(class_name, props=props, links=links, uuid=uuid)

        dep_map = dict()
        for key, entity in uuid_map.items():
            refs = []
            for link_ref in entity.links.values():
                if isinstance(link_ref, (list, tuple)):
                    for r in link_ref:
                        if isinstance(r, str) is False:
                            raise ValueError("")
                        refs.append(r)

                else:
                    refs.append(link_ref)
            dep_map[key] = refs

        # Substitute uuid string in link dict with Entity
        for entity in uuid_map.values():
            if len(entity.links) == 0:
                continue
            updated_links = dict()
            for key, uuid in entity.links.items():
                if isinstance(uuid, list):
                    updated_links[key] = tuple([uuid_map[u] for u in uuid])
                else:
                    updated_links[key] = uuid_map[uuid]
            entity.links = updated_links

        for uuid in toposort.toposort_flatten(dep_map):
            yield uuid_map[uuid]

    def get_db_instance_types(self) -> list[str]:
        class_types = []
        for r in filter(lambda x: x["abstract"] is False, self._query_all_class_types()):
            name = clean_name(r, self.db_entity_model.config.module_name)
            if name not in class_types:
                class_types.append(name)

        db_entities = filter(lambda x: x.name in class_types, self.db_entity_model.get_entities_in_insert_order(True))
        sorted_order = [x.name for x in db_entities]

        return sorted_order

    def _get_selects_for_all_instances(self, include_props=False):
        class_types = self.get_db_instance_types()
        return [self._get_select_from_class_type(ct, include_props) for ct in class_types]

    def _get_select_from_class_type(self, class_type: str, include_all_props=False) -> EdgeSelect:
        db_entity = self.db_entity_model.entities.get(class_type)
        props = None
        if include_all_props:
            props = ["id"] + list(db_entity.get_all_props().keys())
        return EdgeSelect(change_case(class_type), Entity(class_type, db_entity=db_entity), entity_props=props)

    def _query_all_selects(self, selects: list[EdgeSelect], return_only_non_empty=True) -> edgedb.Object:
        query_str = "SELECT {\n"
        for select in selects:
            query_str += select.to_edql_str(assign_to_variable=True, sep=",\n")
        query_str += "}"
        return self.client.query_single(query_str)

    def _query_all_class_types(self) -> dict:
        query_str = introspect_db(self.db_entity_model.config.module_name)
        return json.loads(self.client.query_json(query_str))

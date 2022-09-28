import json
from dataclasses import dataclass
from typing import Iterable

import edgedb
import ifcopenshell
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
        selects = self._get_selects_for_all_instances(include_all_props=False)
        class_types_map = {x.name: x.entity_top.name for x in selects}
        query_str = "SELECT {" + "".join((s.to_edql_str(assign_to_variable=True, sep=",\n") for s in selects)) + "}"
        class_instances = json.loads(self.client.query_single_json(query_str))
        removes = dict()
        for ref_name, instances in class_instances.items():
            if len(instances) == 0:
                continue
            class_name = class_types_map[ref_name]
            if class_name not in removes.keys():
                removes[class_name] = []

            for instance in instances:
                removes[class_name].append(self._get_edgeremove_from_class_type(class_name, instance.get("id")))

        print("do deletion here")

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
        selects = self._get_selects_for_all_instances(include_all_props=True)

        query_str = "SELECT {\n"
        for select in selects:
            query_str += select.to_edql_str(assign_to_variable=True, sep=",\n")
        query_str += "}"

        resu = self.client.query_single(query_str)

        class_types_map = {x.name: x.entity_top.name for x in selects}
        uuid_map = dict()
        for select_name, class_name in class_types_map.items():
            db_entity = self.db_entity_model.entities.get(class_name)
            result = getattr(resu, select_name)
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

        return class_types

    def get_db_instances(self) -> dict[str, list[str]]:
        instances = dict()

        for r in self._query_all_class_types():
            name = clean_name(r, self.db_entity_model.config.module_name)
            if name not in instances.keys():
                instances[name] = []
            instances[name].append(r["id"])
        return instances

    def _get_selects_for_all_instances(self, include_all_props=False):
        class_types = self.get_db_instance_types()
        return [self._get_select_from_class_type(ct, include_all_props) for ct in class_types]

    def _get_edgeremove_from_class_type(self, class_type: str, uuid: str):
        return EdgeRemove(change_case(class_type), class_type, EdgeFilter("id", uuid, EdgeFilter.TYPES.UUID))

    def _get_select_from_class_type(self, class_type: str, include_all_props=False) -> EdgeSelect:
        db_entity = self.db_entity_model.entities.get(class_type)
        props = ["id"]
        if include_all_props:
            props += list(db_entity.get_all_props().keys())
        return EdgeSelect(change_case(class_type), Entity(class_type, db_entity=db_entity), entity_props=props)

    def _query_all_class_types(self) -> dict:
        query_str = introspect_db(self.db_entity_model.config.module_name)
        return json.loads(self.client.query_json(query_str))

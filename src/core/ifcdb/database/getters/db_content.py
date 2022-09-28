import json
import logging
from dataclasses import dataclass
from typing import Iterable

import edgedb
import ifcopenshell
import toposort

from ifcdb.database.queries import introspect_db
from ifcdb.database.select import EdgeSelect
from ifcdb.database.utils import clean_name
from ifcdb.entities import Entity
from ifcdb.schema.new_model import DbEntityModel
from ifcdb.utils import change_case


@dataclass
class DbContent:
    db_entity_model: DbEntityModel

    def get_db_content_as_ifcopenshell_object(self, client: edgedb.Client) -> ifcopenshell.file:
        insert_map = dict()
        f = ifcopenshell.file(schema=self.db_entity_model.config.ifc_schema_version)
        for entity in self.perform_query_and_iterate_entities(client):
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
            try:
                if wrapped_value is not None:
                    insert_map[entity.uuid] = f.create_entity(entity.name, wrapped_value)
                else:
                    insert_map[entity.uuid] = f.create_entity(entity.name, **entity.props, **links)
            except TypeError as e:
                logging.error(entity)
                raise e

        return f

    def perform_query_and_iterate_entities(self, client) -> Iterable[Entity]:
        class_types = self.get_db_instance_types(client)
        class_types_map = dict()
        query_str = "SELECT {\n"
        for i, select in enumerate(map(self._get_select_from_class_type, class_types)):
            query_str += select.to_edql_str(assign_to_variable=True, sep=",\n")
            class_types_map[select.name] = class_types[i]
        query_str += "}"

        resu = client.query_single(query_str)
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

    def perform_query_json(self, client, query_str, class_types_map) -> dict[str, list[dict]]:
        return {class_types_map[key]: value for key, value in json.loads(client.query_single_json(query_str)).items()}

    def get_db_instance_types(self, client: edgedb.Client) -> list[str]:
        def filter_objects(x):
            if "|" in x:
                return False
            if x["abstract"] is True:
                return False
            return True

        class_types = []

        for r in filter(filter_objects, self._perform_query(client)):
            name = clean_name(r, self.db_entity_model.config.module_name)
            if name not in class_types:
                class_types.append(name)

        return class_types

    def _get_select_from_class_type(self, class_type: str) -> EdgeSelect:
        db_entity = self.db_entity_model.entities.get(class_type)
        props = list(db_entity.get_all_props().keys()) + ["id", ""]
        return EdgeSelect(change_case(class_type), Entity(class_type), entity_props=props)

    def _perform_query(self, client: edgedb.Client) -> dict:
        query_str = introspect_db(self.db_entity_model.config.module_name)
        return json.loads(client.query_json(query_str))


def create_entities_in_insert_order(result: dict) -> Iterable[Entity]:
    id_map = {}
    for ifc_class, instances in result.items():
        for instance in instances:
            uuid = instance.pop("id")
            props = dict()
            links = dict()
            for key, value in instance.items():
                if isinstance(value, dict):
                    links[key] = value.get("id")
                else:
                    props[key] = value

            id_map[uuid] = Entity(ifc_class, props, links, uuid=uuid)

    dep_map = {key: list(value.links.values()) for key, value in id_map.items()}

    # Substitute uuid string in link dict with Entity
    for entity in id_map.values():
        updated_links = dict()
        for key, uuid in entity.links.items():
            updated_links[key] = id_map[uuid]
        entity.links = updated_links

    for uuid in toposort.toposort_flatten(dep_map):
        yield id_map[uuid]

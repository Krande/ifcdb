from __future__ import annotations

from dataclasses import dataclass, field
from itertools import count
from typing import Any, Iterable

import ifcopenshell

from ifcdb.schema.model import ArrayModel, EntityModel, IfcSchemaModel
from ifcdb.utils import change_case

_IFC_ENTITY = ifcopenshell.entity_instance
_INSERT_COUNT = count(1)


def get_entity_from_source_dict(source: dict, schema_ver: str = "IFC4x1") -> Entity:
    er = EntityResolver(schema_ver)
    return er.create_insert_entity_from_ifc_dict(source)


def get_entity_from_source_ifc_elem(item: _IFC_ENTITY, schema_ver: str = "IFC4x1") -> Entity:
    er = EntityResolver(schema_ver)
    return er.create_insert_entity_from_ifc_entity(item)


@dataclass
class EntityResolver:
    ifc_schema: str = None
    specific_ifc_ids: list[int] = None

    uuid_map: dict[_IFC_ENTITY, Entity] = field(default_factory=dict)
    schema_model: IfcSchemaModel = None

    def __post_init__(self):
        if self.schema_model is None:
            self.schema_model = IfcSchemaModel(schema_version=self.ifc_schema)

    def create_insert_entity_from_ifc_entity(self, item: _IFC_ENTITY) -> Entity:
        existing_entity = self.uuid_map.get(item, None)
        if existing_entity is not None:
            return existing_entity

        entity = self.schema_model.get_entity_by_name(item.is_a())
        all_atts = entity.get_entity_atts(item)
        links = dict()
        props = dict()
        for j, att in enumerate(all_atts):
            name = att.name
            att_ref = att.get_type_ref()
            res = getattr(item, name)
            if isinstance(res, _IFC_ENTITY):
                links[name] = self.create_insert_entity_from_ifc_entity(res)
            else:
                if isinstance(att_ref, ArrayModel):
                    ptype = att_ref.parameter_type
                    if isinstance(ptype, EntityModel):
                        result = []
                        for r in res:
                            output = self.create_insert_entity_from_ifc_entity(r)
                            result.append(output)

                        links[name] = tuple(result)
                        continue

                props[name] = res

        return Entity(entity.name, props, links)

    @staticmethod
    def create_insert_entity_from_ifc_dict(source: dict) -> Entity:
        props = dict()
        links = dict()

        class_type = source.pop("type")

        for key, value in source.items():
            if isinstance(value, dict):
                links[key] = EntityResolver.create_insert_entity_from_ifc_dict(value)
            elif isinstance(value, tuple):
                values = []
                contains_linked_items = False
                for val in value:
                    if isinstance(val, dict):
                        contains_linked_items = True
                        values.append(EntityResolver.create_insert_entity_from_ifc_dict(val))
                    else:
                        values.append(val)
                if contains_linked_items:
                    links[key] = tuple(values)
                else:
                    props[key] = tuple(values)
            else:
                props[key] = value

        return Entity(class_type, props, links)

    @staticmethod
    def create_entity_tool_from_ifcopenshell_entity(el: ifcopenshell.entity_instance) -> EntityTool:
        linked_objects: dict[ifcopenshell.entity_instance, Entity] = dict()

        def walk(source) -> Entity | dict | tuple:
            nonlocal linked_objects
            if isinstance(source, ifcopenshell.entity_instance):
                existing_obj = linked_objects.get(source, None)
                if existing_obj is not None:
                    return existing_obj
                info = source.get_info(recursive=False, include_identifier=False)
                props = dict()
                links = dict()
                for key, value in info.items():
                    if key in ("type",):
                        continue
                    if isinstance(value, ifcopenshell.entity_instance):
                        links[key] = walk(value)
                    elif isinstance(value, tuple):
                        res = walk(value)
                        if value_contains_link(res):
                            links[key] = res
                        else:
                            props[key] = res
                    elif isinstance(value, dict):
                        res = walk(value)
                        if value_contains_link(res):
                            links[key] = res
                        else:
                            props[key] = res
                    else:
                        props[key] = value
                new_entity = Entity(source.is_a(), props, links)
                linked_objects[source] = new_entity
                return new_entity
            elif isinstance(source, tuple):
                return tuple([walk(v) for v in source])
            elif isinstance(source, dict):
                return {key: walk(value) for key, value in source.items()}
            elif isinstance(source, (float, str, int)):
                return source
            else:
                raise NotImplementedError(f'Unsupported type "{type(source)}"')

        top_entity = walk(el)
        entity_identifier_map = {x.temp_unique_identifier: x for x in linked_objects.values()}
        return EntityTool(top_entity, entity_identifier_map)


@dataclass
class Entity:
    name: str
    props: dict[str, Any] = field(repr=False, default_factory=dict)
    links: dict[str, Entity | tuple | dict] = field(repr=False, default_factory=dict)
    uuid: str = None
    temp_unique_identifier: str = None

    def __post_init__(self):
        self.temp_unique_identifier = f"{change_case(self.name)}_{next(_INSERT_COUNT)}"


@dataclass
class EntityRef:
    entity: Entity
    parent: Entity | None
    key: str | None


def walk_links(value: Entity | dict | tuple, parent: Entity = None, key: str = None) -> Iterable[EntityRef]:
    if isinstance(value, Entity):
        if parent is not None:
            yield EntityRef(value, parent, key)
        for e in walk_links(value.links, value, key):
            yield e
    elif isinstance(value, dict):
        for skey, svalue in value.items():
            if key is None:
                key_str = skey
            else:
                key_str = f"{key}.{skey}"
            for e in walk_links(svalue, parent, key_str):
                yield e
    elif isinstance(value, tuple):
        for i, v in enumerate(value):
            for e in walk_links(v, parent, f"{key}[{i}]"):
                yield e
    else:
        raise NotImplementedError(f'Unknown link value type "{value}"')


def entity_to_dict(entity: Entity) -> dict:
    new_d = dict(type=entity.name)
    new_d.update(entity.props)
    new_d.update(traverse_dicts(entity.links))
    return new_d


def traverse_tuples(source: tuple) -> tuple:
    output = []
    for value in source:
        if isinstance(value, Entity):
            output.append(entity_to_dict(value))
        elif isinstance(value, dict):
            output.append(traverse_dicts(value))
        else:
            output.append(value)

    return tuple(output)


def traverse_dicts(source: dict):
    new_d = dict()
    for key, value in source.items():
        if isinstance(value, Entity):
            new_d[key] = entity_to_dict(value)
        elif isinstance(value, tuple):
            new_d[key] = traverse_tuples(value)
        else:
            new_d[key] = value

    return new_d


@dataclass
class EntityTool:
    entity: Entity
    linked_objects: dict[str, Entity]


def value_contains_link(source: tuple | dict) -> bool:
    if isinstance(source, tuple):
        for v in source:
            return value_contains_link(v)
    if isinstance(source, dict):
        for key, value in source.items():
            return value_contains_link(value)
    else:
        if isinstance(source, ifcopenshell.entity_instance):
            return True
        elif isinstance(source, Entity):
            return True
        else:
            return False

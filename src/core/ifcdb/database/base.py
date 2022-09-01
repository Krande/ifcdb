from __future__ import annotations

import ifcopenshell
from dataclasses import dataclass, field
from itertools import count
from typing import Any

from ifcdb.schema.model import ArrayModel, EntityModel, IfcSchemaModel

_INSERT_COUNTER = count(start=1)
_IFC_ENTITY = ifcopenshell.entity_instance


@dataclass
class EntityResolver:
    ifc_schema: str = None
    specific_ifc_ids: list[int] = None

    uuid_map: dict[_IFC_ENTITY, Entity] = field(default_factory=dict)
    schema_model: IfcSchemaModel = None

    def __post_init__(self):
        if self.schema_model is None:
            self.schema_model = IfcSchemaModel(schema_version=self.ifc_schema)

    def create_insert_entity(self, item: _IFC_ENTITY) -> Entity:
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
                links[name] = self.create_insert_entity(res)
            else:
                if isinstance(att_ref, ArrayModel):
                    ptype = att_ref.parameter_type
                    if isinstance(ptype, EntityModel):
                        result = []
                        for r in res:
                            output = self.create_insert_entity(r)
                            result.append(output)

                        links[name] = tuple(result)
                        continue

                props[name] = res

        return Entity(entity.name, props, links)


@dataclass
class Entity:
    name: str
    props: dict[str, Any] = field(repr=False, default_factory=dict)
    links: dict[str, Entity] = field(repr=False, default_factory=dict)
    uuid: str = None

    def props_str(self):
        return ",\n".join([f"{key}:= {value}" for key, value in self.props.items()])

    def links_str(self):
        links_str = ""
        for key, value in self.links.items():
            if isinstance(value, Entity):
                value = [value]

            for v in value:
                if v.uuid is None:
                    value_str = v.to_str()
                else:
                    value_str = f'SELECT {v.name} filter .id = <uuid>"{v.uuid}"'
                links_str += f"{key}:= ({value_str}),\n"
        return links_str

    def to_str(self, with_map: dict = None):
        prop_str = self.props_str()
        links_str = self.links_str()

        return f"INSERT {self.name} {{\n    {prop_str},\n{links_str} }};"

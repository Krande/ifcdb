from __future__ import annotations

import json
from dataclasses import dataclass

import edgedb

from ifcdb.schema.model import (
    EntityModel,
    EnumModel,
    IfcSchemaModel,
    IntermediateClass,
    SelectModel,
    TypeModel,
)

from .builder import EQBuilder


@dataclass
class QueryModel:
    client: edgedb.Client
    database: str
    ifc_schema_ver: str = "IFC4x1"
    module_name: str = "default"

    _sm: IfcSchemaModel = None
    _eq_builder: EQBuilder = None

    def __post_init__(self):
        self._sm = IfcSchemaModel(self.ifc_schema_ver)
        self._eq_builder = EQBuilder(self.client, self.module_name)

    def get_all(self, entities: list[str] = None, limit_to_ifc_entities=False):
        """This will query the EdgeDB for all known IFC entities."""
        db_entities = list(self._eq_builder.edgedb_objects.keys())
        if limit_to_ifc_entities is True:
            if entities is None:
                entities = []
            entities += db_entities

        select_str = "select {\n"
        if entities is None:
            ent_dict = self._sm.entities
        else:
            ent_dict = {x: self._sm.get_entity_by_name(x) for x in self._sm.get_related_entities(entities)}

        self._insert_intermediate_classes(ent_dict)

        for entity_name, entity in ent_dict.items():
            if isinstance(entity, EnumModel):
                continue
            if isinstance(entity, EntityModel) and entity.entity.is_abstract():
                continue
            select_str += f"{entity_name} := (SELECT {entity_name} {{"
            if isinstance(entity, (SelectModel, TypeModel)):
                select_str += 4 * " " + "id,\n"
                select_str += 4 * " " + f"`{entity.name}`"
            elif isinstance(entity, IntermediateClass):
                select_str += 4 * " " + "id,\n"
                select_str += 4 * " " + f"`{entity.att_name}`"
            else:
                all_atts = entity.get_attributes(True)
                select_str += 4 * " " + "id,\n"
                for i, att in enumerate(all_atts):
                    select_str += 4 * " " + f"`{att.name}`"
                    select_str += "" if i == len(all_atts) - 1 else ","
            select_str += "}),\n"
        select_str += "}"

        return json.loads(self.client.query_json(select_str))

    def _insert_intermediate_classes(self, ent_dict: dict):
        to_be_added = dict()
        for key, value in ent_dict.items():
            if isinstance(value, EntityModel) is False:
                continue
            for att in value.get_attributes(True):
                if att.needs_intermediate_class_str is False:
                    continue
                intermediate_class = att.get_intermediate_array_class()
                to_be_added[intermediate_class.name] = intermediate_class

        ent_dict.update(to_be_added)

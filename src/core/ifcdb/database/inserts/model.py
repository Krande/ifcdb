from __future__ import annotations

import logging
from dataclasses import dataclass, field
from itertools import count
from typing import ClassVar

import ifcopenshell

from ifcdb.schema.model import (
    ArrayModel,
    AttributeModel,
    IfcSchemaModel,
    IfcSchemaType,
    SelectModel,
    TypeModel,
)

_INSERT_COUNTER = count(start=1)
_IFC_ENTITY = ifcopenshell.entity_instance


class INSERTS:
    SEQ: ClassVar[str] = "seq"


@dataclass
class InsertBase:
    ifc_schema: str = None
    specific_ifc_ids: list[int] = None

    uuid_map: dict[_IFC_ENTITY, str] = field(default_factory=dict)
    schema_model: IfcSchemaModel = None

    def __post_init__(self):
        if self.schema_model is None:
            self.schema_model = IfcSchemaModel(schema_version=self.ifc_schema)

    def create_entity_insert_str(self, item: _IFC_ENTITY) -> str:
        entity = self.schema_model.get_entity_by_name(item.is_a())
        all_atts = entity.get_entity_atts(item)

        # INSERT block
        with_map: dict[_IFC_ENTITY | str, WithRef] = dict()
        insert_str = f"SELECT (INSERT {entity.name} {{\n    "

        for j, att in enumerate(all_atts):
            att_str = self.get_att_insert_str(att, item, with_map)
            if j == len(all_atts) - 1:
                comma_str = ""
            else:
                comma_str = ",\n    "

            insert_str += att_str + comma_str
        insert_str += "\n   }\n)"

        with_str = "WITH\n" if len(with_map.keys()) > 0 else ""
        for value in with_map.values():
            with_str += 4 * " " + f"{value.key} := {value.insert_str},\n"

        total_insert_str = with_str + insert_str
        return total_insert_str

    def insert_ifc_entity(self, res: _IFC_ENTITY, att_ref, with_map: dict[str | _IFC_ENTITY, WithRef]) -> str:
        uuid_obj = self.uuid_map.get(res, None)
        existing_ref = with_map.get(res, None)
        if existing_ref is not None:
            return existing_ref.key

        if uuid_obj is None:
            entity = self.schema_model.get_entity_by_name(res.is_a())
            if isinstance(entity, TypeModel):
                wrap_value = res.wrappedValue
                if isinstance(wrap_value, str):
                    wrap_str = f"'{wrap_value}'"
                else:
                    wrap_str = str(wrap_value)
                entity_insert_str = f"INSERT {entity.name} {{{entity.name} := {wrap_str} }}"
                entity_str = f"({entity_insert_str})"
            else:
                entity_str, sub_with_atts = self.get_sub_att_str(res, entity)
                with_map.update(sub_with_atts)
        else:
            res_name = res.is_a()
            entity_str = f'(SELECT {res_name} filter .id = <uuid>"{uuid_obj}")'

        res_id = next(_INSERT_COUNTER)
        if isinstance(att_ref, ArrayModel):
            ptype = att_ref.parameter_type
            if isinstance(ptype, SelectModel):
                aname = ptype.name
                unique_ref_name_a = f"ifc_{res_id + 100000}"
                with_map[unique_ref_name_a] = WithRef(unique_ref_name_a, entity_str)
                ref_str = f"(INSERT {aname} {{ {aname} := {unique_ref_name_a} }})"
            else:
                ref_str = entity_str
        elif isinstance(att_ref, SelectModel) and att_ref.name not in ("IfcAxis2Placement",):
            # TODO: Align treatment of SELECT entities across schema_gen, entity inserts here and in bulk_insert
            aname = att_ref.name
            unique_ref_name_a = f"ifc_{res_id + 100000}"
            with_map[unique_ref_name_a] = WithRef(unique_ref_name_a, entity_str)
            ref_str = f"(INSERT {aname} {{ {aname} := {unique_ref_name_a} }})"
        else:
            ref_str = entity_str

        unique_ref_name = f"ifc_{res_id}"

        with_map[res] = WithRef(unique_ref_name, ref_str)
        return unique_ref_name

    def get_sub_att_str(self, ifc_entity: _IFC_ENTITY, schema_entity: IfcSchemaType) -> tuple[str, dict]:
        att_str = f"(INSERT {schema_entity.name} {{"
        with_map = dict()
        for att in schema_entity.get_entity_atts(ifc_entity):
            att_str += self.get_att_insert_str(att, ifc_entity, with_map) + ","
        att_str += "})"
        return att_str, with_map

    def get_array_att_str(
        self, res: tuple, att: AttributeModel, att_ref: ArrayModel, with_map: dict[str | _IFC_ENTITY, WithRef]
    ):
        levels = att_ref.get_levels()
        num_levels = len(levels)
        curr_level = levels[-1]
        ptype = att_ref.parameter_type
        b1 = curr_level.bound1()
        b2 = curr_level.bound2()
        if num_levels > 1 and isinstance(ptype, str) is False:
            if att.needs_intermediate_class_str is True and att.intermediate_class_name is not None:
                int_class = att.intermediate_class_name
                value_str = "{"
                for i, x in enumerate(res, start=1):
                    int_name = f"{int_class}_{next(_INSERT_COUNTER)}"
                    int_value_str = "{"
                    int_value_str += ",".join([self.insert_ifc_entity(r, att_ref, with_map) for r in x])
                    int_value_str += "}"
                    with_map[int_name] = WithRef(
                        int_name, f"(INSERT {int_class} {{ {ptype.name}s := {int_value_str} }})"
                    )
                    value_str += int_name
                    value_str += "," if i != len(res) else ""

                value_str += "}"
            else:
                value_str = "["
                for x in res:
                    value_str += "("
                    value_str += ",".join([f"{self.insert_ifc_entity(r, att_ref, with_map)}" for r in x])
                    value_str += "),"
                value_str += "]"
        elif num_levels > 1 and isinstance(ptype, str):
            value_str = list(res)
        else:
            if b1 != b2 and b2 != -1:
                res = list(res)
            value_str = res
        return value_str

    def get_att_insert_str(
        self, att: AttributeModel, entity: _IFC_ENTITY, with_map: dict[str | _IFC_ENTITY, WithRef]
    ) -> str | None:
        res = getattr(entity, att.name)
        att_ref = att.get_type_ref()
        name = att.name

        if name is None:
            raise ValueError()
        if res is None:
            logging.debug(f'Property att: "{name}" is None')
            return None

        if isinstance(res, str):
            value_str = f"'{res}'"
        elif isinstance(res, tuple) and isinstance(att_ref, ArrayModel) and isinstance(res[0], _IFC_ENTITY):
            value_str = "{"
            value_str += ",".join([self.insert_ifc_entity(r, att_ref, with_map) for r in res])
            value_str += "}"
        elif isinstance(res, tuple) and isinstance(att_ref, ArrayModel):
            value_str = self.get_array_att_str(res, att, att_ref, with_map)
        elif isinstance(res, tuple) and isinstance(att_ref, ArrayModel) is False:
            value_str = res
        elif isinstance(res, (int, float)):
            value_str = res
        elif isinstance(res, _IFC_ENTITY):
            value_str = self.insert_ifc_entity(res, att_ref, with_map)
        else:
            raise NotImplementedError(f'Currently not added support for att: "{name}" -> {type(res)}')

        return f"{name} := {value_str}"


@dataclass
class WithRef:
    key: str
    insert_str: str

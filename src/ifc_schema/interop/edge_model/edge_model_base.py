from __future__ import annotations
import operator
from typing import ClassVar
from dataclasses import dataclass

import ifcopenshell

wrap = ifcopenshell.ifcopenshell_wrapper


def get_base_type(content_type: wrap.named_type) -> str:
     res = content_type.declared_type().declared_type().declared_type()
     return EntityEdgeModel.simple_types.get(res)


@dataclass
class ArrayEdgeModel:
    entity: wrap.aggregation_type
    schema: wrap.schema_definition

    def to_str(self) -> str:
        multilevel = False
        aggregate_types = [self.entity]
        shape_len = self.entity.type_of_aggregation()

        if shape_len > 1:
            multilevel = True
            end_fix = shape_len * ">"
        else:
            end_fix = ">"

        for agg in range(0, shape_len - 1):
            type_result = aggregate_types[-1].type_of_element()
            aggregate_types.append(type_result)

        content_type: wrap.named_type = aggregate_types[-1].type_of_element()
        cast_type = get_base_type(content_type)
        entity_str = ""
        if multilevel is False:
            agg_type = aggregate_types[0]
            bnum = agg_type.bound1()
            array_str = "array<"
            entity_str = ", ".join([cast_type for i in range(bnum)])
        else:
            array_str = "array<"
            for i, agg_type in enumerate(aggregate_types):
                if i == 0:
                    continue
                bnum = agg_type.bound1()
                entity_str = ", ".join([cast_type for i in range(bnum)])
                array_str += "tuple<"
        output_str = array_str + f"{entity_str}{end_fix}"
        return output_str


@dataclass
class EntityEdgeModel:
    entity: wrap.entity
    schema: wrap.schema_definition

    simple_types: ClassVar[dict[wrap.simple_type, str]] = {
        wrap.simple_type.real_type: "float64",
        "real": "float64",
        wrap.simple_type.integer_type: "int32",
        wrap.simple_type.boolean_type: "bool",
        wrap.simple_type.string_type: "string",
    }

    @property
    def ancestor_str(self):
        ancestor_str = ""
        if self.entity.supertype() is not None:
            ancestor_str = f"({self.entity.supertype().name()})"
        return ancestor_str

    @property
    def attributes_str(self):
        atts_str = ""
        indent_str = 8 * " "
        atts: tuple[wrap.attribute] = self.entity.all_attributes()

        for val in atts:
            att_prefix = "required " if val.optional() is False else ""
            typeof = val.type_of_attribute()

            if isinstance(typeof, wrap.aggregation_type):
                entity_to_write = ArrayEdgeModel(typeof, self.schema)
            else:
                entity_to_write = typeof.declared_type()

            if isinstance(entity_to_write, wrap.entity):
                atts_str += indent_str + f"{att_prefix}property {val.name} -> {entity_to_write.name()};\n"
            elif isinstance(entity_to_write, ArrayEdgeModel):
                atts_str += indent_str + entity_to_write.to_str()
            elif isinstance(entity_to_write, wrap.type_declaration):
                atts_str += indent_str + f"{att_prefix}property {val.name} -> {entity_to_write.name()};\n"
            else:
                raise NotImplemented()

        return atts_str

    def to_str(self) -> str:
        att_str = self.attributes_str
        prop_prefix = "abstract " if self.entity.is_abstract() is True else ""
        parent_str = f"extending {self.entity.supertype().name()}" if self.entity.supertype() is not None else ""

        return f"""
    {prop_prefix}type {self.entity.name} {parent_str} {{
{att_str}    }}
"""


@dataclass
class EnumEdgeModel:
    entity: wrap.enumeration_type
    schema: wrap.schema_definition

    def to_str(self) -> str:
        enum_str = ", ".join(self.entity.enumeration_items())
        return f"\n    scalar type {self.entity.name} extending enum<{enum_str}>;\n\n"


@dataclass
class EdgeModel:
    schema: wrap.schema_definition

    def __post_init__(self):
        self.entities = {x.name(): x for x in self.schema.declarations()}

    def entity_to_edge_str(self, entity: str) -> str:
        res = self.entities[entity]
        if isinstance(res, wrap.entity):
            entity = EntityEdgeModel(res, self.schema)
        elif isinstance(res, wrap.enumeration_type):
            entity = EnumEdgeModel(res, self.schema)
        else:
            raise ValueError("Unsupported Type")

        return entity.to_str()

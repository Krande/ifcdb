from __future__ import annotations

import logging
from dataclasses import dataclass
from typing import ClassVar, Union, List

import ifcopenshell
from toposort import toposort_flatten

wrap = ifcopenshell.ifcopenshell_wrapper


def get_aggregation_type(agg_entity: wrap.aggregation_type):
    shape_len = agg_entity.type_of_aggregation()
    aggregate_types = [agg_entity]
    for agg in range(0, shape_len - 1):
        prev_entry = aggregate_types[-1]
        if hasattr(prev_entry, "type_of_element") is False:
            type_result = prev_entry
        else:
            type_result = prev_entry.type_of_element()
        aggregate_types.append(type_result)

    last_entry = aggregate_types[-1]
    if isinstance(last_entry, wrap.named_type):
        content_type = last_entry
    else:
        content_type: wrap.named_type = last_entry.type_of_element()

    result = get_base_type_name(content_type)

    if isinstance(result, wrap.named_type):
        cast_type_str = content_type.declared_type().name()
    elif isinstance(result, wrap.enumeration_type):
        cast_type_str = result.name()
    else:
        cast_type_str = result

    return cast_type_str


def get_base_type_name(
    content_type: Union[wrap.named_type, wrap.type_declaration],
) -> Union[wrap.entity, str, wrap.enumeration_type, wrap.select_type]:
    cur_decl = content_type
    while hasattr(cur_decl, "declared_type") is True:
        cur_decl = cur_decl.declared_type()

    if isinstance(cur_decl, wrap.entity):
        return cur_decl
    if isinstance(cur_decl, wrap.select_type):
        return cur_decl
    if isinstance(cur_decl, wrap.enumeration_type):
        return cur_decl
    if isinstance(cur_decl, wrap.aggregation_type):
        res = cur_decl.type_of_element()
        cur_decl = res.declared_type()
        while hasattr(cur_decl, "declared_type") is True:
            cur_decl = cur_decl.declared_type()

    if isinstance(cur_decl, str):
        if cur_decl == "binary":
            return ""

        cast_type = EntityEdgeModel.simple_types.get(cur_decl)
        if cast_type is None:
            raise ValueError(f'Cast Simple Type not found for "{cur_decl}" related to {content_type}')
        return cast_type

    raise NotImplementedError(f"Base type is unknown type {cur_decl}")


def get_ancestors(entity: wrap.entity):
    cur_entity = entity
    ancestors = []
    while cur_entity.supertype() is not None:
        cur_entity = cur_entity.supertype()
        ancestors.append(cur_entity)

    return ancestors


def get_attribute_entities(entity: wrap.entity):
    att_entities = []
    for att in entity.attributes():
        typeof = att.type_of_attribute()
        if isinstance(typeof, wrap.aggregation_type):
            typeof = get_aggregation_type(typeof)
            if isinstance(typeof, str):
                continue
        result = get_base_type_name(typeof)
        if isinstance(result, str):
            continue
        else:
            att_entities.append(result)

    return att_entities


@dataclass
class TypeEdgeModel:
    entity: wrap.type_declaration
    schema: wrap.schema_definition

    def to_str(self):
        try:
            value = get_base_type_name(self.entity)
        except NotImplementedError as e:
            raise NotImplementedError(f"{e}\n\n{self.entity}")
        return f"""
    type {self.entity.name()} {{
        required property value -> {value};
    }}
"""


@dataclass
class ArrayEdgeModel:
    entity: wrap.attribute
    schema: wrap.schema_definition

    @property
    def agg_type(self) -> wrap.aggregation_type:
        return self.entity.type_of_attribute()

    def to_str(self) -> str:
        multilevel = False

        prev_entry = self.agg_type
        levels = []

        while isinstance(prev_entry, wrap.aggregation_type):
            levels.append(prev_entry)
            prev_entry = prev_entry.type_of_element()

        shape_len = len(levels)

        if shape_len > 1:
            multilevel = True

        end_fix = shape_len * ">"
        aggregate_parameter = levels[-1].type_of_element()
        parameter = get_base_type_name(aggregate_parameter)

        if isinstance(parameter, str):
            cast_type_str = parameter
        else:
            cast_type_str = parameter.name()

        bnum1 = levels[-1].bound1()
        bnum2 = levels[-1].bound2()

        prefix = f"property {self.entity.name()}"
        entity_str = ""
        if multilevel is False:
            if isinstance(parameter, wrap.entity):
                prefix = f"multi link {self.entity.name()}"
                array_str = ""
                end_fix = ""
                entity_str = cast_type_str
            elif isinstance(parameter, wrap.select_type):
                prefix = f"multi link {self.entity.name()}"
                array_str = ""
                end_fix = ""
                params = []
                for param in parameter.select_list():
                    param: wrap.type_declaration
                    res = get_base_type_name(param)
                    if isinstance(res, str):
                        # TODO: Evaluate how Unions should handle select Type of mixed objects
                        params.append(param.name())
                        # params.append(res)
                    else:
                        params.append(res.name())
                entity_str = " | ".join(params)
            else:
                if bnum2 == -1:
                    array_str = "array<"
                    entity_str = ", ".join([cast_type_str for i in range(bnum1)])
                else:
                    array_str = "array<" if bnum2 == 1 else "tuple<"
                    if bnum1 != 1:
                        logging.warning(f"BNUM 1 = {bnum1} ({self.entity}) is not accounted for")
                    entity_str = ", ".join([cast_type_str for i in range(bnum2)])
        else:
            array_str = "array<"
            for i, level in enumerate(levels):
                if i == 0:
                    continue
                if isinstance(parameter, wrap.named_type):
                    entity_str = cast_type_str
                    array_str += "tuple<"
                else:
                    bnum = level.bound1()
                    entity_str = ", ".join([cast_type_str for i in range(bnum)])
                    array_str += "tuple<"

        output_str = f"{prefix} -> " + array_str + f"{entity_str}{end_fix};\n"
        return output_str


@dataclass
class EntityEdgeModel:
    entity: wrap.entity
    schema: wrap.schema_definition

    simple_types: ClassVar[dict[wrap.simple_type, str]] = {
        "logical": "bool",
        "number": "int64",
        "real": "float64",
        "integer": "int64",
        "boolean": "bool",
        "string": "str",
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
        atts: tuple[wrap.attribute] = self.entity.attributes()

        for val in atts:
            att_prefix = "required " if val.optional() is False else ""
            typeof = val.type_of_attribute()

            if isinstance(typeof, wrap.aggregation_type):
                entity_to_write = ArrayEdgeModel(val, self.schema)
            else:
                result = get_base_type_name(typeof)
                if isinstance(result, wrap.entity):
                    entity_to_write = typeof.declared_type()
                else:
                    entity_to_write = result

            if isinstance(entity_to_write, wrap.entity):
                atts_str += indent_str + f"{att_prefix}link {val.name()} -> {entity_to_write.name()};\n"
            elif isinstance(entity_to_write, ArrayEdgeModel):
                atts_str += indent_str + f"{att_prefix}{entity_to_write.to_str()}"
            elif isinstance(entity_to_write, str):
                atts_str += indent_str + f"{att_prefix}property {val.name()} -> {entity_to_write};\n"
            elif isinstance(entity_to_write, wrap.select_type):
                selectable_types = " | ".join([x.name() for x in entity_to_write.select_list()])
                atts_str += indent_str + f"{att_prefix}link {val.name()} -> {selectable_types};\n"
            elif isinstance(entity_to_write, wrap.enumeration_type):
                atts_str += indent_str + f"{att_prefix}property {val.name()} -> {entity_to_write.name()};\n"
            else:
                raise NotImplementedError(f'Unsupported instance "{entity_to_write}"')

        return atts_str

    def to_str(self) -> str:
        att_str = self.attributes_str
        prop_prefix = "abstract " if self.entity.is_abstract() is True else ""
        parent_str = f"extending {self.entity.supertype().name()}" if self.entity.supertype() is not None else ""

        return f"""
    {prop_prefix}type {self.entity.name()} {parent_str} {{
{att_str}    }}
"""


@dataclass
class EnumEdgeModel:
    entity: wrap.enumeration_type
    schema: wrap.schema_definition

    def to_str(self) -> str:
        enum_str = ", ".join(self.entity.enumeration_items())
        return f"\n    scalar type {self.entity.name()} extending enum<{enum_str}>;\n\n"


@dataclass
class EdgeModel:
    schema: wrap.schema_definition

    def __post_init__(self):
        self.entities = {x.name(): x for x in self.schema.declarations()}

    def _find_dependencies(self, entity_name, dep_tree: dict = None, search_recursively=True):
        dep_tree = dict() if dep_tree is None else dep_tree
        res = self.entities[entity_name]

        name = res.name()
        if name not in dep_tree.keys():
            dep_tree[name] = []

        if isinstance(res, wrap.aggregation_type):
            res = get_aggregation_type(res)
            if isinstance(res, str):
                return dep_tree

        if isinstance(res, wrap.enumeration_type):
            return dep_tree

        if isinstance(res, wrap.select_type):
            for select_item in res.select_list():
                select_item_name = select_item.name()
                dep_tree[name].append(select_item_name)
                if select_item_name not in dep_tree.keys():
                    dep_tree[select_item_name] = []

                if search_recursively is True:
                    self._find_dependencies(select_item_name, dep_tree)
            return dep_tree

        base_value = get_base_type_name(res)
        if isinstance(base_value, str):
            return dep_tree

        if isinstance(res, wrap.entity) is False:
            raise NotImplementedError(f"Unsupported entity {res}")

        for x in get_ancestors(res):
            ancestor_name = x.name()
            if ancestor_name not in dep_tree[name]:
                dep_tree[name].append(ancestor_name)
            if search_recursively is True:
                self._find_dependencies(ancestor_name, dep_tree)

        for x in get_attribute_entities(res):
            att_name = x.name()
            if att_name not in dep_tree[name]:
                dep_tree[name].append(att_name)
            if search_recursively is True:
                self._find_dependencies(att_name, dep_tree)

        return dep_tree

    def get_all_entities(self):
        entity_dep_map = dict()
        for entity_name in self.entities.keys():
            self._find_dependencies(entity_name, entity_dep_map, search_recursively=False)

        res = list(toposort_flatten(entity_dep_map, sort=True))
        return res

    def get_related_entities(self, entity_names: Union[str, List[str]], entity_dep_map: dict = None) -> list[str]:
        if isinstance(entity_names, str):
            entity_names = [entity_names]

        entity_dep_map = dict() if entity_dep_map is None else entity_dep_map
        for entity_name in entity_names:
            self._find_dependencies(entity_name, entity_dep_map)

        res = list(toposort_flatten(entity_dep_map, sort=True))
        return res

    def get_entity_by_name(self, name: str) -> Union[str, EntityEdgeModel, EnumEdgeModel, TypeEdgeModel]:
        res = self.entities[name]
        schema = self.schema

        if isinstance(res, wrap.entity):
            entity = EntityEdgeModel(res, schema)
        elif isinstance(res, wrap.enumeration_type):
            entity = EnumEdgeModel(res, schema)
        elif isinstance(res, wrap.select_type):
            return ""
        elif isinstance(res, wrap.type_declaration):
            entity = TypeEdgeModel(res, schema)
        else:
            raise NotImplementedError(f'Unsupported Type "{res}"')

        return entity

    def entity_to_edge_str(self, entity: str) -> str:
        res = self.get_entity_by_name(entity)

        if isinstance(res, str):
            return res

        return res.to_str()

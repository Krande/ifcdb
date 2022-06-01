from __future__ import annotations

import logging
from dataclasses import dataclass, field
from typing import ClassVar, Union, List, Dict

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

    if isinstance(cur_decl, wrap.select_type):
        return cur_decl
    if isinstance(cur_decl, wrap.enumeration_type):
        return cur_decl
    if isinstance(cur_decl, wrap.aggregation_type):
        res = cur_decl.type_of_element()
        cur_decl = res.declared_type()
        while hasattr(cur_decl, "declared_type") is True:
            cur_decl = cur_decl.declared_type()

    if isinstance(cur_decl, wrap.entity):
        return cur_decl

    if isinstance(cur_decl, str):
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


def unwrap_selected_items(entity: wrap.select_type, selectable_type_entities: list[wrap.entity] = None):
    selectable_type_entities = [] if selectable_type_entities is None else selectable_type_entities
    for x in entity.select_list():
        if x in selectable_type_entities:
            continue
        if isinstance(x, wrap.entity):
            selectable_type_entities.append(x)
        elif isinstance(x, wrap.select_type):
            unwrap_selected_items(x, selectable_type_entities)
        else:
            if x in selectable_type_entities:
                continue
            selectable_type_entities.append(x)
    return selectable_type_entities


def get_aggregation_levels(agg_type):
    prev_entry = agg_type
    levels = []

    while isinstance(prev_entry, wrap.aggregation_type):
        levels.append(prev_entry)
        prev_entry = prev_entry.type_of_element()
    return levels


def get_array_str(entity: wrap.type_declaration):
    levels = get_aggregation_levels(entity.declared_type())
    if len(levels) != 1:
        logging.warning("Get Array string has only been tested on a single level")

    bnum1 = levels[-1].bound1()
    bnum2 = levels[-1].bound2()
    aggregate_parameter = levels[-1].type_of_element()
    parameter = get_base_type_name(aggregate_parameter)

    if isinstance(parameter, str):
        cast_type_str = parameter
    else:
        cast_type_str = parameter.name()

    array_str = "array<" if bnum2 == 1 else "tuple<"
    max_num = max(max(bnum1, bnum2), 1)
    entity_str = ", ".join([cast_type_str for i in range(max_num)])
    return array_str + f"{entity_str}>"


# Attribute References
@dataclass
class PropertyEdgeModel:
    edge_model: EdgeModel = field(repr=False)
    att: wrap.attribute = field(repr=False)

    @property
    def name(self):
        return self.att.name()

    def array_ref(self) -> None | str | ArrayEdgeModel:
        if isinstance(self.att.type_of_attribute(), wrap.aggregation_type) is False:
            return None

        return ArrayEdgeModel(self.att, self.edge_model.schema)

    def entity_ref(self) -> Union[None, EntityEdgeModel]:
        typeof = self.att.type_of_attribute()
        if isinstance(typeof, wrap.aggregation_type):
            typeof = get_aggregation_type(typeof)
            if isinstance(typeof, str):
                return None
        result = get_base_type_name(typeof)
        if isinstance(result, str):
            return result

        return self.edge_model.get_entity_by_name(result.name())

    def __repr__(self):
        return f'{self.__class__.__name__}({self.name}:)'


@dataclass
class ArrayEdgeModel:
    entity: wrap.attribute
    schema: wrap.schema_definition

    @property
    def agg_type(self) -> wrap.aggregation_type:
        return self.entity.type_of_attribute()

    def to_str(self) -> str:
        multilevel = False
        levels = get_aggregation_levels(self.agg_type)
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
                selectable_type_entities = unwrap_selected_items(parameter)
                for param in selectable_type_entities:
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
                    entity_str = ", ".join([cast_type_str for i in range(max(bnum1, 1))])
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


# Entities and types
@dataclass
class EntityBaseEdgeModel:
    edge_model: EdgeModel = field(repr=False)
    entity: Union[wrap.entity, wrap.select_type, wrap.enumeration_type, wrap.type_declaration]

    @property
    def name(self):
        return self.entity.name()

    @property
    def schema(self):
        return self.edge_model.schema

    def to_str(self) -> str:
        raise NotImplementedError()


@dataclass
class EntityEdgeModel(EntityBaseEdgeModel):
    entity: wrap.entity

    simple_types: ClassVar[dict[wrap.simple_type, str]] = {
        "binary": "bytes",
        "logical": "bool",
        "number": "int64",
        "real": "float64",
        "integer": "int64",
        "boolean": "bool",
        "string": "str",
    }

    def get_attributes(self) -> list[PropertyEdgeModel]:
        return [PropertyEdgeModel(self.edge_model, att) for att in self.entity.attributes()]

    def get_ancestors(self):
        parents = []
        parent = self.entity.supertype()
        while parent is not None:
            parent_entity = self.edge_model.get_entity_by_name(parent.name())
            parents.append(parent_entity)
            parent = parent.supertype()
        return parents

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
            name = val.name()

            res = EdgeModel.reserved_keys.get(name.lower())
            if res is not None:
                name = res

            if isinstance(entity_to_write, wrap.entity):
                atts_str += indent_str + f"{att_prefix}link {name} -> {entity_to_write.name()};\n"
            elif isinstance(entity_to_write, ArrayEdgeModel):
                atts_str += indent_str + f"{att_prefix}{entity_to_write.to_str()}"
            elif isinstance(entity_to_write, str):
                atts_str += indent_str + f"{att_prefix}property {name} -> {entity_to_write};\n"
            elif isinstance(entity_to_write, wrap.select_type):
                selectable_type_entities = unwrap_selected_items(entity_to_write)
                selectable_types = " | ".join([x.name() for x in selectable_type_entities])
                atts_str += indent_str + f"{att_prefix}link {name} -> {selectable_types};\n"
            elif isinstance(entity_to_write, wrap.enumeration_type):
                atts_str += indent_str + f"{att_prefix}property {name} -> {entity_to_write.name()};\n"
            else:
                raise NotImplementedError(f'Unsupported instance "{entity_to_write}"')

        return atts_str

    def to_str(self) -> str:
        att_str = self.attributes_str
        prop_prefix = "abstract " if self.entity.is_abstract() is True else ""
        parent_str = f"extending {self.entity.supertype().name()}" if self.entity.supertype() is not None else ""
        name = self.entity.name()
        return f"""
    {prop_prefix}type {name} {parent_str} {{
{att_str}    }}
"""


@dataclass
class EnumEdgeModel(EntityBaseEdgeModel):
    entity: wrap.enumeration_type

    def to_str(self) -> str:
        def name_check(name):
            res = EdgeModel.reserved_keys.get(name.lower())
            if res is not None:
                name = res
            return name

        enum_str = ", ".join(name_check(x) for x in self.entity.enumeration_items())
        return f"\n    scalar type {self.entity.name()} extending enum<{enum_str}>;\n\n"


@dataclass
class TypeEdgeModel(EntityBaseEdgeModel):
    entity: wrap.type_declaration

    def is_aggregate(self):
        cur_decl = self.entity
        while hasattr(cur_decl, "declared_type") is True:
            cur_decl = cur_decl.declared_type()

        return isinstance(cur_decl, wrap.aggregation_type)

    def to_str(self):
        entity = None
        try:
            value = get_base_type_name(self.entity)
            if isinstance(value, wrap.entity):
                entity = value
                value = value.name()
        except NotImplementedError as e:
            raise NotImplementedError(f"{e}\n\n{self.entity}")

        if self.is_aggregate() is True:
            if entity is not None:
                prop_str = "multi link"
            else:
                value = get_array_str(self.entity)
                prop_str = "property"
        else:
            prop_str = "property"
        return f"""
    type {self.entity.name()} {{
        required {prop_str} value -> {value};
    }}
"""


@dataclass
class SelectEdgeModel(EntityBaseEdgeModel):
    entity: wrap.select_type

    def get_select_entities(self):
        return [self.edge_model.get_entity_by_name(x.name()) for x in self.entity.select_list()]

    def to_str(self) -> str:
        return ""


@dataclass
class EdgeModel:
    schema: wrap.schema_definition
    enum_types: Dict[str, EnumEdgeModel] = None
    base_types: Dict[str, TypeEdgeModel] = None
    entities: Dict[str, EntityEdgeModel] = None
    select_types: Dict[str, SelectEdgeModel] = None

    reserved_keys: ClassVar[dict] = dict(
        start="`Start`", union="`UNION`", group="`GROUP`", move="`MOVE`", check="`CHECK`", window="`WINDOW`"
    )

    def __post_init__(self):
        decl = self.schema.declarations()
        self.select_types = {x.name(): SelectEdgeModel(self, x) for x in decl if isinstance(x, wrap.select_type)}
        self.enum_types = {x.name(): EnumEdgeModel(self, x) for x in decl if isinstance(x, wrap.enumeration_type)}
        self.base_types = {x.name(): TypeEdgeModel(self, x) for x in decl if isinstance(x, wrap.type_declaration)}
        type_names = list(self.base_types.keys()) + list(self.select_types.keys()) + list(self.enum_types.keys())
        self.entities = {x.name(): EntityEdgeModel(self, x) for x in decl if x.name() not in type_names}

    def _find_dependencies(self, entity_name, dep_tree: dict = None, search_recursively=True):
        dep_tree = dict() if dep_tree is None else dep_tree

        entity_model = self.get_entity_by_name(entity_name)
        res = entity_model.entity

        name = res.name()

        if name not in dep_tree.keys():
            dep_tree[name] = []

        if isinstance(res, wrap.aggregation_type):
            res = get_aggregation_type(res)
            if isinstance(res, str):
                return dep_tree

        if isinstance(entity_model, EnumEdgeModel):
            return dep_tree
        elif isinstance(entity_model, SelectEdgeModel):
            for select_item in entity_model.get_select_entities():
                dep_tree[name].append(select_item.name)
                if select_item.name not in dep_tree.keys():
                    dep_tree[select_item.name] = []

                if search_recursively is True:
                    self._find_dependencies(select_item.name, dep_tree)
            return dep_tree

        base_value = get_base_type_name(res)
        if isinstance(base_value, str):
            return dep_tree

        if isinstance(res, wrap.entity) is False:
            raise NotImplementedError(f"Unsupported entity {res}")

        for x in entity_model.get_ancestors():
            ancestor_name = x.name
            if ancestor_name not in dep_tree[name]:
                dep_tree[name].append(ancestor_name)
            if search_recursively is True:
                self._find_dependencies(ancestor_name, dep_tree)

        for x in entity_model.get_attributes():
            entity_ref = x.entity_ref()
            if entity_ref is None:
                continue

            entity_name = entity_ref.name
            if entity_name not in dep_tree[name]:
                dep_tree[name].append(entity_name)

            if search_recursively is True:
                self._find_dependencies(entity_name, dep_tree)

        return dep_tree

    def get_all_types(self):
        return {
            x.name(): x
            for x in self.schema.declarations()
            if isinstance(x, (wrap.type_declaration, wrap.select_type, wrap.enumeration_type))
        }

    def get_all_entities(self):
        entity_dep_map = dict()
        for type_name in self.base_types.keys():
            entity_dep_map[type_name] = []
        for type_name in self.enum_types.keys():
            entity_dep_map[type_name] = []
        for entity_name in self.entities.keys():
            self._find_dependencies(entity_name, entity_dep_map, search_recursively=False)

        # The following dependencies are by default circular dependencies. Will remove deps for Select Types
        for stype in [
            "IfcBooleanOperand",
            "IfcClassificationSelect",
            "IfcClassificationReferenceSelect",
            "IfcCsgSelect",
            "IfcFillStyleSelect",
            "IfcPresentationStyleSelect",
            "IfcStyleAssignmentSelect",
        ]:
            entity_dep_map[stype] = []
        circular_deps = {
            "IfcBooleanClippingResult": {"IfcBooleanResult"},
            "IfcBooleanOperand": {"IfcBooleanResult"},
            "IfcBooleanResult": {"IfcBooleanOperand"},
            "IfcClassificationReference": {"IfcClassificationReferenceSelect"},
            "IfcClassificationReferenceSelect": {"IfcClassificationReference"},
            "IfcClassificationSelect": {"IfcClassificationReference"},
            "IfcCsgSelect": {"IfcBooleanResult"},
            "IfcCsgSolid": {"IfcCsgSelect"},
            "IfcFillAreaStyle": {"IfcFillStyleSelect"},
            "IfcFillAreaStyleTiles": {"IfcStyledItem"},
            "IfcFillStyleSelect": {"IfcFillAreaStyleTiles"},
            "IfcMaterialClassificationRelationship": {"IfcClassificationSelect"},
            "IfcPresentationStyleAssignment": {"IfcPresentationStyleSelect"},
            "IfcPresentationStyleSelect": {"IfcFillAreaStyle"},
            "IfcRelAssociatesClassification": {"IfcClassificationSelect"},
            "IfcStyleAssignmentSelect": {"IfcPresentationStyleAssignment"},
            "IfcStyledItem": {"IfcStyleAssignmentSelect"},
        }

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

    def get_entity_by_name(self, name: str) -> Union[EntityEdgeModel, EnumEdgeModel, TypeEdgeModel, SelectEdgeModel]:
        for entity_types in [self.select_types, self.base_types, self.entities, self.enum_types]:
            res = entity_types.get(name)
            if res is not None:
                return res

        raise NotImplementedError(f'Unsupported Type "{res}"')

    def entity_to_edge_str(self, entity: str) -> str:
        res = self.get_entity_by_name(entity)
        return res.to_str()

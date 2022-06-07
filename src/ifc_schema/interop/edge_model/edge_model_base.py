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


def get_array_str(levels):
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
class AttributeEdgeModel:
    edge_model: EdgeModel = field(repr=False)
    att: wrap.attribute = field(repr=False)

    @property
    def name(self):
        return self.att.name()

    @property
    def optional(self):
        return self.att.optional()

    def get_type_ref(self) -> str | EntityEdgeModel | SelectEdgeModel | ArrayEdgeModel:
        array_ref = self.array_ref()
        entity_ref = self.entity_ref()
        return_ref = array_ref if array_ref is not None else entity_ref

        if return_ref is None:
            raise ValueError("type ref cannot be None")

        return return_ref

    def array_ref(self) -> None | str | ArrayEdgeModel:
        if isinstance(self.att.type_of_attribute(), wrap.aggregation_type) is False:
            return None

        return ArrayEdgeModel(self.att, self.edge_model)

    def entity_ref(self) -> Union[None, str, EntityEdgeModel, SelectEdgeModel]:
        typeof = self.att.type_of_attribute()
        if isinstance(typeof, wrap.aggregation_type):
            typeof = get_aggregation_type(typeof)
            if isinstance(typeof, str):
                return None
        result = get_base_type_name(typeof)
        if isinstance(result, str):
            return result

        return self.edge_model.get_entity_by_name(result.name())

    def to_str(self):
        value_ref = self.entity_ref() if self.entity_ref() is not None else self.array_ref()

        prefix_str = "" if self.optional is False else "required "
        name = self.edge_model.reserved_keys.get(self.name.lower(), self.name)
        if isinstance(value_ref, str):
            prefix_str += "property"
            value_name = value_ref
        elif isinstance(value_ref, (EntityEdgeModel, SelectEdgeModel)):
            prefix_str += "link"
            value_name = value_ref.name
        elif isinstance(value_ref, ArrayEdgeModel):
            param = value_ref.parameter_type
            if value_ref.list_type == ArrayEdgeModel.LIST:
                prefix_str += "property" if isinstance(param, str) else "multi link"
            else:
                prefix_str += "multi property" if isinstance(param, str) else "multi link"
            value_name = value_ref.to_str()
        elif isinstance(value_ref, EnumEdgeModel):
            prefix_str += "property"
            items_str = ",".join(f"'{x}'" for x in value_ref.get_enum_items())
            value_name = f"str {{\n            constraint one_of ({items_str});\n        }}"
        else:
            raise NotImplementedError(f'Unknown attribute type "{value_ref}"')

        return f"{prefix_str} {name} -> {value_name};"

    def __repr__(self):
        return f"{self.__class__.__name__}({self.name}:)"


@dataclass
class ArrayEdgeModel:
    entity: wrap.attribute
    edge_model: EdgeModel

    LIST: ClassVar[str] = "list"
    SET: ClassVar[str] = "set"
    ARRAY: ClassVar[str] = "array"

    @property
    def schema(self):
        return self.edge_model.schema

    @property
    def agg_type(self) -> wrap.aggregation_type:
        return self.entity.type_of_attribute()

    def get_levels(self):
        return get_aggregation_levels(self.agg_type)

    @property
    def list_type(self) -> str:
        agg_map = {
            self.agg_type.array_type.real: self.ARRAY,
            self.agg_type.list_type.real: self.LIST,
            self.agg_type.set_type.real: self.SET,
        }
        agg_type = self.agg_type.type_of_aggregation()
        result = agg_map.get(agg_type, None)
        if result is None:
            raise NotImplementedError(f'Have yet to add support for aggregation type "{agg_type}"')

        return result

    @property
    def parameter_type(self):
        levels = self.get_levels()
        aggregate_parameter = levels[-1].type_of_element()
        parameter = get_base_type_name(aggregate_parameter)
        if isinstance(parameter, str):
            return parameter

        return self.edge_model.get_entity_by_name(parameter.name())

    def to_str(self) -> str:
        levels = self.get_levels()
        if isinstance(self.parameter_type, str) and self.list_type in (self.SET,):
            return self.parameter_type
        return get_array_str(levels)


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
    _attributes: list[AttributeEdgeModel] = field(default=None)

    def get_attributes(self) -> list[AttributeEdgeModel]:
        circular_refs = [
            ("IfcFillAreaStyleTiles", "Tiles"),
            ("IfcClassificationReference", "ReferencedSource"),
            ("IfcBooleanResult", "FirstOperand"),
            ("IfcBooleanResult", "SecondOperand"),
        ]
        if self._attributes is None:
            atts = []
            for att in self.entity.attributes():
                att_name = att.name()
                should_skip = False
                for circ_class, circ_att in circular_refs:
                    if self.name == circ_class and att_name == circ_att:
                        should_skip = True
                        break
                if should_skip:
                    continue

                atts.append(AttributeEdgeModel(self.edge_model, att))
            self._attributes = atts
        return self._attributes
        # return [AttributeEdgeModel(self.edge_model, att) for att in self.entity.attributes()]

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
        for val in self.get_attributes():
            atts_str += indent_str + val.to_str() + "\n"

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

    def get_enum_items(self):
        return self.entity.enumeration_items()

    def to_str(self) -> str:
        # def name_check(name):
        #     res = EdgeModel.reserved_keys.get(name.lower())
        #     if res is not None:
        #         return res
        #     return f"`{name}`"
        #
        # enum_str = ", ".join(name_check(x) for x in self.get_enum_items())
        items_str = ",".join(f"'{x}'" for x in self.get_enum_items())
        name = self.entity.name()
        if name != "IfcNullStyle":
            return ""

        return f"""
    type {name} {{
        required property {name} -> str {{
            constraint one_of ({items_str});
        }};
    }}
"""




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
                levels = get_aggregation_levels(self.entity.declared_type())
                if len(levels) != 1:
                    logging.warning("Get Array string has only been tested on a single level")

                value = get_array_str(levels)
                prop_str = "property"
        else:
            prop_str = "property"
        return f"""
    type {self.name} {{
        required {prop_str} `{self.name}` -> {value};
    }}
"""


@dataclass
class SelectEdgeModel(EntityBaseEdgeModel):
    entity: wrap.select_type

    def get_select_entities(self) -> list[EntityEdgeModel]:
        return [self.edge_model.get_entity_by_name(x.name()) for x in self.entity.select_list()]

    def to_str(self) -> str:
        ent_names = " | ".join(x.name for x in self.get_select_entities())
        return f"""
    type {self.entity.name()} {{
        link {self.entity.name()} -> {ent_names};
    }}
"""


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

        if isinstance(entity_model, EntityEdgeModel):
            for x in entity_model.get_ancestors():
                ancestor_name = x.name
                if ancestor_name not in dep_tree[name]:
                    dep_tree[name].append(ancestor_name)
                    if search_recursively is True:
                        self._find_dependencies(ancestor_name, dep_tree)

            for att in entity_model.get_attributes():
                entity = att.get_type_ref()
                if isinstance(entity, ArrayEdgeModel):
                    entity = entity.parameter_type

                if isinstance(entity, str):
                    continue

                entity_name = entity.name
                if entity_name not in dep_tree[name]:
                    dep_tree[name].append(entity_name)
                    if search_recursively is True:
                        self._find_dependencies(entity_name, dep_tree)

        elif isinstance(entity_model, SelectEdgeModel):
            for entity in entity_model.get_select_entities():
                entity_name = entity.name
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

    def _fix_circular_deps(self, entity_dep_map):
        # The following dependencies are by default circular dependencies. Will remove deps for Select Types

        for stype in [
            "IfcBooleanOperand",
            "IfcClassificationSelect",
            "IfcClassificationReferenceSelect",
            "IfcCsgSelect",
            "IfcFillStyleSelect",
            "IfcPresentationStyleSelect",
            "IfcStyleAssignmentSelect",
            "IfcFillAreaStyleTiles",
        ]:
            res = entity_dep_map.get(stype)
            if res is None:
                continue
            # entity_dep_map[stype] = []
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

    def get_all_entities(self):
        entity_dep_map = dict()
        for type_name in self.base_types.keys():
            entity_dep_map[type_name] = []
        for type_name in self.enum_types.keys():
            entity_dep_map[type_name] = []
        for entity_name in self.select_types.keys():
            self._find_dependencies(entity_name, entity_dep_map, search_recursively=False)
        for entity_name in self.entities.keys():
            self._find_dependencies(entity_name, entity_dep_map, search_recursively=False)

        self._fix_circular_deps(entity_dep_map)
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

from __future__ import annotations

import logging
import os
import pathlib
from dataclasses import dataclass, field
from typing import ClassVar, Dict, List, Union

import ifcopenshell
from toposort import toposort_flatten

wrap = ifcopenshell.ifcopenshell_wrapper


@dataclass
class WithNode:
    name: str
    class_name: str
    query_str: str


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
    aggregate_parameter = levels[-1].type_of_element()
    parameter = get_base_type_name(aggregate_parameter)

    if isinstance(parameter, str):
        cast_type_str = parameter
    else:
        cast_type_str = parameter.name()
    indent = 4 * " "
    astr = ""
    ending = ""
    constr_str = ""
    for i, level in enumerate(levels):
        b1 = level.bound1()
        b2 = level.bound2()
        if len(levels) > 1 and i == 0:
            array_str = "array<"
        else:
            array_str = "array<" if b2 == 1 else "tuple<"

        if b1 != b2 and b2 != -1:
            array_str = "array<"
            g = 3 * indent
            g2 = 2 * indent
            range_str = ""
            range_l = list(range(b1, b2 + 1))
            for j, k in enumerate(range_l, start=1):
                range_str += f"len(__subject__) = {k}"
                range_str += " or " if j != len(range_l) else ""
            constr_str = f"{{\n{g}constraint expression on ({range_str})\n{g2}}}"
            entity_str = cast_type_str
        else:
            max_num = max(max(b1, b2), 1)
            entity_str = ", ".join([cast_type_str for i in range(max_num)])

        if i == len(levels) - 1:
            astr += array_str + f"{entity_str}"
        else:
            astr += array_str
        ending += ">"
    return astr + ending + constr_str


@dataclass
class IntermediateClass:
    source_attribute: AttributeEdgeModel = field(repr=False)
    written_to_file: bool = field(default=False)

    @property
    def name(self):
        array = self.source_attribute.array_ref()
        ptype = array.parameter_type
        return f"List_of_{ptype.name}"

    @property
    def att_name(self):
        ptype = self.source_attribute.array_ref().parameter_type
        return f"{ptype.name}s"

    @property
    def type_str(self):
        ptype = self.source_attribute.array_ref().parameter_type
        return f"""\n    type {self.name} {{ required multi link {self.att_name} -> {ptype.name} }}\n"""


# Attribute References
@dataclass
class AttributeEdgeModel:
    edge_model: EdgeModel = field(repr=False)
    att: wrap.attribute = field(repr=False)
    derived: bool

    @property
    def name(self):
        return self.att.name()

    @property
    def optional(self):
        optional = self.att.optional()
        if optional is False and self.derived is True:
            return True
        return optional

    @property
    def ref_to_many(self):
        return self.array_ref() is not None

    @property
    def needs_intermediate_class_str(self):
        att_ref = self.array_ref()
        if att_ref is None:
            return False
        levels = att_ref.get_levels()
        num_levels = len(levels)
        ptype = att_ref.parameter_type
        if num_levels > 1 and isinstance(ptype, str) is False:
            return True
        return False

    def get_intermediate_array_class(self) -> IntermediateClass:
        """Creates an intermediate class for nested links to Entities"""
        new_class = IntermediateClass(self)
        class_name = new_class.name
        if class_name in self.edge_model.intermediate_classes:
            return self.edge_model.intermediate_classes[class_name]

        self.edge_model.intermediate_classes[class_name] = new_class
        return self.edge_model.intermediate_classes[class_name]

    @property
    def intermediate_class_name(self):
        if self.needs_intermediate_class_str is False:
            return None
        imc = self.get_intermediate_array_class()
        return imc.name

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
        array_ref = self.array_ref()
        value_ref = self.entity_ref()
        prefix_str = "" if self.optional is True else "required "
        name = self.edge_model.reserved_keys.get(self.name.lower(), self.name)

        if isinstance(value_ref, str):
            prefix_str += "property"
            value_name = value_ref
        elif isinstance(array_ref, ArrayEdgeModel):
            param = array_ref.parameter_type

            if isinstance(param, str):
                prefix_str += "property" if array_ref.list_type == ArrayEdgeModel.LIST else "multi property"
            else:
                prefix_str += "multi link"

            if "multi" in prefix_str:
                if value_ref is None:
                    value_name = param
                else:
                    if self.needs_intermediate_class_str is False:
                        value_name = value_ref.name
                    else:
                        imc = self.get_intermediate_array_class()
                        value_name = imc.name
            else:
                value_name = array_ref.to_str()
        elif isinstance(value_ref, (EntityEdgeModel, SelectEdgeModel)):
            prefix_str += "link"
            value_name = value_ref.name
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
    entity: wrap.attribute = field(repr=False)
    edge_model: EdgeModel = field(repr=False)

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
    entity: Union[wrap.entity, wrap.select_type, wrap.enumeration_type, wrap.type_declaration] = field(repr=False)

    @property
    def name(self):
        return self.entity.name()

    @property
    def schema(self):
        return self.edge_model.schema

    def to_insert_str(
        self,
        entity: ifcopenshell.entity_instance,
        indent: str = "",
        with_map: dict = None,
        uuid_map: dict = None,
    ) -> str:
        raise NotImplementedError(f"Have not added method for subclass '{self.__class__.__name__}'")

    def to_str(self) -> str:
        raise NotImplementedError(f"Have not added method for subclass '{self.__class__.__name__}'")


@dataclass
class EntityEdgeModel(EntityBaseEdgeModel):
    entity: wrap.entity = field(repr=False)

    simple_types: ClassVar[dict[wrap.simple_type, str]] = {
        "binary": "bytes",
        "logical": "bool",
        "number": "int64",
        "real": "float64",
        "integer": "int64",
        "boolean": "bool",
        "string": "str",
    }
    _attributes: list[AttributeEdgeModel] = field(default=None, repr=False)
    _name: str = None

    def get_derive_map(self) -> dict[str, bool] | None:
        derived = self.entity.derived()
        attributes = self.entity.all_attributes()
        if len(derived) != len(attributes):
            logging.debug("Explicit attributes is NOT redeclared as derived in a subtype")
            return None
        return {attref.name(): derived for derived, attref in zip(derived, attributes)}

    def get_attributes(self, include_inherited_attributes=False) -> list[AttributeEdgeModel]:
        if self._attributes is None or include_inherited_attributes is True:
            atts = []
            att_list = (
                self.entity.attributes() if include_inherited_attributes is False else self.entity.all_attributes()
            )

            dmap = {x.name(): False for x in att_list}
            for child_entity in self.get_children():
                child_dmap = child_entity.get_derive_map()
                if child_dmap is None:
                    continue
                for key, value in child_dmap.items():
                    if value is False and key in dmap.keys():
                        continue
                    dmap[key] = value

            for att in att_list:
                att_name = att.name()
                if self.edge_model.modify_circular_deps is True:
                    if self._skip_due_to_circular_deps(att_name):
                        continue
                derived_data = dmap.get(att_name, None)
                atts.append(AttributeEdgeModel(self.edge_model, att, derived=derived_data))
            self._attributes = atts
        return self._attributes

    def get_ancestors(self) -> list[EntityEdgeModel]:
        parents = []
        parent = self.entity.supertype()
        while parent is not None:
            parent_entity = self.edge_model.get_entity_by_name(parent.name())
            parents.append(parent_entity)
            parent = parent.supertype()
        return parents

    def get_children(self, current_child=None, children_all=None) -> list[EntityEdgeModel]:
        children_all = [] if children_all is None else children_all
        current_child = self if current_child is None else current_child

        children = current_child.entity.subtypes()
        if children is None:
            return children_all

        child_entities = [self.edge_model.get_entity_by_name(child.name()) for child in children]
        children_all += child_entities
        for child in child_entities:
            self.get_children(child, children_all)

        return children_all

    def _skip_due_to_circular_deps(self, att_name):
        circular_refs = [
            ("IfcFillAreaStyleTiles", "Tiles"),
            ("IfcClassificationReference", "ReferencedSource"),
            ("IfcBooleanResult", "FirstOperand"),
            ("IfcBooleanResult", "SecondOperand"),
        ]
        should_skip = False
        for circ_class, circ_att in circular_refs:
            if self.name == circ_class and att_name == circ_att:
                should_skip = True
                break

        return should_skip

    @property
    def name(self):
        if self._name is None:
            self._name = self.entity.name()
        return self._name

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

    def get_entity_atts(self, entity: ifcopenshell.entity_instance):
        return [x for x in self.get_attributes(True) if getattr(entity, x.name) is not None]

    def to_select_str(self, with_map: dict[str, WithNode] = None) -> str:
        from ifcdb.utils import change_case

        select_str = "{"
        all_atts = self.get_attributes(True)

        def add_entity_ref(ref_type):
            if with_map is None:
                ref_str = ref_type.to_select_str(with_map=with_map)
            else:
                ref_str = change_case(att.name)
                query_str = ref_type.to_select_str(with_map=with_map)
                with_map[ref_str] = WithNode(ref_str, att.name, query_str)
            return ref_str

        for i, att in enumerate(all_atts):
            type_ref = att.get_type_ref()
            if isinstance(type_ref, ArrayEdgeModel):
                type_ref = type_ref.parameter_type
            select_str += f"{att.name}"
            if isinstance(type_ref, EntityEdgeModel):
                select_ref = add_entity_ref(type_ref)
                select_str += f" : {select_ref}"
            elif isinstance(type_ref, (str, EnumEdgeModel)):
                pass
            elif isinstance(type_ref, SelectEdgeModel):
                print("sd")
            else:
                raise ValueError(f'Unknown type ref "{type_ref}"')

            select_str += "" if i == len(all_atts) - 1 else ","
        select_str += "}"
        return select_str

    def to_insert_str(
        self,
        entity: ifcopenshell.entity_instance,
        indent: str = "",
        uuid_map: dict = None,
        with_map: dict[str, str] = None,
    ):
        from ifcdb.interop.edge_model.query_utils import get_att_insert_str

        all_atts = self.get_entity_atts(entity)
        newline = "" if len(all_atts) == 1 else "\n"
        insert_str = f"{indent}INSERT {self.name} {{{newline}  "
        for i, att in enumerate(all_atts):
            res = get_att_insert_str(att, entity, self.edge_model, uuid_map=uuid_map, with_map=with_map)
            if res is None:
                continue

            comma_str = "" if i == len(all_atts) - 1 else ","
            insert_str += res + comma_str

        return insert_str + f"}}{newline}"

    def to_str(self) -> str:
        att_str = self.attributes_str
        prop_prefix = "abstract " if self.entity.is_abstract() is True else ""
        parent_str = f"extending {self.entity.supertype().name()}" if self.entity.supertype() is not None else ""
        name = self.entity.name()

        # Check for any need to construct intermediate classes
        intermediate_classes_str = ""
        for att in self.get_attributes(True):
            if att.needs_intermediate_class_str is True:
                imc = att.get_intermediate_array_class()
                if imc.written_to_file is False:
                    intermediate_classes_str += imc.type_str
                    imc.written_to_file = True
        return f"""{intermediate_classes_str}
    {prop_prefix}type {name} {parent_str} {{
{att_str}    }}
"""

    def __repr__(self):
        return f"{self.__class__.__name__}({self.name})"


@dataclass
class EnumEdgeModel(EntityBaseEdgeModel):
    entity: wrap.enumeration_type = field(repr=False)

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
    entity: wrap.type_declaration = field(repr=False)

    def is_aggregate(self):
        cur_decl = self.entity
        while hasattr(cur_decl, "declared_type") is True:
            cur_decl = cur_decl.declared_type()

        return isinstance(cur_decl, wrap.aggregation_type)

    def to_insert_str(
        self,
        entity: ifcopenshell.entity_instance,
        indent: str = "",
        with_map: dict = None,
        uuid_map: dict = None,
    ) -> str:
        # value = get_base_type_name(self.entity)
        wrap_value = entity.wrappedValue
        if isinstance(wrap_value, str):
            wrap_str = f"'{wrap_value}'"
        else:
            wrap_str = str(wrap_value)
        return f"INSERT {self.name} {{{self.name} := {wrap_str} }}"

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
    entity: wrap.select_type = field(repr=False)

    def get_select_entities(self, unwrap_all=False) -> list[EntityEdgeModel]:
        if unwrap_all is False:
            return [self.edge_model.get_entity_by_name(x.name()) for x in self.entity.select_list()]
        res = [self.edge_model.get_entity_by_name(x.name()) for x in unwrap_selected_items(self.entity)]
        return res

    def to_str(self) -> str:
        ent_names = " | ".join(x.name for x in self.get_select_entities(self.edge_model.select_types_unwrap))
        return f"""
    type {self.entity.name()} {{
        link {self.entity.name()} -> {ent_names};
    }}
"""


@dataclass
class EdgeModel:
    schema: wrap.schema_definition
    enum_types: Dict[str, EnumEdgeModel] = field(default=None, repr=False)
    base_types: Dict[str, TypeEdgeModel] = field(default=None, repr=False)
    entities: Dict[str, EntityEdgeModel] = field(default=None, repr=False)
    select_types: Dict[str, SelectEdgeModel] = field(default=None, repr=False)

    modify_circular_deps: bool = False
    select_types_unwrap: bool = True

    intermediate_classes: dict[str, IntermediateClass] = field(default_factory=dict, repr=False)

    reserved_keys: ClassVar[dict] = dict(
        start="`Start`",
        union="`UNION`",
        group="`GROUP`",
        move="`MOVE`",
        check="`CHECK`",
        window="`WINDOW`",
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

        if self.modify_circular_deps is False:
            return list(entity_dep_map.keys())

        self._fix_circular_deps(entity_dep_map)
        res = list(toposort_flatten(entity_dep_map, sort=True))
        return res

    def get_related_entities(self, entity_names: Union[str, List[str]], entity_dep_map: dict = None) -> list[str]:
        if isinstance(entity_names, str):
            entity_names = [entity_names]

        entity_dep_map = dict() if entity_dep_map is None else entity_dep_map
        for entity_name in entity_names:
            self._find_dependencies(entity_name, entity_dep_map)

        if self.modify_circular_deps is False:
            return list(sorted(entity_dep_map.keys()))

        res = list(toposort_flatten(entity_dep_map, sort=True))
        return res

    def get_entity_by_name(
        self, name: str
    ) -> Union[EntityEdgeModel, EnumEdgeModel, TypeEdgeModel, SelectEdgeModel, IntermediateClass]:
        for entity_types in [
            self.select_types,
            self.base_types,
            self.entities,
            self.enum_types,
        ]:
            res = entity_types.get(name)
            if res is not None:
                return res
        if name in self.intermediate_classes.keys():
            return self.intermediate_classes.get(name)
        raise NotImplementedError(f'Unsupported Type "{res}"')

    def entity_to_edge_str(self, entity: str) -> str:
        res = self.get_entity_by_name(entity)
        return res.to_str()

    def get_entity_insert_str(
        self,
        ifc_entity: ifcopenshell.entity_instance,
        indent: str = "",
        uuid_map: dict = None,
        with_map: dict[str, str] = None,
    ) -> str:
        entity = self.get_entity_by_name(ifc_entity.is_a())
        return entity.to_insert_str(ifc_entity, indent=indent, uuid_map=uuid_map, with_map=with_map)

    def write_entities_to_esdl_file(
        self, entities: list[str], esdl_file_path, module_name="default", include_server_files=False
    ):
        from ifcdb.interop.edge_model.utils import copy_server_files

        esdl_file_path = pathlib.Path(esdl_file_path)
        os.makedirs(esdl_file_path.parent, exist_ok=True)

        with open(esdl_file_path, "w") as f:
            f.write(f"module {module_name} {{\n\n")
            for entity_name in entities:
                edge_str = self.entity_to_edge_str(entity_name)
                f.write(edge_str)
            f.write("}")

        if include_server_files:
            copy_server_files(esdl_file_path.parent.parent)

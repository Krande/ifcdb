from __future__ import annotations

import logging
import os
import pathlib
from dataclasses import dataclass, field
from typing import ClassVar, Dict, List, Union, TypeVar

import ifcopenshell
from toposort import toposort_flatten

from .utils import (
    get_aggregation_levels,
    get_aggregation_type,
    get_array_str,
    get_base_type_name,
    unwrap_selected_items,
)

wrap = ifcopenshell.ifcopenshell_wrapper


@dataclass
class IntermediateClass:
    source_attribute: AttributeModel = field(repr=False)
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

    def to_str(self):
        ptype = self.source_attribute.array_ref().parameter_type
        return f"""\n    type {self.name} {{ required multi link {self.att_name} -> {ptype.name} }}\n"""


# Attribute References
@dataclass
class AttributeModel:
    edge_model: IfcSchemaModel = field(repr=False)
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

    def get_type_ref(self) -> str | EntityModel | SelectModel | ArrayModel:
        array_ref = self.array_ref()
        entity_ref = self.entity_ref()
        return_ref = array_ref if array_ref is not None else entity_ref

        if return_ref is None:
            raise ValueError("type ref cannot be None")

        return return_ref

    def array_ref(self) -> None | str | ArrayModel:
        if isinstance(self.att.type_of_attribute(), wrap.aggregation_type) is False:
            return None

        return ArrayModel(self.att, self.edge_model)

    def entity_ref(self) -> Union[None, str, EntityModel, SelectModel]:
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
        elif isinstance(array_ref, ArrayModel):
            param = array_ref.parameter_type

            if isinstance(param, str):
                prefix_str += "property" if array_ref.list_type == ArrayModel.LIST else "multi property"
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
        elif isinstance(value_ref, (EntityModel, SelectModel)):
            prefix_str += "link"
            value_name = value_ref.name
        elif isinstance(value_ref, EnumModel):
            prefix_str += "property"
            items_str = ",".join(f"'{x}'" for x in value_ref.get_enum_items())
            value_name = f"str {{\n            constraint one_of ({items_str});\n        }}"
        else:
            raise NotImplementedError(f'Unknown attribute type "{value_ref}"')

        return f"{prefix_str} {name} -> {value_name};"

    def __repr__(self):
        return f"{self.__class__.__name__}({self.name}:)"


@dataclass
class ArrayModel:
    entity: wrap.attribute = field(repr=False)
    edge_model: IfcSchemaModel = field(repr=False)

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
class EntityBaseModel:
    edge_model: IfcSchemaModel = field(repr=False)
    entity: Union[wrap.entity, wrap.select_type, wrap.enumeration_type, wrap.type_declaration] = field(repr=False)

    @property
    def name(self):
        return self.entity.name()

    @property
    def schema(self):
        return self.edge_model.schema

    def to_str(self) -> str:
        raise NotImplementedError(f"Have not added method for subclass '{self.__class__.__name__}'")


@dataclass
class EntityModel(EntityBaseModel):
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
    _attributes: list[AttributeModel] = field(default=None, repr=False)
    _name: str = None

    def get_derive_map(self) -> dict[str, bool] | None:
        derived = self.entity.derived()
        attributes = self.entity.all_attributes()
        if len(derived) != len(attributes):
            logging.debug("Explicit attributes is NOT redeclared as derived in a subtype")
            return None
        return {attref.name(): derived for derived, attref in zip(derived, attributes)}

    def get_attributes(self, include_inherited_attributes=False) -> list[AttributeModel]:
        atts = []
        att_list = self.entity.attributes() if include_inherited_attributes is False else self.entity.all_attributes()

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
            atts.append(AttributeModel(self.edge_model, att, derived=derived_data))

        return atts

    def get_ancestors(self) -> list[EntityModel]:
        parents = []
        parent = self.entity.supertype()
        while parent is not None:
            parent_entity = self.edge_model.get_entity_by_name(parent.name())
            parents.append(parent_entity)
            parent = parent.supertype()
        return parents

    def get_children(self, current_child=None, children_all=None) -> list[EntityModel]:
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
                    intermediate_classes_str += imc.to_str()
                    imc.written_to_file = True
        return f"""{intermediate_classes_str}
    {prop_prefix}type {name} {parent_str} {{
{att_str}    }}
"""

    def __repr__(self):
        return f"{self.__class__.__name__}({self.name})"


@dataclass
class EnumModel(EntityBaseModel):
    entity: wrap.enumeration_type = field(repr=False)

    def get_enum_items(self):
        return self.entity.enumeration_items()

    def to_str(self) -> str:
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
class TypeModel(EntityBaseModel):
    entity: wrap.type_declaration = field(repr=False)

    def get_cur_decl(self):
        cur_decl = self.entity
        while hasattr(cur_decl, "declared_type") is True:
            cur_decl = cur_decl.declared_type()
        return cur_decl

    def is_aggregate(self):
        cur_decl = self.get_cur_decl()
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
class SelectModel(EntityBaseModel):
    entity: wrap.select_type = field(repr=False)

    def get_select_entities(self, unwrap_all=False) -> list[EntityModel]:
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
class IfcSchemaModel:
    schema_version: str
    schema: wrap.schema_definition = None
    enum_types: Dict[str, EnumModel] = field(default=None, repr=False)
    base_types: Dict[str, TypeModel] = field(default=None, repr=False)
    entities: Dict[str, EntityModel] = field(default=None, repr=False)
    select_types: Dict[str, SelectModel] = field(default=None, repr=False)

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
        self.schema = wrap.schema_by_name(self.schema_version)
        decl = self.schema.declarations()
        self.select_types = {x.name(): SelectModel(self, x) for x in decl if isinstance(x, wrap.select_type)}
        self.enum_types = {x.name(): EnumModel(self, x) for x in decl if isinstance(x, wrap.enumeration_type)}
        self.base_types = {x.name(): TypeModel(self, x) for x in decl if isinstance(x, wrap.type_declaration)}
        type_names = list(self.base_types.keys()) + list(self.select_types.keys()) + list(self.enum_types.keys())
        self.entities = {x.name(): EntityModel(self, x) for x in decl if x.name() not in type_names}

        # instantiate known intermediate classes
        _ = self.entities["IfcBSplineSurface"].attributes_str

    def _find_dependencies(self, entity_name, dep_tree: dict = None, search_recursively=True):
        dep_tree = dict() if dep_tree is None else dep_tree
        entity_model = self.get_entity_by_name(entity_name)
        if isinstance(entity_model, IntermediateClass):
            name = entity_model.name
        else:
            res = entity_model.entity
            name = res.name()

        if name not in dep_tree.keys():
            dep_tree[name] = []

        if isinstance(entity_model, EntityModel):
            for x in entity_model.get_ancestors():
                ancestor_name = x.name
                if ancestor_name not in dep_tree[name]:
                    dep_tree[name].append(ancestor_name)
                    if search_recursively is True:
                        self._find_dependencies(ancestor_name, dep_tree)
            for att in entity_model.get_attributes():
                if att.needs_intermediate_class_str is True:
                    entity = self.get_entity_by_name(att.intermediate_class_name)
                    entity_name = entity.name
                    if entity_name not in dep_tree[name]:
                        dep_tree[name].append(entity_name)
                        if search_recursively is True:
                            self._find_dependencies(entity_name, dep_tree)
                    continue
                else:
                    entity = att.get_type_ref()
                if isinstance(entity, ArrayModel):
                    entity = entity.parameter_type

                if isinstance(entity, str):
                    continue

                entity_name = entity.name
                if entity_name not in dep_tree[name]:
                    dep_tree[name].append(entity_name)
                    if search_recursively is True:
                        self._find_dependencies(entity_name, dep_tree)

        elif isinstance(entity_model, SelectModel):
            for entity in entity_model.get_select_entities():
                entity_name = entity.name
                if entity_name not in dep_tree[name]:
                    dep_tree[name].append(entity_name)
                    if search_recursively is True:
                        self._find_dependencies(entity_name, dep_tree)

        elif isinstance(entity_model, TypeModel):
            en = entity_model.get_cur_decl()
            if isinstance(en, wrap.aggregation_type):
                res = en.type_of_element()
                entity = res.declared_type()
                if not isinstance(entity, str):
                    entity_name = entity.name()
                    if isinstance(entity_name, str) and entity_name not in dep_tree[name]:
                        dep_tree[name].append(entity_name)
                        if search_recursively is True:
                            self._find_dependencies(entity_name, dep_tree)
        elif isinstance(entity_model, EnumModel):
            pass
        elif isinstance(entity_model, IntermediateClass):
            att_type = entity_model.source_attribute.att.type_of_attribute()
            if isinstance(att_type, wrap.aggregation_type):
                res = get_aggregation_type(att_type)
                if isinstance(res, wrap.entity):
                    entity_name = res.name()
                    if entity_name not in dep_tree[name]:
                        dep_tree[name].append(entity_name)
                        if search_recursively is True:
                            self._find_dependencies(entity_name, dep_tree)
        else:
            print(f'Skipping "{name}" -> {entity_model}')
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
        logging.info(circular_deps)

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

    def get_entity_by_name(self, name: str) -> Union[EntityModel, EnumModel, TypeModel, SelectModel, IntermediateClass]:
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
        if isinstance(res, IntermediateClass):
            if res.written_to_file is True:
                return ""
            res.written_to_file = True
        return res.to_str()

    def to_esdl_str(self, entities: list[str], module_name="default") -> str:
        esdl_str = f"module {module_name} {{\n\n"
        for entity_name in entities:
            esdl_str += self.entity_to_edge_str(entity_name)
        esdl_str += "}"
        return esdl_str

    def to_esdl_file(self, esdl_file_path: str | pathlib.Path, entities: list[str], module_name="default") -> None:
        esdl_file_path = pathlib.Path(esdl_file_path)
        os.makedirs(esdl_file_path.parent, exist_ok=True)

        with open(esdl_file_path, "w") as f:
            f.write(self.to_esdl_str(entities, module_name))


IfcSchemaType = TypeVar("IfcSchemaType", EntityModel, EnumModel, TypeModel, SelectModel, IntermediateClass)

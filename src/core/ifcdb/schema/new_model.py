from __future__ import annotations

import logging
import os
import pathlib
from dataclasses import dataclass, field
from enum import Enum
from typing import TYPE_CHECKING, Any, Iterable

import toposort

from ifcdb.config import IfcDbConfig

from .common import CommonData
from .model import (
    ArrayModel,
    AttributeModel,
    EntityModel,
    EnumModel,
    IntermediateClass,
    SelectModel,
    TypeModel,
)
from .utils import get_aggregation_levels, get_base_type_name

if TYPE_CHECKING:
    from .model import IfcSchemaModel

_ENTITY_CLASS = EntityModel | EnumModel | TypeModel | SelectModel | IntermediateClass


@dataclass
class DbEntityUpdate:
    db_entity: DbEntity | DbLink
    entity: _ENTITY_CLASS
    val: AttributeModel | list[_ENTITY_CLASS] | str


@dataclass
class DbEntityModel:
    entities: dict[str, DbEntity]
    config: IfcDbConfig

    def get_entities_in_insert_order(self, break_cyclic_dep=False) -> list[DbEntity]:
        def unwrap_links(links: Iterable[DbLink]):
            all_linked_entity_names = []
            for link in links:
                if isinstance(link.link_to, list):
                    for sub_link in link.link_to:
                        all_linked_entity_names.append(sub_link.name)
                else:
                    all_linked_entity_names.append(link.link_to.name)
            return all_linked_entity_names

        dep_map = {key: unwrap_links(db_entity.get_all_props(skip_props=True).values()) for key, db_entity in self.entities.items()}
        if break_cyclic_dep:
            dep_map['IfcFillAreaStyle'] = []
        result = toposort.toposort_flatten(dep_map)
        return list(map(self.entities.get, result))

    def to_esdl_str(self, module_name: str, limit_to_entities: list[str]):
        types_str = "\n".join([x.to_schema_str() for x in self.entities.values()])
        return f"module {module_name} {{\n\n{types_str}\n}}"

    def to_esdl_file(self, filepath: os.PathLike, module_name: str = "default", limit_to_entities: list[str] = None):
        filepath = pathlib.Path(filepath).resolve().absolute()
        os.makedirs(filepath.parent, exist_ok=True)
        with open(filepath, "w") as f:
            f.write(self.to_esdl_str(module_name, limit_to_entities))


@dataclass
class DbEntityResolver:

    db_entities: dict[str, DbEntity] = field(default_factory=dict)
    to_be_updated_later: list[DbEntityUpdate] = field(default_factory=list)

    def resolve(self, entities: list[_ENTITY_CLASS]):
        for entity in entities:
            db_entity = self.convert_entity(entity)
            if db_entity is None:
                continue
            if db_entity.name in self.db_entities.keys():
                raise ValueError("Duplicate db entities should not happen")
            self.db_entities[db_entity.name] = db_entity

        to_be_updated = [x for x in self.to_be_updated_later]

        for entity in to_be_updated:
            self.update_db_entities(entity)

        # Clear update list
        self.to_be_updated_later = []

        # Update supertype relationships
        for key, entity in self.db_entities.items():
            if entity.extending is None:
                continue

            if isinstance(entity.extending, str):
                supertype_class = self.db_entities.get(entity.extending)
                entity.extending = supertype_class
            else:
                supertype_class = entity.extending

            supertype_class.extended_by.append(entity)

        # Check for incompatible nested linked list of
        new_db_entities = []
        for entity in self.db_entities.values():
            for link in entity.links.values():
                is_nested_link = link.array_def is not None and link.array_def.levels > 1
                if is_nested_link is False:
                    continue
                new_intermediate_db_entity_name = "List_of_" + link.link_to.name
                new_link_name = link.link_to.name + "s"
                new_db_link = DbLink(new_link_name, link.link_to, array_def=link.array_def)
                new_db_entity = DbEntity(new_intermediate_db_entity_name, links={new_link_name: new_db_link})
                new_db_entities.append(new_db_entity)
                link.link_to = new_db_entity

        for new_db_entity in new_db_entities:
            self.db_entities[new_db_entity.name] = new_db_entity

        # Add linked_from properties
        for db_entity in self.db_entities.values():
            for link in db_entity.links.values():
                link.link_from = db_entity
                if isinstance(link.link_to, DbEntity):
                    if link not in link.link_to.linked_from:
                        link.link_to.linked_from.append(link)
                else:
                    for sl in link.link_to:
                        if link not in sl.linked_from:
                            sl.linked_from.append(link)

    def convert_entity(self, entity: _ENTITY_CLASS) -> DbEntity | None:
        if isinstance(entity, TypeModel):
            return self._convert_type_model(entity)
        elif isinstance(entity, EnumModel):
            return self._convert_enum_model(entity)
        elif isinstance(entity, SelectModel):
            return self._convert_select_model(entity)
        elif isinstance(entity, EntityModel):
            return self._convert_entity_model(entity)
        elif isinstance(entity, IntermediateClass):
            return self._convert_intermediate_class_model(entity)
        else:
            raise NotImplementedError()

    def update_db_entities(self, update_entity: DbEntityUpdate):
        if isinstance(update_entity.db_entity, DbEntity) and update_entity.db_entity.is_select:
            self._update_select(update_entity)
        elif isinstance(update_entity.db_entity, DbEntity):
            self._update_db_entity(update_entity)
        elif isinstance(update_entity.db_entity, DbLink) and isinstance(update_entity.val, str):
            self._update_db_link(update_entity)
        else:
            raise NotImplementedError()

    def unwrap_selects(self):
        non_select_entities = list(filter(lambda x: x.is_select is False, self.db_entities.values()))
        for link in walk_links_with_selects(non_select_entities):
            select_entity = link.link_to
            select_link = select_entity.links[select_entity.name]
            sub_entities = unwrap_and_flatten_selects_to_list(select_link)
            for se in sub_entities:
                if se.name not in self.db_entities.keys():
                    self.db_entities[se.name] = se
            non_select_db_entity = link.link_from
            # Replace link pointing to Select object with a link pointing directly to all wrapped entities
            non_select_db_entity.links[link.name] = DbLink(
                link.name,
                link_to=sub_entities,
                is_select=True,
                optional=link.optional,
                link_from=link.link_from,
                array_def=link.array_def,
            )

        # Remove all select entities
        select_entities = list(filter(lambda x: x.is_select, self.db_entities.values()))
        for s in select_entities:
            self.db_entities.pop(s.name)
        logging.info(f'Flattened and removed "{len(select_entities)}" Selects')

    def unwrap_enums(self):
        enums_removed = 0
        links_severed = 0
        entities_list = list(filter(lambda x: x.is_enum, self.db_entities.values()))
        db_entities_with_links_to_pop = []
        for db_entity in entities_list:
            for link in db_entity.linked_from:
                linking_db_entity = link.link_from
                if linking_db_entity.is_select:
                    continue

                # Make a copy of the enum as it is used by others with different link properties
                enum_prop = db_entity.props[db_entity.name].copy()

                enum_prop.optional = link.optional

                linking_db_entity.props[link.name] = enum_prop
                if link.name in linking_db_entity.links.keys():
                    db_entities_with_links_to_pop.append((linking_db_entity, link.name))

                links_severed += 1

            self.db_entities.pop(db_entity.name)
            enums_removed += 1

        for linking_db_entity, link_name in db_entities_with_links_to_pop:
            if link_name in linking_db_entity.links.keys():
                linking_db_entity.links.pop(link_name)

        logging.info(f'Removed {enums_removed} Enums and replaced "{links_severed}" links to Enums with DbProp objects')

    def _update_db_link(self, update_entity: DbEntityUpdate):
        linked_to = self.db_entities.get(update_entity.val)
        if linked_to is None:
            raise NotImplementedError()
        update_entity.db_entity.link_to = linked_to

    def _update_db_entity(self, update_entity: DbEntityUpdate):
        key = update_entity.val.name
        value = update_entity.db_entity.links.get(key)
        if value is not None:
            raise ValueError
        link = self.get_link(update_entity.val)
        if link is None:
            raise ValueError("")

        update_entity.db_entity.links[key] = link

    def _update_select(self, update_entity: DbEntityUpdate):
        entity = update_entity.db_entity
        for missing_entity in update_entity.val:
            link = entity.links[entity.name]
            if None in link.link_to:
                link.link_to = [x for x in link.link_to if x is not None]

            existing_obj = self.db_entities.get(missing_entity.name, None)
            if existing_obj is None:
                raise ValueError()

            link.link_to.append(existing_obj)

    def _convert_type_model(self, entity: TypeModel):
        array_type = None
        if entity.is_aggregate():
            array_type = get_array_obj(entity)

        value = get_base_type_name(entity.entity)
        if isinstance(value, str):
            return DbEntity(entity.name, props={entity.name: DbProp(value, array_def=array_type)})
        else:
            ref_db_entity = self.db_entities.get(value.name())

            if ref_db_entity is None:
                ref_db_entity = value.name()

            link = DbLink(entity.name, link_to=ref_db_entity, array_def=array_type)
            db_entity = DbEntity(entity.name, links={entity.name: link})
            if isinstance(ref_db_entity, str):
                self.to_be_updated_later.append(DbEntityUpdate(link, entity, value.name()))

            return db_entity

    def _convert_enum_model(self, entity: EnumModel):
        enum_data = entity.get_enum_items()
        return DbEntity(entity.name, props={entity.name: DbProp(enum_data, is_enum=True)}, is_enum=True)

    def _convert_select_model(self, entity: SelectModel):
        select_entities = entity.get_select_entities()
        select_db_entities = []
        missing_select_entities = []
        for s in select_entities:
            existing_entity = self.db_entities.get(s.name)
            if existing_entity is None:
                missing_select_entities.append(s)
            select_db_entities.append(existing_entity)

        link = DbLink(entity.name, select_db_entities, is_select=True)
        db_entity = DbEntity(entity.name, links={entity.name: link}, is_select=True)

        if len(missing_select_entities) > 0:
            self.to_be_updated_later.append(DbEntityUpdate(db_entity, entity, missing_select_entities))
        return db_entity

    def _convert_entity_model(self, entity: EntityModel):
        db_parent = None
        parent = entity.entity.supertype()
        if parent is not None:
            db_parent = self.db_entities.get(parent.name())
            if db_parent is None:
                db_parent = parent.name()

        links: dict[str, DbLink] = dict()
        props: dict[str, DbProp] = dict()

        db_entity = DbEntity(entity.name, links, props, extending=db_parent, abstract=entity.entity.is_abstract())
        for val in entity.get_attributes():
            val_name = val.name
            if self.is_val_prop(val):
                props[val_name] = self.get_prop(val)
            else:
                link = self.get_link(val)
                if link is None:
                    self.to_be_updated_later.append(DbEntityUpdate(db_entity, entity, val))

                links[val_name] = link

        return db_entity

    def _convert_intermediate_class_model(self, entity: IntermediateClass):
        links = dict()
        db_entity = DbEntity(entity.name, links=links)
        link = self.get_link(entity.source_attribute)
        if link is None:
            self.to_be_updated_later.append(DbEntityUpdate(db_entity, entity, entity.source_attribute))
        links[entity.att_name] = link
        return db_entity

    def is_val_prop(self, val: AttributeModel) -> bool:
        array_ref = val.array_ref()
        value_ref = val.entity_ref()
        if isinstance(value_ref, (SelectModel, EntityModel, EnumModel)):
            return False
        if isinstance(value_ref, str) or (value_ref is None and isinstance(array_ref, ArrayModel)):
            return True
        else:
            raise NotImplementedError()

    def get_prop(self, val: AttributeModel) -> DbProp:
        array_ref = val.array_ref()
        value_ref = val.entity_ref()
        optional = val.optional
        if isinstance(value_ref, str):
            return DbProp(value_ref, optional=optional)
        elif value_ref is None and isinstance(array_ref, ArrayModel):
            array_type = get_array_obj(array_ref)
            return DbProp(array_ref.parameter_type, array_type, optional=optional)
        else:
            raise NotImplementedError()

    def get_link(self, val: AttributeModel) -> DbLink | None:
        array_ref = val.array_ref()
        value_ref = val.entity_ref()
        optional = val.optional
        if isinstance(value_ref, (SelectModel, EntityModel, EnumModel)):
            existing_db_object = self.db_entities.get(value_ref.name, None)
            if existing_db_object is None:
                return None

            array_def = get_array_obj(array_ref) if array_ref is not None else None
            return DbLink(val.name, existing_db_object, array_def=array_def, optional=optional)
        else:
            raise NotImplementedError()


class DbListTypes(Enum):
    TUPLE = "tuple"
    ARRAY = "array"


class IfcListTypes(Enum):
    LIST = "list"
    SET = "set"
    ARRAY = "array"
    BAG = "bag"

    @staticmethod
    def from_str(list_type: str):
        emap = {e.value: e for e in IfcListTypes}
        return emap.get(list_type)

    @staticmethod
    def from_ifc_agg_type(agg_type: int):
        agg_map = {0: IfcListTypes.ARRAY, 1: IfcListTypes.BAG, 2: IfcListTypes.LIST, 3: IfcListTypes.SET}
        return agg_map.get(agg_type)


@dataclass
class ArrayShape:
    ifc_agg_type: IfcListTypes
    bound_type: DbListTypes
    lower_bound: int
    upper_bound: int


@dataclass
class ArrayDef:
    list_type: IfcListTypes
    shapes: list[ArrayShape]

    @property
    def levels(self) -> int:
        return len(self.shapes)

    def get_variable_bound_constraint_str(self, indent: str) -> str:
        s = self.shapes[-1]
        lower = s.lower_bound
        upper = s.upper_bound

        if s.upper_bound == s.lower_bound or upper == -1:
            return ""

        g = indent + 4 * " "
        g2 = indent
        range_str = ""
        range_l = list(range(lower, upper + 1))
        for j, k in enumerate(range_l, start=1):
            range_str += f"len(__subject__) = {k}"
            range_str += " or " if j != len(range_l) else ""
        constr_str = f"{{\n{g}constraint expression on ({range_str})\n{g2}}}"
        return constr_str

    def get_base_property_str(self, prop_value: Any = None) -> str:
        s = self.shapes[-1]
        prop_text = "{prop_value}" if prop_value is None else f"{prop_value}"
        if s.upper_bound != s.lower_bound:
            return prop_text
        final_prop = ",".join([prop_text] * s.upper_bound)
        return final_prop

    def to_str(self, indent: str, prop_value: Any = None) -> str:
        if self.list_type not in (IfcListTypes.LIST, IfcListTypes.SET, IfcListTypes.ARRAY):
            raise NotImplementedError()
        left_side = ""
        middle = self.get_base_property_str(prop_value)
        constr_str = self.get_variable_bound_constraint_str(indent)
        right_side = ""

        for i, s in enumerate(self.shapes):
            bound_type = s.bound_type
            if bound_type == DbListTypes.TUPLE and s.upper_bound == -1:
                bound_type = DbListTypes.ARRAY
            else:
                bound_type = bound_type

            bound_type_str = bound_type.value
            left_side += f"{bound_type_str}<"
            right_side += ">"

        return left_side + middle + right_side + constr_str


class PropValue(Enum):
    FLOAT64 = "float64"
    INT64 = "int64"

    @staticmethod
    def from_str(lstype: str):
        emap = {e.value: e for e in PropValue}
        return emap.get(lstype)


@dataclass
class DbProp:
    prop_value: Any
    array_def: ArrayDef = field(default=None)
    is_enum: bool = field(default=False)
    optional: bool = False

    PROP_VALUE: PropValue = PropValue

    def copy(self) -> DbProp:
        return DbProp(self.prop_value, self.array_def, self.is_enum, self.optional)

    def to_str(self, indent: str) -> str:
        if self.array_def is not None:
            array_str = self.array_def.to_str(indent, prop_value=self.prop_value)
            return array_str

        elif self.is_enum is True:
            ident = 12 * " "
            enum_str = ",".join([f"'{x}'" for x in self.prop_value])
            return f"str {{\n{ident}constraint one_of ({enum_str});\n{indent}}}"
        else:
            return self.prop_value


@dataclass
class DbLink:
    name: str
    link_to: DbEntity | list[DbEntity]
    link_from: DbEntity = field(repr=False, default=None)
    is_select: bool = field(default=False)
    optional: bool = False
    array_def: ArrayDef = None

    def to_str(self) -> str:
        if self.is_select:
            return " | ".join([f"{x.name}" for x in self.link_to])
        elif isinstance(self.link_to, DbEntity):
            return self.link_to.name
        else:
            raise NotImplementedError()

    def get_derived_type(self, ifc_class_name) -> DbEntity | None:
        if isinstance(self.link_to, list) is False:
            link_to = [self.link_to]
        else:
            link_to = self.link_to

        entities = []
        for x in link_to:
            entities += get_db_entity_children(x)

        rmp = {x.name: x for x in entities}
        return rmp.get(ifc_class_name, None)

    def get_value_if_valid_linked_to(self, entity_ifc_class: str, max_levels=10) -> DbEntity | None:
        if isinstance(self.link_to, list):
            link_names = {x.name: x for x in self.link_to}
        else:
            link_names = {self.link_to.name: self.link_to}

        db_entity = link_names.get(entity_ifc_class, None)
        if db_entity is not None:
            return db_entity

        result = self.get_derived_type(entity_ifc_class)
        extended = result.extending

        level = 0
        while extended:
            if extended.name in link_names:
                break
            extended = extended.extending
            level += 1
            if level > max_levels:
                return None

        return extended


@dataclass
class DbEntity:
    name: str
    links: dict[str, DbLink] = field(default_factory=dict)
    props: dict[str, DbProp] = field(default_factory=dict)
    extending: DbEntity = field(default=None, repr=False)
    linked_from: list[DbLink] = field(default_factory=list, repr=False)
    abstract: bool = False
    extended_by: list[DbEntity] = field(default_factory=list, repr=False)

    is_select: bool = False
    is_enum: bool = False

    def get_all_props(self, skip_props=False, skip_links=False) -> dict[str, DbProp | DbLink]:
        props = {}
        if skip_props is False:
            props.update(self.props)
        if skip_links is False:
            props.update(self.links)
        curr_db_entity = self
        while True:
            if curr_db_entity.extending is None:
                break
            curr_db_entity = curr_db_entity.extending
            if skip_props is False:
                props.update(curr_db_entity.props)
            if skip_links is False:
                props.update(curr_db_entity.links)
        return props

    def links_str(self, indent: str) -> str:
        links_str = ""
        for key, link in self.links.items():
            opt_str = "required " if link.optional is False else ""
            multi_str = "multi " if link.array_def is not None else ""
            safe_name = CommonData.get_safe_key(key)
            links_str += f"{indent}{opt_str}{multi_str}link {safe_name} -> {link.to_str()};\n"
        return links_str

    def props_str(self, indent: str) -> str:
        props_str = ""
        for key, prop in self.props.items():
            safe_key = key
            if key == self.name:
                safe_key = f"`{key}`"

            safe_name = CommonData.get_safe_key(safe_key)
            opt_str = "required " if prop.optional is False else ""
            props_str += f"{indent}{opt_str}property {safe_name} -> {prop.to_str(indent)};\n"
        return props_str

    def to_schema_str(self, indent=4 * " "):
        extending_str = ""
        if self.extending is not None:
            extending_str = f" extending {self.extending.name}"

        si = 2 * indent
        att_str = self.props_str(si) + self.links_str(si)
        abstract_str = "" if self.abstract is False else "abstract "
        return f"{indent}{abstract_str}type {self.name}{extending_str} {{\n{att_str}{indent}}}\n"


def get_array_obj(array_ref) -> ArrayDef:
    if isinstance(array_ref, ArrayModel):
        ltype = IfcListTypes.from_str(array_ref.list_type)
        levels = array_ref.get_levels()
    elif isinstance(array_ref, TypeModel):
        levels = get_aggregation_levels(array_ref.entity.declared_type())
        ltype = IfcListTypes.from_ifc_agg_type(levels[0].type_of_aggregation())
    else:
        raise NotImplementedError(f"Unrecognized type {type(array_ref)}")

    shapes = []
    for i, level in enumerate(levels):
        shape_ltype = IfcListTypes.from_ifc_agg_type(levels[0].type_of_aggregation())
        b1 = level.bound1()
        b2 = level.bound2()
        if len(levels) > 1 and i == 0:
            db_list_type = DbListTypes.ARRAY
        else:
            db_list_type = DbListTypes.ARRAY if b2 == 1 else DbListTypes.TUPLE

        if b1 != b2 and b2 != -1 and len(levels) == 1:
            db_list_type = DbListTypes.ARRAY

        shapes.append(ArrayShape(shape_ltype, db_list_type, b1, b2))

    return ArrayDef(ltype, shapes)


def walk_links_with_selects(non_select_entities: list[DbEntity]) -> Iterable[DbLink]:
    for db_entity in non_select_entities:
        for link in db_entity.links.values():
            if isinstance(link.link_to, DbEntity) and link.link_to.is_select is True:
                yield link


def unwrap_and_flatten_selects_to_list(link: DbLink, entities: list[DbEntity] = None) -> list[DbEntity]:
    """Drill down all nested Select paths and return all relevant DbEntities into a single flat list"""
    entities = [] if entities is None else entities
    for sub_entity in link.link_to:
        if sub_entity.is_select is False:
            entities.append(sub_entity)
        else:
            unwrap_and_flatten_selects_to_list(sub_entity.links[sub_entity.name], entities)

    return entities


def db_entity_model_from_schema_model(
    ifm: IfcSchemaModel, entities: list[str] = None, unwrap_enums=True, unwrap_selects=True
) -> DbEntityModel:
    der = DbEntityResolver()
    if entities is None:
        entities = [ifm.get_entity_by_name(x) for x in ifm.get_all_entities()]
    else:
        entities = [ifm.get_entity_by_name(x) for x in ifm.get_related_entities(entities)]

    der.resolve(entities)
    if unwrap_enums:
        der.unwrap_enums()
    if unwrap_selects:
        der.unwrap_selects()

    return DbEntityModel(der.db_entities, IfcDbConfig(ifm.schema_version, unwrap_enums, unwrap_selects))


def db_entity_model_from_schema_version(
    schema_version: str, entities: list[str] = None, unwrap_enums=True, unwrap_selects=True
) -> DbEntityModel:
    from .model import IfcSchemaModel

    ifm = IfcSchemaModel(schema_version)
    return db_entity_model_from_schema_model(ifm, entities, unwrap_enums, unwrap_selects)


def get_db_entity_children(db_entity: DbEntity, entities: list[DbEntity] = None):
    entities = [] if entities is None else entities
    entities.append(db_entity)
    for x in db_entity.extended_by:
        get_db_entity_children(x, entities)
    return entities

from __future__ import annotations

import os
import pathlib
from dataclasses import dataclass, field
from enum import Enum
from typing import Any

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

_ENTITY_CLASS = EntityModel | EnumModel | TypeModel | SelectModel | IntermediateClass


@dataclass
class DbEntityUpdate:
    db_entity: DbEntity | DbLink
    entity: _ENTITY_CLASS
    val: AttributeModel | list[_ENTITY_CLASS]


@dataclass
class DbEntityResolver:
    all_entities: list[_ENTITY_CLASS]
    db_entities: dict[str, DbEntity] = field(default_factory=dict)

    to_be_updated_later: list[DbEntityUpdate] = field(default_factory=list)

    def convert_entity(self, entity: _ENTITY_CLASS) -> DbEntity | None:
        if isinstance(entity, TypeModel):
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
        elif isinstance(entity, EnumModel):
            enum_data = entity.get_enum_items()
            return DbEntity(entity.name, props={entity.name: DbProp(enum_data, is_enum=True)})
        elif isinstance(entity, SelectModel):
            select_entities = entity.get_select_entities()
            select_db_entities = []
            missing_select_entities = []
            for s in select_entities:
                existing_entity = self.db_entities.get(s.name)
                if existing_entity is None:
                    missing_select_entities.append(s)
                select_db_entities.append(existing_entity)

            link = DbLink(entity.name, select_db_entities, is_select=True)
            db_entity = DbEntity(entity.name, links={entity.name: link})

            if len(missing_select_entities) > 0:
                self.to_be_updated_later.append(DbEntityUpdate(db_entity, entity, missing_select_entities))
            return db_entity
        elif isinstance(entity, EntityModel):
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

        elif isinstance(entity, IntermediateClass):
            links = dict()
            db_entity = DbEntity(entity.name, links=links)
            link = self.get_link(entity.source_attribute)
            if link is None:
                self.to_be_updated_later.append(DbEntityUpdate(db_entity, entity, entity.source_attribute))
            links[entity.att_name] = link
            return
        else:
            raise NotImplementedError()

    def update_db_entities(self, update_entity: DbEntityUpdate):
        if isinstance(update_entity.val, list):
            entity = update_entity.db_entity
            for missing_entity in update_entity.val:
                link = entity.links[entity.name]
                existing_obj = self.db_entities.get(missing_entity.name, None)
                if existing_obj is None:
                    raise ValueError("")
                if None in link.link_to:
                    index = link.link_to.index(None)
                    link.link_to.pop(index)
                link.link_to.append(existing_obj)
        elif isinstance(update_entity.val, str) and isinstance(update_entity.db_entity, DbLink):

            linked_to = self.db_entities.get(update_entity.val)
            if linked_to is None:
                raise NotImplementedError()
            update_entity.db_entity.link_to = linked_to
        else:
            key = update_entity.val.name
            value = update_entity.db_entity.links.get(key)
            if value is not None:
                raise ValueError
            link = self.get_link(update_entity.val)
            if link is None:
                raise ValueError("")

            update_entity.db_entity.links[key] = link

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

    def resolve(self):
        for entity in self.all_entities:
            db_entity = self.convert_entity(entity)
            if db_entity is None:
                continue
            if db_entity.name in self.db_entities.keys():
                raise ValueError("Duplicate db entities should not happen")
            self.db_entities[db_entity.name] = db_entity

        to_be_updated = [x for x in self.to_be_updated_later]

        for entity in to_be_updated:
            self.update_db_entities(entity)

        # Update supertype relationships
        for key, entity in self.db_entities.items():
            if entity.extending is None:
                continue
            if isinstance(entity.extending, str):
                entity.extending = self.db_entities.get(entity.extending)

        # Check for incompatible nested linked list of
        new_db_entities = []
        for key, entity in self.db_entities.items():
            for link_name, link in entity.links.items():
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

    def unwrap_selects(self):
        def get_all_selects(e: DbLink, selects: list[DbEntity] = None) -> list[DbEntity]:
            selects = [] if selects is None else selects
            for sub_link in e.link_to:
                contains_sub_selects = False
                for slink in sub_link.links.values():
                    if slink.is_select is False:
                        continue
                    contains_sub_selects = True
                    get_all_selects(slink, selects)
                if contains_sub_selects is False:
                    selects.append(sub_link)

            return selects

        entities_to_pop = []
        for name, db_entity in self.db_entities.items():
            if "Select" in name:
                continue
            for key, link in db_entity.links.items():
                if link.is_select is False:
                    continue
                entities = get_all_selects(link)
                if len(entities) == len(link.link_to):
                    continue
                # print(f"selects {len(entities)}")

                if db_entity not in entities_to_pop:
                    entities_to_pop.append(db_entity)
                link.link_to = entities

        for entity in entities_to_pop:
            self.db_entities.pop(entity.name)

        print(f'Flattened and removed "{len(entities_to_pop)}" Selects')

    def unwrap_enums(self):
        def get_enum(e: DbEntity) -> DbProp | None:
            if "Enum" not in e.name:
                return None
            for prop in e.props.values():
                if prop.is_enum is True:
                    return prop
            return None

        entities_to_pop = []
        for name, db_entity in self.db_entities.items():
            links_to_pop = []

            for key, link in db_entity.links.items():
                if isinstance(link.link_to, DbEntity) is False:
                    continue
                enum_prop = get_enum(link.link_to)
                if enum_prop is None:
                    continue
                if link.link_to not in entities_to_pop:
                    entities_to_pop.append(link.link_to)
                db_entity.props[key] = enum_prop
                links_to_pop.append(key)
            for key in links_to_pop:
                db_entity.links.pop(key)

        for entity in entities_to_pop:
            self.db_entities.pop(entity.name)

        print(f'Converted and removed "{len(entities_to_pop)}" Enums to simple constraints on string properties')

    def get_db_entities(self, unwrap_enums=False, unwrap_selects=False) -> list[DbEntity]:
        self.resolve()

        if unwrap_enums:
            self.unwrap_enums()

        if unwrap_selects:
            self.unwrap_selects()

        return list(self.db_entities.values())

    def to_esdl_str(self, module_name: str):
        types_str = "\n".join([x.to_schema_str() for x in self.db_entities.values()])
        return f"module {module_name} {{\n\n{types_str}\n}}"

    def to_esdl_file(self, filepath: os.PathLike, module_name: str = "default"):
        filepath = pathlib.Path(filepath).resolve().absolute()
        os.makedirs(filepath.parent, exist_ok=True)
        with open(filepath, "w") as f:
            f.write(self.to_esdl_str(module_name))


class DbListTypes(Enum):
    TUPLE = "tuple"
    ARRAY = "array"


class IfcListTypes(Enum):
    LIST = "list"
    SET = "set"
    ARRAY = "array"
    BAG = "bag"

    @staticmethod
    def from_str(lstype: str):
        emap = {e.value: e for e in IfcListTypes}
        return emap.get(lstype)

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
            left_side += f"{s.bound_type.value}<"
            right_side += ">"

        return left_side + middle + right_side + constr_str


@dataclass
class DbProp:
    prop_value: Any
    array_def: ArrayDef = field(default=None)
    is_enum: bool = field(default=False)
    optional: bool = False

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
    link_from: list[DbEntity] = field(repr=False, default_factory=list)
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


@dataclass
class DbEntity:
    name: str
    links: dict[str, DbLink] = field(default_factory=dict)
    props: dict[str, DbProp] = field(default_factory=dict)
    extending: DbEntity = field(default=None, repr=False)
    abstract: bool = False

    def __post_init__(self):
        for link in self.links.values():
            if link is None:
                continue
            link.link_from.append(self)

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

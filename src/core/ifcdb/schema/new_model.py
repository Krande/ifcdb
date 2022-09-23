from __future__ import annotations

from dataclasses import dataclass, field
from enum import Enum
from typing import Any

from .model import (
    ArrayModel,
    AttributeModel,
    EntityModel,
    EnumModel,
    IntermediateClass,
    SelectModel,
    TypeModel,
)
from .utils import get_base_type_name

_ENTITY_CLASS = EntityModel | EnumModel | TypeModel | SelectModel | IntermediateClass


@dataclass
class DbEntityUpdate:
    db_entity: DbEntity
    entity: _ENTITY_CLASS
    val: AttributeModel | list[_ENTITY_CLASS]


@dataclass
class DbEntityResolver:
    all_entities: list[_ENTITY_CLASS]
    db_entities: dict[str, DbEntity] = field(default_factory=dict)

    to_be_updated_later: list[DbEntityUpdate] = field(default_factory=list)

    def convert_entity(self, entity: _ENTITY_CLASS) -> DbEntity | None:
        entity_name = entity.name

        if isinstance(entity, TypeModel):
            value = get_base_type_name(entity.entity)
            return DbEntity(entity.name, props={entity.name: DbProp(value)})
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
                db_parent = self.db_entities.get(parent.name)

            links: dict[str, DbLink] = dict()
            props: dict[str, DbProp] = dict()
            db_entity = DbEntity(entity_name, links, props, parent=db_parent)
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
            db_entity = DbEntity(entity_name, links=links)
            link = self.get_link(entity.source_attribute)
            if link is None:
                self.to_be_updated_later.append(DbEntityUpdate(db_entity, entity, entity.source_attribute))
            links[entity.att_name] = link
            return
        else:
            raise NotImplementedError()

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
            ltype = ListTypes.from_str(array_ref.list_type)
            levels = array_ref.get_levels()
            array_type = ArrayType(ltype, len(levels))

            return DbProp(array_ref.parameter_type, array_type, optional=optional)
        else:
            raise NotImplementedError()

    def get_link(self, val: AttributeModel) -> DbLink | None:
        # array_ref = val.array_ref()
        value_ref = val.entity_ref()
        optional = val.optional
        if isinstance(value_ref, (SelectModel, EntityModel, EnumModel)):
            existing_db_object = self.db_entities.get(value_ref.name, None)
            if existing_db_object is None:
                return None
            return DbLink(val.name, existing_db_object, optional=optional)
        else:
            raise NotImplementedError()

    def get_db_entities(self) -> list[DbEntity]:
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

        return list(self.db_entities.values())

    def update_db_entities(self, update_entity: DbEntityUpdate):
        if isinstance(update_entity.val, list):
            # These are select objects
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
                print("sd")
        else:
            keys = update_entity.db_entity.links.keys()
            for key in keys:
                value = update_entity.db_entity.links.get(key)
                if value is not None:
                    continue
                link = self.get_link(update_entity.val)
                if link is None:
                    raise ValueError("")

                update_entity.db_entity.links[key] = link


class ListTypes(Enum):
    LIST = "list"
    SET = "set"
    ARRAY = "array"

    @staticmethod
    def from_str(lstype: str):
        emap = {e.value: e for e in ListTypes}
        return emap.get(lstype)


@dataclass
class ArrayType:
    list_type: ListTypes
    levels: int


@dataclass
class DbProp:
    prop_value: Any
    array_def: ArrayType = field(default=None)
    is_enum: bool = field(default=False)
    optional: bool = False

    def to_str(self) -> str:
        if self.array_def is not None:
            if self.array_def.list_type in (ListTypes.LIST, ListTypes.SET, ListTypes.ARRAY):
                if self.array_def.levels == 1:
                    return f"tuple<{self.prop_value}>"
                elif self.array_def.levels == 2:
                    return f"array<tuple<{self.prop_value}>>"
                else:
                    raise NotImplementedError()
            else:
                raise NotImplementedError()
        elif self.is_enum is True:
            ident = 12 * " "
            enum_str = ",".join([f"'{x}'" for x in self.prop_value])
            return f"str {{\n{ident}constraint one_of ({enum_str});\n}};\n"
        else:
            return self.prop_value


@dataclass
class DbLink:
    name: str
    link_to: DbEntity | list[DbEntity]
    multi: bool = False
    link_from: list[DbEntity] = field(repr=False, default_factory=list)
    is_select: bool = field(default=False)
    optional: bool = False

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
    parent: DbEntity = field(default=None)

    def __post_init__(self):
        for link in self.links.values():
            if link is None:
                continue
            link.link_from.append(self)

    def links_str(self) -> str:
        links_str = ""
        for key, link in self.links.items():
            opt_str = "required " if link.optional is False else ""
            links_str += f"{opt_str}link {key} -> {link.to_str()};\n"
        return links_str

    def props_str(self) -> str:
        props_str = ""
        for key, prop in self.props.items():
            opt_str = "required " if prop.optional is False else ""
            props_str += f"{opt_str}property {key} -> {prop.to_str()};\n"
        return props_str

    def to_schema_str(self):
        parent_str = ""
        if self.parent is not None:
            parent_str = f" extending {self.parent.name}"
        return f"type {self.name}{parent_str} {{\n {self.links_str()}{self.props_str()}\n}}\n"

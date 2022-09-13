from __future__ import annotations

from dataclasses import dataclass, field
from itertools import count
from typing import TYPE_CHECKING

from ifcdb.database.select import EdgeSelect
from ifcdb.entities import Entity

if TYPE_CHECKING:
    from ifcdb.diffing.tool import EntityDiffAdd


@dataclass
class EdgeInsert:
    name: str
    entity: Entity

    def to_edql_str(self, assign_to_variable=True):
        props = ""
        props_writable = {p: v for p, v in self.entity.props.items() if v is not None}
        if len(props_writable) > 0:
            props = to_props_str(self.entity)
        links = ""
        if len(self.entity.links) > 0:
            if len(props_writable) > 0:
                links += ", "
            links += to_links_str(self.entity)
        if assign_to_variable:
            return f"{self.name} := (INSERT {self.entity.name} {{ {props}{links} }}),"
        else:
            return f"INSERT {self.entity.name} {{ {props}{links} }}"


@dataclass
class BulkEntityInsert:
    entities: list[EntityDiffAdd]

    inserts: dict[str, EdgeInsert] = field(default_factory=dict)
    selects: dict[str, EdgeSelect] = field(default_factory=dict)

    indent: str = 4 * " "

    def __post_init__(self):
        for entity_add in self.entities:
            for key, value in entity_add.added.linked_objects.items():
                if value == entity_add.added.entity:
                    continue
                self.inserts[key] = EdgeInsert(key, value)

    def get_global_with_str(self, indent_override: str = None):
        insert_str = "with\n"
        indent = self.indent if indent_override is None else indent_override
        for key, insert in self.inserts.items():
            insert_str += indent + f"{key} := ({insert.to_edql_str()}),\n"
        return insert_str

    def get_insert_str(self, entity: EntityDiffAdd, indent_override: str = None):
        indent = self.indent if indent_override is None else indent_override
        insert_str = ""
        prop_str = to_props_str(entity.added.entity, sep=f",\n{indent}")
        lstr = to_links_str(entity.added.entity, sep=f",\n{indent}")
        if prop_str != "":
            prop_str += f",\n{indent}"
        insert_str += f"INSERT {entity.class_name} {{\n{indent}{prop_str}{lstr} }}\n"
        return insert_str

    def to_edql_str(self, variable_counter: count = None, embed_with_statement=True):
        extra_with_indent = None
        if variable_counter is not None:
            extra_with_indent = self.indent * 2

        global_with_str = ""
        if embed_with_statement:
            global_with_str = self.get_global_with_str(extra_with_indent)
        insert_str = ""
        for entity in self.entities:
            istr = self.get_insert_str(entity, indent_override=extra_with_indent)
            if variable_counter is not None:
                new_name = f"insert{next(variable_counter)}"
                insert_str += f"{new_name} := (\n{self.indent}{global_with_str}{self.indent}{istr}),\n"
            else:
                insert_str += global_with_str + istr
        return insert_str


def link_select(v: Entity, wrap_select=False) -> str:
    if v.uuid is None:
        return v.temp_unique_identifier
    else:
        if wrap_select:
            return f"(SELECT {v.name} filter .id = <uuid>'{v.uuid}')"
        else:
            return f"SELECT {v.name} filter .id = <uuid>'{v.uuid}'"


def to_links_str(entity: Entity, sep=", "):
    lstr = ""

    for key, value in entity.links.items():
        if value is None:
            continue

        if isinstance(value, Entity):
            lstr += f"{key}:= {link_select(value)}{sep}"
        elif isinstance(value, tuple):
            lstr += f"{key}:= {{"
            lstr += ",".join([link_select(v, wrap_select=True) for v in value])
            lstr += f"}}{sep}"
        else:
            raise NotImplementedError(f"Currently unsupported: {type(value)}")
    return lstr


def to_bulk_insert_str(entity: EntityDiffAdd):
    insert_str = "with\n"
    indent = 4 * " "
    for key, value in entity.added.linked_objects.items():
        if value == entity.added.entity:
            continue
        props = ""
        props_writable = {p: v for p, v in value.props.items() if v is not None}
        if len(props_writable) > 0:
            props = to_props_str(value)
        links = ""
        if len(value.links) > 0:
            if len(props_writable) > 0:
                links += ", "
            links += to_links_str(value)
        insert_str += indent + f"{key} := (INSERT {value.name} {{ {props}{links} }}),\n"

    prop_str = to_props_str(entity.added.entity, sep=f",\n{indent}")
    lstr = to_links_str(entity.added.entity, sep=f",\n{indent}")
    if prop_str != "":
        prop_str += f",\n{indent}"
    insert_str += f"INSERT {entity.class_name} {{\n{indent}{prop_str}{lstr} }};"
    return insert_str


def value_writer(value) -> str:
    if isinstance(value, str):
        return f"'{value}'"
    elif isinstance(value, tuple):
        return f"{list(value)}"
    else:
        return value


def to_props_str(entity: Entity, sep=", "):
    return sep.join([f"{key}:= {value_writer(value)}" for key, value in entity.props.items() if value is not None])

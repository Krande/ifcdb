from __future__ import annotations

from dataclasses import dataclass, field
from itertools import count
from typing import TYPE_CHECKING

from ifcdb.database.select import EdgeSelect
from ifcdb.entities import Entity

if TYPE_CHECKING:
    from ifcdb.diffing.tool import EntityDiffAdd


@dataclass
class BulkEntityInsert:
    entities: list[EntityDiffAdd]
    with_map: dict[str, EdgeSelect] = field(default_factory=dict)

    indent: str = 4 * " "

    def get_global_with_str(self):
        insert_str = "with\n"
        indent = 4 * " "
        for entity in self.entities:
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
        return insert_str

    def get_insert_str(self, entity: EntityDiffAdd):
        insert_str = ""
        prop_str = to_props_str(entity.added.entity, sep=f",\n{self.indent}")
        lstr = to_links_str(entity.added.entity, sep=f",\n{self.indent}")
        if prop_str != "":
            prop_str += f",\n{self.indent}"
        insert_str += f"INSERT {entity.class_name} {{\n{self.indent}{prop_str}{lstr} }}"
        return insert_str

    def to_edql_str(self, variable_counter: count = None):
        global_with_str = self.get_global_with_str()
        insert_str = ""
        for entity in self.entities:
            istr = self.get_insert_str(entity)
            if variable_counter is not None:
                new_name = f"insert{next(variable_counter)}"
                insert_str += f"{new_name} := ({global_with_str}{istr}),\n"
            else:
                insert_str += global_with_str + istr
        return insert_str


def to_links_str(entity: Entity, sep=", "):
    lstr = ""
    for key, value in entity.links.items():
        if value is None:
            continue

        if isinstance(value, Entity):
            value = [value]

        for v in value:
            if v.uuid is None:
                value_str = v.temp_unique_identifier
            else:
                value_str = f'SELECT {v.name} filter .id = <uuid>"{v.uuid}"'
            lstr += f"{key}:= {value_str}{sep}"
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

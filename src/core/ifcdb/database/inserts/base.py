from __future__ import annotations

from dataclasses import dataclass

from ifcdb.entities import Entity
from ifcdb.utils import change_case
from itertools import count

_INSERT_VAR = count()


@dataclass
class EdgeInsert:
    entity: Entity
    name: str = None

    def __post_init__(self):
        if self.name is None:
            self.name = f"{change_case(self.entity.name)}_{next(_INSERT_VAR)}"

    def to_edql_str(self, assign_to_variable=False, indent_override: str = None, sep=", "):
        indent = "" if indent_override is None else indent_override
        props = ""
        props_writable = {p: v for p, v in self.entity.props.items() if v is not None}
        if len(props_writable) > 0:
            if "wrappedValue" in self.entity.props.keys():
                print("sd")
                props = ""
            else:
                props = to_props_str(self.entity, sep=sep)
        links = ""
        if len(self.entity.links) > 0:
            if len(props_writable) > 0:
                links += sep
            links += to_links_str(self.entity, sep=sep)
        if assign_to_variable:
            if self.name is None:
                raise ValueError('Variable "name" cannot be None')
            return f"{indent}{self.name} := (INSERT {self.entity.name} {{ {props}{links} }}){sep}"
        else:
            return f"INSERT {self.entity.name} {{ {props}{links} }}"


def to_props_str(entity: Entity, sep=", "):

    return sep.join([f"{key}:= {value_writer(value)}" for key, value in entity.props.items() if value is not None])


def to_links_str(entity: Entity, sep=", "):
    lstr = ""

    for key, value in entity.links.items():
        if value is None:
            continue

        if key == "wrappedValue":
            print("sd")

        if isinstance(value, Entity):
            lstr += f"{key}:= {link_select(value)}{sep}"
        elif isinstance(value, tuple):
            lstr += f"{key}:= {{"
            lstr += ",".join([link_select(v, wrap_select=True) for v in value])
            lstr += f"}}{sep}"
        else:
            raise NotImplementedError(f"Currently unsupported: {type(value)}")
    return lstr


def link_select(v: Entity, wrap_select=False) -> str:
    if v.uuid is None:
        return v.temp_unique_identifier
    else:
        if wrap_select:
            return f"(SELECT {v.name} filter .id = <uuid>'{v.uuid}')"
        else:
            return f"SELECT {v.name} filter .id = <uuid>'{v.uuid}'"


def value_writer(value) -> str:
    if isinstance(value, str):
        return f"'{value}'"
    elif isinstance(value, tuple):
        return f"{list(value)}"
    else:
        return value

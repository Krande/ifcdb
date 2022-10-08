from __future__ import annotations

import logging

from dataclasses import dataclass
from itertools import count

from ifcdb.database.select import EdgeFilter, EdgeSelect
from ifcdb.entities import Entity
from ifcdb.utils import change_case

_INSERT_VAR = count()


@dataclass
class EdgeInsert:
    entity: Entity
    name: str = None

    def __post_init__(self):
        if self.name is None:
            self.name = f"{change_case(self.entity.name)}_{next(_INSERT_VAR)}"

    def to_edql_str(self, assign_to_variable=False, indent_override: str = None, prop_sep=",", sep=",", detached=False):
        indent = "" if indent_override is None else indent_override
        props = ""
        props_writable = {p: v for p, v in self.entity.props.items() if v is not None}
        if len(props_writable) > 0:
            props = to_props_str(self.entity, sep=prop_sep)
        links = ""
        with_block_content = None
        if len(self.entity.links) > 0:
            if len(props_writable) > 0:
                links += prop_sep

            for key, l_obj in self.get_link_objects().items():
                if isinstance(l_obj, Entity):
                    links += f"{key} := {l_obj.name}" + prop_sep
                elif isinstance(l_obj, EdgeInsert):
                    edql_str = l_obj.to_edql_str(assign_to_variable)
                    links += f"{key} := ({edql_str})" + prop_sep
                elif isinstance(l_obj, EdgeSelect):
                    # Self-referencing is not allowed. Will use detached if necessary
                    detached = l_obj.entity_top.name == self.entity.name
                    edql_str = l_obj.to_edql_str(assign_to_variable, detached=detached)
                    links += f"{key} := ({edql_str})" + prop_sep
                elif isinstance(l_obj, tuple):
                    if with_block_content is None:
                        with_block_content = ""
                    refs = ""
                    for o in l_obj:
                        if isinstance(o, Entity):
                            logging.info("ds")
                        else:
                            with_block_content += o.to_edql_str(assign_to_variable=True) + "\n"
                        refs += o.name + prop_sep
                    links += f"{key} := {{ {refs} }}" + prop_sep
                else:
                    links += f"{key} := {value_writer(l_obj)}" + prop_sep

            # links += to_links_str(self.entity, sep=prop_sep)
        if with_block_content is not None:
            insert_base = f"with\n{with_block_content}\nINSERT {self.entity.name} {{ {props}{links} }}"
        else:
            insert_base = f"INSERT {self.entity.name} {{ {props}{links} }}"

        if assign_to_variable is False:
            return insert_base

        return f"{indent}{self.name} := ({insert_base }){sep}"

    def get_link_objects(self) -> dict[str, Entity | EdgeSelect | EdgeInsert]:
        link_props = {}
        for key, value in self.entity.links.items():
            if value is None:
                continue
            if isinstance(value, Entity):
                link_props[key] = get_link_entity_object(value)
            elif isinstance(value, tuple):
                link_props[key] = tuple([get_link_entity_object(v) for v in value])
            else:
                raise NotImplementedError(f"Currently unsupported: {type(value)}")

        return link_props


def to_props_str(entity: Entity, sep=",") -> str:
    props = []
    for key, value in entity.props.items():
        if value is None:
            continue
        if key == "wrappedValue":
            key = f"`{entity.name}`"
        props.append(f"{key}:= {value_writer(value)}")

    return f"{sep}".join(props)


def get_link_entity_object(value: Entity):
    if value.uuid is not None:
        efilter = EdgeFilter("id", value.uuid, EdgeFilter.TYPES.UUID)
        return EdgeSelect(change_case(value.name) + f"_{next(_INSERT_VAR)}", value, filter=efilter)
    else:
        return value


def to_links_str(entity: Entity, sep=","):
    lstr = ""

    for key, value in entity.links.items():
        if value is None:
            continue

        if isinstance(value, Entity):
            wrapped_value = value.props.get("wrappedValue", None)
            if wrapped_value is not None:
                if isinstance(wrapped_value, str):
                    vstr = f"'{wrapped_value}'"
                else:
                    vstr = f"{wrapped_value}"
                lstr += f"{key} := (INSERT {value.name} {{ `{value.name}` := {vstr} }}){sep}"
            elif value.uuid is not None:
                lstr += f"{key}:= {link_select(value, wrap_select=True)}{sep}"
            else:
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
            return f"(SELECT {v.name} filter .id=<uuid>'{v.uuid}')"
        else:
            return f"SELECT {v.name} filter .id=<uuid>'{v.uuid}'"


def value_writer(value) -> str:
    if isinstance(value, str):
        return f"'{value}'"
    elif isinstance(value, tuple):
        return f"{list(value)}"
    else:
        return value

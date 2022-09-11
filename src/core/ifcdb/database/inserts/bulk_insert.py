from __future__ import annotations

from dataclasses import dataclass, field
from itertools import count, groupby
from operator import attrgetter
from typing import TYPE_CHECKING

from deepdiff import DeepDiff

from ifcdb.database.select import EdgeSelect
from ifcdb.entities import Entity, walk_links

if TYPE_CHECKING:
    from ifcdb.diffing.tool import EntityDiffAdd


@dataclass
class BulkEntityInsert:
    entities: list[EntityDiffAdd]
    with_map: dict[str, EdgeSelect] = field(default_factory=dict)

    def merge_identical_objects(self):
        entity_map: dict[str, list] = dict()
        all_related_entities = [entity_ref for e in self.entities for entity_ref in walk_links(e)]
        for key, group in groupby(
            sorted(all_related_entities, key=lambda x: len(x.entity.links)), key=attrgetter("entity.name")
        ):
            if key not in entity_map.keys():
                entity_map[key] = []

            entity_map[key] += list(group)

        for key, value in entity_map.items():
            similar = []
            not_similar = []
            for v1 in value[1:]:
                for v2 in value[:-1]:
                    res = DeepDiff(v1.entity, v2.entity)
                    if len(res.keys()) == 0:
                        print("Equal")
                        similar.append((v1, v2))
                    else:
                        not_similar.append((v1, v2))
                    print("res")

            # dicts = [entity_to_dict(v.entity) for v in value]
            # frozen_dicts = [frozenset(x) for x in dicts]
            # unique_values = set([frozenset(entity_to_dict(v.entity)) for v in value])
            print("sd")
        print("sd")

    def to_edql_str(self, variable_counter: count = None):
        insert_str = ""
        for entity in self.entities:
            istr = to_bulk_insert_str(entity)
            if variable_counter is not None:
                new_name = f"insert{next(variable_counter)}"
                insert_str += f"{new_name} := ({istr}),\n"
            else:
                insert_str += istr
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

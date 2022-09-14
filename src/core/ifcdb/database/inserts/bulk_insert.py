from __future__ import annotations

from dataclasses import dataclass, field
from itertools import count
from typing import TYPE_CHECKING

from ifcdb.database.select import EdgeSelect
from .base import EdgeInsert, to_links_str, to_props_str

if TYPE_CHECKING:
    from ifcdb.diffing.tool import EntityDiffAdd


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
                self.inserts[key] = EdgeInsert(value, key)

    def get_global_with_str(self, indent_override: str = None):
        insert_str = "with\n"
        indent = self.indent if indent_override is None else indent_override
        for key, insert in self.inserts.items():
            insert_str += indent + f"{key} := ({insert.to_edql_str()}),\n"
        return insert_str

    def get_insert_entities(self, variable_counter: count = None) -> list[EdgeInsert]:
        edge_inserts = []
        for entitydiff in self.entities:
            new_name = None
            if variable_counter is not None:
                new_name = f"insert{next(variable_counter)}"
            edge_inserts.append(self.get_insert_entity(entitydiff, new_name))
        return edge_inserts

    def get_insert_entity(self, entity: EntityDiffAdd, name: str = None) -> EdgeInsert:
        return EdgeInsert(entity.added.entity, name)

    def get_insert_str(self, entity: EntityDiffAdd, indent_override: str = None) -> str:
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
        for entity in self.get_insert_entities():
            istr = entity.to_edql_str(indent_override=extra_with_indent)
            if variable_counter is not None:
                new_name = f"insert{next(variable_counter)}"
                insert_str += f"{new_name} := (\n{self.indent}{global_with_str}{self.indent}{istr}),\n"
            else:
                insert_str += global_with_str + istr
        return insert_str

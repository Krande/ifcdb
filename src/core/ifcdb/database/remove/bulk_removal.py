from __future__ import annotations

from dataclasses import dataclass
from typing import TYPE_CHECKING

from ifcdb.database.select import EdgeFilter, FilterType

if TYPE_CHECKING:
    from ifcdb.diffing.tool import EntityDiffRemove


@dataclass
class EntityRemove:
    class_name: str
    entity_filter: EdgeFilter

    def to_edql_str(self) -> str:
        fstr = self.entity_filter.to_edql_str()
        return f"DELETE {self.class_name} {fstr}"


@dataclass
class BulkEntityRemoval:
    entities: list[EntityDiffRemove]
    indent: str = 4 * " "

    def to_edql_str(self, variable_counter):
        insert_str = ""
        for entity in self.entities:
            er = EntityRemove(entity.class_name, EdgeFilter("GlobalId", entity.guid, FilterType.STR))
            delete_str = er.to_edql_str()
            if variable_counter is not None:
                new_name = f"remove_{next(variable_counter)}"
                insert_str += f"{new_name} := (\n{self.indent}{delete_str}{self.indent}),\n"
            else:
                insert_str += delete_str

        return insert_str

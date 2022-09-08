from __future__ import annotations

from dataclasses import dataclass
from enum import Enum

from ifcdb.entities import Entity


class FilterType(Enum):
    STR = "str"
    UUID = "uuid"


@dataclass
class EdgeFilter:
    key: str
    value: str
    value_type: FilterType

    def to_edql_str(self):
        return f"FILTER .{self.key}=<{self.value_type.value}>'{self.value}'"


@dataclass
class EdgeSelect:
    name: str

    entity_top: Entity | EdgeSelect
    entity_path: str | None
    entity_index: int = None

    assert_class: str = None
    is_multi_link: bool = False
    filter: EdgeFilter = None

    def get_absolute_path(self) -> str:
        if self.entity_path is None:
            return self.entity_top.name
        abs_path = f"{self.entity_top.get_absolute_path()}.{self.entity_path}"
        if self.entity_index is not None:
            abs_path += f"[{self.entity_index}]"
        return abs_path

    def get_ancestry(self, ancestor=None, ancestors: list[Entity | EdgeSelect] = None):
        if ancestors is None:
            ancestors = []
        if ancestor is None:
            ancestor = self.entity_top

        if isinstance(ancestor, Entity):
            return ancestors

        ancestors.append(ancestor)

        self.get_ancestry(ancestor.entity_top, ancestors)
        return ancestors

    def to_edql_str(self, assign_to_variable=True):
        select_str = "select "
        entity_path = (
            f"{self.entity_top.name}.{self.entity_path}" if self.entity_path is not None else self.entity_top.name
        )
        if self.entity_index is not None and self.is_multi_link:
            select_str += f"array_agg({entity_path})[{self.entity_index}]"
        else:
            select_str += entity_path

        if self.assert_class is not None:
            select_str += f"[is {self.assert_class}]"

        if self.filter is not None:
            select_str += " " + self.filter.to_edql_str()

        if assign_to_variable:
            return f"{self.name} := ({select_str}),"
        else:
            return select_str

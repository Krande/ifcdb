from __future__ import annotations
from dataclasses import dataclass, field
from enum import Enum


class FilterType(Enum):
    STR = "str"


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
    entity_path: str
    entity_index: int = None
    assert_class: str = None
    is_multi_link: bool = False
    filter: EdgeFilter = None

    def to_edql_str(self, assign_to_variable=True):
        select_str = "select "
        if self.entity_index is not None and self.is_multi_link:
            select_str += f"array_agg({self.entity_path})[{self.entity_index}]"
        else:
            select_str += self.entity_path

        if self.assert_class is not None:
            select_str += f"[is {self.assert_class}]"

        if self.filter is not None:
            select_str += " " + self.filter.to_edql_str()

        if assign_to_variable:
            return f"{self.name} := ({select_str}),"
        else:
            return select_str


def create_select_obj(path: str, filter_key: str, filter_value: str, filter_type: FilterType, **kwargs) -> EdgeSelect:
    return EdgeSelect(path, filter=EdgeFilter(filter_key, filter_value, filter_type), **kwargs)

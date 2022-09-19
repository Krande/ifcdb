from __future__ import annotations

from dataclasses import dataclass
from itertools import count
from typing import Any

from ifcdb.database.inserts import EdgeInsert
from ifcdb.database.select import EdgeSelect
from ifcdb.diffing.types import (
    ValueAddedToIterable,
    ValueChange,
    ValueRemovedFromIterable,
)
from ifcdb.utils import change_case

_UPDATE_VAR = count(1)


@dataclass
class EdgeUpdate:
    select_obj: EdgeSelect | EdgeInsert
    update_value: EntityUpdateValue = None
    name: str = None

    def __post_init__(self):
        if self.name is None:
            self.name = f"{change_case(self.select_obj.name)}_{next(_UPDATE_VAR)}"

    def to_edql_str(self, assign_to_variable=False, indent=2 * " ", sep=",\n"):
        update_str = indent + f"UPDATE {self.select_obj.name}\n{2 * indent}" + "SET {\n"
        update_str += 3 * indent + self.update_value.to_edql_str()
        update_str += 2 * indent + "}\n"

        if assign_to_variable:
            return f"{indent}{self.name} := (\n{indent}{update_str}{indent}){sep}"
        else:
            return update_str


@dataclass
class EntityUpdateValue:
    assignment_value: Any
    value_data: ValueChange | ValueAddedToIterable | ValueRemovedFromIterable

    def to_edql_str(self) -> str:
        if self.value_data.key is None:
            raise ValueError("Key cannot be zero")

        if isinstance(self.assignment_value, (EdgeInsert, EdgeSelect)):
            value = f"({self.assignment_value.name})"
        else:
            value = self.assignment_value

        if isinstance(self.value_data, ValueChange):
            assignment_type = ":="
        elif isinstance(self.value_data, ValueAddedToIterable):
            assignment_type = "+="
        elif isinstance(self.value_data, ValueRemovedFromIterable):
            assignment_type = "-="
        else:
            raise NotImplementedError(f"Unsupported assignment type '{self.value_data}'")

        edql_str = f"{self.value_data.key} {assignment_type}"

        if isinstance(self.value_data, ValueChange) and self.value_data.tuple_len is not None:
            array_str = "["
            for i in range(0, self.value_data.tuple_len):
                if i != 0:
                    array_str += ", "
                if i == self.value_data.index:
                    array_str += f"{value}"
                else:
                    array_str += f".{self.value_data.key}[{i}]"
            array_str += "]"
            edql_str += f" {array_str}\n"
        else:
            edql_str += f" {value}\n"

        return edql_str

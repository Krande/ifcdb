from __future__ import annotations

from dataclasses import dataclass
from itertools import count
from typing import Any

from ifcdb.database.inserts import EdgeInsert
from ifcdb.database.select import EdgeSelect
from ifcdb.diffing.diff_types import PropUpdateType
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
    value: Any
    old_value: Any
    prop_update_type: PropUpdateType

    key: str = None

    # Optional params relevant only for tuple insertions
    index: int | None = None
    len: int | None = None

    def to_edql_str(self) -> str:
        if self.key is None:
            raise ValueError("Key cannot be zero")

        if isinstance(self.value, (EdgeInsert, EdgeSelect)):
            value = f"({self.value.name})"
        else:
            value = self.value

        edql_str = ""

        if self.prop_update_type == PropUpdateType.UPDATE:
            assignment_type = ":="
        elif self.prop_update_type == PropUpdateType.ADD_TO_ITERABLE:
            assignment_type = "+="
        elif self.prop_update_type == PropUpdateType.REMOVE_FROM_ITERABLE:
            assignment_type = "-="
        else:
            raise NotImplementedError(f"Unsupported assignment type '{self.prop_update_type}'")

        if self.index is not None:
            array_str = "["
            for i in range(0, self.len):
                if i != 0:
                    array_str += ", "
                if i == self.index:
                    array_str += f"{value}"
                else:
                    array_str += f".{self.key}[{i}]"
            array_str += "]"
            edql_str += f"{self.key} {assignment_type} {array_str}\n"
        else:
            edql_str += f"{self.key} {assignment_type} {value}\n"

        return edql_str

from __future__ import annotations

from dataclasses import dataclass
from itertools import count

from ifcdb.database.select import EdgeFilter, EdgeSelect

_REM_VAR = count(1)


@dataclass
class EdgeRemove:
    select: EdgeSelect = None
    class_name: str = None
    entity_filter: EdgeFilter = None
    name: str = None

    def __post_init__(self):
        if self.name is None:
            self.name = f"remove_{next(_REM_VAR)}"

    def to_edql_str(self, embed_select=False, assign_to_variable=False) -> str:
        if self.select is None:
            fstr = self.entity_filter.to_edql_str()
            del_str = f"{self.class_name} {fstr}"
        else:
            if embed_select:
                del_str = f"({self.select.to_edql_str(assign_to_variable=False, sep='')})"
            else:
                del_str = self.select.name

        if assign_to_variable is False:
            return f"DELETE {del_str}"
        else:
            return f"{self.name} := (DELETE {del_str}),\n"

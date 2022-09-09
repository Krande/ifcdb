from __future__ import annotations

from dataclasses import dataclass
from itertools import count

from ifcdb.database.inserts.utils import to_insert_str
from ifcdb.entities import Entity


@dataclass
class BulkEntityRemoval:
    entities: list[Entity]

    def to_edql_str(self, variable_counter: count = None):
        insert_str = ""
        for entity in self.entities:
            istr = to_insert_str(entity)
            if variable_counter is not None:
                new_name = f"remove{next(variable_counter)}"
                insert_str += f"{new_name} := ({istr}),\n"
            else:
                insert_str += istr
        return insert_str

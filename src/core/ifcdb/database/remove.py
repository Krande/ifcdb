from __future__ import annotations

import logging
from dataclasses import dataclass
from itertools import count
from typing import TYPE_CHECKING

import edgedb

from ifcdb.database.select import EdgeFilter, EdgeSelect

if TYPE_CHECKING:
    from ifcdb.database.getters.get_bulk import BulkGetter

_REM_VAR = count(1)


def wipe_db(bg: BulkGetter, delete_in_sequence: bool, max_attempts: int):
    empty = False
    attempt_no = 0

    def perform_logger_query(query_str) -> bool:
        try:
            bg.client.execute(query_str)
        except edgedb.errors.InternalServerError as e:
            logging.warning(e)
            return False
        return True

    while empty is False:
        edge_objects = bg.get_all_in_ordered_sequence()
        if len(edge_objects) == 0:
            empty = True
            break
        edge_objects.reverse()

        delete_str = ""
        if delete_in_sequence is False:
            delete_str = "select {"

        for i, x in enumerate(edge_objects):
            class_name = x["class"]
            uuid = x["id"]
            delstr = f"DELETE {class_name} FILTER .id = <uuid>'{uuid}'"
            if delete_in_sequence:
                if perform_logger_query(delstr) is False:
                    continue
            else:
                delete_str += f"del{i} := ({delstr}),\n"

        if delete_in_sequence is False:
            delete_str += "}"
            if perform_logger_query(delete_str) is False:
                continue
        attempt_no += 1
        if attempt_no > max_attempts:
            logging.error(f"Unable to wipe database in maximum number of attempts={max_attempts}")
            break


@dataclass
class EdgeRemove:
    select: EdgeSelect = None
    class_name: str = None
    entity_filter: EdgeFilter = None
    name: str = None

    def __post_init__(self):
        if self.name is None:
            self.name = f"remove_{next(_REM_VAR)}"

    def to_edql_str(self, assign_to_variable=False) -> str:
        if self.select is None:
            fstr = self.entity_filter.to_edql_str()
            del_str = f"{self.class_name} {fstr}"
        else:
            del_str = f"{self.select.name}"
        if assign_to_variable is False:
            return f"DELETE {del_str}"
        else:
            return f"{self.name} := (DELETE {del_str}),\n"

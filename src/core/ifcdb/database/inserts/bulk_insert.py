from __future__ import annotations

from dataclasses import dataclass, field
from itertools import count, groupby
from operator import attrgetter

from ifcdb.database.select import EdgeSelect
from ifcdb.entities import Entity, walk_links
from .utils import to_insert_str


@dataclass
class BulkEntityInsert:
    entities: list[Entity]
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

        print("sd")

    def to_edql_str(self, variable_counter: count = None):
        self.merge_identical_objects()
        insert_str = ""
        for entity in self.entities:
            istr = to_insert_str(entity)
            if variable_counter is not None:
                new_name = f"insert{next(variable_counter)}"
                insert_str += f"{new_name} := ({istr}),\n"
            else:
                insert_str += istr
        return insert_str

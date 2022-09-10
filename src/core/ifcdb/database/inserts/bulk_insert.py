from __future__ import annotations

from dataclasses import dataclass, field
from itertools import count, groupby
from operator import attrgetter

from deepdiff import DeepDiff

from ifcdb.database.select import EdgeSelect
from ifcdb.entities import Entity, entity_to_dict, walk_links

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

        for key, value in entity_map.items():
            similar = []
            not_similar = []
            for v1 in value[1:]:
                for v2 in value[:-1]:
                    res = DeepDiff(v1.entity, v2.entity)
                    if len(res.keys()) == 0:
                        print("Equal")
                        similar.append((v1, v2))
                    else:
                        not_similar.append((v1, v2))
                    print("res")

            # dicts = [entity_to_dict(v.entity) for v in value]
            # frozen_dicts = [frozenset(x) for x in dicts]
            # unique_values = set([frozenset(entity_to_dict(v.entity)) for v in value])
            # print("sd")
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


def compare_two_entities(e1: Entity, e2: Entity) -> bool:
    e1info = entity_to_dict(e1)
    e2info = entity_to_dict(e2)
    return frozenset(e2info) == frozenset(e1info)

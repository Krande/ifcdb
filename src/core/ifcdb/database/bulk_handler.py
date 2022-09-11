from __future__ import annotations

from dataclasses import dataclass, field
from itertools import count
from typing import TYPE_CHECKING

import edgedb

from ifcdb.entities import Entity

from .inserts.bulk_insert import BulkEntityInsert
from .remove.bulk_removal import BulkEntityRemoval
from .updates.bulk_updates import (
    BulkEntityUpdate,
    EntityPropUpdate,
    EntityUpdateValue,
    PropUpdateType,
)

if TYPE_CHECKING:
    from ifcdb.diffing.tool import EntityDiffChange, IfcDiffTool


@dataclass
class BulkEntityHandler:
    ifc_diff_tool: IfcDiffTool

    inserts: BulkEntityInsert = None
    removals: BulkEntityRemoval = None
    updates: list[BulkEntityUpdate] = field(default_factory=list)

    insert_map: dict[str, Entity] = field(default_factory=dict)

    uuid_map: dict[Entity, str] = field(default_factory=dict)

    def __post_init__(self):
        self.inserts = BulkEntityInsert(self.ifc_diff_tool.added)
        self.removals = BulkEntityRemoval(self.ifc_diff_tool.removed)
        self.add_changes()

        self.insert_map = {el.added.entity.props.get("GlobalId"): el for el in self.inserts.entities}

    def add_changes(
        self,
    ) -> None:
        for diff_el in self.ifc_diff_tool.changed:
            change_object = self.change_entity(diff_el)
            if change_object is not None:
                self.updates.append(change_object)

    def add_item_to_change_objects(self, entity: Entity, source: dict) -> list[EntityPropUpdate]:
        change_objects = []
        for path, values in source.items():
            value_update = EntityUpdateValue(values["new_value"], values["old_value"])
            change_objects.append(EntityPropUpdate(entity, path, value_update, PropUpdateType.UPDATE))
        return change_objects

    def add_item_to_iterable(self, entity: Entity, source: dict) -> list[EntityPropUpdate]:
        add_objects = []

        for path, elem_dict in source.items():
            guid = elem_dict.get("GlobalId")
            entity_ref = self.insert_map.get(guid)
            value_update = EntityUpdateValue(entity_ref, None)
            add_objects.append(EntityPropUpdate(entity, path, value_update, PropUpdateType.ADD_TO_ITERABLE))

        return add_objects

    def change_entity(self, elem: EntityDiffChange) -> BulkEntityUpdate | None:
        updates = []
        for diff_type, diff in elem.diff.items():
            if diff_type == "values_changed":
                updates += self.add_item_to_change_objects(elem.entity, diff)
            elif diff_type == "iterable_item_added":
                updates += self.add_item_to_iterable(elem.entity, diff)
            else:
                raise NotImplementedError(f'not yet added support for diff_type "{diff_type}"')

        if len(updates) == 0:
            return None

        return BulkEntityUpdate(updates)

    def get_db_data(self, client: edgedb.Client):
        pass

    def to_edql_str(self, client: edgedb.Client = None) -> str:
        # add new entities
        if client is not None:
            self.get_db_data(client)
        c = count(1)
        query_str = "SELECT {\n"
        query_str += self.inserts.to_edql_str(c)
        query_str += self.removals.to_edql_str(c)
        for update in self.updates:
            query_str += update.to_edql_str(use_select_wrapper=False)
        query_str += "}"
        return query_str

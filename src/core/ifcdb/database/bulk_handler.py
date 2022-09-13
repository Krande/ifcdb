from __future__ import annotations

from dataclasses import dataclass, field
from itertools import count
from typing import TYPE_CHECKING

import edgedb

from ifcdb.entities import Entity, EntityResolver

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

    bulk_inserts: BulkEntityInsert = None
    bulk_removals: BulkEntityRemoval = None
    bulk_updates: list[BulkEntityUpdate] = field(default_factory=list)

    insert_map: dict[str, Entity] = field(default_factory=dict)
    uuid_map: dict[Entity, str] = field(default_factory=dict)

    def __post_init__(self):
        self.bulk_inserts = BulkEntityInsert(self.ifc_diff_tool.added)
        self.insert_map = {el.guid: el for el in self.bulk_inserts.entities}
        self.bulk_removals = BulkEntityRemoval(self.ifc_diff_tool.removed)
        self.add_changes()

    def add_changes(self) -> None:
        for diff_el in self.ifc_diff_tool.changed:
            change_object = self.change_entity(diff_el)
            if change_object is not None:
                self.bulk_updates.append(change_object)

    def add_item_to_change_objects(self, elem: EntityDiffChange, source: dict) -> list[EntityPropUpdate]:
        change_objects = []
        for path, values in source.items():
            value_update = EntityUpdateValue(values["new_value"], values["old_value"])
            change_objects.append(EntityPropUpdate(elem.entity, path, value_update, PropUpdateType.UPDATE))
        return change_objects

    def add_item_to_iterable(self, elem: EntityDiffChange, source: dict) -> list[EntityPropUpdate]:
        add_objects = []

        for path, elem_dict in source.items():
            guid = elem_dict.get("GlobalId")
            entity_ref = self.insert_map.get(guid)
            value_update = EntityUpdateValue(entity_ref, None)
            add_objects.append(EntityPropUpdate(elem.entity, path, value_update, PropUpdateType.ADD_TO_ITERABLE))

        return add_objects

    def remove_item_from_iterable(self, elem: EntityDiffChange, source: dict):
        remove_objects = []

        for path, elem_dict in source.items():
            entity = EntityResolver.create_insert_entity_from_ifc_dict(elem_dict)
            value_update = EntityUpdateValue(None, entity)
            p_update = EntityPropUpdate(elem.entity, path, value_update, PropUpdateType.REMOVE_FROM_ITERABLE)
            remove_objects.append(p_update)

        return remove_objects

    def change_entity(self, elem: EntityDiffChange) -> BulkEntityUpdate | None:
        updates = []

        for diff_type, diff in elem.diff.items():
            if diff_type == "values_changed":
                updates += self.add_item_to_change_objects(elem, diff)
            elif diff_type == "iterable_item_added":
                updates += self.add_item_to_iterable(elem, diff)
            elif diff_type == "iterable_item_removed":
                updates += self.remove_item_from_iterable(elem, diff)
            else:
                raise NotImplementedError(f'not yet added support for diff_type "{diff_type}"')

        if len(updates) == 0:
            return None

        return BulkEntityUpdate(updates)

    def get_db_data(self, client: edgedb.Client):
        pass

    def get_all_global_with_statements(self):
        all_with_statements = dict()

        for key, value in self.bulk_inserts.inserts.items():
            all_with_statements[key] = value

        for update in self.bulk_updates:
            update._resolve_global_with_statements()
            if len(update.global_with_selects.keys()) == 0:
                continue
            for key, value in update.global_with_selects.items():
                all_with_statements[key] = value
        return all_with_statements

    def get_global_with_str(self):
        all_with_statements = self.get_all_global_with_statements()
        if len(all_with_statements.keys()) == 0:
            return ""

        global_wstr = "with\n"
        for key, value in all_with_statements.items():
            global_wstr += "    " + value.to_edql_str() + "\n"

        return global_wstr

    def to_edql_str(self, client: edgedb.Client = None) -> str | None:
        # add new entities
        if client is not None:
            self.get_db_data(client)
        c = count(1)
        query_str = ""
        for key, value in self.get_all_global_with_statements().items():
            query_str += f"{key}_ := {key},\n"
        query_str += self.bulk_inserts.to_edql_str(c, embed_with_statement=False)
        for update in self.bulk_updates:
            query_str += update.to_edql_str(use_select_wrapper=False, variable_assignment=f"global_{next(c)}")
        query_str += self.bulk_removals.to_edql_str(c)

        if query_str == "":
            return None
        else:
            return self.get_global_with_str() + f"\nSELECT {{\n{query_str}\n}}"

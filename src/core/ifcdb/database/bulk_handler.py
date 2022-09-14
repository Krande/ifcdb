from __future__ import annotations

import edgedb
from dataclasses import dataclass, field
from itertools import count
from typing import TYPE_CHECKING

from ifcdb.entities import Entity, EntityResolver
from ifcdb.diffing.utils import slice_property_path_at_key
from .inserts.bulk_insert import BulkEntityInsert
from .remove.bulk_removal import BulkEntityRemoval
from .updates.bulk_updates import (
    BulkEntityUpdate,
    EntityPropUpdate,
    EntityUpdateValue,
    PropUpdateType,
)

if TYPE_CHECKING:
    from ifcdb.diffing.tool import EntityDiffChange, IfcDiffTool, EntityDiffAdd


@dataclass
class BulkEntityHandler:
    ifc_diff_tool: IfcDiffTool

    bulk_inserts: BulkEntityInsert = None
    bulk_removals: BulkEntityRemoval = None
    bulk_updates: list[BulkEntityUpdate] = field(default_factory=list)

    insert_map: dict[str, Entity] = field(default_factory=dict)
    uuid_map: dict[Entity, str] = field(default_factory=dict)

    do_selects_on_all_with_variables: bool = False

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

    def change_object_values(self, elem: EntityDiffChange, source: dict) -> list[EntityPropUpdate]:
        change_objects = []
        er = EntityResolver("IFC4x1")
        for path, values in source.items():
            overlinked_new_value = elem.overlinked_entities.get(path)
            if overlinked_new_value is not None:
                new_value = er.create_insert_entity_from_ifc_entity(overlinked_new_value.value)
                path = slice_property_path_at_key(path, overlinked_new_value.index)
                old_value = None
                value_update = EntityUpdateValue(new_value, old_value, key=overlinked_new_value.index)
            else:
                old_value = values["old_value"]
                new_value = values["new_value"]
                value_update = EntityUpdateValue(new_value, old_value)
            entity_prop = EntityPropUpdate(elem.entity, path, value_update, PropUpdateType.UPDATE)
            change_objects.append(entity_prop)
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
                updates += self.change_object_values(elem, diff)
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

        self.bulk_inserts.get_insert_entities()

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
            global_wstr += "    " + value.to_edql_str(assign_to_variable=True) + "\n"

        return global_wstr

    def to_edql_str(self, client: edgedb.Client = None) -> str | None:
        # add new entities
        if client is not None:
            self.get_db_data(client)
        c = count(1)
        indent = 4 * " "

        query_str = ""
        # Global WITH statements
        all_with_statements = self.get_all_global_with_statements()
        global_wstr = ""
        if len(all_with_statements.keys()) != 0:
            global_wstr = "with\n"
            for key, value in all_with_statements.items():
                global_wstr += "    " + value.to_edql_str(assign_to_variable=True) + "\n"

        if self.do_selects_on_all_with_variables:
            # for logging purposes do a select on all intermediate WITH statements
            for key, value in self.get_all_global_with_statements().items():
                query_str += f"{indent}{key}_ := {key},\n"

        # INSERT statements
        insert_statement = ""
        all_inserts = self.bulk_inserts.get_insert_entities(c)
        for insert in all_inserts:
            move_insert_to_global_with = False
            for bulk_ent_up in self.bulk_updates:
                for prop_up in bulk_ent_up.updates:
                    if hasattr(prop_up.update_value.value, "guid"):
                        if insert.entity.props.get("GlobalId") == prop_up.update_value.value.guid:
                            move_insert_to_global_with = True
                            global_wstr += indent + insert.to_edql_str(assign_to_variable=True)
                            prop_up.update_value.value = insert
                            break
            if move_insert_to_global_with:
                continue
            insert_statement += indent + insert.to_edql_str(assign_to_variable=True)
        query_str += insert_statement

        # UPDATE statements
        for update in self.bulk_updates:
            query_str += update.to_edql_str(use_select_wrapper=False, variable_assignment=f"global_{next(c)}")

        # DELETE statements
        query_str += self.bulk_removals.to_edql_str(c)

        if query_str == "":
            return None
        else:
            return global_wstr + f"\nSELECT {{\n{query_str}\n}}"

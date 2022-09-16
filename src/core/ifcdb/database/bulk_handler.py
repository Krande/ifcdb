from __future__ import annotations

from dataclasses import dataclass, field
from itertools import count
from typing import TYPE_CHECKING

import edgedb

from ifcdb.diffing.utils import slice_property_path_at_key
from ifcdb.entities import Entity, EntityResolver

from .inserts import EdgeInsert
from .inserts.bulk_insert import BulkEntityInsert
from .remove.bulk_removal import BulkEntityRemoval, EntityRemove
from .select import EdgeFilter, EdgeSelect, FilterType, SelectResolver
from .updates.bulk_updates import (
    BulkEntityUpdate,
    EdgeUpdate,
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

    all_selects: dict[str, EdgeSelect] = field(default_factory=dict)
    extra_inserts: dict[str, EdgeInsert] = field(default_factory=dict)

    do_selects_on_all_with_variables: bool = False

    def __post_init__(self):
        self.bulk_inserts = BulkEntityInsert(self.ifc_diff_tool.added)
        self.insert_map = {el.guid: el for el in self.bulk_inserts.entities}
        self.bulk_removals = BulkEntityRemoval(self.ifc_diff_tool.removed)
        self.add_changes()

        for bulk_update in self.bulk_updates:
            # for select_item in bulk_update.all_select_items:
            #     self.all_selects[select_item.name] = select_item

            for update in bulk_update.updates:
                new_value = update.update_value.value
                if isinstance(new_value, Entity):
                    for key, link in new_value.links.items():
                        if isinstance(link, tuple):
                            for item in link:
                                tuid = item.temp_unique_identifier
                                self.extra_inserts[tuid] = EdgeInsert(item, tuid)
                        else:
                            tuid = link.temp_unique_identifier
                            self.extra_inserts[tuid] = EdgeInsert(link, tuid)

        for select_item in self.bulk_inserts.selects.values():
            self.all_selects[select_item.name] = select_item

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

        for update in self.bulk_updates:
            update.resolve_global_with_statements()
            if len(update.global_with_selects.keys()) == 0:
                continue
            for key, value in update.global_with_selects.items():
                all_with_statements[key] = value

        return all_with_statements

    def to_edql_str(self, indent=2 * " ") -> str | None:
        c = count(1)
        query_str = ""

        # Global WITH statements
        all_with_statements = self.get_all_global_with_statements()
        global_wstr = ""
        if len(all_with_statements.keys()) != 0:
            global_wstr = "with\n"
            for key, value in all_with_statements.items():
                global_wstr += indent + value.to_edql_str(assign_to_variable=True) + "\n"

            for key, value in self.extra_inserts.items():
                global_wstr += indent + value.to_edql_str(assign_to_variable=True) + "\n"

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


def to_bulk_entity_handler(ifc_diff_tool: IfcDiffTool) -> BulkEntityHandler:
    # Should instead look for ways of merging bulk update objects is not yet supported instead of returning list
    inserts = dict()
    removals = []
    changes = dict()
    selects = dict()

    # Additions
    for entity_add in ifc_diff_tool.added:
        for key, value in entity_add.added.linked_objects.items():
            if value == entity_add.added.entity:
                continue
            inserts[key] = EdgeInsert(value, key)

    # Removals
    for entity in ifc_diff_tool.removed:
        er = EntityRemove(entity.class_name, EdgeFilter("GlobalId", entity.guid, FilterType.STR))
        removals.append(er)

    # Changes
    c = count(1)
    for diff_el in ifc_diff_tool.changed:
        existing_select = selects.get(diff_el.guid)
        if existing_select is None:
            select_name = f"root{next(c)}"
            current_select = EdgeSelect(
                select_name, diff_el.entity, None, filter=EdgeFilter("GlobalId", diff_el.guid, FilterType.STR)
            )
            selects[select_name] = current_select
        else:
            current_select = existing_select

        for path, value in diff_el.value_changes.items():
            root_key = value.indices[0]
            if root_key == "ObjectPlacement":
                existing_object_placement = changes.get(diff_el.guid)
                if existing_object_placement is not None:
                    continue
                object_place_ifc_elem = value.levels[1]
                new_entity_tool = EntityResolver.create_entity_tool_from_ifcopenshell_entity(object_place_ifc_elem)
                sr = SelectResolver(
                    new_entity_tool.entity,
                )
                sr.resolve_selects()
                new_insert = EdgeInsert(new_entity_tool.entity)
                new_update = EdgeUpdate(current_select, EntityUpdateValue(new_insert, None, "ObjectPlacement"))

                changes[diff_el.guid] = new_update
                inserts[new_insert.name] = new_insert
            else:
                raise NotImplementedError(f"Have not yet added support for changes related to {root_key=}")

    res = BulkHandler2(selects, inserts, changes, removals)
    _ = res.to_edql_str()
    return BulkEntityHandler(ifc_diff_tool)


@dataclass
class BulkHandler2:
    selects: dict[str, EdgeSelect]
    inserts: dict[str, EdgeInsert]
    changes: dict[str, EdgeUpdate]
    removes: list[EntityRemove]

    def to_edql_str(self, indent=2 * " ") -> str | None:
        # INSERT statements
        insert_statement = ""
        for key, insert in self.inserts.items():
            insert_statement += indent + insert.to_edql_str(assign_to_variable=True)

        # SELECT statements
        select_statement = ""
        for key, select in self.selects.items():
            select_statement += indent + select.to_edql_str(assign_to_variable=True, sep=",\n")

        # UPDATE statements
        update_str = ""
        for key, update in self.changes.items():
            update_str += update.to_edql_str()

        # DELETE statements
        remove_str = ""
        for rem in self.removes:
            remove_str += rem.to_edql_str()

        global_w_str = "with\n" + select_statement + insert_statement
        query_str = update_str + remove_str

        total_str = global_w_str + f"\nSELECT {{\n{query_str}\n}}"

        return total_str

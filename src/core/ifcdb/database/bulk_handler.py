from __future__ import annotations

from dataclasses import dataclass
from itertools import count
from typing import TYPE_CHECKING

from ifcdb.diffing.types import (
    PropUpdateType,
    ValueAddedToIterable,
    ValueChange,
    ValueRemovedFromIterable,
)
from ifcdb.entities import EntityTool

from .inserts import EdgeInsert
from .remove import EdgeRemove
from .select import EdgeFilter, EdgeSelect, FilterType, PropSelectResolver
from .updates import EdgeUpdate, EntityUpdateValue

if TYPE_CHECKING:
    from ifcdb.diffing.tool import IfcDiffTool


@dataclass
class BulkEntityHandler:
    selects: dict[str, EdgeSelect]
    inserts: dict[str, EdgeInsert]
    changes: dict[str, EdgeUpdate]
    removes: list[EdgeRemove]

    def to_edql_str(self, indent=2 * " ") -> str | None:
        # INSERT statements
        insert_statement = ""
        for key, insert in self.inserts.items():
            insert_statement += indent + insert.to_edql_str(assign_to_variable=True, sep=",\n")

        # SELECT statements
        select_statement = ""
        for key, select in self.selects.items():
            select_statement += indent + select.to_edql_str(assign_to_variable=True, sep=",\n")

        # UPDATE statements
        update_str = ""
        for key, update in self.changes.items():
            update_str += update.to_edql_str(assign_to_variable=True)

        # DELETE statements
        remove_str = ""
        for rem in self.removes:
            remove_str += indent + rem.to_edql_str(assign_to_variable=True)

        global_w_str = "with\n" + select_statement + insert_statement
        query_str = update_str + remove_str

        total_str = global_w_str + f"\nSELECT {{\n{query_str}}}"

        return total_str


def to_bulk_entity_handler(ifc_diff_tool: IfcDiffTool) -> BulkEntityHandler:
    # Should instead look for ways of merging bulk update objects is not yet supported instead of returning list
    inserts = dict()
    removals = []
    changes = dict()
    selects: dict[str, EdgeSelect] = dict()

    select_abs_path_map: dict[str, EdgeSelect] = dict()
    insert_map: dict[str, EdgeInsert] = dict()

    c = count(1)

    # Additions
    for entity_add in ifc_diff_tool.added:
        for key, value in entity_add.added.linked_objects.items():
            if value == entity_add.added.entity:
                new_insert = EdgeInsert(entity_add.added.entity, key)
                inserts[key] = EdgeInsert(value, key)
                insert_map[entity_add.guid] = new_insert
                continue
            inserts[key] = EdgeInsert(value, key)

    # Removals
    for entity_rem in ifc_diff_tool.removed:
        rem_filter = EdgeFilter("GlobalId", entity_rem.guid, FilterType.STR)
        rem_select = EdgeSelect(f"remove_{next(c)}", entity_rem.removed, filter=rem_filter)
        selects[rem_select.name] = rem_select
        er = EdgeRemove(rem_select)
        removals.append(er)

    # Changes

    for diff_el in ifc_diff_tool.changed:
        for path, value in diff_el.value_changes.items():
            if isinstance(value, ValueChange):
                sr = PropSelectResolver(diff_el.root_entity, path, PropUpdateType.UPDATE)
                new_selects = sr.get_resolved_selects()
                last_select = add_to_selects(new_selects, selects, select_abs_path_map, c)
                if isinstance(value.new_value, EntityTool):
                    new_value = None
                    for key, linked_obj in value.new_value.linked_objects.items():
                        if value.new_value.entity == linked_obj:
                            new_value = EdgeInsert(value.new_value.entity, key)
                            inserts[key] = new_value
                            continue
                        inserts[key] = EdgeInsert(linked_obj, key)
                else:
                    new_value = value.new_value

                update_value = EntityUpdateValue(new_value, value)
                eu = EdgeUpdate(last_select, update_value)
                changes[eu.name] = eu

            elif isinstance(value, ValueAddedToIterable):
                sr = PropSelectResolver(diff_el.root_entity, path, PropUpdateType.ADD_TO_ITERABLE)
                new_selects = sr.get_resolved_selects()
                last_select = add_to_selects(new_selects, selects, select_abs_path_map, c)
                new_guid = value.new_entity.props.get("GlobalId")
                existing_insert = insert_map.get(new_guid)
                if existing_insert is None:
                    new_entity_insert = EdgeInsert(value.new_entity)
                    inserts[new_entity_insert.name] = new_entity_insert
                else:
                    new_entity_insert = existing_insert
                update_value = EntityUpdateValue(new_entity_insert, value)
                eu = EdgeUpdate(last_select, update_value)
                changes[eu.name] = eu
            elif isinstance(value, ValueRemovedFromIterable):
                select_for_rem = None
                for r in removals:
                    if r.select.entity_top.props.get("GlobalId") == value.entity.props.get("GlobalId"):
                        select_for_rem = r.select
                        break
                if select_for_rem is None:
                    raise NotImplementedError()

                update_value = EntityUpdateValue(select_for_rem, value)

                owner_name = f"{value.owning_entity.name}_{next(c)}"
                owner_guid = value.owning_entity.props.get("GlobalId")
                owner_select_filter = EdgeFilter("GlobalId", owner_guid, FilterType.STR)
                last_select = EdgeSelect(owner_name, value.owning_entity, filter=owner_select_filter)
                existing_select = select_abs_path_map.get(last_select.get_absolute_path())
                if existing_select is not None:
                    last_select = existing_select
                else:
                    selects[last_select.name] = last_select
                eu = EdgeUpdate(last_select, update_value)
                changes[eu.name] = eu

            else:
                raise ValueError(f"Unsupported change type '{type(value)}'")

    return BulkEntityHandler(selects, inserts, changes, removals)


def add_to_selects(add_selects: list[EdgeSelect], selects, select_abs_path_map, c) -> EdgeSelect:
    final_selects = []
    for new_select in add_selects:
        new_abs_path = new_select.get_absolute_path()
        existing_select = select_abs_path_map.get(new_abs_path)
        if existing_select is not None:
            for ref in new_select.referred_selects:
                ref.entity_top = existing_select
            final_selects.append(existing_select)
        else:
            if new_select.name in selects.keys():
                new_select.name += f"_{next(c)}"
            select_abs_path_map[new_abs_path] = new_select
            selects[new_select.name] = new_select
            final_selects.append(new_select)
    final_select = final_selects[-1]
    return final_select

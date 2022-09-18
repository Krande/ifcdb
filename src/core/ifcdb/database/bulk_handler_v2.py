from __future__ import annotations

from dataclasses import dataclass
from itertools import count
from typing import TYPE_CHECKING

from ifcdb.diffing.diff_types import (
    ValueAddedToIterable,
    ValueChange,
    ValueRemovedFromIterable,
)
from .inserts import EdgeInsert
from .remove.bulk_removal import EdgeRemove
from .select import EdgeFilter, EdgeSelect, FilterType, PropSelectResolver
from .updates.bulk_updates import EdgeUpdate, EntityUpdateValue, PropUpdateType

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
            remove_str += rem.to_edql_str()

        global_w_str = "with\n" + select_statement + insert_statement
        query_str = update_str + remove_str

        total_str = global_w_str + f"\nSELECT {{\n{query_str}\n}}"

        return total_str


def to_bulk_entity_handler(ifc_diff_tool: IfcDiffTool) -> BulkEntityHandler:
    # Should instead look for ways of merging bulk update objects is not yet supported instead of returning list
    inserts = dict()
    removals = []
    changes = dict()
    selects: dict[str, EdgeSelect] = dict()

    select_abs_path_map: dict[str, EdgeSelect] = dict()
    # TODO: bridge inserts and updates here
    insert_map: dict[str, EdgeInsert]
    c = count(1)

    # Additions
    for entity_add in ifc_diff_tool.added:
        for key, value in entity_add.added.linked_objects.items():
            if value == entity_add.added.entity:
                continue
            inserts[key] = EdgeInsert(value, key)

    # Removals
    for entity in ifc_diff_tool.removed:
        er = EdgeRemove(entity.class_name, EdgeFilter("GlobalId", entity.guid, FilterType.STR))
        removals.append(er)

    # Changes

    for diff_el in ifc_diff_tool.changed:
        for path, value in diff_el.value_changes.items():
            if isinstance(value, ValueChange):
                sr = PropSelectResolver(diff_el.entity, path, PropUpdateType.UPDATE)
                new_selects = sr.get_resolved_selects()
                last_select = add_to_selects(new_selects, selects, select_abs_path_map, c)

                att = getattr(value.ifc_elem, value.key)
                index = None
                tuple_len = None
                if isinstance(att, tuple):
                    index = att.index(value.new_value)
                    tuple_len = len(att)

                update_value = EntityUpdateValue(
                    value.new_value, value.old_value, PropUpdateType.UPDATE, value.key, index, tuple_len
                )
                eu = EdgeUpdate(last_select, update_value)
                changes[eu.name] = eu

            elif isinstance(value, ValueAddedToIterable):
                sr = PropSelectResolver(diff_el.entity, path, PropUpdateType.ADD_TO_ITERABLE)
                new_selects = sr.get_resolved_selects()
                last_select = add_to_selects(new_selects, selects, select_abs_path_map, c)

                new_entity_insert = EdgeInsert(value.new_entity)
                inserts[new_entity_insert.name] = new_entity_insert
                update_value = EntityUpdateValue(new_entity_insert, None, PropUpdateType.ADD_TO_ITERABLE, value.key)
                eu = EdgeUpdate(last_select, update_value)
                changes[eu.name] = eu
            elif isinstance(value, ValueRemovedFromIterable):
                er = EdgeRemove(value.entity.name, EdgeFilter("GlobalId", diff_el.guid, FilterType.STR))
                removals.append(er)
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

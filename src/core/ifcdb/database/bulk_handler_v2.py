from __future__ import annotations

import logging
from dataclasses import dataclass
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
class BulkHandler2:
    selects: dict[str, EdgeSelect]
    inserts: dict[str, EdgeInsert]
    changes: dict[str, EdgeUpdate]
    removes: list[EdgeRemove]

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
            update_str += update.to_edql_str(assign_to_variable=True)

        # DELETE statements
        remove_str = ""
        for rem in self.removes:
            remove_str += rem.to_edql_str()

        global_w_str = "with\n" + select_statement + insert_statement
        query_str = update_str + remove_str

        total_str = global_w_str + f"\nSELECT {{\n{query_str}\n}}"

        return total_str


def to_bulk_entity_handler(ifc_diff_tool: IfcDiffTool) -> BulkHandler2:
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
        er = EdgeRemove(entity.class_name, EdgeFilter("GlobalId", entity.guid, FilterType.STR))
        removals.append(er)

    # Changes
    def add_to_selects(add_selects: list[EdgeSelect]):
        for new_select in add_selects:
            existing_select = selects.get(new_select.name)
            if existing_select is not None:
                if new_select.entity_index != existing_select.entity_index:
                    new_select.name += "_1"
                else:
                    logging.warning(f"{new_select=}\n\n replaced by: \n\n{existing_select=}")
            selects[new_select.name] = new_select

    for diff_el in ifc_diff_tool.changed:
        for path, value in diff_el.value_changes.items():
            if isinstance(value, ValueChange):
                sr = PropSelectResolver(diff_el.entity, path, PropUpdateType.UPDATE)
                new_selects = sr.get_resolved_selects()
                add_to_selects(new_selects)
                last_select = new_selects[-1]
                att = getattr(value.ifc_elem, value.key)
                index = None
                tuple_len = None
                if isinstance(att, tuple):
                    index = att.index(value.new_value)
                    tuple_len = len(att)

                eu = EdgeUpdate(
                    last_select, EntityUpdateValue(value.new_value, value.old_value, value.key, index, tuple_len)
                )
                changes[eu.name] = eu

            elif isinstance(value, ValueAddedToIterable):
                sr = PropSelectResolver(diff_el.entity, path, PropUpdateType.ADD_TO_ITERABLE)
                new_selects = sr.get_resolved_selects()
                add_to_selects(new_selects)
                last_select = new_selects[-1]
                eu = EdgeUpdate(last_select, EntityUpdateValue(value.new_entity, None, value.key))
                changes[eu.name] = eu

                raise NotImplementedError()
            elif isinstance(value, ValueRemovedFromIterable):
                sr = PropSelectResolver(diff_el.entity, path, PropUpdateType.REMOVE_FROM_ITERABLE)
                new_selects = sr.get_resolved_selects()
                add_to_selects(new_selects)
                last_select = new_selects[-1]
                eu = EdgeRemove(value.entity.name, EdgeFilter("GlobalId", value))
                raise NotImplementedError()

    return BulkHandler2(selects, inserts, changes, removals)

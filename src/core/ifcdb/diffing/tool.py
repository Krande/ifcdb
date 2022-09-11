from __future__ import annotations

import copy
import logging
from dataclasses import dataclass, field
from enum import Enum

import ifcopenshell
from deepdiff import DeepDiff

from ifcdb.database.bulk_handler import BulkEntityHandler
from ifcdb.entities import (
    Entity,
    EntityResolver,
    EntityTool,
    get_entity_from_source_dict,
)
from ifcdb.io.ifc.optimizing import general_optimization


class ChangeType(Enum):
    CHANGED = "changed"
    REMOVED = "removed"
    ADDED = "added"


@dataclass
class EntityDiffBase:
    guid: str
    class_name: str


@dataclass
class EntityDiffChange(EntityDiffBase):
    diff: dict
    entity: Entity = None


@dataclass
class EntityDiffAdd(EntityDiffBase):
    added: EntityTool


@dataclass
class EntityDiffRemove(EntityDiffBase):
    pass


@dataclass
class IfcDiffTool:
    changed: list[EntityDiffChange] = field(default_factory=list)
    added: list[EntityDiffAdd] = field(default_factory=list)
    removed: list[EntityDiffRemove] = field(default_factory=list)

    schema_ver: str = "IFC4x1"
    optimize_before_diffing: bool = True

    def run(self, f1: ifcopenshell.file, f2: ifcopenshell.file):
        """Compare rooted elements in two ifc files and generate a list of element diffs"""
        if self.optimize_before_diffing:
            f1 = general_optimization(f1)
            f2 = general_optimization(f2)

        guids1 = set(x.GlobalId for x in f1.by_type("IfcRoot"))
        guids2 = set(x.GlobalId for x in f2.by_type("IfcRoot"))

        removed = guids1 - guids2
        added = guids2 - guids1

        for guid in removed:
            el = f1.by_guid(guid)
            self.removed.append(EntityDiffRemove(guid, el.is_a()))

        for guid in added:
            el = f2.by_guid(guid)
            entity_tool = EntityResolver.create_entity_tool_from_ifcopenshell_entity(el)
            self.added.append(EntityDiffAdd(guid, el.is_a(), entity_tool))

        for el in f1.by_type("IfcRoot"):
            guid = el.GlobalId
            if guid in removed or guid in added:
                continue
            result = self.element_validator(el, f2.by_guid(guid))
            if result is None:
                continue

            self.changed.append(result)

    def element_validator(
        self, el1: ifcopenshell.entity_instance, el2: ifcopenshell.entity_instance
    ) -> EntityDiffChange | None:
        info1 = el1.get_info(recursive=True, include_identifier=False)
        info2 = el2.get_info(recursive=True, include_identifier=False)

        # Walk hierarchy and pop linked elements that are already diffed
        new_info1 = ifc_info_walk_and_pop(info1, [x.guid for x in self.changed])
        new_info2 = ifc_info_walk_and_pop(info2, [x.guid for x in self.changed])

        res = DeepDiff(new_info1, new_info2)
        keys = list(res)
        if len(keys) > 0:
            entity = get_entity_from_source_dict(info1, schema_ver=self.schema_ver)
            return EntityDiffChange(el1.GlobalId, el1.is_a(), {key: res[key] for key in keys}, entity)

        return None

    def to_bulk_entity_handler(self: IfcDiffTool) -> BulkEntityHandler:
        # Should instead look for ways of merging bulk update objects is not yet supported instead of returning list
        return BulkEntityHandler(self)


def ifc_diff_tool(f1: ifcopenshell.file, f2: ifcopenshell.file) -> IfcDiffTool:
    tool = IfcDiffTool()
    tool.run(f1, f2)
    return tool


def ifc_info_walk_and_pop(source: dict, ids_to_skip: list[str]) -> dict:
    copied_source = copy.deepcopy(source)

    def walk(d, parents: list[dict | tuple], keys: list[str | int]):
        parent = parents[-1] if len(parents) > 0 else None
        parent_key = keys[-1] if len(keys) > 0 else None
        if isinstance(d, dict):
            guid = d.get("GlobalId")
            if guid is not None and guid in ids_to_skip:
                if len(parents) == 0:
                    logging.warning("Root object should not be included to begin with")
                    return None
                else:
                    if isinstance(parent, tuple):
                        grand_parent = parents[-2]
                        grand_parent_key = keys[-2]
                        list_copy = list(grand_parent[grand_parent_key])
                        list_copy.pop(parent_key)
                        grand_parent[grand_parent_key] = tuple(list_copy)
                    else:
                        parent.pop(parent_key)
            copy_d = copy.deepcopy(d)
            for key, value in copy_d.items():
                walk(value, parents + [d], keys + [key])

        elif isinstance(d, tuple):
            for i, x in enumerate(d):
                walk(x, parents + [d], keys + [i])
        else:
            logging.info("skipping ")

    walk(copied_source, [], [])
    return copied_source

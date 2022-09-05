from __future__ import annotations

from dataclasses import dataclass, field
from enum import Enum

import ifcopenshell
from deepdiff import DeepDiff


class ChangeType(Enum):
    CHANGED = "changed"
    REMOVED = "removed"
    ADDED = "added"


@dataclass
class ElDiff:
    guid: str
    change_type: ChangeType
    class_name: str
    diff: dict


@dataclass
class IfcDiffTool:
    changed: list[ElDiff] = field(default_factory=list)
    added: list[ElDiff] = field(default_factory=list)
    removed: list[ElDiff] = field(default_factory=list)

    def run(self, f1: ifcopenshell.file, f2: ifcopenshell.file):
        """Compare rooted elements in two ifc files and generate a list of element diffs"""
        guids1 = set(x.GlobalId for x in f1.by_type("IfcRoot"))
        guids2 = set(x.GlobalId for x in f2.by_type("IfcRoot"))

        removed = guids1 - guids2
        added = guids2 - guids1

        for guid in removed:
            el = f1.by_guid(guid)
            self.removed.append(ElDiff(guid, ChangeType.REMOVED, el.is_a(), dict()))

        for guid in added:
            el = f2.by_guid(guid)
            info = el.get_info(recursive=True, include_identifier=False)
            self.added.append(ElDiff(guid, ChangeType.ADDED, el.is_a(), info))

        for el in f1.by_type("IfcRoot"):
            guid = el.GlobalId
            if guid in removed or guid in added:
                continue
            result = self.element_validator(el, f2.by_guid(guid))
            if result is None:
                continue

            self.changed.append(result)

    def element_validator(self, el1: ifcopenshell.entity_instance, el2: ifcopenshell.entity_instance) -> ElDiff | None:
        info1 = el1.get_info(recursive=True, include_identifier=False)
        info2 = el2.get_info(recursive=True, include_identifier=False)

        res = DeepDiff(info1, info2)
        keys = list(res)
        if len(keys) > 0:
            # info2_ = el2.get_info(recursive=False, include_identifier=False)
            return ElDiff(el1.GlobalId, ChangeType.CHANGED, el1.is_a(), {key: res[key] for key in keys})

        return None


def ifc_diff_tool(f1: ifcopenshell.file, f2: ifcopenshell.file) -> IfcDiffTool:
    tool = IfcDiffTool()
    tool.run(f1, f2)
    return tool

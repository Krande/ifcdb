from __future__ import annotations

from dataclasses import dataclass

import ifcopenshell
from deepdiff import DeepDiff

from ifcdb.diffing.tool import (
    EntityDiffChange,
    IfcDiffTool,
    ValueAddedToIterable,
    ValueChange,
    ValueRemovedFromIterable,
)
from ifcdb.diffing.utils import get_elem_paths
from ifcdb.entities import EntityResolver


@dataclass
class OverlinkResolver:
    ifc_diff_tool: IfcDiffTool

    replace_object_placements_when_changed: bool = True

    def resolve(self) -> IfcDiffTool:
        ifc_diff_tool = self.ifc_diff_tool.copy()
        for change in self.ifc_diff_tool.changed:
            res = self.check_diff_entity(change)
            if res is None:
                continue
            index = ifc_diff_tool.changed.index(change)
            ifc_diff_tool.changed.pop(index)
            ifc_diff_tool.changed.insert(index, res)

        return ifc_diff_tool

    def check_inverse_relations_of_elem(self, f, elem, path):
        ifc_elem_path = get_elem_paths(elem, path)
        index = ifc_elem_path.get_index_of_nearest_ifc_elem()
        lowest_elem = ifc_elem_path.levels[index]
        inverse_elems = []
        has_inverse = True
        curr_level = lowest_elem
        curr_inverses = [lowest_elem]
        while has_inverse is True:
            inverse = f.get_inverse(curr_level, allow_duplicate=True)
            if len(inverse) > 0:
                inverse_elems.append((curr_level, inverse))
            curr_inverses += list(inverse)
            if len(curr_inverses) == 0:
                has_inverse = False
            else:
                curr_level = curr_inverses.pop()

        return inverse_elems

    def replace_local_placements(
        self, path: str, el1: ifcopenshell.entity_instance, el2: ifcopenshell.entity_instance
    ) -> ReplaceValue | None:
        obj_place_old = getattr(el1, "ObjectPlacement")
        info_old = obj_place_old.get_info(recursive=True, include_identifier=False)
        obj_place_new = getattr(el2, "ObjectPlacement")
        info_new = obj_place_new.get_info(recursive=True, include_identifier=False)
        res = DeepDiff(info_old, info_new)
        keys = list(res)
        entity_tool = EntityResolver.create_entity_tool_from_ifcopenshell_entity(obj_place_new)
        if len(keys) > 0:
            path_cropped = path.replace(path.split("ObjectPlacement']")[-1], "")
            vc = ValueChange(path_cropped, entity_tool.entity, key="ObjectPlacement")
            return ReplaceValue("ObjectPlacement", vc)
        return None

    def check_diff_entity(self, diff_entity: EntityDiffChange) -> EntityDiffChange | None:
        root_entity = diff_entity.guid
        path_to_be_replaced_by: dict[str, ReplaceValue] = dict()
        new_vc = {key: value for key, value in diff_entity.value_changes.items()}
        for path, vc in diff_entity.value_changes.items():
            root_elem_original = self.ifc_diff_tool.f1.by_guid(root_entity)
            root_elem_new = self.ifc_diff_tool.f2.by_guid(root_entity)
            if self.replace_object_placements_when_changed:
                new_diff = self.replace_local_placements(path, root_elem_original, root_elem_new)
                if new_diff is not None:
                    path_to_be_replaced_by[path] = new_diff
            # inverses_old = self.check_inverse_relations_of_elem(self.ifc_diff_tool.f1, root_elem_original, path)
            # inverses_new = self.check_inverse_relations_of_elem(self.ifc_diff_tool.f2, root_elem_new, path)
        if len(path_to_be_replaced_by) == 0:
            return None
        for key, value in path_to_be_replaced_by.items():
            new_vc.pop(key)
            new_vc[value.path] = value.new_value

        return EntityDiffChange(
            diff_entity.guid, diff_entity.class_name, diff_entity.diff, new_vc, diff_entity.root_entity
        )


@dataclass
class ReplaceValue:
    path: str
    new_value: ValueChange | ValueRemovedFromIterable | ValueAddedToIterable


def walk_inverses(f: ifcopenshell.file, elem: ifcopenshell.entity_instance) -> ifcopenshell.entity_instance:
    inverse = f.get_inverse(elem)
    for x in inverse:
        yield x

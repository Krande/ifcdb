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

OBJ_PLACE_STR = "ObjectPlacement"


@dataclass
class OverlinkResolver:
    ifc_diff_tool: IfcDiffTool

    replace_object_placements_when_changed: bool = True

    def resolve(self) -> IfcDiffTool:
        ifc_diff_tool = self.ifc_diff_tool.copy()
        for old_change in self.ifc_diff_tool.changed:
            new_change = self.check_diff_entity(old_change)
            if new_change is None:
                continue

            # remove old
            index = ifc_diff_tool.changed.index(old_change)
            ifc_diff_tool.changed.pop(index)

            # insert new
            ifc_diff_tool.changed.insert(index, new_change)

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

    def replace_geom_placement(self, path: str, el1: ifcopenshell.entity_instance, el2: ifcopenshell.entity_instance):
        ifc_elem_path_old = get_elem_paths(el1, path)
        ifc_elem_path_new = get_elem_paths(el2, path)
        res1 = ifc_elem_path_old.get_related_ifc_object_placement()
        res2 = ifc_elem_path_new.get_related_ifc_object_placement()
        if len(res2) == 0:
            return None

        info_old = res1[0].location_object.get_info(recursive=True, include_identifier=False)
        info_new = res2[0].location_object.get_info(recursive=True, include_identifier=False)
        entity_tool = EntityResolver.create_entity_tool_from_ifcopenshell_entity(res2[0].location_object)
        key = res2[0].key
        path_cropped = path.split(f"['{key}']")[0]
        vc = ValueChange(path_cropped, entity_tool, key=key)

        res = DeepDiff(info_old, info_new)
        keys = list(res)

        if len(keys) > 0:
            return ReplaceValue(path_cropped, vc)

        return None

    def replace_local_placements(
        self, path: str, el1: ifcopenshell.entity_instance, el2: ifcopenshell.entity_instance
    ) -> ReplaceValue | None:
        obj_place_old = getattr(el1, OBJ_PLACE_STR)
        obj_place_new = getattr(el2, OBJ_PLACE_STR)

        info_old = obj_place_old.get_info(recursive=True, include_identifier=False)
        info_new = obj_place_new.get_info(recursive=True, include_identifier=False)
        entity_tool = EntityResolver.create_entity_tool_from_ifcopenshell_entity(obj_place_new)

        key = OBJ_PLACE_STR
        path_cropped = path.replace(path.split(f"{key}']")[-1], "")
        vc = ValueChange(path_cropped, entity_tool, key=key)

        res = DeepDiff(info_old, info_new)
        keys = list(res)

        if len(keys) > 0:
            return ReplaceValue("root", vc)

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
                    continue

                other_diff = self.replace_geom_placement(path, root_elem_original, root_elem_new)
                if other_diff is not None:
                    path_to_be_replaced_by[path] = other_diff
                    continue
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

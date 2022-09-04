from __future__ import annotations

import logging
import re
from dataclasses import dataclass, field
from enum import Enum

import ifcopenshell
from deepdiff import DeepDiff

from ifcdb.ifcdiff import IfcDiff


def validate_ifc_content(ofile: ifcopenshell.file, results: dict):
    obj_set = {key: value for key, value in results[0].items() if len(value) != 0}

    # Try to manually edit a single property to ensure that it fails if discrepancies are found
    # obj_set["IfcCartesianPointList3D"][0]["CoordList"][0][1] = 200

    for ifc_class, instances in obj_set.items():
        for instance in instances:
            original_instance_found = False
            ifc_class_entities = list(ofile.by_type(ifc_class, True))
            for original_instance in ifc_class_entities:
                match_found = True
                for prop_name, prop_value in instance.items():
                    if prop_name == "id":
                        continue
                    if isinstance(prop_value, (list, tuple)) and len(prop_value) == 0:
                        prop_value = None
                    inst_value = getattr(original_instance, prop_name)
                    if isinstance(inst_value, ifcopenshell.entity_instance):
                        continue
                    elif isinstance(inst_value, (list, tuple)) and isinstance(
                        inst_value[0], ifcopenshell.entity_instance
                    ):
                        if len(inst_value) != len(prop_value):
                            match_found = False
                            break
                    elif isinstance(inst_value, (list, tuple)) and isinstance(inst_value[0], float):
                        for x, y in zip(inst_value, prop_value):
                            if x != y:
                                match_found = False
                                break
                    elif isinstance(inst_value, (list, tuple)) and isinstance(inst_value[0], (list, tuple)):
                        for a1, a2 in zip(inst_value, prop_value):
                            for x, y in zip(a1, a2):
                                if x != y:
                                    match_found = False
                                    break
                    else:
                        if inst_value != prop_value:
                            match_found = False
                            break
                if match_found is True:
                    original_instance_found = True
                    break

            if len(ifc_class_entities) > 0 and original_instance_found is False:
                entity_description = "[" + ",\n".join([str(x) for x in ifc_class_entities]) + "]"
                raise ValueError(f'Instance "{instance}" not found among\n{entity_description}')

    print("Successfully Validated IFC Content")


def fingerprint(file: ifcopenshell.file):
    get_info_props = dict(include_identifier=False, recursive=True, return_type=frozenset)
    return frozenset(inst.get_info(**get_info_props) for inst in file)


def validate_ifc_objects(f1: ifcopenshell.file, f2: ifcopenshell.file):
    compare_ifcopenshell_objects_element_by_element(f1, f2)

    # This assertion does not work as intended
    assert fingerprint(f1) == fingerprint(f2)


def compare_ifcopenshell_objects_element_by_element(f1: ifcopenshell.file, f2: ifcopenshell.file):
    results = sorted(fingerprint(f1).symmetric_difference(fingerprint(f2)), key=lambda x: len(str(x)))

    res = [set([name for name, value in result]) for result in results]

    matches = []
    i = 0
    while i < len(res):
        x = res[i]
        for k, match_eval in enumerate(res):
            if k == i or x != match_eval:
                continue
            found = tuple(sorted([i, k]))
            if found not in matches:
                matches.append(found)
            break
        i += 1

    # Compare element by element
    for a, b in matches:
        m_a = {key: value for key, value in results[a]}
        m_b = {key: value for key, value in results[b]}
        ifc_class = m_a["type"]
        for key, value in m_a.items():
            other_val = m_b[key]
            if isinstance(value, frozenset):
                continue
            if isinstance(value, tuple) and isinstance(value[0], frozenset):
                continue
            if other_val != value:
                logging.error(f'Diff in Ifc Class "{ifc_class}" property: {key} := "{value}" != "{other_val}"')


def validate_using_ifc_diff(
    f1: ifcopenshell.file,
    f2: ifcopenshell.file,
    output_file: str = None,
    inverse_classes: list[str] = None,
):
    ifc_diff = IfcDiff(f1, f2, output_file, inverse_classes)
    ifc_diff.diff()
    return ifc_diff.to_json()


class ChangeType(Enum):
    CHANGED = "changed"
    REMOVED = "removed"
    ADDED = "added"
    VALUES_CHANGED = "values_changed"


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

    guid_map: dict[str, dict] = field(default_factory=dict, repr=False)

    def do_diffing(self, f1: ifcopenshell.file, f2: ifcopenshell.file):
        """Compare rooted elements in two ifc files and generate a list of element diffs"""
        guids1 = set(x.GlobalId for x in f1.by_type("IfcRoot"))
        guids2 = set(x.GlobalId for x in f2.by_type("IfcRoot"))

        guids_diff = guids2.difference(guids1)
        for guid in guids_diff:
            if guid in guids1:
                el = f1.by_guid(guid)
                self.removed.append(ElDiff(guid, ChangeType.REMOVED, el.is_a(), dict()))
            else:
                el = f2.by_guid(guid)
                info = el.get_info(recursive=True, include_identifier=False)
                self.added.append(ElDiff(guid, ChangeType.ADDED, el.is_a(), info))

        for el in f1.by_type("IfcRoot"):
            result = self.element_validator(el, f2.by_guid(el.GlobalId))
            if result is None:
                continue
            if result.change_type == ChangeType.ADDED:
                self.added.append(result)
            elif result.change_type == ChangeType.REMOVED:
                self.removed.append(result)
            else:
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
    tool.do_diffing(f1, f2)
    return tool


RE_COMP = re.compile(r"\[(.*?)\]")


def replace_value(elem: ifcopenshell.entity_instance, path: str, new_value) -> None:
    curr_elem = elem
    all_sub_levels = RE_COMP.findall(path)
    levels = [curr_elem]
    indices = []
    for i, next_path in enumerate(all_sub_levels, start=1):
        path_ = next_path.replace("'", "")

        if path_.isnumeric():
            path_ = int(path_)
            next_elem = curr_elem[path_]
        else:
            next_elem = getattr(curr_elem, path_)
        indices.append(path_)
        curr_elem = next_elem
        levels.append(curr_elem)

    parent_entity = levels[-3]
    parent_index = indices[-2]
    last_entity = levels[-2]
    last_index = indices[-1]
    if isinstance(last_entity, tuple):
        list_ver = list(levels[-2])
        list_ver[last_index] = new_value
        result = tuple(list_ver)
        if isinstance(parent_entity, ifcopenshell.entity_instance):
            setattr(parent_entity, parent_index, result)
        else:
            raise NotImplementedError("This is not yet supported")
    else:
        setattr(last_entity, last_index, new_value)


def add_elem_to_object(f: ifcopenshell.file, path: str, value: dict):
    raise NotImplementedError("Adding elements are not yet implemented")


def get_guid_map(f: ifcopenshell.file, value: dict, guid_map: dict = None) -> dict:
    if guid_map is None:
        guid_map = dict()
    for key, value in value.items():
        if isinstance(value, dict):
            guid = value.get("GlobalId")
            if guid is not None:
                res = f.by_guid(guid)
                if res is not None:
                    guid_map[guid] = res
            get_guid_map(f, value, guid_map)
        elif isinstance(value, tuple):
            for v in value:
                if isinstance(v, dict):
                    get_guid_map(f, v, guid_map)
    return guid_map


def add_elem(f: ifcopenshell.file, value: dict):
    # check for existing elements by globalid
    _ = get_guid_map(f, value)
    raise NotImplementedError("Adding elements are not yet implemented")


def apply_diffs_ifcopenshell(f: ifcopenshell.file, diff_tool: IfcDiffTool):
    for diff_el in diff_tool.added:
        add_elem(f, diff_el.diff)

    for diff_el in diff_tool.changed:
        old_ifc_elem: ifcopenshell.entity_instance = f.by_guid(diff_el.guid)
        for diff_type, diff in diff_el.diff.items():
            for diff_path, value_change in diff.items():
                if diff_type == "values_changed":
                    replace_value(old_ifc_elem, diff_path, value_change["new_value"])
                elif diff_type == "iterable_item_added":
                    add_elem_to_object(f, diff_path, value_change)
                else:
                    raise NotImplementedError(f'Change type "{diff_type}" is not yet supported')

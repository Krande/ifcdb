from __future__ import annotations

import re
from typing import TYPE_CHECKING

import ifcopenshell
from deepdiff import DeepDiff

if TYPE_CHECKING:
    from ifcdb.diffing.tool import IfcDiffTool, EntityDiffAdd

from ifcdb.entities import entity_to_dict

_RE_COMP = re.compile(r"\[(.*?)\]")


def get_elem_paths(elem: ifcopenshell.entity_instance, path: str, is_append_obj=False):
    curr_elem = elem
    all_sub_levels = _RE_COMP.findall(path)
    levels = [curr_elem]
    indices = []
    for i, next_path in enumerate(all_sub_levels, start=1):
        path_ = next_path.replace("'", "")
        is_index = False
        if path_.isnumeric():
            path_ = int(path_)
            is_index = True

        indices.append(path_)

        if is_append_obj and i == len(all_sub_levels):
            continue

        if is_index:
            next_elem = curr_elem[path_]
        else:
            next_elem = getattr(curr_elem, path_)

        curr_elem = next_elem
        levels.append(curr_elem)
    return levels, indices


def replace_value(elem: ifcopenshell.entity_instance, path: str, new_value) -> None:
    levels, indices = get_elem_paths(elem, path)

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


def add_iterable_item(f: ifcopenshell.file, elem: ifcopenshell.entity_instance, path: str, value: dict):
    levels, indices = get_elem_paths(elem, path, is_append_obj=True)
    owning_entity = levels[-2]
    last_index = indices[-2]
    new_iterable = list(levels[-1])
    new_iterable.append(f.by_guid(value["GlobalId"]))
    setattr(owning_entity, last_index, tuple(new_iterable))


def dict_to_ifcopenshell_entity(f: ifcopenshell.file, source: dict) -> ifcopenshell.entity_instance:
    props = dict()
    class_type = source.pop("type")
    for key, value in source.items():
        if isinstance(value, dict):
            props[key] = dict_to_ifcopenshell_entity(f, value)
        elif isinstance(value, tuple):
            values = []
            for val in value:
                if isinstance(val, dict):
                    values.append(dict_to_ifcopenshell_entity(f, val))
                else:
                    values.append(val)
            props[key] = tuple(values)
        else:
            props[key] = value

    entity = f.create_entity(class_type, **props)
    return entity


def get_existing_type(f: ifcopenshell.file, class_type: str, class_info: dict) -> ifcopenshell.entity_instance:
    for existing_placement in f.by_type(class_type):
        info_existing = existing_placement.get_info(recursive=True, include_identifier=False)
        result = DeepDiff(info_existing, class_info)
        keys = list(result)
        if len(keys) == 0:
            return existing_placement

    # Unable to find existing, so creating a new one instead
    return dict_to_ifcopenshell_entity(f, class_info)


def add_elem(f: ifcopenshell.file, entity_add: EntityDiffAdd):
    source = entity_to_dict(entity_add.added.entity)
    # check for existing elements by globalid
    class_type = source.pop("type")
    owner = source.get("OwnerHistory")
    obj_place = source.get("ObjectPlacement")

    rel_to = get_existing_type(f, "IfcLocalPlacement", obj_place.get("PlacementRelTo"))
    axis_loc = get_existing_type(f, "IfcAxis2Placement3D", obj_place.get("RelativePlacement"))
    obj_placement = f.create_entity("IfcLocalPlacement", PlacementRelTo=rel_to, RelativePlacement=axis_loc)
    representation = source.get("Representation")

    geom = dict_to_ifcopenshell_entity(f, representation)
    props = dict(Representation=geom, ObjectPlacement=obj_placement, OwnerHistory=owner)
    for key, value in source.items():
        if key in ("OwnerHistory", "ObjectPlacement", "Representation"):
            continue
        props[key] = value

    return f.create_entity(class_type, **props)


def remove_elem(f: ifcopenshell.file, guid: str):
    elem_to_be_removed = f.by_guid(guid)
    f.remove(elem_to_be_removed)


def apply_diffs_ifcopenshell(f: ifcopenshell.file, diff_tool: IfcDiffTool):
    for diff_el in diff_tool.added:
        add_elem(f, diff_el)

    for diff_el in diff_tool.removed:
        remove_elem(f, diff_el.guid)

    for diff_el in diff_tool.changed:
        old_ifc_elem: ifcopenshell.entity_instance = f.by_guid(diff_el.guid)
        for diff_type, diff in diff_el.diff.items():
            for diff_path, value_change in diff.items():
                if diff_type == "values_changed":
                    replace_value(old_ifc_elem, diff_path, value_change["new_value"])
                elif diff_type == "iterable_item_added":
                    add_iterable_item(f, old_ifc_elem, diff_path, value_change)
                elif diff_type == "iterable_item_removed":
                    pass
                else:
                    raise NotImplementedError(f'Change type "{diff_type}" is not yet supported')

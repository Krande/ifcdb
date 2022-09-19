from __future__ import annotations

import re
from dataclasses import dataclass
from typing import Iterable

import ifcopenshell

RE_COMP = re.compile(r"\[(.*?)\]")


@dataclass
class IfcElemPath:
    levels: list[ifcopenshell.entity_instance | tuple | float | str | int]
    indices: list[str | int]

    def get_index_of_nearest_ifc_elem(self) -> int:
        levels_rev = [x for x in self.levels]
        levels_rev.reverse()

        level_index = None
        for i, lvl in enumerate(levels_rev):
            if isinstance(lvl, ifcopenshell.entity_instance):
                level_index = i
                break

        index = len(self.levels) - level_index - 1
        return index


def get_elem_paths(elem: ifcopenshell.entity_instance, path: str, is_append_obj=False) -> IfcElemPath:
    curr_elem = elem
    all_sub_levels = RE_COMP.findall(path)
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
    return IfcElemPath(levels, indices)


def slice_property_path_at_key(path: str, key_to_stop_at: str) -> str:
    all_sub_levels = list(dict_path_to_iterable(path))
    index_ref_key = all_sub_levels.index(key_to_stop_at)
    actual_key = all_sub_levels[index_ref_key + 1]
    temp_split = path.split(actual_key)
    if len(temp_split) == 1:
        raise ValueError(f'Unable to find key "{key_to_stop_at}" in path "{path}"')
    elif len(temp_split) > 2:
        raise ValueError(f'Multiple "{key_to_stop_at}" keys found in path "{path}"')
    base_path = temp_split[0][:-2]
    return base_path


def clean_path_elem(elem: str) -> str | int:
    elem = elem.replace("'", "")
    if elem.isnumeric():
        return int(elem)
    else:
        return elem


def dict_path_to_iterable(path) -> Iterable:
    return map(clean_path_elem, RE_COMP.findall(path))

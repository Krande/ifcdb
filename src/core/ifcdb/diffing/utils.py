from __future__ import annotations

import re
import ifcopenshell

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


def slice_property_path_at_key(path: str, key_to_stop_at: str) -> str:
    all_sub_levels = [x.replace("'", '') for x in _RE_COMP.findall(path)]
    index_ref_key = all_sub_levels.index(key_to_stop_at)
    actual_key = all_sub_levels[index_ref_key+1]
    temp_split = path.split(actual_key)
    if len(temp_split) == 1:
        raise ValueError(f'Unable to find key "{key_to_stop_at}" in path "{path}"')
    elif len(temp_split) > 2:
        raise ValueError(f'Multiple "{key_to_stop_at}" keys found in path "{path}"')
    base_path = temp_split[0][:-2]
    return base_path

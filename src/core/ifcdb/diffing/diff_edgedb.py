from __future__ import annotations

import toposort
from typing import Iterable

from .diff_ifcopen import _RE_COMP


def clean_path_elem(elem: str) -> str | int:
    elem = elem.replace("'", "")
    if elem.isnumeric():
        return int(elem)
    else:
        return elem


def dict_path_to_iterable(path) -> Iterable:
    return map(clean_path_elem, _RE_COMP.findall(path))


def iterable_path_to_edgedb_path(path_iter: Iterable) -> str:
    path_str = ""
    for i, elem in enumerate(path_iter):
        if isinstance(elem, int):
            path_str += f"[{elem}]"
        else:
            if i != 0:
                path_str += "."
            path_str += elem
    return path_str


def dict_path_to_edgedb_path(path: str) -> str:
    return iterable_path_to_edgedb_path(dict_path_to_iterable(path))


def find_unique_selects(source: dict):
    all_path_deps = dict()
    value_keys = []
    for key, value in source.items():
        path = tuple(dict_path_to_iterable(key))
        value_keys.append((path[-1], value))
        all_prev = []
        for p in path:
            abs_path = iterable_path_to_edgedb_path(all_prev + [p])
            parent_path = iterable_path_to_edgedb_path(all_prev)
            if abs_path not in all_path_deps.keys():
                all_path_deps[abs_path] = []
            all_path_deps[abs_path].append(parent_path)
            all_prev.append(p)

    result_list = list(toposort.toposort(all_path_deps))

    branches = []
    for result_set in result_list:
        if len(result_set) > 1:
            branches.append(result_set)

    # find common paths

    print("sd")

from __future__ import annotations

from typing import Iterable

from .utils import dict_path_to_iterable


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

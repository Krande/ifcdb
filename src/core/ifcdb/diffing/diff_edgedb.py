from __future__ import annotations

from typing import TYPE_CHECKING

import edgedb

if TYPE_CHECKING:
    from ifcdb.diffing.concept import IfcDiffTool, ElDiff

from .diff_ifcopen import _RE_COMP


def dict_path_to_edgedb_path(path: str) -> str:
    res = _RE_COMP.findall(path)
    path_str = ""
    num_close = 0
    for r in res:
        prop = r.replace("'", "")
        if prop.isnumeric():
            path_str += f"[{prop}]"
        else:
            path_str += ": {"
            num_close += 1
            path_str += prop
    path_str += num_close * "}"
    return path_str


def add_entity(elem: ElDiff):
    _ = "SELECT (INSERT"
    raise NotImplementedError()


def remove_entity(elem: ElDiff):
    raise NotImplementedError()


def change_entity(client: edgedb.Client, elem: ElDiff) -> str:
    filter_str = f"UPDATE {elem.class_name} FILTER .GlobalId=<str>'{elem.guid}'"

    prop_set_str = ""
    for diff_type, diff in elem.diff.items():
        if diff_type == "values_changed":
            for path, values in diff.items():
                edgedb_path = dict_path_to_edgedb_path(path)
                new_value = values["new_value"]
                prop_set_str += f"{edgedb_path}:={new_value},\n"
    set_str = f"SET {{ {prop_set_str} }}"

    return_props_str = "{FamilyName, GivenName, Identification, Roles, Addresses}"
    _ = f"""
                SELECT (
                    {filter_str}
                    {set_str}
                ) {return_props_str};
                """
    raise NotImplementedError()


def apply_diffs_edgedb(client: edgedb.Client, diff_tool: IfcDiffTool):
    for diff_el in diff_tool.added:
        add_entity(diff_el)

    for diff_el in diff_tool.removed:
        remove_entity(diff_el)

    for diff_el in diff_tool.changed:
        change_entity(client, diff_el)

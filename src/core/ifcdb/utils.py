from __future__ import annotations

import ifcopenshell
import os
import pathlib
from typing import TYPE_CHECKING
from dataclasses import dataclass

if TYPE_CHECKING:
    from ifcdb import EdgeIO


def top_dir() -> pathlib.Path:
    this_dir = pathlib.Path(__file__).parent.resolve().absolute()
    cwd = pathlib.Path(os.getcwd())
    top_level_dirs = {"src", "files", "docs"}
    parents = [this_dir, cwd] + list(cwd.parents) + list(this_dir.parents)
    if "site-packages" in parents[0].name:
        cwd = pathlib.Path.cwd()
        this_dir = cwd.parent.resolve().absolute()
        parents = list(this_dir.parents)
    list_of_subdirs = []
    for parent in parents:
        subdirs = set([x.name for x in parent.iterdir() if x.is_dir()])
        if subdirs.issuperset(top_level_dirs):
            return parent
        list_of_subdirs.append(list(subdirs)[:3])

    raise ValueError(
        f"Unable to find top directory containing '{top_level_dirs}' within parent dirs '{list(parents)}'"
        f" with subdirs; '{list_of_subdirs}'"
    )


def change_case(camelcase_str):
    res = [camelcase_str[0].lower()]
    for c in camelcase_str[1:]:
        if c in "ABCDEFGHIJKLMNOPQRSTUVWXYZ":
            res.append("_")
            res.append(c.lower())
        else:
            res.append(c)

    return "".join(res)


@dataclass
class DbIfcClassesDiff:
    db_class_types: set
    ifc_classes: set

    def get_missing_ifc_classes(self) -> list[str]:
        missing = self.ifc_classes - self.db_class_types
        return list(missing)

    def get_all_classes(self) -> list[str]:
        return list(set(list(self.ifc_classes) + list(self.db_class_types)))


def db_ifc_diff_getter(db_name: str, ifc_path: os.PathLike | str) -> DbIfcClassesDiff:
    from ifcdb.database.getters.db_content import DbContent
    from ifcdb import EdgeIO

    with EdgeIO(db_name, load_env=True) as io:
        dbc = DbContent(io.db_entity_model, io.client)
        db_class_types = set(dbc.get_db_instance_types())

    f = ifcopenshell.open(ifc_path)
    ifc_classes = set([x.is_a() for x in f])
    return DbIfcClassesDiff(db_class_types, ifc_classes)

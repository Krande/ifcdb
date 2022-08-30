import os
import pathlib


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

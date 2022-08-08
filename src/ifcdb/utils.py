import pathlib


def top_dir() -> pathlib.Path:
    this_dir = pathlib.Path(__file__).parent.resolve().absolute()
    top_level_dirs = {"src", "files", "scripts"}
    parents = list(this_dir.parents)
    if "site-packages" in parents[0].name:
        cwd = pathlib.Path.cwd()
        this_dir = cwd.parent.resolve().absolute()
        parents = list(this_dir.parents)
    for parent in parents:
        subdirs = set([x.name for x in parent.iterdir() if x.is_dir()])
        if subdirs.issuperset(top_level_dirs):
            return parent

    raise ValueError(f"Unable to find top directory containing '{top_level_dirs}' within parent dirs '{list(parents)}'")


def change_case(camelcase_str):
    res = [camelcase_str[0].lower()]
    for c in camelcase_str[1:]:
        if c in "ABCDEFGHIJKLMNOPQRSTUVWXYZ":
            res.append("_")
            res.append(c.lower())
        else:
            res.append(c)

    return "".join(res)

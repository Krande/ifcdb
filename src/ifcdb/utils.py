import pathlib


def top_dir() -> pathlib.Path:
    this_dir = pathlib.Path(__file__).parent
    for parent in this_dir.parents:
        subdirs = [x.name for x in parent.iterdir()]
        if "src" in subdirs and "files" in subdirs and "scripts" in subdirs:
            return parent


def change_case(camelcase_str):
    res = [camelcase_str[0].lower()]
    for c in camelcase_str[1:]:
        if c in "ABCDEFGHIJKLMNOPQRSTUVWXYZ":
            res.append("_")
            res.append(c.lower())
        else:
            res.append(c)

    return "".join(res)

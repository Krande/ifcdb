import pathlib


def top_dir() -> pathlib.Path:
    this_dir = pathlib.Path(__file__).parent
    for parent in this_dir.parents:
        subdirs = [x.name for x in parent.iterdir()]
        if "src" in subdirs and "files" in subdirs and "scripts" in subdirs:
            return parent

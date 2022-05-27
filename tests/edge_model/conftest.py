import pytest
import pathlib


@pytest.fixture
def root_dir() -> pathlib.Path:
    parent_dirs = list(pathlib.Path(__file__).parents)
    index = [x.stem for x in parent_dirs].index("ifcdb")
    return parent_dirs[index]

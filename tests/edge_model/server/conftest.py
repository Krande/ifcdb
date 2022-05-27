import pathlib

import pytest


@pytest.fixture
def ifc_files_dir(root_dir) -> pathlib.Path:
    return root_dir / "files"

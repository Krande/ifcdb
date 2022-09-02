import ifcopenshell
import pytest


@pytest.fixture
def my_cube(files_dir) -> ifcopenshell.file:
    return ifcopenshell.open(files_dir / "MyCube.ifc")


@pytest.fixture
def my_cube_post(files_dir) -> ifcopenshell.file:
    return ifcopenshell.open(files_dir / "MyCubePost.ifc")

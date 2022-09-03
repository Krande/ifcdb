import ifcopenshell
import pytest


@pytest.fixture
def my_cube(files_dir) -> ifcopenshell.file:
    return ifcopenshell.open(files_dir / "MyCube.ifc")


@pytest.fixture
def my_cube_edited(files_dir) -> ifcopenshell.file:
    return ifcopenshell.open(files_dir / "MyCubeEdited.ifc")


@pytest.fixture
def my_cube_added(files_dir) -> ifcopenshell.file:
    return ifcopenshell.open(files_dir / "MyCubeAdded.ifc")

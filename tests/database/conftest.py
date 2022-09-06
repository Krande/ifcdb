import json
import pathlib
from dataclasses import dataclass

import ifcopenshell
import pytest

from ifcdb.io.ifc import IfcIO
from ifcdb.schema.model import IfcSchemaModel


@pytest.fixture
def my_cube(files_dir) -> ifcopenshell.file:
    return ifcopenshell.open(files_dir / "MyCube.ifc")


@pytest.fixture
def my_cube_edited(files_dir) -> ifcopenshell.file:
    return ifcopenshell.open(files_dir / "MyCubeEdited.ifc")


@pytest.fixture
def my_cube_added(files_dir) -> ifcopenshell.file:
    return ifcopenshell.open(files_dir / "MyCubeAdded.ifc")


@dataclass
class MockDb:
    json_result_all: pathlib.Path

    def to_ifcopenshell_object(self) -> ifcopenshell.file:
        res = json.load(open(self.json_result_all))
        return IfcIO.to_ifcopenshell_object(res, IfcSchemaModel("IFC4x1"))


@pytest.fixture
def mock_db_my_beam_with_holes(files_dir) -> MockDb:
    return MockDb(files_dir / "MyBeamWithHoles_get_all_res.json")

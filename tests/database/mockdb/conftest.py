import json
import pathlib
from dataclasses import dataclass

import ifcopenshell
import pytest

from ifcdb.io.ifc import IfcIO
from ifcdb.schema.model import IfcSchemaModel


@pytest.fixture
def empty_ifc_model():
    return ifcopenshell.file(schema="IFC4x1")


@pytest.fixture
def my_cube_added(my_cube_added_ifc_filepath) -> ifcopenshell.file:
    return ifcopenshell.open(my_cube_added_ifc_filepath)


@dataclass
class MockDb:
    json_result_all: pathlib.Path

    def to_ifcopenshell_object(self) -> ifcopenshell.file:
        res = json.load(open(self.json_result_all))
        return IfcIO.to_ifcopenshell_object(res, IfcSchemaModel("IFC4x1"))


@pytest.fixture
def mock_db_my_beam_with_holes(files_dir) -> MockDb:
    return MockDb(files_dir / "MyBeam_w_holes/MyBeamWithHoles_get_all_res.json")


@pytest.fixture
def mock_db_my_cube_original(files_dir) -> MockDb:
    return MockDb(files_dir / "MyCube/res_original_raw.json")

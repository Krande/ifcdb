import pathlib

import ifcopenshell
import pytest
from dotenv import load_dotenv

from ifcdb.pymodel.base import ExpReader
from ifcdb.schema.model import IfcSchemaModel

load_dotenv()  # take environment variables from .env.


@pytest.fixture
def root_dir() -> pathlib.Path:
    parent_dirs = list(pathlib.Path(__file__).parents)
    index = [x.stem for x in parent_dirs].index("ifcdb")
    return parent_dirs[index]


@pytest.fixture
def files_dir(root_dir) -> pathlib.Path:
    return root_dir / "files"


@pytest.fixture
def ifc_4x1_exp_file(root_dir):
    exp_file = root_dir / "IFC4.3.x-development/reference_schemas/IFC4x1.exp"
    return exp_file.resolve().absolute()


@pytest.fixture
def wrap() -> ifcopenshell.ifcopenshell_wrapper:
    return ifcopenshell.ifcopenshell_wrapper


@pytest.fixture
def sm_ifc4x1(wrap) -> IfcSchemaModel:
    return IfcSchemaModel(schema_version="IFC4x1")


@pytest.fixture
def expreader_ifc4x1(ifc_4x1_exp_file) -> ExpReader:
    return ExpReader(express_file=ifc_4x1_exp_file)


@pytest.fixture
def my_beam_w_holes_ifc(files_dir):
    return ifcopenshell.open(files_dir / "MyBeam_w_holes/MyBeamWithHoles.ifc")

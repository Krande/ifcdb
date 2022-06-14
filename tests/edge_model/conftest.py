import pathlib

import ifcopenshell
import pytest

from ifc_schema.interop.base import ExpReader
from ifc_schema.interop.edge_model.edge_model_base import EdgeModel


@pytest.fixture
def root_dir() -> pathlib.Path:
    parent_dirs = list(pathlib.Path(__file__).parents)
    index = [x.stem for x in parent_dirs].index("ifcdb")
    return parent_dirs[index]


@pytest.fixture
def ifc_files_dir(root_dir) -> pathlib.Path:
    return root_dir / "files"


@pytest.fixture
def ifc_4x1_exp_file(root_dir):
    exp_file = root_dir / "IFC4.3.x-development/reference_schemas/IFC4x1.exp"
    return exp_file.resolve().absolute()


@pytest.fixture
def wrap() -> ifcopenshell.ifcopenshell_wrapper:
    return ifcopenshell.ifcopenshell_wrapper


@pytest.fixture
def em_ifc4x1(wrap) -> EdgeModel:
    return EdgeModel(schema=wrap.schema_by_name("IFC4x1"))


@pytest.fixture
def expreader_ifc4x1(ifc_4x1_exp_file) -> ExpReader:
    return ExpReader(express_file=ifc_4x1_exp_file)


@pytest.fixture
def tesselated_item_ifc(ifc_files_dir):
    return ifcopenshell.open(ifc_files_dir / "tessellated-item.ifc")

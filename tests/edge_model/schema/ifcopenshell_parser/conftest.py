import ifcopenshell
import pytest
from ifc_schema.interop.edge_model.edge_model_base import EdgeModel
from ifc_schema.interop.base import ExpReader


@pytest.fixture
def wrap() -> ifcopenshell.ifcopenshell_wrapper:
    return ifcopenshell.ifcopenshell_wrapper


@pytest.fixture
def em_ifc4x1(wrap) -> EdgeModel:
    return EdgeModel(schema=wrap.schema_by_name("IFC4x1"))


@pytest.fixture
def expreader_ifc4x1(ifc_4x1_exp_file) -> ExpReader:
    return ExpReader(express_file=ifc_4x1_exp_file)

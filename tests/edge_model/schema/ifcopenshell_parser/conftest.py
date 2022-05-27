import ifcopenshell
import pytest
from ifc_schema.interop.edge_model.edge_model_base import EdgeModel


@pytest.fixture
def wrap() -> ifcopenshell.ifcopenshell_wrapper:
    return ifcopenshell.ifcopenshell_wrapper


@pytest.fixture
def em_ifc4x1(wrap) -> EdgeModel:
    return EdgeModel(schema=wrap.schema_by_name("IFC4x1"))

import pytest


@pytest.fixture
def ifc_4x1_exp_file(root_dir):
    exp_file = root_dir / "IFC4.3.x-development/reference_schemas/IFC4x1.exp"
    return exp_file.resolve().absolute()

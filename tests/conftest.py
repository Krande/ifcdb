import pathlib

import pytest


@pytest.fixture
def ifc_4x1_exp_file():
    return (pathlib.Path(__file__).parent / "../IFC4.3.x-development/reference_schemas/IFC4x1.exp").resolve().absolute()

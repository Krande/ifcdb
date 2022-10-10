import ifcopenshell
import pytest

from ifcdb.diffing.tool import IfcDiffTool


@pytest.fixture
def model_0(files_dir):
    return ifcopenshell.open(files_dir / "simplestru_diffing/model_00.ifc")


@pytest.fixture
def model_1_from_db(files_dir):
    return ifcopenshell.open(files_dir / "simplestru_diffing/model_01_from_db.ifc")


@pytest.fixture
def model_2_w_cubes(files_dir):
    return ifcopenshell.open(files_dir / "simplestru_diffing/model_02_w_cubes.ifc")


@pytest.fixture
def model_3_w_pipes(files_dir):
    return ifcopenshell.open(files_dir / "simplestru_diffing/model_03_w_pipe.ifc")


@pytest.fixture
def model_4_w_pen_detail(files_dir):
    return ifcopenshell.open(files_dir / "simplestru_diffing/model_04_w_pen_detail.ifc")


def test_model_download(model_0, model_1_from_db):
    diff_tool = IfcDiffTool(model_0, model_1_from_db)

    assert len(diff_tool.changed) == 0
    assert len(diff_tool.added) == 0
    assert len(diff_tool.removed) == 0


def test_model_add_cube(model_1_from_db, model_2_w_cubes):
    diff_tool = IfcDiffTool(model_1_from_db, model_2_w_cubes)

    assert len(diff_tool.changed) == 0
    assert len(diff_tool.added) == 8
    assert len(diff_tool.removed) == 0

    print("sd")


def test_model_add_pipe(model_2_w_cubes, model_3_w_pipes):
    diff_tool = IfcDiffTool(model_2_w_cubes, model_3_w_pipes)

    assert len(diff_tool.changed) == 2
    assert len(diff_tool.added) == 19
    assert len(diff_tool.removed) == 0

    print("sd")


def test_model_add_pen(model_3_w_pipes, model_4_w_pen_detail):
    diff_tool = IfcDiffTool(model_3_w_pipes, model_4_w_pen_detail)

    assert len(diff_tool.changed) == 3
    assert len(diff_tool.added) == 36
    assert len(diff_tool.removed) == 0

    print("sd")

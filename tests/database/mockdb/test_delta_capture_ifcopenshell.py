import json

from ifcdb.diffing.diff_ifcopen import apply_diffs_ifcopenshell
from ifcdb.diffing.tool import IfcDiffTool


def test_cube_edited(my_cube, my_cube_edited, my_cube_ifc_filepath):
    diff_tool = IfcDiffTool(my_cube, my_cube_edited)

    assert len(diff_tool.changed) == 1
    assert len(diff_tool.added) == 0
    assert len(diff_tool.removed) == 0

    el_1 = diff_tool.changed[0]

    assert el_1.diff == json.load(open(my_cube_ifc_filepath.parent / "diff_edited.json"))["changed"][0]["diff"]

    # Apply the diffs recorded by the diff_tool onto the existing IFC file and compare with the modified IFC file
    apply_diffs_ifcopenshell(my_cube, diff_tool)

    # import os
    # os.makedirs('temp', exist_ok=True)
    # with open('temp/MyCubeEdited2.ifc', 'w') as f:
    #     f.write(my_cube.wrapped_data.to_string())

    diff_tool_2 = IfcDiffTool(my_cube, my_cube_edited)

    assert len(diff_tool_2.changed) == 0
    assert len(diff_tool_2.added) == 0
    assert len(diff_tool_2.removed) == 0

    # For debugging only
    # with open("temp/export.ifc", "w") as f:
    #     f.write(my_cube.wrapped_data.to_string())


def test_cube_added(my_cube, my_cube_added):
    res = IfcDiffTool(my_cube, my_cube_added)

    assert len(res.added) == 1
    assert len(res.changed) == 1
    assert len(res.removed) == 0

    apply_diffs_ifcopenshell(my_cube, res)

    diff_tool_2 = IfcDiffTool(my_cube, my_cube_added)

    assert len(diff_tool_2.changed) == 0
    assert len(diff_tool_2.added) == 0
    assert len(diff_tool_2.removed) == 0

    # For debugging only
    # with open("temp/export.ifc", "w") as f:
    #     f.write(my_cube.wrapped_data.to_string())


def test_cube_removed(my_cube_added, my_cube):
    res = IfcDiffTool(my_cube_added, my_cube)

    assert len(res.removed) == 1
    assert len(res.added) == 0
    assert len(res.changed) == 1

    apply_diffs_ifcopenshell(my_cube_added, res)

    diff_tool_2 = IfcDiffTool(my_cube_added, my_cube)

    assert len(diff_tool_2.changed) == 0
    assert len(diff_tool_2.added) == 0
    assert len(diff_tool_2.removed) == 0

    # For debugging only
    # with open("temp/export.ifc", "w") as f:
    #     f.write(my_cube.wrapped_data.to_string())

import os

from ifcdb.diffing.diff_ifcopen import apply_diffs_ifcopenshell
from ifcdb.diffing.tool import IfcDiffTool


def test_cube_edited(my_cube, my_cube_edited):
    diff_tool = IfcDiffTool(my_cube, my_cube_edited)

    assert len(diff_tool.changed) == 1
    assert len(diff_tool.added) == 0
    assert len(diff_tool.removed) == 0
    os.makedirs("temp", exist_ok=True)
    diff_tool.to_json_file("temp/edited_non_indented.json", indent=None)
    el_1 = diff_tool.changed[0]

    items_path = "root['Representation']['Representations'][0]['Items']"
    assert el_1.diff["values_changed"][items_path + "[0]['Position']['Location']['Coordinates'][2]"] == {
        "new_value": -5.68906497955322,
        "old_value": -1.0,
    }

    # Use the apply_diffs_ifcopenshell to apply the diffs recorded by the diff_tool
    apply_diffs_ifcopenshell(my_cube, diff_tool)
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

    assert len(res.added) == 0
    assert len(res.changed) == 1
    assert len(res.removed) == 1

    apply_diffs_ifcopenshell(my_cube_added, res)

    diff_tool_2 = IfcDiffTool(my_cube_added, my_cube)

    assert len(diff_tool_2.changed) == 0
    assert len(diff_tool_2.added) == 0
    assert len(diff_tool_2.removed) == 0

    # For debugging only
    # with open("temp/export.ifc", "w") as f:
    #     f.write(my_cube.wrapped_data.to_string())

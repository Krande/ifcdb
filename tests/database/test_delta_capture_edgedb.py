import edgedb

from ifcdb.diffing.concept import ifc_diff_tool
from ifcdb.diffing.diff_edgedb import apply_diffs_edgedb


def test_cube_edited(my_cube, my_cube_edited):
    diff_tool = ifc_diff_tool(my_cube, my_cube_edited)

    assert len(diff_tool.changed) == 2
    assert len(diff_tool.added) == 0
    assert len(diff_tool.removed) == 0

    # Use the apply_diffs_ifcopenshell to apply the diffs recorded by the diff_tool
    apply_diffs_edgedb(edgedb.create_client(), diff_tool)

    diff_tool_2 = ifc_diff_tool(my_cube, my_cube_edited)

    assert len(diff_tool_2.changed) == 0
    assert len(diff_tool_2.added) == 0
    assert len(diff_tool_2.removed) == 0

    # For debugging only
    # with open("temp/export.ifc", "w") as f:
    #     f.write(my_cube.wrapped_data.to_string())


def test_cube_added(my_cube, my_cube_added):
    diff_tool = ifc_diff_tool(my_cube, my_cube_added)

    assert len(diff_tool.added) == 1
    assert len(diff_tool.changed) == 1
    assert len(diff_tool.removed) == 0

    apply_diffs_edgedb(edgedb.create_client(), diff_tool)

    diff_tool_2 = ifc_diff_tool(my_cube, my_cube_added)

    assert len(diff_tool_2.changed) == 0
    assert len(diff_tool_2.added) == 0
    assert len(diff_tool_2.removed) == 0

    # For debugging only
    # with open("temp/export.ifc", "w") as f:
    #     f.write(my_cube.wrapped_data.to_string())


def test_cube_removed(my_cube_added, my_cube):
    diff_tool = ifc_diff_tool(my_cube_added, my_cube)

    assert len(diff_tool.added) == 0
    assert len(diff_tool.changed) == 1
    assert len(diff_tool.removed) == 1

    apply_diffs_edgedb(edgedb.create_client(), diff_tool)

    diff_tool_2 = ifc_diff_tool(my_cube_added, my_cube)

    assert len(diff_tool_2.changed) == 0
    assert len(diff_tool_2.added) == 0
    assert len(diff_tool_2.removed) == 0

    # For debugging only
    # with open("temp/export.ifc", "w") as f:
    #     f.write(my_cube.wrapped_data.to_string())

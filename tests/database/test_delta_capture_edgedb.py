from ifcdb.diffing.diff_edgedb import apply_diffs_edgedb
from ifcdb.diffing.tool import ifc_diff_tool


def test_cube_edited(my_cube, my_cube_edited):
    diff_tool = ifc_diff_tool(my_cube, my_cube_edited)

    assert len(diff_tool.changed) == 1
    assert len(diff_tool.added) == 0
    assert len(diff_tool.removed) == 0

    # Use the apply_diffs_ifcopenshell to apply the diffs recorded by the diff_tool
    bulk_updates = apply_diffs_edgedb(diff_tool)
    # for bulk_update in bulk_updates:
    #     edql_str = bulk_update.to_edql_str()
    #     print(edql_str)

    assert len(bulk_updates) == 1

    update1 = bulk_updates[0]
    assert len(update1.insert_items) == 5


def test_cube_added(my_cube, my_cube_added):
    diff_tool = ifc_diff_tool(my_cube, my_cube_added)

    assert len(diff_tool.added) == 1
    assert len(diff_tool.changed) == 1
    assert len(diff_tool.removed) == 0

    _ = apply_diffs_edgedb(diff_tool)

    diff_tool_2 = ifc_diff_tool(my_cube, my_cube_added)

    assert len(diff_tool_2.changed) == 0
    assert len(diff_tool_2.added) == 0
    assert len(diff_tool_2.removed) == 0

    # For debugging only
    # with open("temp/added.ifc", "w") as f:
    #     f.write(my_cube.wrapped_data.to_string())


def test_cube_removed(my_cube_added, my_cube):
    diff_tool = ifc_diff_tool(my_cube_added, my_cube)

    assert len(diff_tool.added) == 0
    assert len(diff_tool.changed) == 1
    assert len(diff_tool.removed) == 1

    _ = apply_diffs_edgedb(diff_tool)

    diff_tool_2 = ifc_diff_tool(my_cube_added, my_cube)

    assert len(diff_tool_2.changed) == 0
    assert len(diff_tool_2.added) == 0
    assert len(diff_tool_2.removed) == 0

    # For debugging only
    # with open("temp/removed.ifc", "w") as f:
    #     f.write(my_cube.wrapped_data.to_string())

from ifcdb.diffing.diff_edgedb import create_edgedb_diff_objects
from ifcdb.diffing.tool import ifc_diff_tool
from ifcdb.entities import Entity


def test_cube_edited(my_cube, my_cube_edited):
    diff_tool = ifc_diff_tool(my_cube, my_cube_edited)

    assert len(diff_tool.changed) == 1
    assert len(diff_tool.added) == 0
    assert len(diff_tool.removed) == 0

    # Use the apply_diffs_ifcopenshell to apply the diffs recorded by the diff_tool
    bulk_updates = create_edgedb_diff_objects(diff_tool)
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

    updates = create_edgedb_diff_objects(diff_tool)
    assert len(updates) == 1

    update1 = updates[0]
    assert isinstance(update1, Entity)

    # For debugging only
    # with open("temp/added.ifc", "w") as f:
    #     f.write(my_cube.wrapped_data.to_string())


def test_cube_removed(my_cube_added, my_cube):
    diff_tool = ifc_diff_tool(my_cube_added, my_cube)

    assert len(diff_tool.added) == 0
    assert len(diff_tool.changed) == 1
    assert len(diff_tool.removed) == 1

    _ = create_edgedb_diff_objects(diff_tool)

    diff_tool_2 = ifc_diff_tool(my_cube_added, my_cube)

    assert len(diff_tool_2.changed) == 0
    assert len(diff_tool_2.added) == 0
    assert len(diff_tool_2.removed) == 0

    # For debugging only
    # with open("temp/removed.ifc", "w") as f:
    #     f.write(my_cube.wrapped_data.to_string())

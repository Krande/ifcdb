from ifcdb.diffing.tool import IfcDiffTool


def test_cube_edited(my_cube, my_cube_edited):
    diff_tool = IfcDiffTool(my_cube, my_cube_edited)

    assert len(diff_tool.changed) == 1
    assert len(diff_tool.added) == 0
    assert len(diff_tool.removed) == 0

    # Use the apply_diffs_ifcopenshell to apply the diffs recorded by the diff_tool
    bulk_entity_handler = diff_tool.to_bulk_entity_handler()
    edql_str = bulk_entity_handler.to_edql_str()
    print(edql_str)

    assert len(bulk_entity_handler.changes) == 5
    assert len(bulk_entity_handler.selects) == 8


def test_cube_edited_z(my_cube, my_cube_edited_z):
    diff_tool = IfcDiffTool(my_cube, my_cube_edited_z)

    assert len(diff_tool.changed) == 1
    assert len(diff_tool.added) == 0
    assert len(diff_tool.removed) == 0

    bulk_entity_handler = diff_tool.to_bulk_entity_handler()

    edql_str = bulk_entity_handler.to_edql_str()
    print(edql_str)

    assert len(bulk_entity_handler.selects) == 2
    assert len(bulk_entity_handler.changes) == 1

    value_data = list(bulk_entity_handler.changes.values())[0].update_value.value_data

    assert value_data.index == 2
    assert value_data.key == "Coordinates"
    assert value_data.new_value == 4.71695518493652


def test_cube_added(my_cube, my_cube_added):
    diff_tool = IfcDiffTool(my_cube, my_cube_added)

    assert len(diff_tool.added) == 1
    assert len(diff_tool.changed) == 1
    assert len(diff_tool.removed) == 0

    bulk_entity_handler = diff_tool.to_bulk_entity_handler()

    edql_str = bulk_entity_handler.to_edql_str()
    print(edql_str)

    assert len(bulk_entity_handler.changes) == 1
    assert len(bulk_entity_handler.selects) == 1
    assert len(bulk_entity_handler.inserts) == 25


def test_cube_removed(my_cube_added, my_cube):
    diff_tool = IfcDiffTool(my_cube_added, my_cube)

    assert len(diff_tool.added) == 0
    assert len(diff_tool.changed) == 1
    assert len(diff_tool.removed) == 1

    bulk_entity_handler = diff_tool.to_bulk_entity_handler()

    edql_str = bulk_entity_handler.to_edql_str()
    print(edql_str)

    assert len(bulk_entity_handler.changes) == 1
    assert len(bulk_entity_handler.selects) == 2
    assert len(bulk_entity_handler.removes) == 1

    # For debugging only
    # with open("temp/removed.ifc", "w") as f:
    #     f.write(my_cube.wrapped_data.to_string())

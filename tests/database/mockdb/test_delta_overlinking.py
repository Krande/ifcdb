from ifcdb.diffing.overlinking.tool import OverlinkResolver
from ifcdb.diffing.tool import IfcDiffTool


def test_cube_edited_overlinked(my_cube, my_cube_edited):
    diff_tool = IfcDiffTool(my_cube, my_cube_edited)

    assert len(diff_tool.changed) == 1
    assert len(diff_tool.added) == 0
    assert len(diff_tool.removed) == 0

    olr = OverlinkResolver(diff_tool)
    new_diff_tool = olr.resolve()

    bulk_entity_handler = new_diff_tool.to_bulk_entity_handler()
    edql_str = bulk_entity_handler.to_edql_str()
    print(edql_str)


def test_cube_edited_z_overlinked(my_cube, my_cube_edited_z):
    diff_tool = IfcDiffTool(my_cube, my_cube_edited_z)

    assert len(diff_tool.changed) == 1
    assert len(diff_tool.added) == 0
    assert len(diff_tool.removed) == 0

    olr = OverlinkResolver(diff_tool)
    new_diff_tool = olr.resolve()

    assert len(new_diff_tool.changed) == 1
    assert len(new_diff_tool.added) == 0
    assert len(new_diff_tool.removed) == 0

    root_change = new_diff_tool.changed[0].value_changes["root"]

    assert root_change.key == "ObjectPlacement"
    assert root_change.path == "root['ObjectPlacement']"
    assert root_change.new_value.entity.name == "IfcLocalPlacement"

    bulk_entity_handler = new_diff_tool.to_bulk_entity_handler()
    edql_str = bulk_entity_handler.to_edql_str()
    print(edql_str)


def test_cube_added_overlinking(my_cube, my_cube_added):
    diff_tool = IfcDiffTool(my_cube, my_cube_added)

    assert len(diff_tool.added) == 1
    assert len(diff_tool.changed) == 1
    assert len(diff_tool.removed) == 0

    olr = OverlinkResolver(diff_tool)
    new_diff_tool = olr.resolve()

    bulk_entity_handler = new_diff_tool.to_bulk_entity_handler()

    edql_str = bulk_entity_handler.to_edql_str()
    print(edql_str)

    assert len(bulk_entity_handler.changes) == 1
    assert len(bulk_entity_handler.selects) == 1
    assert len(bulk_entity_handler.inserts) == 25


def test_cube_removed_overlinking(my_cube_added, my_cube):
    diff_tool = IfcDiffTool(my_cube_added, my_cube)

    assert len(diff_tool.added) == 0
    assert len(diff_tool.changed) == 1
    assert len(diff_tool.removed) == 1

    olr = OverlinkResolver(diff_tool)
    new_diff_tool = olr.resolve()

    bulk_entity_handler = new_diff_tool.to_bulk_entity_handler()

    edql_str = bulk_entity_handler.to_edql_str()
    print(edql_str)

    assert len(bulk_entity_handler.changes) == 1
    assert len(bulk_entity_handler.selects) == 2
    assert len(bulk_entity_handler.removes) == 1

    # For debugging only
    # with open("temp/removed.ifc", "w") as f:
    #     f.write(my_cube.wrapped_data.to_string())

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

    bulk_entity_handler = new_diff_tool.to_bulk_entity_handler()
    edql_str = bulk_entity_handler.to_edql_str()
    print(edql_str)

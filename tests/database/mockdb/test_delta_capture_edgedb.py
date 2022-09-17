from ifcdb.diffing.tool import BulkEntityHandler, IfcDiffTool


def test_cube_edited(my_cube, my_cube_edited):
    diff_tool = IfcDiffTool(my_cube, my_cube_edited)

    assert len(diff_tool.changed) == 1
    assert len(diff_tool.added) == 0
    assert len(diff_tool.removed) == 0

    # Use the apply_diffs_ifcopenshell to apply the diffs recorded by the diff_tool
    bulk_entity_handler = diff_tool.to_bulk_entity_handler(use_v2=True)
    edql_str = bulk_entity_handler.to_edql_str()
    print(edql_str)
    if isinstance(bulk_entity_handler, BulkEntityHandler):
        assert len(bulk_entity_handler.bulk_updates) == 1

        update1 = bulk_entity_handler.bulk_updates[0]
        assert len(update1.select_items) == 5
    else:
        assert len(bulk_entity_handler.changes) == 5
        assert len(bulk_entity_handler.selects) == 5


def test_cube_edited_z(my_cube, my_cube_edited_z):
    diff_tool = IfcDiffTool(my_cube, my_cube_edited_z)

    assert len(diff_tool.changed) == 1
    assert len(diff_tool.added) == 0
    assert len(diff_tool.removed) == 0

    diff_tool.to_json_file("temp/diff_edited_z.json")

    bulk_entity_handler = diff_tool.to_bulk_entity_handler(use_v2=True)
    edql_str = bulk_entity_handler.to_edql_str()
    print(edql_str)

    if isinstance(bulk_entity_handler, BulkEntityHandler):
        assert len(bulk_entity_handler.bulk_updates) == 1
        update1 = bulk_entity_handler.bulk_updates[0]
        assert len(update1.select_items) == 1
    else:
        assert len(bulk_entity_handler.selects) == 2
        assert len(bulk_entity_handler.changes) == 1


def test_cube_added(my_cube, my_cube_added):
    diff_tool = IfcDiffTool(my_cube, my_cube_added)

    assert len(diff_tool.added) == 1
    assert len(diff_tool.changed) == 1
    assert len(diff_tool.removed) == 0

    bulk_entity_handler = diff_tool.to_bulk_entity_handler(use_v2=True)
    edql_str = bulk_entity_handler.to_edql_str()
    print(edql_str)
    if isinstance(bulk_entity_handler, BulkEntityHandler):
        assert len(bulk_entity_handler.bulk_inserts.entities) == 1
        assert len(bulk_entity_handler.bulk_updates) == 1

        new_entity = bulk_entity_handler.bulk_inserts.entities[0]
        assert new_entity.guid == "0V5VOywXLEaQbV_VYResiJ"
        assert new_entity.class_name == "IfcBuildingElementProxy"

        updated_element = bulk_entity_handler.bulk_updates[0]

        assert len(updated_element.select_items) == 1
    else:
        pass

    # For debugging only
    # with open("temp/added.ifc", "w") as f:
    #     f.write(my_cube.wrapped_data.to_string())


def test_cube_removed(my_cube_added, my_cube):
    diff_tool = IfcDiffTool(my_cube_added, my_cube)

    assert len(diff_tool.added) == 0
    assert len(diff_tool.changed) == 1
    assert len(diff_tool.removed) == 1

    bulk_entity_handler = diff_tool.to_bulk_entity_handler()

    edql_str = bulk_entity_handler.to_edql_str()
    print(edql_str)
    # For debugging only
    # with open("temp/removed.ifc", "w") as f:
    #     f.write(my_cube.wrapped_data.to_string())

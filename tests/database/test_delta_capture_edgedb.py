from ifcdb.diffing.tool import ifc_diff_tool


def test_cube_edited(my_cube, my_cube_edited):
    diff_tool = ifc_diff_tool(my_cube, my_cube_edited)

    assert len(diff_tool.changed) == 1
    assert len(diff_tool.added) == 0
    assert len(diff_tool.removed) == 0

    # Use the apply_diffs_ifcopenshell to apply the diffs recorded by the diff_tool
    bulk_entity_handler = diff_tool.to_bulk_entity_handler()
    assert len(bulk_entity_handler.updates) == 1

    update1 = bulk_entity_handler.updates[0]
    assert len(update1.insert_items) == 5

    edql_str = update1.to_edql_str()
    print(edql_str)


def test_cube_added(my_cube, my_cube_added):
    diff_tool = ifc_diff_tool(my_cube, my_cube_added)

    assert len(diff_tool.added) == 1
    assert len(diff_tool.changed) == 1
    assert len(diff_tool.removed) == 0

    bulk_entity_handler = diff_tool.to_bulk_entity_handler()
    assert len(bulk_entity_handler.inserts.entities) == 1
    assert len(bulk_entity_handler.updates) == 1

    new_entity = bulk_entity_handler.inserts.entities[0]
    assert new_entity.guid == "0V5VOywXLEaQbV_VYResiJ"
    assert new_entity.class_name == "IfcBuildingElementProxy"

    updated_element = bulk_entity_handler.updates[0]

    assert len(updated_element.insert_items) == 1

    edql_str = bulk_entity_handler.to_edql_str()
    print(edql_str)
    # For debugging only
    # with open("temp/added.ifc", "w") as f:
    #     f.write(my_cube.wrapped_data.to_string())


def test_cube_removed(my_cube_added, my_cube):
    diff_tool = ifc_diff_tool(my_cube_added, my_cube)

    assert len(diff_tool.added) == 0
    assert len(diff_tool.changed) == 1
    assert len(diff_tool.removed) == 1

    _ = diff_tool.to_bulk_entity_handler()

    diff_tool_2 = ifc_diff_tool(my_cube_added, my_cube)

    assert len(diff_tool_2.changed) == 0
    assert len(diff_tool_2.added) == 0
    assert len(diff_tool_2.removed) == 0

    # For debugging only
    # with open("temp/removed.ifc", "w") as f:
    #     f.write(my_cube.wrapped_data.to_string())

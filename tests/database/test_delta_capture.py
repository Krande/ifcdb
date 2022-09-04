from ifcdb.validation_utils import apply_diffs_ifcopenshell, ifc_diff_tool


def test_cube_edited(my_cube, my_cube_edited):
    diff_tool = ifc_diff_tool(my_cube, my_cube_edited)

    assert len(diff_tool.changed) == 2
    assert len(diff_tool.added) == 0
    assert len(diff_tool.removed) == 0

    el_1 = diff_tool.changed[0]

    items_path = "root['Representation']['Representations'][0]['Items']"
    assert el_1.diff["values_changed"][items_path + "[0]['Position']['Location']['Coordinates'][2]"] == {
        "new_value": -5.68906497955322,
        "old_value": -1.0,
    }

    # Use the apply_diffs_ifcopenshell to apply the diffs recorded by the diff_tool
    apply_diffs_ifcopenshell(my_cube, diff_tool)
    diff_tool_2 = ifc_diff_tool(my_cube, my_cube_edited)

    assert len(diff_tool_2.changed) == 0
    assert len(diff_tool_2.added) == 0
    assert len(diff_tool_2.removed) == 0

    # For debugging only
    # with open("temp/export.ifc", "w") as f:
    #     f.write(my_cube.wrapped_data.to_string())


def test_cube_added(my_cube, my_cube_added):
    res = ifc_diff_tool(my_cube, my_cube_added)

    assert len(res.added) == 1
    assert len(res.changed) == 1
    assert len(res.removed) == 0

    apply_diffs_ifcopenshell(my_cube, res)

    # print(res)

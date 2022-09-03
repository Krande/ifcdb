from ifcdb.validation_utils import ifc_diff_tool


def test_cube_edited(my_cube, my_cube_edited):
    results = ifc_diff_tool(my_cube, my_cube_edited)
    res = results.diffs
    assert len(res) == 2
    el_1 = res[0]

    items_path = "root['Representation']['Representations'][0]['Items']"
    assert el_1.diff["values_changed"][items_path + "[0]['Position']['Location']['Coordinates'][2]"] == {
        "new_value": -5.68906497955322,
        "old_value": -1.0,
    }
    assert el_1.name == "Cube"
    # print(res)


def test_cube_added(my_cube, my_cube_added):
    res = ifc_diff_tool(my_cube, my_cube_added)
    assert len(res.diffs) == 2
    # print(res)

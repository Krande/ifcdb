from ifcdb.validation_utils import ifc_validator_v2


def test_file_delta(my_cube, my_cube_post):
    res = ifc_validator_v2(my_cube, my_cube_post)
    assert len(res) == 2
    el_1 = res[0]
    items_path = "root['Representation']['Representations'][0]['Items']"
    assert el_1.diff[items_path + "[0]['Position']['Location']['Coordinates'][2]"] == {
        "new_value": -5.68906497955322,
        "old_value": -1.0,
    }
    assert el_1.name == "Cube"
    # print(res)

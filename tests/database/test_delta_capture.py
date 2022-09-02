from ifcdb.validation_utils import ifc_validator_v2


def test_file_delta(my_cube, my_cube_post):
    res = ifc_validator_v2(my_cube, my_cube_post)
    print(res)

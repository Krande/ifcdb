import json

import pytest


@pytest.fixture
def io(my_beam_4x1_db):
    my_beam_4x1_db.default_client(my_beam_4x1_db.database)
    my_beam_4x1_db._eq_builder.load_db_objects()
    return my_beam_4x1_db


def test_get_ifc_class_select_zero_depth(io):
    name = "MyBeam"

    uuid, class_name = io._get_id_class_name_from_simple_filter("Name", name)
    query_str = io._eq_builder.get_select_str(class_name, uuid, max_depth=0)
    result = json.loads(io.client.query_json(query_str))[0]

    res = {
        "Description": "IPE400",
        "GlobalId": "3PXsnq_3qHxBd2w2f4ZOUQ",
        "Name": "MyBeam",
        "ObjectType": "Beam",
        "Tag": "MyBeam",
        "PredefinedType": None,
        "OwnerHistory": {"id": "f1e7c288-02bc-11ed-bd24-5b3ad6a2215e"},
        "ObjectPlacement": {"id": "f4e3e5fc-02bc-11ed-bd24-eff8210e1fa8"},
        "Representation": {"id": "f451415c-02bc-11ed-bd24-4312f33dcf1d"},
    }

    for key, value in res.items():
        if key == "GlobalId":
            continue
        elif isinstance(value, dict):
            assert len(value.keys()) == len(result[key].keys())
        else:
            assert value == result[key]


def test_get_ifc_class_select_full_depth(io):
    name = "MyBeam"
    io.get_by_name_v2(name)


def test_get_by_globalid(io):
    _ = io.get_by_global_id("3PXsnq_3qHxBd2w2f4ZOUQ", top_level_only=True)

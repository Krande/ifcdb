import json

import pytest


@pytest.fixture
def io(my_beam_4x1_db):
    my_beam_4x1_db.create_client(my_beam_4x1_db.database)
    my_beam_4x1_db.eq_builder.load_db_objects()
    return my_beam_4x1_db


def test_get_ifc_class_select_zero_depth(io):
    name = "MyBeam"

    uuid, class_name = io._get_id_class_name_from_simple_filter("Name", name)
    query_str = io.eq_builder.get_select_str(class_name, uuid, max_depth=0)
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

    _ = io.get_owner_history()
    _ = io.get_object_placements()
    skippable_classes = ["IfcOwnerHistory", "IfcObjectPlacement", "IfcRepresentationContext"]

    uuid, class_name = io._get_id_class_name_from_simple_filter("Name", name)
    query_str = io.eq_builder.get_select_str(class_name, uuid, max_depth=None, skip_link_classes=skippable_classes)
    _ = json.loads(io.client.query_json(query_str))[0]


def test_get_by_globalid(io):
    _ = io.get_by_global_id("3PXsnq_3qHxBd2w2f4ZOUQ", top_level_only=True)

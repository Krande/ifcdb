import json
import pytest

from ifcdb import EdgeIO
from ifcdb.database.getters.get_bulk import GetBulk


@pytest.fixture
def bulk_io(my_beam_4x1_db: EdgeIO) -> GetBulk:
    return GetBulk(my_beam_4x1_db.client, my_beam_4x1_db.schema_model)


def test_get_ifc_class_select_zero_depth(bulk_io: GetBulk):
    name = "MyBeam"

    uuid, class_name = bulk_io.get_id_class_name_from_simple_filter("Name", name)
    query_str = bulk_io.eq_builder.get_select_str(class_name, uuid, max_depth=0)
    result = json.loads(bulk_io.client.query_json(query_str))[0]

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


def test_get_ifc_class_select_full_depth(bulk_io: GetBulk):
    name = "MyBeam"
    _ = bulk_io.get_by_name_v2(name)


def test_get_by_globalid(bulk_io: GetBulk):
    _ = bulk_io.get_by_global_id("3PXsnq_3qHxBd2w2f4ZOUQ", top_level_only=True)

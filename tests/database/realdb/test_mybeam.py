import json
import pytest

from ifcdb import EdgeIO
from ifcdb.database.getters.get_bulk import BulkGetter
from ifcdb.utils import top_dir


@pytest.fixture
def bg(root_dir) -> BulkGetter:
    ifc_file = "MyBeam.ifc"
    db_name = ifc_file.replace(".ifc", "").replace("-", "_")
    ifc_path = top_dir() / "files" / ifc_file

    with EdgeIO(db_schema_dir=f"temp/{db_name}/dbschema", ifc_schema="IFC4x1", database_name=db_name) as io:
        io.create_schema_from_ifc_file(ifc_path=ifc_path)
        io.setup_database(delete_existing_migrations=True)
        io.insert_ifc(ifc_path)
        return io.to_bulk_getter()


def test_get_ifc_class_select_zero_depth(bg):
    name = "MyBeam"

    uuid, class_name = bg.get_id_class_name_from_simple_filter("Name", name)
    query_str = bg.eq_builder.get_select_str(class_name, uuid, max_depth=0)
    result = json.loads(bg.client.query_json(query_str))[0]

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


def test_get_ifc_class_select_full_depth(bg):
    name = "MyBeam"
    _ = bg.get_by_name_v2(name)


def test_get_by_globalid(bg):
    _ = bg.get_by_global_id("3PXsnq_3qHxBd2w2f4ZOUQ", top_level_only=True)

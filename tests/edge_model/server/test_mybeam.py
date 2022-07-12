import pytest
import json
from ifcdb.edge_model.utils import clean_name


@pytest.fixture
def io(my_beam_4x1_db):
    my_beam_4x1_db.create_client(my_beam_4x1_db.database)
    my_beam_4x1_db.eq_builder.load_db_objects()
    return my_beam_4x1_db


def test_get_ifc_class_select(io):
    name = "MyBeam"

    _ = io.get_owner_history()
    _ = io.get_object_placements()
    skippable_classes = ["IfcOwnerHistory", "IfcObjectPlacement", "IfcRepresentationContext"]

    result = io._get_id_class_name_from_simple_filter("Name", name)
    uuid = result["id"]
    class_name = clean_name(result["__type__"])

    query_str = io.eq_builder.get_specific_object_str(class_name, uuid, skippable_classes=skippable_classes)

    result = json.loads(io.client.query_json(query_str))
    _ = io._get_specific_uuid_class_name(uuid, class_name, top_level_only=True)

    result_by_name = io.get_by_name("MyBeam", top_level_only=True)


def test_get_by_globalid(io):
    result_by_id = io.get_by_global_id("3PXsnq_3qHxBd2w2f4ZOUQ", top_level_only=True)

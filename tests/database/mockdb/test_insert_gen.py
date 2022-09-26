from itertools import count

import ifcopenshell

from ifcdb.database.inserts import EdgeInsert
from ifcdb.database.inserts.sequentially import InsertSeq
from ifcdb.diffing.tool import IfcDiffTool
from ifcdb.entities import Entity, EntityResolver
from ifcdb.io.ifc.interface import IfcIO


def test_cube_upload_to_blank_db_using_bulk_handler(my_cube):
    f = ifcopenshell.file(schema="IFC4x1")
    diff_tool = IfcDiffTool(f, my_cube)
    bulk_handler = diff_tool.to_bulk_entity_handler()
    # res = bulk_handler.inserts.inserts["ifc_product_definition_shape_85"]
    edql_str = bulk_handler.to_edql_str()
    print(edql_str)


def test_cube_upload_to_blank_db_using_sequential_insert(my_cube):
    ifc_io = IfcIO(ifc_obj=my_cube)
    sq = InsertSeq(ifc_io.schema)
    for item, insert_str in sq.create_bulk_insert_str(ifc_io.get_ifc_objects_by_sorted_insert_order_flat()):
        print(insert_str)


def test_insert_beam(my_beam_w_holes_ifc):
    er = EntityResolver("IFC4x1")
    skippable_classes = [
        "IfcOwnerHistory",
        "IfcObjectPlacement",
        "IfcRepresentationContext",
        "IfcRepresentationItem",
    ]

    for skip_it in skippable_classes:
        uuid_id_gen = count(1)
        for ifc_owner in my_beam_w_holes_ifc.by_type(skip_it):
            er.uuid_map[ifc_owner] = Entity(skip_it, uuid=f"a_random_uuid_replacement_for_IfcOwner{next(uuid_id_gen)}")

    # Adding a single ifc element should return UUID for use later
    bm: ifcopenshell.entity_instance = my_beam_w_holes_ifc.by_type("IfcBeam")[0]

    _ = my_beam_w_holes_ifc.get_inverse(bm)

    insert_entity = er.create_insert_entity_from_ifc_entity(bm)
    assert frozenset(insert_entity.props) == frozenset(
        {
            "GlobalId": "1Yi29q_3qHx8aIw2f4ZOUQ",
            "Name": "MyBeam",
            "Description": "IPE400",
            "ObjectType": "Beam",
            "Tag": "MyBeam",
        }
    )

    er.uuid_map[bm] = Entity("IfcBeam", uuid="a_random_uuid_replacement_for_IfcBeam")

    insert_str = EdgeInsert(insert_entity)
    print(insert_str.to_edql_str())

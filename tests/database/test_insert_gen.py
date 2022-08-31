from ifcdb.database.inserts.sequentially import InsertSeq
from ifcdb.io.ifc.optimizing import general_optimization


def test_insert_beam(my_beam_w_holes_ifc):
    start_entities = len(list(my_beam_w_holes_ifc))
    my_beam_w_holes_optimized = general_optimization(my_beam_w_holes_ifc)
    end_entities = len(list(my_beam_w_holes_optimized))
    assert start_entities == 179
    assert end_entities == 110

    sq = InsertSeq("IFC4x1")

    for ifc_owner in my_beam_w_holes_optimized.by_type("IfcOwnerHistory"):
        sq.uuid_map[ifc_owner] = "a_random_uuid_replacement_for_IfcOwner"
        # insert_str = sq.create_entity_insert_str(ifc_owner)
        # print(insert_str)

    # Adding a single ifc element should return UUID for use later
    bm = my_beam_w_holes_optimized.by_type("IfcBeam")[0]
    _ = sq.create_insert_entity(bm)
    insert_str = sq.create_entity_insert_str(bm)
    sq.uuid_map[bm] = "a_random_uuid_replacement_for_IfcBeam"

    print(insert_str)

    for item, my_beam_w_holes_optimized in sq.create_bulk_insert_str(list(my_beam_w_holes_optimized), silent=True):
        print(my_beam_w_holes_optimized)

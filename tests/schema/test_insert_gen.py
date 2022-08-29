from ifcdb.database.inserts.sequentially import SeqInsert


def test_insert_beam(my_beam_w_holes_ifc):
    sq = SeqInsert("IFC4x1")
    _ = sq.create_entity_insert_str(my_beam_w_holes_ifc.by_id(3))
    _ = sq.create_entity_insert_str(my_beam_w_holes_ifc.by_id(76))

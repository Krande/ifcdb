def test_ifc_tesselated_item(sg_ifc4x1, tesselated_item_ifc):
    class_name = "IfcUnitAssignment"

    ifc_entity = tesselated_item_ifc.by_type(class_name)[0]
    uuid_map = dict()
    with_map = dict()
    entity_str = sg_ifc4x1.get_entity_insert_str(ifc_entity, uuid_map=uuid_map, with_map=with_map)
    print(entity_str)

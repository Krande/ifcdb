def test_ifc_tesselated_item(em_ifc4x1, tesselated_item_ifc):
    class_name = "IfcMeasureWithUnit"

    ifc_entity = tesselated_item_ifc.by_type(class_name)[0]
    entity_str = em_ifc4x1.get_entity_insert_str(ifc_entity)
    print(entity_str)

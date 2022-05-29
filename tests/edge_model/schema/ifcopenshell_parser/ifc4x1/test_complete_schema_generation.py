def test_ifc_all(em_ifc4x1):
    all_entities = em_ifc4x1.get_all_entities()
    entity_str = all_entities[0].to_str()
    print(entity_str)

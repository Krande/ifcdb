def test_exported_types(expreader_ifc4x1, sg_ifc4x1):
    express_types = set(expreader_ifc4x1.type_dict.keys())
    ifcopen_types = set(sg_ifc4x1.get_all_types().keys())

    assert len(ifcopen_types) == 400

    diff = express_types.difference(ifcopen_types)
    assert len(diff) == 0


def test_exported_entities(expreader_ifc4x1, sg_ifc4x1):
    express_entities = set(expreader_ifc4x1.entity_dict.keys())
    ifcopen_entities = set(sg_ifc4x1.entities.keys())

    assert len(ifcopen_entities) == 801

    diff = express_entities.difference(ifcopen_entities)
    assert len(diff) == 0

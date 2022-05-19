from ifc_schema.exp_reader import ExpReader


def test_ifc_buildingelementproxy(ifc_4x1_exp_file):
    exp_reader = ExpReader(express_file=ifc_4x1_exp_file)
    res = exp_reader.entity_dict["IfcBuildingElementProxy"]
    keys = set(res.instance_attributes.keys())
    should_be = {
        "GlobalId",
        "OwnerHistory",
        "Name",
        "Description",
        "ObjectType",
        "ObjectPlacement",
        "Representation",
        "Tag",
        "PredefinedType",
    }
    assert len(should_be.intersection(keys)) == len(keys)


def test_ifc_beam(ifc_4x1_exp_file):
    exp_reader = ExpReader(express_file=ifc_4x1_exp_file)
    res = exp_reader.entity_dict["IfcBeam"]
    keys = set(res.instance_attributes.keys())
    should_be = {
        "GlobalId",
        "OwnerHistory",
        "Name",
        "Description",
        "ObjectType",
        "ObjectPlacement",
        "Representation",
        "Tag",
        "PredefinedType",
    }
    assert len(should_be.intersection(keys)) == len(keys)


def test_ifc_extrudedareasolid(ifc_4x1_exp_file):
    exp_reader = ExpReader(express_file=ifc_4x1_exp_file)
    res = exp_reader.entity_dict["IfcExtrudedAreaSolid"]
    keys = set(res.instance_attributes.keys())
    should_be = {"SweptArea", "ExtrudedDirection", "Position", "Depth"}
    assert len(should_be.intersection(keys)) == len(keys)

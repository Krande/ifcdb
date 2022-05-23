from ifc_schema.exp_reader import ExpReader


def test_ifc_buildingelementproxy(ifc_4x1_exp_file):
    exp_reader = ExpReader(express_file=ifc_4x1_exp_file)
    res = exp_reader.entity_dict["IfcBuildingElementProxy"]
    ancestry = set([x.name for x in res.ancestry])
    ancestry_should_be = {
        "IfcElement",
        "IfcRoot",
        "IfcProduct",
        "IfcObject",
        "IfcBuildingElementProxy",
        "IfcObjectDefinition",
        "IfcBuildingElement",
    }
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
    assert len(ancestry_should_be.intersection(ancestry)) == len(ancestry)


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


def test_ifc_triangulatedfaceset(ifc_4x1_exp_file):
    exp_reader = ExpReader(express_file=ifc_4x1_exp_file)
    res = exp_reader.entity_dict["IfcTriangulatedFaceSet"]
    keys = set(res.instance_attributes.keys())
    should_be = {"Coordinates", "PnIndex", "Normals", "Closed", "CoordIndex"}
    assert len(should_be.intersection(keys)) == len(keys)


def test_ifc_owner_history(ifc_4x1_exp_file):
    exp_reader = ExpReader(express_file=ifc_4x1_exp_file)
    res = exp_reader.entity_dict["IfcOwnerHistory"]
    keys = set(res.instance_attributes.keys())
    should_be = {
        "State",
        "ChangeAction",
        "LastModifiedDate",
        "LastModifyingUser",
        "CreationDate",
        "OwningUser",
        "OwningApplication",
    }
    assert len(should_be.intersection(keys)) == len(keys)


def test_ifc_product_representation(ifc_4x1_exp_file):
    exp_reader = ExpReader(express_file=ifc_4x1_exp_file)
    res = exp_reader.entity_dict["IfcProductRepresentation"]
    representations = res.instance_attributes["Representations"]
    array = representations.type

    assert array.shape[0][0] == "1"
    assert array.shape[0][1] == "?"
    assert array.of_type == exp_reader.entity_dict.get("IfcRepresentation")

    keys = set(res.instance_attributes.keys())
    should_be = {"Name", "Description", "Representations"}
    assert len(should_be.intersection(keys)) == len(keys)


def test_ifc_trimmed_curve(ifc_4x1_exp_file):
    exp_reader = ExpReader(express_file=ifc_4x1_exp_file)
    res = exp_reader.entity_dict["IfcTrimmedCurve"]

    keys = set(res.instance_attributes.keys())
    should_be = {"SenseAgreement", "MasterRepresentation", "BasisCurve", "Trim1", "Trim2"}
    assert len(should_be.intersection(keys)) == len(keys)

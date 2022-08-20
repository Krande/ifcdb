from ifcdb.edge_model.model import (
    ArrayEdgeModel,
    AttributeEdgeModel,
    EdgeModel,
    EntityEdgeModel,
)


def test_ifc_set_and_list(sg_ifc4x1: EdgeModel):
    entity_list: EntityEdgeModel = sg_ifc4x1.get_entity_by_name("IfcIndexedPolyCurve")
    entity_set: EntityEdgeModel = sg_ifc4x1.get_entity_by_name("IfcComplexProperty")
    att_str_list = {a.name: a for a in entity_list.get_attributes()}
    att_str_set = {a.name: a for a in entity_set.get_attributes()}
    list_att: AttributeEdgeModel = att_str_list["Segments"]
    set_att: AttributeEdgeModel = att_str_set["HasProperties"]

    assert list_att.array_ref().list_type == ArrayEdgeModel.LIST
    assert set_att.array_ref().list_type == ArrayEdgeModel.SET


def test_ifc_buildingelementproxy(sg_ifc4x1: EdgeModel):
    res = sg_ifc4x1.get_related_entities("IfcBuildingElementProxy")
    related_entities = set(res)

    should_be = {
        "IfcAddressTypeEnum",
        "IfcActorRole",
        "IfcChangeActionEnum",
        "IfcElement",
        "IfcBuildingElementProxy",
        "IfcBuildingElement",
        "IfcApplication",
        "IfcPerson",
        "IfcRepresentation",
        "IfcRoot",
        "IfcRoleEnum",
        "IfcObjectPlacement",
        "IfcRepresentationContext",
        "IfcObjectDefinition",
        "IfcProductRepresentation",
        "IfcProduct",
        "IfcBuildingElementProxyTypeEnum",
        "IfcPersonAndOrganization",
        "IfcObject",
        "IfcOrganization",
        "IfcAddress",
        "IfcRepresentationItem",
        "IfcOwnerHistory",
        "IfcStateEnum",
    }

    assert len(should_be.intersection(related_entities)) == len(related_entities)


def test_ifc_unit_assigment(sg_ifc4x1: EdgeModel):
    class_name = "IfcUnitAssignment"
    related_entities = [sg_ifc4x1.get_entity_by_name(x) for x in sg_ifc4x1.get_related_entities(class_name)]
    for rele in related_entities:
        x = rele.to_str()
        print(x)

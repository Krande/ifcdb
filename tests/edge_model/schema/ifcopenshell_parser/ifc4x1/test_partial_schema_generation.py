def test_ifc_root(em_ifc4x1):

    entity = em_ifc4x1.get_entity_by_name("IfcRoot")
    entity_str = entity.to_str()
    print(entity_str)


def test_ifc_arc_index(em_ifc4x1):
    entity = em_ifc4x1.get_entity_by_name("IfcArcIndex")
    entity_str = entity.to_str()
    print(entity_str)


def test_ifc_property_definition(em_ifc4x1):
    entity = em_ifc4x1.get_entity_by_name("IfcPropertySetDefinition")
    res =entity.entity.all_inverse_attributes()
    entity_str = entity.to_str()
    print(entity_str)


def test_ifc_buildingelementproxy(em_ifc4x1):
    res = em_ifc4x1.get_related_entities("IfcBuildingElementProxy")
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

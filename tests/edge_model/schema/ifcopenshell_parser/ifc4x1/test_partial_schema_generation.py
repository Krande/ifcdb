from ifc_schema.interop.edge_model.edge_model_base import SelectEdgeModel, EntityEdgeModel, EnumEdgeModel, TypeEdgeModel, PropertyEdgeModel


def test_ifc_root(em_ifc4x1):
    entity = em_ifc4x1.get_entity_by_name("IfcRoot")
    entity_str = entity.to_str()
    print(entity_str)


def test_ifc_irreg_timeseries_value(em_ifc4x1):
    entity: EntityEdgeModel = em_ifc4x1.get_entity_by_name("IfcIrregularTimeSeriesValue")
    ancestors = entity.get_ancestors()
    atts = {x.name: x for x in entity.get_attributes()}
    lv: PropertyEdgeModel = atts["ListValues"]
    array_ref = lv.array_ref()
    print(ancestors)


def test_ifc_arc_index(em_ifc4x1):
    entity = em_ifc4x1.get_entity_by_name("IfcArcIndex")
    entity_str = entity.to_str()
    print(entity_str)


def test_related_ifc_fill_area_style(em_ifc4x1):
    entity = em_ifc4x1.get_entity_by_name("IfcFillAreaStyle")
    att_str = entity.attributes_str
    print(att_str)


def test_related_ifc_value(em_ifc4x1):
    entity: SelectEdgeModel = em_ifc4x1.get_entity_by_name("IfcValue")
    att_str = entity.to_str()
    print(att_str)


def test_ifc_rel_connects_path_elements(em_ifc4x1):
    entity = em_ifc4x1.get_entity_by_name("IfcRelConnectsPathElements")
    entity_str = entity.to_str()
    print(entity_str)


def test_ifc_boolean_operator(em_ifc4x1):
    entity = em_ifc4x1.get_entity_by_name("IfcBooleanOperator")
    entity_str = entity.to_str()
    print(entity_str)


def test_ifc_blob_texture(em_ifc4x1):
    entity = em_ifc4x1.get_entity_by_name("IfcBlobTexture")
    entity_str = entity.to_str()
    print(entity_str)


def test_ifc_work_time(em_ifc4x1):
    entity = em_ifc4x1.get_entity_by_name("IfcWorkTime")
    entity_str = entity.to_str()
    print(entity_str)


def test_ifc_property_definition_set(em_ifc4x1):
    entity = em_ifc4x1.get_entity_by_name("IfcPropertySetDefinitionSet")
    entity_str = entity.to_str()
    print(entity_str)


def test_ifc_property_definition(em_ifc4x1):
    entity = em_ifc4x1.get_entity_by_name("IfcPropertySetDefinition")
    res = entity.entity.all_inverse_attributes()
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

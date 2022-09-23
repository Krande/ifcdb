from ifcdb.database.inserts.base import EdgeInsert
from ifcdb.entities import EntityResolver
from ifcdb.io.ifc.concept import IfcIO
from ifcdb.utils import top_dir


def test_ifc_rel_defines_by_properties():
    # The issue behind this test
    # edgedb.errors.InvalidLinkTargetError: invalid target for link 'RelatingPropertyDefinition' of object type
    # 'default::IfcRelDefinesByProperties': 'default::IfcPropertySetDefinitionSelect'
    # (expecting 'default::IfcPropertySetDefinition | default::IfcPropertySetDefinitionSet')

    # This was the original with statement
    # WITH
    #     ifc_416 := (SELECT IfcOwnerHistory filter .id = <uuid>"7a208bf2-3b1a-11ed-b002-9f9f1c4bd25f"),
    #     ifc_417 := (SELECT IfcSite filter .id = <uuid>"7a208c00-3b1a-11ed-b002-97303341534b"),
    #     ifc_100418 := (SELECT IfcPropertySet filter .id = <uuid>"7a208c01-3b1a-11ed-b002-87de00cbbf0b"),
    #     ifc_418 := (INSERT IfcPropertySetDefinitionSelect { IfcPropertySetDefinitionSelect := ifc_100418 }),
    # SELECT (INSERT IfcRelDefinesByProperties {
    #     GlobalId := '1v6k4WEneHxQR1w2f4ZOUQ',
    #     OwnerHistory := ifc_416,
    #     Name := 'Properties',
    #     RelatedObjects := {ifc_417},
    #     RelatingPropertyDefinition := ifc_418
    #    }
    # )

    schema = "IFC4x1"
    ifc_class = "IfcRelDefinesByProperties"
    er = EntityResolver(schema)

    ifc_io = IfcIO(ifc_file=top_dir() / "files/MyBeam.ifc")
    item = list(filter(lambda x: x.is_a() == ifc_class, ifc_io.get_ifc_objects_by_sorted_insert_order_flat()))[0]

    entity_tool = er.create_entity_tool_from_ifcopenshell_entity(item)

    related_inserts = entity_tool.linked_objects
    insert = EdgeInsert(entity_tool.entity)
    res = insert.entity.links["RelatingPropertyDefinition"]
    link_insert = EdgeInsert(related_inserts[res.temp_unique_identifier])
    link_str = link_insert.to_edql_str(assign_to_variable=True)

    print(link_str)


def test_measure_with_unit():
    schema = "IFC4x1"
    ifc_class = "IfcMeasureWithUnit"
    er = EntityResolver(schema)
    schema_obj = er.schema_model.to_db_entities([ifc_class], return_as_dict=True).get(ifc_class)
    _ = schema_obj.to_schema_str()

    ifc_io = IfcIO(ifc_file=top_dir() / "files/SimpleStru.ifc")
    items = ifc_io.get_ifc_objects_by_sorted_insert_order_flat()
    item = list(filter(lambda x: x.is_a() == ifc_class, items))[0]

    entity_tool = er.create_entity_tool_from_ifcopenshell_entity(item)

    related_inserts = entity_tool.linked_objects
    insert = EdgeInsert(entity_tool.entity)
    res = insert.entity.links["UnitComponent"]
    link_insert = EdgeInsert(related_inserts[res.temp_unique_identifier])
    link_str = link_insert.to_edql_str(assign_to_variable=True)

    print(link_str)

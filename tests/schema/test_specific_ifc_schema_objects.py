from __future__ import annotations

from typing import Any

from ifcdb.database.inserts.base import EdgeInsert
from ifcdb.entities import Entity, EntityResolver
from ifcdb.io.ifc.interface import IfcIO
from ifcdb.schema.new_model import DbLink, DbProp
from ifcdb.utils import top_dir


def get_insert_entity(ifc_class: str, schema="IFC4x1") -> Entity:
    er = EntityResolver(schema)

    ifc_io = IfcIO(ifc_file=top_dir() / "files/MyBeam.ifc")
    item = list(filter(lambda x: x.is_a() == ifc_class, ifc_io.get_ifc_objects_by_sorted_insert_order_flat()))[0]
    entity_tool = er.create_entity_tool_from_ifcopenshell_entity(item)
    return entity_tool.entity


def is_valid(prop: DbProp | DbLink, ifc_entity_value: Any):
    if prop.optional is True and ifc_entity_value is None:
        return True

    if prop.is_enum and ifc_entity_value in prop.prop_value:
        return True
    else:
        return False

    raise NotImplementedError()


def test_ifc_si_unit(schema_der, schema_der_unwrapped_enums):
    ifc_class = "IfcSIUnit"
    entity = get_insert_entity(ifc_class)
    entity_props = entity.props
    entity_props.update(entity.links)

    db_entity_pre = schema_der.db_entities.get(ifc_class)
    db_entity_pre_props = db_entity_pre.get_all_props()
    for key, value in db_entity_pre_props.items():
        entity_value = entity_props.get(key)
        assert is_valid(value, entity_value) is True

    db_entity = schema_der_unwrapped_enums.db_entities.get(ifc_class)
    db_entity_props = db_entity.get_all_props()
    assert len(db_entity_props) == len(list(entity.props.keys()) + list(entity.links.keys()))

    for key, value in db_entity_props.items():
        entity_value = entity_props.get(key)
        assert is_valid(value, entity_value) is True


def test_ifc_rel_defines_by_properties(schema_der_unwrapped_enums):
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

    ifc_class = "IfcRelDefinesByProperties"
    link_name = "RelatingPropertyDefinition"
    entity = get_insert_entity(ifc_class)
    insert_link = entity.links.get(link_name)
    db_entity = schema_der_unwrapped_enums.db_entities.get(ifc_class)
    db_link = db_entity.links.get(link_name)

    print(insert_link, db_link)


def test_measure_with_unit(schema_der_unwrapped_enums):
    schema = "IFC4x1"
    ifc_class = "IfcMeasureWithUnit"
    er = EntityResolver(schema)
    schema_obj = schema_der_unwrapped_enums.db_entities.get(ifc_class)
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


def test_bspline_surface(schema_der):
    ifc_class = "IfcBSplineSurface"
    db_entity = schema_der.db_entities.get(ifc_class)
    cpoint_list = db_entity.links["ControlPointsList"]
    assert cpoint_list.link_to.name == "List_of_IfcCartesianPoint"


def test_unwrap_enums(schema_der):
    schema = "IFC4x1"
    er = EntityResolver(schema)
    db_resolver = er.schema_model.to_db_entity_resolver()
    db_resolver.resolve()
    db_resolver.all_entities = None
    assert len(schema_der.db_entities) == 1202

    db_resolver.unwrap_enums()

    assert len(schema_der.db_entities) == 1202 - 211

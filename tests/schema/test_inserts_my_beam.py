from __future__ import annotations

import pytest

from ifcdb.entities import Entity, EntityFromDbEntity
from ifcdb.io.ifc.interface import IfcIO
from ifcdb.schema.new_model import DbEntityResolver, from_schema_version
from ifcdb.schema.validate import is_valid
from ifcdb.utils import top_dir


def get_insert_entities(ifc_file) -> list[Entity]:
    ede = EntityFromDbEntity(from_schema_version("IFC4x1"))
    ifc_io = IfcIO(ifc_file=top_dir() / f"files/{ifc_file}.ifc")
    ifc_items = ifc_io.get_ifc_objects_by_sorted_insert_order_flat()
    entities = [x.entity for x in map(ede.create_entity_tool_from_ifcopenshell_entity, ifc_items)]
    return entities


_ifc_entities = get_insert_entities("MyBeam")
_ifc_entities_names = [x.name for x in _ifc_entities]


@pytest.mark.parametrize("entity", _ifc_entities, ids=_ifc_entities_names)
def test_all_entities(entity: Entity, schema_der: DbEntityResolver):
    entity_props = entity.props
    entity_props.update(entity.links)

    db_entity = schema_der.db_entities.get(entity.name)
    db_entity_props = db_entity.get_all_props()
    for key, value in db_entity_props.items():
        entity_value = entity_props.get(key)
        assert is_valid(value, entity_value) is True

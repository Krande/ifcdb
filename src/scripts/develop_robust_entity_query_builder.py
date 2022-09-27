from __future__ import annotations

import logging

from ifcdb.entities import Entity, EntityFromDbEntity
from ifcdb.io.ifc.interface import IfcIO
from ifcdb.schema.new_model import db_entity_model_from_schema_version
from ifcdb.schema.validate import is_valid
from ifcdb.utils import top_dir

db_entities = db_entity_model_from_schema_version("IFC4x1", unwrap_enums=True, unwrap_selects=True)


def get_insert_entities(ifc_file) -> list[Entity]:
    ede = EntityFromDbEntity(db_entities)
    ifc_io = IfcIO(ifc_file=top_dir() / f"files/{ifc_file}.ifc")
    ifc_items = ifc_io.get_ifc_objects_by_sorted_insert_order_flat()
    entities = [x.entity for x in map(ede.create_entity_tool_from_ifcopenshell_entity, ifc_items)]
    return entities


def main(my_ifc_file: str):
    for entity in get_insert_entities(my_ifc_file):
        entity_props = entity.props
        entity_props.update(entity.links)

        db_entity = db_entities.entities.get(entity.name)
        db_entity_props = db_entity.get_all_props()
        for key, value in db_entity_props.items():
            entity_value = entity_props.get(key)
            if is_valid(value, entity_value) is False:
                logging.error(f"{entity.name=} -> {key=} FAILS")


if __name__ == "__main__":
    main("MyBeam")

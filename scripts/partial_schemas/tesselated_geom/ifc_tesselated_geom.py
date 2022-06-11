from __future__ import annotations

import os
import pathlib

import edgedb.blocking_client

from ifc_schema.interop.edge_model.edge_model_base import EdgeModel, get_att_str
from ifc_schema.interop.edge_model.insert_model import IfcToEdge
from ifc_schema.interop.edge_model.utils import copy_server_files
from ifc_schema.utils import top_dir
import ifcopenshell

wrap = ifcopenshell.ifcopenshell_wrapper


def case1(ifc_file: pathlib.Path, em: EdgeModel):
    with IfcToEdge(ifc_file) as ifc:
        return em.get_related_entities(ifc.get_unique_class_entities_of_ifc_content())


def main(ifc_file: pathlib.Path, schema_name):
    em = EdgeModel(schema=wrap.schema_by_name(schema_name))
    ordered_entity_names = case1(ifc_file, em)
    output_dir = pathlib.Path("db")
    os.makedirs(output_dir / "dbschema", exist_ok=True)

    with open(output_dir / "dbschema/default.esdl", "w") as f:
        f.write("module default {\n\n")
        for entity_name in ordered_entity_names:
            edge_str = em.entity_to_edge_str(entity_name)
            f.write(edge_str)
        f.write("}")

    copy_server_files(output_dir)


def insert(ifc_file, schema_name):
    em = EdgeModel(schema=wrap.schema_by_name(schema_name))
    with IfcToEdge(ifc_file, em) as ifc:
        for tx in ifc.client.transaction():
            with tx:
                insert_items(ifc, tx)


def insert_items(i2e: IfcToEdge, tx: edgedb.blocking_client):
    ifc_items = i2e.get_ifc_objects_by_sorted_insert_order_flat()
    ifc_items_grouped = i2e.get_ifc_objects_by_sorted_insert_order_grouped()
    res = i2e.get_ifc_dep_map(False)

    uuid_map = dict()
    for item in ifc_items:
        entity = i2e.em.get_entity_by_name(item.is_a())
        all_atts = entity.get_entity_atts(item)

        # INSERT block
        insert_str = f"select (INSERT {entity.name} {{\n  "
        for i, att in enumerate(all_atts):
            insert_str += get_att_str(att, item, i2e.em, )
        insert_str += '})'
        res = tx.query_single_json(insert_str)



if __name__ == "__main__":
    ifc_f = top_dir() / "files/tessellated-item.ifc"
    # main(ifc_f, "IFC4x1")
    insert(ifc_f, "IFC4x1")

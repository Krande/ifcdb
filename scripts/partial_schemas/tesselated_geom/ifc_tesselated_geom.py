from __future__ import annotations

import os
import pathlib
import json

import edgedb.blocking_client

from ifc_schema.interop.edge_model.edge_model_base import EdgeModel, get_att_str
from ifc_schema.interop.edge_model.insert_model import IfcToEdge
from ifc_schema.interop.edge_model.utils import copy_server_files
from ifc_schema.utils import top_dir
from edgedb._testbase import DatabaseTestCase, AsyncQueryTestCase, SyncQueryTestCase

import ifcopenshell

wrap = ifcopenshell.ifcopenshell_wrapper

#
# class DbTest(SyncQueryTestCase):
#     output_dir = pathlib.Path("db").resolve().absolute()
#     SCHEMA = str(output_dir / "dbschema/default.esdl")
#
#     def test_edgeql_insert_1(self):
#         for tx in self.client.transaction():
#             with tx:
#                 tx.execute(
#                     """
#                     INSERT IfcMassMeasure {
#                         IfcMassMeasure := 64
#                     };
#                 """
#                 )


def case1(ifc_file: pathlib.Path, em: EdgeModel):
    with IfcToEdge(ifc_file, em) as ifc:
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
        with_map = dict()
        insert_str = f"select (INSERT {entity.name} {{\n    "
        for i, att in enumerate(all_atts):
            att_str = get_att_str(att, item, i2e.em, uuid_map=uuid_map, with_map=with_map)
            if i == len(all_atts) - 1:
                comma_str = ""
            else:
                comma_str = ",\n    "

            insert_str += att_str + comma_str
        insert_str += "\n   }\n)"

        with_str = "WITH\n" if len(with_map.keys()) > 0 else ''
        for key, value in with_map.items():
            with_str += 4 * " " + f"{key} := {value},\n"

        total_insert_str = with_str + insert_str
        print(total_insert_str)
        query_res = json.loads(tx.query_single_json(total_insert_str))
        uuid_map[item] = query_res["id"]


if __name__ == "__main__":
    ifc_f = top_dir() / "files/tessellated-item.ifc"
    # main(ifc_f, "IFC4x1")
    insert(ifc_f, "IFC4x1")

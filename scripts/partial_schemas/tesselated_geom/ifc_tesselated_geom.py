from __future__ import annotations

import os
import pathlib

import ifcopenshell

from ifc_schema.interop.edge_model.edge_model_base import EdgeModel
from ifc_schema.interop.edge_model.insert_model import IfcToEdge, insert_ifc
from ifc_schema.interop.edge_model.query_model import EdgeToIfc
from ifc_schema.interop.edge_model.utils import copy_server_files
from ifc_schema.utils import top_dir

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


def create_schema(ifc_file: pathlib.Path, schema_name):
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


if __name__ == "__main__":
    ifc_f = top_dir() / "files/tessellated-item.ifc"
    # create_schema(ifc_f, "IFC4x1")
    # insert_ifc(ifc_f, "IFC4x1")
    with EdgeToIfc(schema_name="IFC4x1") as io:
        # res = io.get_spatial_content('Test Building')
        res = io.get_all()
        for r in res:
            print(r)

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



def create_schema(ifc_file: pathlib.Path, schema_name):
    output_dir = pathlib.Path("db")
    with IfcToEdge(ifc_file, schema_name=schema_name) as io:
        io.write_ifc_entities_to_esdl_file(output_dir / "dbschema/default.esdl")
    copy_server_files(output_dir)


def query_data(ifc_file, schema_name: str):
    with EdgeToIfc(ifc_file=ifc_file,schema_name=schema_name) as io:
        # res = io.get_spatial_content('Test Building')
        ents = io.get_unique_class_entities_of_ifc_content(True)
        res = io.get_all(ents)
        num_res = 0
        for r in res:
            if isinstance(r, dict):
                for key, value in r.items():
                    if len(value) == 0:
                        continue
                    print(key, value)
                    num_res += 1
            else:
                print(r)
        print(f'Number of classes with content = {num_res}')


if __name__ == "__main__":
    ifc_f = top_dir() / "files/tessellated-item.ifc"
    # create_schema(ifc_f, "IFC4x1")
    # insert_ifc(ifc_f, "IFC4x1")
    query_data(ifc_f, "IFC4x1")

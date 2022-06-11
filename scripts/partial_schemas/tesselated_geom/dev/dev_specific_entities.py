from __future__ import annotations

import os
import pathlib

from ifc_schema.interop.edge_model.edge_model_base import EdgeModel
from ifc_schema.interop.edge_model.insert_model import IfcToEdge
from ifc_schema.interop.edge_model.utils import copy_server_files
from ifc_schema.utils import top_dir
import ifcopenshell

wrap = ifcopenshell.ifcopenshell_wrapper


def insert_specific(ifc_file, schema_name):
    em = EdgeModel(schema=wrap.schema_by_name(schema_name))
    with IfcToEdge(ifc_file, em) as ifc:
        for tx in ifc.client.transaction():
            with tx:
                tx.execute(open("insert_ifcunitassignment.edql").read())


if __name__ == "__main__":
    ifc_f = top_dir() / "files/tessellated-item.ifc"
    insert_specific(ifc_f, "IFC4x1")

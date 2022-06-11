from __future__ import annotations

import os
import pathlib

from ifc_schema.interop.edge_model.edge_model_base import EdgeModel
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
        ifc_items = ifc.get_ifc_objects_by_sorted_insert_order()
        for tx in ifc.client.transaction():
            with tx:
                for item in ifc_items:
                    insert_str = ifc.em.get_entity_insert_str(item)
                    print(40 * "-" + str(item) + "START")
                    print(insert_str)
                    tx.execute(insert_str)
                    print(40 * "-" + str(item) + "END")


if __name__ == "__main__":
    ifc_f = top_dir() / "files/tessellated-item.ifc"
    # main(ifc_f, "IFC4x1")
    insert(ifc_f, "IFC4x1")

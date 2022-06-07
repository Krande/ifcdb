from __future__ import annotations

import os
import pathlib

import ifcopenshell

from ifc_schema.interop.edge_model.edge_model_base import EdgeModel
from ifc_schema.interop.edge_model.utils import copy_server_files

wrap = ifcopenshell.ifcopenshell_wrapper


def main(schema_name):
    em = EdgeModel(schema=wrap.schema_by_name(schema_name), modify_circular_deps=False)
    ordered_entity_names = em.get_all_entities()

    output_dir = pathlib.Path("temp/edge_model")
    os.makedirs(output_dir / "dbschema", exist_ok=True)

    with open(output_dir / "dbschema/default.esdl", "w") as f:
        f.write("module default {\n\n")
        for entity_name in ordered_entity_names:
            edge_str = em.entity_to_edge_str(entity_name)
            f.write(edge_str)
        f.write("}")

    copy_server_files(output_dir)


if __name__ == "__main__":
    main("IFC4x1")

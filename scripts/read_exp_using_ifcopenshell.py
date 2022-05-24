from __future__ import annotations

import os
import pathlib

from ifc_schema.interop.edge_model.edge_model_base import EdgeModel
from ifc_schema.interop.edge_model.utils import copy_server_files
import ifcopenshell

wrap = ifcopenshell.ifcopenshell_wrapper


def main(schema_name):
    em = EdgeModel(schema=wrap.schema_by_name(schema_name))

    res = em.entity_to_edge_str("IfcTrimmedCurve")
    # res = em.entity_to_edge_str("IfcCartesianPoint")

    ordered_entity_names = em.get_related_entities(
        [
            "IfcBuildingElementProxy",
            "IfcTriangulatedFaceSet",
            "IfcProductDefinitionShape",
            "IfcShapeRepresentation",
            "IfcGeometricRepresentationSubContext",
            "IfcRelContainedInSpatialStructure",
            "IfcBuilding",
            "IfcProject",
            # "IfcTrimmedCurve",
        ]
    )
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

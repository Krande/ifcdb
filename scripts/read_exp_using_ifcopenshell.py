from __future__ import annotations

from ifc_schema.interop.edge_model.edge_model_base import EdgeModel

import ifcopenshell

wrap = ifcopenshell.ifcopenshell_wrapper


def main(schema_name):
    em = EdgeModel(schema=wrap.schema_by_name(schema_name))
    edge_str = em.entity_to_edge_str("IfcTriangulatedFaceSet")
    res = em.entities["IfcTriangulatedFaceSet"]
    res2 = em.entities["IfcBuildingElementProxy"]

    print("")


if __name__ == "__main__":
    main("IFC4x1")

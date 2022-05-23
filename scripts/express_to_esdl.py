from ifc_schema.exp_reader import ExpReader
from ifc_schema.interop.edgemodel import EdgeModel


def main(express_file):
    exp_reader = ExpReader(express_file=express_file)

    res = exp_reader.entity_dict["IfcTrimmedCurve"]
    res.entity_attributes

    edge_model = EdgeModel(exp_reader)
    edge_model.export_all_related_to_esdl(
        [
            "IfcBuildingElementProxy",
            "IfcTriangulatedFaceSet",
            "IfcProductDefinitionShape",
            "IfcShapeRepresentation",
            "IfcGeometricRepresentationContext",
            "IfcRelContainedInSpatialStructure",
            "IfcBuilding",
            "IfcProject",
        ]
    )


if __name__ == "__main__":
    main("../IFC4.3.x-development/reference_schemas/IFC4x1.exp")

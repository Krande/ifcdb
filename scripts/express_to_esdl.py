from ifc_schema.exp_reader import ExpReader
from ifc_schema.interop.edge_model.edgemodel import EdgeModel
from ifc_schema.interop.edge_model.utils import copy_server_files


def main(express_file):
    exp_reader = ExpReader(express_file=express_file)

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
            "IfcTrimmedCurve",
        ]
    )
    copy_server_files(edge_model.output_dir)


if __name__ == "__main__":
    main("../IFC4.3.x-development/reference_schemas/IFC4x1.exp")

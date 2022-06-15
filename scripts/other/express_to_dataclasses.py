from ifcdb.exp_reader import ExpReader
from ifcdb.interop.pymodel import PyModel, build_test_str


def main(express_file):
    exp_reader = ExpReader(express_file=express_file)

    py_model = PyModel(exp_reader)
    py_model.export_all_related_to_dataclasses(
        [
            "IfcBuildingElementProxy",
            "IfcTriangulatedFaceSet",
            "IfcExtrudedAreaSolid",
            "IfcRelContainedInSpatialStructure",
            "IfcBuilding",
            "IfcProject",
        ],
        main_str=build_test_str(),
    )


if __name__ == "__main__":
    main("../IFC4.3.x-development/reference_schemas/IFC4x1.exp")

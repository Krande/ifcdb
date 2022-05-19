from ifc_schema.exp_reader import ExpReader
from ifc_schema.interop.pymodel import PyModel, build_test_str


def main(express_file):
    exp_reader = ExpReader(express_file=express_file)

    # Purely for debugging
    res = exp_reader.entity_dict["IfcBuildingElementProxy"]
    res_extruded = exp_reader.entity_dict["IfcExtrudedAreaSolid"]

    py_model = PyModel(exp_reader)
    py_model.export_all_related_to_dataclasses("IfcTriangulatedFaceSet", main_str=build_test_str())
    py_model.export_all_related_to_dataclasses("IfcExtrudedAreaSolid")
    py_model.export_all_related_to_dataclasses("IfcBuildingElementProxy")


if __name__ == "__main__":
    main("../IFC4.3.x-development/reference_schemas/IFC4x1.exp")

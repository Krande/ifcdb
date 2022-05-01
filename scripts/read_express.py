from __future__ import annotations

from ifc_schema.exp_reader import ExpReader


def main(express_file):
    exp_reader = ExpReader(express_file=express_file)

    triface = exp_reader.entity_dict["IfcTriangulatedFaceSet"]
    for key, value in triface.instance_attributes.items():
        print(f"{key}: {value} [{value.type}] (inherited: {value.inherited})")


if __name__ == "__main__":
    main("../IFC4.3.x-development/reference_schemas/IFC4x1.exp")

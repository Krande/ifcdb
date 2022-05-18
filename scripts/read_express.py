import os

from typing import List
from ifc_schema.exp_reader import ExpReader, Entity


def sort_by_inheritance(list_of_entities: List[Entity]):
    # filter out all elements without parents
    tbr = []
    sorted_list = []
    for i, x in enumerate(list_of_entities):
        if x.parent_type is None:
            sorted_list.append(x)
            tbr.append(x)

    for x in tbr:
        list_of_entities.pop(list_of_entities.index(x))


def test_str():
    return """if __name__ == "__main__":
        tria = IfcTriangulatedFaceSet(
            Coordinates=IfcCartesianPointList3D([(0, 0, 0), (1, 0, 0), (1, 1, 0)]),
            CoordIndex=[(0, 1, 0)],
        )
        print(tria)
"""


def export_all_related_to_dataclasses(exp_reader: ExpReader, class_name, main_str: str = None):
    triface = exp_reader.entity_dict[class_name]
    test_file_str = "from __future__ import annotations\nfrom dataclasses import dataclass\nimport typing\n"

    all_ents = triface.get_related_entities_and_types()
    for ent in all_ents:
        test_file_str += ent.to_dataclass_str()

    os.makedirs("temp", exist_ok=True)
    with open(f"temp/test{class_name}.py", "w") as f:
        f.write(test_file_str + main_str if main_str is not None else "")


def main(express_file):
    exp_reader = ExpReader(express_file=express_file)
    res = exp_reader.entity_dict["IfcTriangulatedFaceSet"]
    res2 = exp_reader.entity_dict["IfcGeometricRepresentationItem"]
    res3 = exp_reader.entity_dict["IfcCartesianPointList3D"]
    for key, value in res3.instance_attributes.items():
        print(key, value)
    export_all_related_to_dataclasses(exp_reader, "IfcTriangulatedFaceSet", main_str=test_str())
    export_all_related_to_dataclasses(exp_reader, "IfcExtrudedAreaSolid")


if __name__ == "__main__":
    main("../IFC4.3.x-development/reference_schemas/IFC4x1.exp")

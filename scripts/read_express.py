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


def export_all_related_to_dataclasses(exp_reader: ExpReader, class_name):
    triface = exp_reader.entity_dict[class_name]
    test_file_str = "from __future__ import annotations\nfrom dataclasses import dataclass\nimport typing\n"

    all_ents = triface.get_related_entities_and_types()
    all_ents.reverse()
    for ent in all_ents:
        test_file_str += ent.to_dataclass_str()

    os.makedirs("temp", exist_ok=True)
    with open(f"temp/test{class_name}.py", "w") as f:
        f.write(test_file_str)


def main(express_file):
    exp_reader = ExpReader(express_file=express_file)
    res = exp_reader.entity_dict['IfcTriangulatedFaceSet']
    res2 = exp_reader.entity_dict['IfcGeometricRepresentationItem']
    export_all_related_to_dataclasses(exp_reader, "IfcTriangulatedFaceSet")
    export_all_related_to_dataclasses(exp_reader, "IfcExtrudedAreaSolid")


if __name__ == "__main__":
    main("../IFC4.3.x-development/reference_schemas/IFC4x1.exp")

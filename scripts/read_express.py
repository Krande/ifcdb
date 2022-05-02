import os

from ifc_schema.exp_reader import ExpReader, Entity


def main(express_file):
    exp_reader = ExpReader(express_file=express_file)

    triface = exp_reader.entity_dict["IfcTriangulatedFaceSet"]
    test_file_str = 'from __future__ import annotations\nfrom dataclasses import dataclass\nimport typing\n\n'
    ancestry = triface.ancestry
    ancestry.reverse()
    for ancestor in triface.ancestry:
        test_file_str += ancestor.to_dataclass_str()
        for key, att in ancestor.instance_attributes.items():
            if att.inherited is True:
                continue
            if isinstance(att.type, Entity):
                test_file_str += att.type.to_dataclass_str()
                for atancestor in att.type.ancestry:
                    test_file_str += atancestor.to_dataclass_str()
    os.makedirs('temp', exist_ok=True)
    with open('temp/ifctest.py', 'w') as f:
        f.write(test_file_str)

    for key, value in triface.instance_attributes.items():
        print(f"{key}: {value} [{value.type}] (inherited: {value.inherited})")


if __name__ == "__main__":
    main("../IFC4.3.x-development/reference_schemas/IFC4x1.exp")

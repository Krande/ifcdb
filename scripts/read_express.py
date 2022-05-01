import re
from dataclasses import dataclass
from typing import Dict

re_flags = re.DOTALL | re.MULTILINE | re.IGNORECASE


@dataclass
class ConvertedObject:
    name: str
    content: str

    @property
    def parent_type(self):
        result = re.search(r"SUBTYPE OF \((.*?)\);", self.content)
        return result.group(1) if result is not None else None

    @property
    def attributes(self):
        result = re.search(r"SUBTYPE OF \((?:.*?)\);(.*?)^ [aA-zZ]", self.content, re_flags)
        re_att = re.compile("^	(?P<key>[aA-zZ]{0,20}) :(?P<value>.*?);", re_flags)
        if result is None:
            return None
        data = result.group(1)
        atts = []
        for r in re_att.finditer(data):
            d = r.groupdict()
            key, value = d["key"], d["value"]
            atts.append((key.strip(), value.strip()))
        return atts


def convert_type(r: re.Match) -> ConvertedObject:
    """Return a minimum class containing identifier and content"""
    d = r.groupdict()
    name = d["name"]
    content = d["content"]

    return ConvertedObject(name=name, content=content)


def main(express_file):

    reg_entities = re.compile(r"ENTITY\s*(?P<name>.*?)\n(?P<content>.*?)END_ENTITY", re_flags)
    reg_types = re.compile(r"TYPE\s*(?P<name>.*?)\s*=\s*(?P<content>.*?);(.*?)END_TYPE", re_flags)

    with open(express_file, "r") as f:
        data = f.read()
        # exp_types: Dict[str, ConvertedObject] = {co.name: co for co in map(convert_type, reg_types.finditer(data))}
        exp_entities: Dict[str, ConvertedObject] = {
            co.name: co for co in map(convert_type, reg_entities.finditer(data))
        }

    triface = exp_entities["IfcTriangulatedFaceSet"]

    class_hierarchy = [triface]
    tri_parent_name = triface.parent_type
    while tri_parent_name:
        tri_parent = exp_entities[tri_parent_name]
        class_hierarchy.append(tri_parent)
        tri_parent_name = tri_parent.parent_type
    for cl in class_hierarchy:
        print(cl.name)
        if cl.attributes is None:
            continue
        for key, value in cl.attributes:
            print(" " * 10 + f"{key}: {value}")


if __name__ == "__main__":
    main("../IFC4.3.x-development/reference_schemas/IFC4x1.exp")

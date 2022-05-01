from __future__ import annotations
import re
from dataclasses import dataclass, field
from typing import Dict

re_flags = re.DOTALL | re.MULTILINE | re.IGNORECASE


@dataclass
class Attribute:
    name: str
    _raw_content_str: str

    @property
    def type(self):
        raise NotImplemented


@dataclass
class ConvertedObject:
    name: str
    content: str = field(repr=False)
    entity_dict: Dict[str, ConvertedObject] = field(default=None, repr=False)
    type_dict: Dict[str, ConvertedObject] = field(default=None, repr=False)

    @property
    def parent_type(self):
        result = re.search(r"SUBTYPE OF \((.*?)\);", self.content)
        return result.group(1) if result is not None else None

    @property
    def instance_attributes(self):
        ancestors = self.ancestry
        ancestors.reverse()
        atts = dict()
        for cl in ancestors:
            if cl.attributes is None:
                continue
            for key, value in cl.attributes:
                atts[key] = Attribute(key, value)
        return atts

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

    @property
    def ancestry(self):
        class_hierarchy = [self]
        tri_parent_name = self.parent_type
        while tri_parent_name:
            tri_parent = self.entity_dict[tri_parent_name]
            class_hierarchy.append(tri_parent)
            tri_parent_name = tri_parent.parent_type

        return class_hierarchy


@dataclass
class ExpReader:
    express_file: str
    entity_dict: Dict[str, ConvertedObject] = field(default_factory=dict)
    type_dict: Dict[str, ConvertedObject] = field(default_factory=dict)

    def __post_init__(self):
        reg_entities = re.compile(r"ENTITY\s*(?P<name>.*?)\n(?P<content>.*?)END_ENTITY;", re_flags)
        reg_types = re.compile(r"TYPE\s*(?P<name>.*?)\s*=\s*(?P<content>.*?);(.*?)END_TYPE;", re_flags)
        self.entity_dict = dict()
        self.type_dict = dict()
        with open(self.express_file, "r") as f:
            data = f.read()
            lpos = data.find("ENTITY ")
            exp_entities: Dict[str, ConvertedObject] = {
                co.name: co
                for co in (
                    convert_type(x, self.entity_dict, self.type_dict) for x in reg_entities.finditer(data, pos=lpos - 5)
                )
            }

            exp_types: Dict[str, ConvertedObject] = {
                co.name: co
                for co in (
                    convert_type(x, self.entity_dict, self.type_dict) for x in reg_types.finditer(data, endpos=lpos + 5)
                )
            }

            self.entity_dict.update(exp_entities)
            self.type_dict.update(exp_types)


def convert_type(r: re.Match, entity_dict=None, type_dict=None) -> ConvertedObject:
    """Return a minimum class containing identifier and content"""
    d = r.groupdict()
    name = d["name"]
    content = d["content"]
    return ConvertedObject(name=name, content=content, entity_dict=entity_dict, type_dict=type_dict)


def main(express_file):

    exp_reader = ExpReader(express_file=express_file)

    triface = exp_reader.entity_dict["IfcTriangulatedFaceSet"]
    print(triface.instance_attributes)
    ancestors = triface.ancestry
    ancestors.reverse()
    for cl in ancestors:
        if cl.attributes is None:
            continue
        print(cl.name)
        for key, value in cl.attributes:
            print(" " * 10 + f"{key}: {value}")


if __name__ == "__main__":
    main("../IFC4.3.x-development/reference_schemas/IFC4x1.exp")

from __future__ import annotations
import re
from dataclasses import dataclass, field
from typing import Dict, TYPE_CHECKING

if TYPE_CHECKING:
    from ifc_schema.exp_reader import ExpReader
    from ifc_schema.att_types import Attribute

re_flags = re.DOTALL | re.MULTILINE | re.IGNORECASE


@dataclass
class Entity:
    name: str
    content: str = field(repr=False)
    exp_reader: ExpReader = field(repr=False)

    @property
    def parent_type(self):
        result = re.search(r"SUBTYPE OF \((.*?)\);", self.content)
        return result.group(1) if result is not None else None

    @property
    def instance_attributes(self) -> Dict[str, Attribute]:
        ancestors = self.ancestry
        ancestors.reverse()
        atts = dict()
        for cl in ancestors:
            if cl.entity_attributes is None:
                continue
            for key, value in cl.entity_attributes:
                inherited = cl != self
                atts[key] = self.exp_reader.resolve_attribute(key, value, inherited)
        return atts

    @property
    def entity_attributes(self):
        re_subtype = re.search(r"SUBTYPE OF \((?:.*?)\);(.*?)^ [aA-zZ]", self.content, re_flags)
        re_att = re.compile(r"^	(?P<key>[aA-zZ]{0,20}) :(?P<value>.*?);", re_flags)
        if re_subtype is None:
            return None
        data = re_subtype.group(1)
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
            tri_parent = self.exp_reader.entity_dict[tri_parent_name]
            class_hierarchy.append(tri_parent)
            tri_parent_name = tri_parent.parent_type

        return class_hierarchy

    @property
    def entity_inverse(self):
        re_inverse_seg = re.search(r"INVERSE\n(.*?)(?:^ [aA-zZ]|\Z)", self.content, re_flags)
        re_att = re.compile(r"^	(?P<key>[a-zA-Z0-9_]{0,20}) :(?P<value>.*?);", re_flags)
        if re_inverse_seg is None:
            return None

        data = re_inverse_seg.group(1)
        inverses = []
        for r in re_att.finditer(data):
            d = r.groupdict()
            key, value = d["key"], d["value"]
            inverses.append((key.strip(), value.strip()))
        return inverses

    @property
    def instance_inverse(self):
        inverse = []
        for ancestor in self.ancestry:
            if ancestor.entity_inverse is None:
                continue
            inverse += ancestor.entity_inverse
        return inverse

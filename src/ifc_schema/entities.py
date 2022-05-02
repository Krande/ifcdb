from __future__ import annotations
import operator
import re
from dataclasses import dataclass, field
from typing import Dict, TYPE_CHECKING, Union

if TYPE_CHECKING:
    from ifc_schema.exp_reader import ExpReader
    from ifc_schema.att_types import Attribute

re_flags = re.DOTALL | re.MULTILINE | re.IGNORECASE


def append_to(el, elements: list):
    if el in elements:
        return
    elements.append(el)


@dataclass
class Entity:
    name: str
    content: str = field(repr=False)
    exp_reader: ExpReader = field(repr=False)

    def to_dataclass_str(self):
        ancestor_str = ""
        if self.parent_type is not None:
            ancestor_str = f"({self.parent_type})"
        atts_str = ""
        for val in sorted(self.instance_attributes.values(), key=operator.attrgetter("optional")):
            if val.parent != self:
                continue

            vtyp = val.type
            if isinstance(vtyp, Entity):
                att_ref = vtyp.name
            else:
                att_ref = vtyp

            opt_str = " = None" if val.optional is True else ""
            atts_str += f"    {val.name}: {att_ref}" + opt_str + "\n"
        if atts_str == '':
            atts_str = '    pass'
        return f"""

@dataclass
class {self.name}{ancestor_str}:
{atts_str}
"""

    def get_related_entities_and_types(self):
        """Loop over ancestry and used types to list up all defined types and entities"""
        ancestry = self.ancestry
        ancestry.reverse()

        related_entities = []
        for ancestor in self.ancestry:
            append_to(ancestor, related_entities)
            if ancestor.entity_attributes is None:
                continue
            for key, att in ancestor.entity_attributes.items():
                if isinstance(att.type, Entity) is False:
                    continue
                append_to(att.type, related_entities)
                for at_ancestor in att.type.ancestry:
                    append_to(at_ancestor, related_entities)
        return related_entities

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
            for key, value in cl.entity_attributes.items():
                atts[key] = value
        return atts

    @property
    def entity_attributes(self) -> Union[None, Dict[str, Attribute]]:
        from ifc_schema.att_types import Attribute

        re_subtype = re.search(r"SUBTYPE OF \((?:.*?)\);(.*?)^ [aA-zZ]", self.content, re_flags)
        re_att = re.compile(r"^	(?P<key>[aA-zZ]{0,20}) :(?P<value>.*?);", re_flags)
        if re_subtype is None:
            return None
        data = re_subtype.group(1)
        atts = dict()
        for r in re_att.finditer(data):
            d = r.groupdict()
            key, value = d["key"], d["value"].strip()
            optional = value.upper().startswith("OPTIONAL")
            atts[key] = Attribute(key, value, optional=optional, parent=self, _exp_reader=self.exp_reader)
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

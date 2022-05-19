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
    parent_type = el.parent_type
    if parent_type is None:
        elements.insert(0, el)
        return

    el_name_index = [x.name for x in elements]
    parent_index = None
    if parent_type in el_name_index:
        parent_index = el_name_index.index(parent_type)

    if el.supertype_of is not None:
        set1 = set(el_name_index)
        set2 = set(el.supertype_of)
        res = list(set2.intersection(set1))
        index = min([el_name_index.index(x) for x in res])
        if parent_index is not None and index < parent_index:
            re_input_el = elements.pop(parent_index)
            elements.insert(index, el)
            elements.insert(index, re_input_el)
        else:
            elements.insert(index, el)
        return

    elements.append(el)


@dataclass
class Entity:
    name: str
    content: str = field(repr=False)
    exp_reader: ExpReader = field(repr=False)

    @property
    def ancestor_str(self):
        ancestor_str = ""
        if self.parent_type is not None:
            ancestor_str = f"({self.parent_type})"
        return ancestor_str

    @property
    def attributes_str(self):
        atts_str = ""
        attributes = sorted(self.instance_attributes.values(), key=operator.attrgetter("optional"))
        for val in attributes:
            if val.parent != self:
                continue

            vtyp = val.type
            if isinstance(vtyp, Entity):
                att_ref = vtyp.name
            else:
                att_ref = vtyp

            opt_str = " = None" if val.optional is True else ""
            atts_str += f"    {val.name}: {att_ref}" + opt_str + "\n"
        if atts_str == "":
            atts_str = "    pass"
        return atts_str

    def to_dataclass_str(self):
        att_str = self.attributes_str
        dataclass_props = ''
        if "= None" in att_str:
            dataclass_props = '(kw_only=True)'
        return f"""

@dataclass{dataclass_props}
class {self.name}{self.ancestor_str}:
{att_str}
"""

    def to_pydantic_str(self):
        ancestor_str = self.ancestor_str
        if ancestor_str == '':
            ancestor_str = '(pydantic.BaseModel)'
        return f"""

class {self.name}{ancestor_str}:
{self.attributes_str}
"""

    def get_related_entities_and_types(self, related_entities=None):
        """Loop over ancestry and used types to list up all defined types and entities"""
        related_entities = [] if related_entities is None else related_entities
        for ancestor in self.ancestry:
            append_to(ancestor, related_entities)
            if ancestor.entity_attributes is None:
                continue
            for key, att in ancestor.entity_attributes.items():
                if isinstance(att.type, Entity) is False:
                    continue
                append_to(att.type, related_entities)
                for at_ancestor in att.type.get_related_entities_and_types(related_entities):
                    append_to(at_ancestor, related_entities)
        return related_entities

    @property
    def parent_type(self):
        result = re.search(r"SUBTYPE OF \((.*?)\);", self.content)
        return result.group(1) if result is not None else None

    @property
    def instance_attributes(self) -> Dict[str, Attribute]:
        """Entity attributes including inherited attributes"""
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

        re_supertype = re.compile(r"SUPERTYPE OF \((?:.*?)\);(.*?)^ [aA-zZ]", re_flags)
        re_subtype_alt = re.compile(r"SUBTYPE OF \((?:.*?)\);(.*?)\Z", re_flags)
        res_attributes_re = re.search(r"SUBTYPE OF \((?:.*?)\);(.*?)^ [aA-zZ]", self.content, re_flags)
        re_att = re.compile(r"^	(?P<key>[aA-zZ]{0,20}) :(?P<value>.*?);", re_flags)

        if res_attributes_re is None:
            res_attributes_re = re_subtype_alt.search(self.content)
            if res_attributes_re is None:
                res_attributes_re = re_supertype.search(self.content)
                if res_attributes_re is None:
                    return None

        data = res_attributes_re.group(1)
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

    @property
    def supertype_of(self):
        res = re.search(r"ABSTRACT SUPERTYPE OF \(ONEOF\n\s*\((.*?)\)", self.content, re.MULTILINE | re.DOTALL)
        if res is None:
            return None
        return [x.strip() for x in res.group(1).split(",")]

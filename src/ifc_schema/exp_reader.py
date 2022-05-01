import re
from dataclasses import dataclass, field
from typing import Dict

from ifc_schema.entities import Entity
from ifc_schema.att_types import Attribute, get_att_type

re_flags = re.DOTALL | re.MULTILINE | re.IGNORECASE


@dataclass
class ExpReader:
    express_file: str
    entity_dict: Dict[str, Entity] = field(default_factory=dict)
    type_dict: Dict[str, Entity] = field(default_factory=dict)

    def __post_init__(self):
        reg_entities = re.compile(r"ENTITY\s*(?P<name>.*?)\n(?P<content>.*?)END_ENTITY;", re_flags)
        reg_types = re.compile(r"TYPE\s*(?P<name>.*?)\s*=\s*(?P<content>.*?);(.*?)END_TYPE;", re_flags)
        with open(self.express_file, "r") as f:
            data = f.read()
            lpos = data.find("ENTITY ")
            exp_entities: Dict[str, Entity] = {
                co.name: co for co in (convert_type(x, self) for x in reg_entities.finditer(data, pos=lpos - 5))
            }

            exp_types: Dict[str, Entity] = {
                co.name: co for co in (convert_type(x, self) for x in reg_types.finditer(data, endpos=lpos + 5))
            }

            self.entity_dict.update(exp_entities)
            self.type_dict.update(exp_types)

    def resolve_attribute(self, name: str, attribute: str, inherited: bool) -> Attribute:
        optional = attribute.upper().startswith("OPTIONAL")
        if " " not in attribute:
            entity = self.entity_dict.get(attribute, None)
            if entity is not None:
                return Attribute(name, entity, inherited=inherited, optional=optional)

        att = get_att_type(attribute, self)
        return Attribute(name, att, inherited=inherited, optional=optional)


def convert_type(r: re.Match, exp_reader) -> Entity:
    """Return a minimum class containing identifier and content"""
    d = r.groupdict()
    name = d["name"]
    content = d["content"]
    return Entity(name=name, content=content, exp_reader=exp_reader)

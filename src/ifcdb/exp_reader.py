import re
from dataclasses import dataclass, field
from typing import ClassVar, Dict

from ifcdb.entities import Entity

re_flags = re.DOTALL | re.MULTILINE | re.IGNORECASE


@dataclass
class ExpReader:
    express_file: str
    entity_dict: Dict[str, Entity] = field(default_factory=dict)
    type_dict: Dict[str, Entity] = field(default_factory=dict)
    reg_entities: ClassVar[re.Pattern] = re.compile(r"ENTITY\s*(?P<name>.*?)$(?P<content>.*?)END_ENTITY;", re_flags)
    reg_types: ClassVar[re.Pattern] = re.compile(
        r"TYPE\s*(?P<name>.*?)\s*=\s*(?P<content>.*?);(.*?)END_TYPE;", re_flags
    )

    def __post_init__(self):

        with open(self.express_file, "r") as f:
            data = f.read()
            lpos = data.find("ENTITY ")
            exp_entities: Dict[str, Entity] = {
                co.name: co for co in (convert_type(x, self) for x in self.reg_entities.finditer(data, pos=lpos - 5))
            }

            exp_types: Dict[str, Entity] = {
                co.name: co for co in (convert_type(x, self) for x in self.reg_types.finditer(data, endpos=lpos + 5))
            }

            self.entity_dict.update(exp_entities)
            self.type_dict.update(exp_types)


def convert_type(r: re.Match, exp_reader) -> Entity:
    """Return a minimum class containing identifier and content"""
    d = r.groupdict()
    name = d["name"].strip().replace(";", "")
    content = d["content"].strip()
    return Entity(name=name, content=content, exp_reader=exp_reader)

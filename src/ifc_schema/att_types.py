from __future__ import annotations

import re
from dataclasses import dataclass, field
from typing import TYPE_CHECKING, List, Tuple

if TYPE_CHECKING:
    from ifc_schema.entities import Entity
    from ifc_schema.exp_reader import ExpReader


class ExpressBaseTypes:
    REAL = "REAL"
    NUMBER = "NUMBER"
    BINARY = "BINARY"
    BOOLEAN = "BOOLEAN"
    INTEGER = "INTEGER"
    STRING = "STRING"
    LOGICAL = "LOGICAL"

    entity_map = dict(IfcBoolean="bool", IfcPositiveLengthMeasure="float")


@dataclass
class Attribute:
    name: str
    att_str: str
    parent: Entity = field(repr=False)
    optional: bool
    _exp_reader: ExpReader = field(repr=False)

    def __post_init__(self):
        self.att_str = self.att_str.replace("OPTIONAL ", "").strip()

    @property
    def type(self):
        # Check for list content
        att_res = get_list_att(self.att_str, self._exp_reader)
        if att_res is not None:
            return att_res
        if self.type_ref is not None:
            entity_type = ExpressBaseTypes.entity_map.get(self.type_ref.name, None)
            if entity_type is not None:
                return entity_type
        if self.entity_ref is not None:
            return self.entity_ref

        raise ValueError(f"Unable to infer type from {self.att_str}")

    @property
    def entity_ref(self):
        if " " in self.att_str:
            return None
        return self._exp_reader.entity_dict.get(self.att_str, None)

    @property
    def type_ref(self):
        if " " in self.att_str:
            re_type_object = re.search(r"OF\s([a-zA-Z0-9_]{1,40})\Z", self.att_str)
            if re_type_object is None:
                return None
            return self._exp_reader.type_dict.get(re_type_object.group(1), None)

        return self._exp_reader.type_dict.get(self.att_str, None)


class InvalidAttTypeDefinitionError(Exception):
    pass


def get_list_att(att_str: str, exp_reader: ExpReader):
    re_list_of_list = re.search(r"LIST \[1:\?\] OF LIST \[(.*?):(.*?)\]", att_str)
    re_list = re.search(r"LIST \[(.*?):(.*?)\] OF", att_str)

    if re_list_of_list is not None:
        a = re_list_of_list.group(1)
        b = int(float(re_list_of_list.group(2)))
        if b == 3:
            return List[Tuple[float, float, float]]
        else:
            raise NotImplemented()

    if re_list is not None:
        a = re_list.group(1)
        b = re_list.group(2)

        return List

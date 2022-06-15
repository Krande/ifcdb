from __future__ import annotations

import re
from dataclasses import dataclass, field
from typing import TYPE_CHECKING, ClassVar

if TYPE_CHECKING:
    from ifcdb.entities import Entity
    from ifcdb.exp_reader import ExpReader


class ExpressBaseTypes:
    REAL = "REAL"
    NUMBER = "NUMBER"
    BINARY = "BINARY"
    BOOLEAN = "BOOLEAN"
    INTEGER = "INTEGER"
    STRING = "STRING"
    LOGICAL = "LOGICAL"

    entity_map = dict(IfcBoolean="bool", IfcPositiveLengthMeasure="float", IfcStateEnum="str")
    entity_type_map = {
        "INTEGER": "int",
        "STRING(255)": "str",
        "STRING": "str",
        "STRING(22) FIXED": "str",
        "REAL": "float",
    }


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
        if self.att_str.startswith("LIST") or self.att_str.startswith("SET"):
            return Array(self.att_str, self._exp_reader)

        if self.type_ref is not None:
            return self.type_ref

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


@dataclass
class Array:
    att_str: str

    _exp_reader: ExpReader = field(repr=False)
    _shape_re: ClassVar[re.Pattern] = re.compile(r"\[(?P<a>.*?):(?P<b>.*?)\]")

    @property
    def shape(self):
        shape = []
        for shp in self._shape_re.finditer(self.att_str):
            d = shp.groupdict()
            a, b = d["a"], d["b"]
            shape.append((a, b))
        return shape

    @property
    def of_type(self):
        type_res = list(self.att_str.split("OF"))
        res_str = type_res[-1].strip()
        res = self._exp_reader.entity_dict.get(res_str, None)
        if res is not None:
            return res
        res = self._exp_reader.type_dict.get(res_str, None)
        if res is not None:
            return res

        raise ValueError("Unable to recognize type")

from __future__ import annotations
import re
from dataclasses import dataclass
from typing import Union, TYPE_CHECKING, List, Tuple

if TYPE_CHECKING:
    from ifc_schema.entities import Entity
    from ifc_schema.exp_reader import ExpReader


@dataclass
class Attribute:
    name: str
    type: Union[object, Entity]
    inherited: bool
    optional: bool


class InvalidAttTypeDefinitionError(Exception):
    pass


class ExpressBaseTypes:
    REAL = "REAL"
    NUMBER = "NUMBER"
    BINARY = "BINARY"
    BOOLEAN = "BOOLEAN"
    INTEGER = "INTEGER"
    STRING = "STRING"
    LOGICAL = "LOGICAL"


def get_att_type(att_str: str, exp_reader: ExpReader) -> object:

    re_type_object = re.search("OF\s([a-zA-Z0-9_]{1,40})\Z", att_str)
    type_res = exp_reader.type_dict.get(re_type_object.group(1))

    if re_type_object is None:
        raise InvalidAttTypeDefinitionError(f"Unable to interpret type {att_str}")

    # Check for list content
    att_res = get_list_att(att_str, exp_reader)
    if att_res is not None:
        return type_res, att_res
    raise ValueError("Unable to convert")


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

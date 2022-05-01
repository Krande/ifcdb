from __future__ import annotations
import re
from dataclasses import dataclass
from typing import Union, TYPE_CHECKING, List, Annotated

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


def get_att_type(att_str: str, exp_reader: ExpReader) -> object:
    re_list_of_list = re.search(r"LIST \[1:\?\] OF LIST \[(.*?):(.*?)\]", att_str)
    re_type_object = re.search("OF\s([a-zA-Z0-9_]{1,40})\Z", att_str)
    if re_type_object is None:
        raise InvalidAttTypeDefinitionError(f"Unable to interpret type {att_str}")

    if re_list_of_list is not None:
        a = re_list_of_list.group(1)
        b = re_list_of_list.group(2)
        res = exp_reader.type_dict.get(re_type_object.group(1))
        return "[]"
    print("att_str")

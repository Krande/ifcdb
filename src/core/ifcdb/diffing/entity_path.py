from __future__ import annotations

from dataclasses import dataclass
from typing import Any

import ifcopenshell

from .utils import get_elem_paths

_ifc_ent = ifcopenshell.entity_instance


@dataclass
class IfcValueToChange:
    entity: _ifc_ent
    index: str | int
    value: Any


@dataclass
class IfcEntityValueEditor:
    f: ifcopenshell.file
    elem: _ifc_ent
    path: str
    new_value: Any

    def __post_init__(self):
        self.levels, self.indices = get_elem_paths(self.elem, self.path)

        self.parent_entity = self.levels[-3]
        self.parent_index = self.indices[-2]
        self.last_entity = self.levels[-2]
        self.last_index = self.indices[-1]

    def update_tuple(self) -> tuple:
        list_ver = list(self.levels[-2])
        list_ver[self.last_index] = self.new_value
        return tuple(list_ver)

    def get_new_value_old_algo(self):
        parent_entity = self.parent_entity
        f = self.f

        if isinstance(parent_entity, ifcopenshell.entity_instance) and len(f.get_inverse(parent_entity)) > 1:
            inverse_entity = self.levels[-4]
            inverse_index = self.indices[-3]
            res = parent_entity.get_info(include_identifier=False)
            res.pop("type")
            if isinstance(self.last_entity, tuple):
                res[self.parent_index] = self.update_tuple()
                new_entity = f.create_entity(parent_entity.is_a(), **res)
            else:
                raise NotImplementedError()

            return IfcValueToChange(inverse_entity, inverse_index, new_entity)

        if isinstance(self.last_entity, tuple):
            result = self.update_tuple()
            if isinstance(parent_entity, ifcopenshell.entity_instance):
                return IfcValueToChange(parent_entity, self.parent_index, result)
            else:
                raise NotImplementedError("This is not yet supported")
        else:
            new_value = IfcValueToChange(self.last_entity, self.last_index, self.new_value)
        return new_value

    def replace_value(self) -> None:
        new_value = self.get_new_value_old_algo()
        try:
            setattr(new_value.entity, new_value.index, new_value.value)
        except IndexError as e:
            raise IndexError(e)

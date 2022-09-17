from __future__ import annotations

from dataclasses import dataclass
from enum import Enum
from typing import TYPE_CHECKING, Any

import ifcopenshell

from .utils import get_elem_paths

_ifc_ent = ifcopenshell.entity_instance

if TYPE_CHECKING:
    from .tool import ValueChange


@dataclass
class OverlinkedEntity:
    index: int
    item: _ifc_ent
    inverse_entities: list[_ifc_ent]


class OverlinkAlgo(Enum):
    V1 = "V1"
    V2 = "V2"
    OFF = "OFF"


@dataclass
class OverlinkResolver:
    value_change: ValueChange
    f: ifcopenshell.file

    def check_dep_path(self, ifc_elem: _ifc_ent, list_of_deps: list[_ifc_ent] = None):
        if list_of_deps is None:
            list_of_deps = []

        inverse_elems = self.f.get_inverse(ifc_elem)

        for x in inverse_elems:
            list_of_deps.append(x)
            self.check_dep_path(x, list_of_deps)

        return list_of_deps

    def perform(self) -> None:
        inverse_elems = self.check_dep_path(self.value_change.ifc_elem)

        # find shared linked object
        object_to_replace = inverse_elems[-1]
        res = self.value_change.levels.index(object_to_replace)
        _ = self.value_change.indices[res - 1]
        print("sd")


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

    def _identify_top_most_overlinked_entity(self) -> OverlinkedEntity | None:
        overlinked_ancestors = []

        ancestry = [x for x in self.levels]
        ancestry.reverse()

        for i, ancestor in enumerate(ancestry):
            if isinstance(ancestor, _ifc_ent) is False:
                continue

            inverse_owners = self.f.get_inverse(ancestor)
            is_owned_by_multiple = len(inverse_owners) > 1

            if is_owned_by_multiple:
                index = self.levels.index(ancestor)
                overlinked_ancestors.append(OverlinkedEntity(index, ancestor, inverse_owners))

        if len(overlinked_ancestors) == 0:
            return None

        return overlinked_ancestors[0]

    def get_new_value(self) -> IfcValueToChange:
        result = self._identify_top_most_overlinked_entity()
        if result is None:
            return self.get_new_value_old_algo()

        index = self.indices[result.index - 1]
        if isinstance(index, int):
            return self.get_new_value_old_algo()
        class_name = result.item.is_a()
        res = result.item.get_info(include_identifier=False)
        res.pop("type")
        # If this object is linked to other objects, a new object should be created instead
        new_entity = self.f.create_entity(class_name, **res)

        return IfcValueToChange(result.item, index, new_entity)

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
        new_value = self.get_new_value()
        try:
            setattr(new_value.entity, new_value.index, new_value.value)
        except IndexError as e:
            raise IndexError(e)

from __future__ import annotations

from dataclasses import dataclass
from typing import TYPE_CHECKING

import ifcopenshell

_ifc_ent = ifcopenshell.entity_instance

if TYPE_CHECKING:
    from .tool import ValueChange


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

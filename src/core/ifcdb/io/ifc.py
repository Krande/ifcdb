from __future__ import annotations

import pathlib
from dataclasses import dataclass

import ifcopenshell
from toposort import toposort, toposort_flatten


@dataclass
class IfcIO:
    ifc_file: str | pathlib.Path = None
    ifc_str: str = None
    ifc_obj: ifcopenshell.file = None
    schema: str = None

    def __post_init__(self):
        if self.ifc_file is not None:
            self.ifc_obj = ifcopenshell.open(str(self.ifc_file))
        else:
            self.ifc_obj = ifcopenshell.file.from_string(self.ifc_str)
        self.schema = self.ifc_obj.wrapped_data.schema

    def get_ifc_dep_map(self, use_ids=True):
        dep_map = dict()
        for inst in self.ifc_obj:
            id_ref = inst.id() if use_ids else inst
            if id_ref not in dep_map.keys():
                dep_map[id_ref] = []
            for dep in self.ifc_obj.traverse(inst, max_levels=1)[1:]:
                dep_ref = dep.id() if use_ids else dep
                dep_map[id_ref if use_ids else inst].append(dep_ref)
        return dep_map

    def get_ifc_objects_by_sorted_insert_order_flat(self):
        dep_map = self.get_ifc_dep_map()
        return [self.ifc_obj.by_id(x) for x in toposort_flatten(dep_map, sort=True) if x != 0]

    def get_ifc_objects_by_sorted_insert_order_grouped(self):
        dep_map = self.get_ifc_dep_map()
        return [[self.ifc_obj.by_id(x) for x in group if x != 0] for group in toposort(dep_map)]

    def get_unique_class_entities_of_ifc_content(self, include_related=False) -> list[str]:
        return list(set([x.is_a() for x in self.get_ifc_objects_by_sorted_insert_order_flat()]))

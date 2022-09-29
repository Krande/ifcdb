from __future__ import annotations

import copy
import json
import logging
from dataclasses import dataclass, field

import ifcopenshell
from deepdiff import DeepDiff

from ifcdb.database.bulk_handler import BulkEntityHandler, to_bulk_entity_handler
from ifcdb.diffing.types import (
    PropUpdateType,
    ValueAddedToIterable,
    ValueChange,
    ValueRemovedFromIterable,
)
from ifcdb.diffing.utils import get_elem_paths
from ifcdb.entities import (
    Entity,
    EntityResolver,
    EntityTool,
    create_insert_entity_from_ifc_dict,
)
from ifcdb.io.ifc.optimizing import general_optimization

_ifc_ent = ifcopenshell.entity_instance
_guid = "GlobalId"


@dataclass
class EntityDiffBase:
    guid: str
    class_name: str

    def to_dict(self):
        ...

    def to_json_file(self, filepath):
        ...


@dataclass
class EntityDiffChange(EntityDiffBase):
    diff: dict
    value_changes: dict[str, ValueChange | ValueRemovedFromIterable | ValueAddedToIterable]
    root_entity: Entity = None

    def to_dict(self):
        return dict(diff=self.diff, guid=self.guid, class_name=self.class_name)

    def to_json_file(self, filepath):
        with open(filepath, "w") as f:
            json.dump(self.to_dict(), f, indent=4)

    @staticmethod
    def from_json_file(filepath, ifc_obj: ifcopenshell.file) -> EntityDiffChange:
        with open(filepath, "r") as f:
            data = json.load(f)
        guid = data["guid"]
        item = ifc_obj.by_guid(guid)
        er = EntityResolver(ifc_obj.wrapped_data.schema)
        entity = er.create_insert_entity_from_ifc_entity(item)
        return EntityDiffChange(guid, data["class_name"], data["diff"], entity)


@dataclass
class EntityDiffAdd(EntityDiffBase):
    added: EntityTool

    def to_dict(self) -> dict:
        return dict(class_name=self.class_name, entity=self.added.entity.to_dict())


@dataclass
class EntityDiffRemove(EntityDiffBase):
    removed: Entity

    def to_dict(self) -> dict:
        return dict(guid=self.guid)


@dataclass
class IfcDiffTool:
    f1: ifcopenshell.file
    f2: ifcopenshell.file = None

    auto_run: bool = True
    schema_ver: str = "IFC4x1"
    optimize_before_diffing: bool = True

    changed: list[EntityDiffChange] = field(default_factory=list)
    added: list[EntityDiffAdd] = field(default_factory=list)
    removed: list[EntityDiffRemove] = field(default_factory=list)

    def __post_init__(self):
        if self.f2 is not None and self.auto_run is True:
            self._run()

    def _run(self):
        """Compare rooted elements in two ifc files and generate a list of element diffs"""
        f1 = self.f1
        f2 = self.f2
        if self.optimize_before_diffing:
            f1 = general_optimization(f1)
            f2 = general_optimization(f2)

        guids1 = set(getattr(x, _guid) for x in f1.by_type("IfcRoot"))
        guids2 = set(getattr(x, _guid) for x in f2.by_type("IfcRoot"))

        removed = guids1 - guids2
        added = guids2 - guids1

        for guid in removed:
            el = f1.by_guid(guid)
            entity_tool = EntityResolver.create_entity_tool_from_ifcopenshell_entity(el)
            self.removed.append(EntityDiffRemove(guid, el.is_a(), entity_tool.entity))

        for guid in added:
            el = f2.by_guid(guid)
            entity_tool = EntityResolver.create_entity_tool_from_ifcopenshell_entity(el)
            self.added.append(EntityDiffAdd(guid, el.is_a(), entity_tool))

        for el in f1.by_type("IfcRoot"):
            guid = getattr(el, _guid)
            if guid in removed or guid in added:
                continue

            result = self.compare_rooted_elements(el, f2.by_guid(guid))
            if result is None:
                continue

            self.changed.append(result)

    def compare_elements(self, el1: _ifc_ent, el2: _ifc_ent) -> dict:
        info1 = el1.get_info(recursive=True, include_identifier=False)
        info2 = el2.get_info(recursive=True, include_identifier=False)

        # Walk hierarchy and pop linked rooted elements that are already diffed
        new_info1 = ifc_info_walk_and_pop(info1, [x.guid for x in self.changed])
        new_info2 = ifc_info_walk_and_pop(info2, [x.guid for x in self.changed])

        return DeepDiff(new_info1, new_info2)

    def are_elements_equal(self, el1: _ifc_ent, el2: _ifc_ent) -> bool:
        res = self.compare_elements(el1, el2)
        keys = list(res)
        if len(keys) > 0:
            return False

        return True

    def compare_rooted_elements(self, el1: _ifc_ent, el2: _ifc_ent) -> EntityDiffChange | None:
        info1 = el1.get_info(recursive=True, include_identifier=False)
        info2 = el2.get_info(recursive=True, include_identifier=False)

        # Walk hierarchy and pop linked elements that are already diffed
        new_info1 = ifc_info_walk_and_pop(info1, [x.guid for x in self.changed])
        new_info2 = ifc_info_walk_and_pop(info2, [x.guid for x in self.changed])

        res = DeepDiff(new_info1, new_info2, view="text")
        keys = list(res)
        if len(keys) > 0:
            entity = create_insert_entity_from_ifc_dict(info1)
            diff = {key: res[key] for key in keys}
            dr = DiffResolver(self.f1, self.f2)
            vcs = dr.diff_to_value_changes(el1.GlobalId, diff)
            return EntityDiffChange(el1.GlobalId, el1.is_a(), diff, vcs, entity)

        return None

    def to_bulk_entity_handler(self) -> BulkEntityHandler:
        return to_bulk_entity_handler(self)

    def to_dict(self) -> dict:
        return dict(
            changed=[x.to_dict() for x in self.changed],
            added=[x.to_dict() for x in self.added],
            removed=[x.to_dict() for x in self.removed],
        )

    def to_json_file(self, filepath, indent=4) -> None:
        with open(filepath, "w") as f:
            json.dump(self.to_dict(), f, indent=indent)

    def copy(self) -> IfcDiffTool:
        changed = [x for x in self.changed]
        removed = [x for x in self.removed]
        added = [x for x in self.added]

        return IfcDiffTool(self.f1, self.f2, auto_run=False, changed=changed, removed=removed, added=added)

    @property
    def contains_changes(self) -> bool:
        return len(self.added) + len(self.changed) + len(self.removed) > 0


def ifc_info_walk_and_pop(source: dict, ids_to_skip: list[str]) -> dict:
    copied_source = copy.deepcopy(source)

    def walk(d, parents: list[dict | tuple], keys: list[str | int]):
        parent = parents[-1] if len(parents) > 0 else None
        parent_key = keys[-1] if len(keys) > 0 else None
        if isinstance(d, dict):
            guid = d.get(_guid)
            if guid is not None and guid in ids_to_skip:
                if len(parents) == 0:
                    logging.warning("Root object should not be included to begin with")
                    return None
                else:
                    if isinstance(parent, tuple):
                        grand_parent = parents[-2]
                        grand_parent_key = keys[-2]
                        list_copy = list(grand_parent[grand_parent_key])
                        list_copy.pop(parent_key)
                        grand_parent[grand_parent_key] = tuple(list_copy)
                    else:
                        parent.pop(parent_key)
            copy_d = copy.deepcopy(d)
            for key, value in copy_d.items():
                walk(value, parents + [d], keys + [key])

        elif isinstance(d, tuple):
            for i, x in enumerate(d):
                walk(x, parents + [d], keys + [i])
        else:
            logging.info("skipping ")

    walk(copied_source, [], [])
    return copied_source


@dataclass
class DiffResolver:
    f1: ifcopenshell.file
    f2: ifcopenshell.file

    def diff_to_value_changes(
        self, guid: str, diff: dict
    ) -> dict[str, ValueChange | ValueRemovedFromIterable | ValueAddedToIterable]:
        vc = dict()
        elem = self.f2.by_guid(guid)
        for key, value in diff.items():
            safe_key = PropUpdateType.get_prop_type(key)
            if safe_key == PropUpdateType.DICT_ITEM_ADDED:
                for item in value:
                    vc[item] = self.dict_value_to_add(item, elem)
                continue
            for path, value_changes in value.items():
                if safe_key == PropUpdateType.UPDATE:
                    vc[path] = self.path_to_value_change(path, elem, **value_changes)
                elif safe_key == PropUpdateType.ADD_TO_ITERABLE:
                    vc[path] = self.path_to_value_add_to_iterable(path, elem)
                elif safe_key == PropUpdateType.REMOVE_FROM_ITERABLE:
                    vc[path] = self.path_to_value_remove_from_iterable(path, guid)
                else:
                    raise ValueError(f'Unrecognized key "{safe_key}"')

        return vc

    def dict_value_to_add(self, path: str, elem: _ifc_ent) -> str:
        print('test')
        return path

    def path_to_value_change(self, path: str, root_elem: _ifc_ent, old_value, new_value) -> ValueChange:
        ifc_elem_path = get_elem_paths(root_elem, path)

        index = ifc_elem_path.get_index_of_nearest_ifc_elem()
        key = ifc_elem_path.indices[index]
        new_value_alt = ifc_elem_path.levels[index + 1]

        tuple_len = None
        if isinstance(new_value_alt, tuple):
            tuple_len = len(new_value_alt)

        return ValueChange(path, new_value, key, index - 1, tuple_len)

    def path_to_value_add_to_iterable(self, path, root_elem) -> ValueAddedToIterable:
        ifc_elem_path = get_elem_paths(root_elem, path)

        elem_to_be_added = ifc_elem_path.levels[-1]
        parent_entity_tool = EntityResolver.create_entity_tool_from_ifcopenshell_entity(root_elem)
        entity_tool = EntityResolver.create_entity_tool_from_ifcopenshell_entity(elem_to_be_added)
        return ValueAddedToIterable(path, entity_tool.entity, ifc_elem_path.indices[0], parent_entity_tool.entity)

    def path_to_value_remove_from_iterable(self, path, guid) -> ValueRemovedFromIterable:
        elem_old = self.f1.by_guid(guid)
        ifc_elem_path = get_elem_paths(elem_old, path)
        elem_to_be_removed = ifc_elem_path.levels[-1]
        entity_tool = EntityResolver.create_entity_tool_from_ifcopenshell_entity(elem_to_be_removed)

        parent_entity_tool = EntityResolver.create_entity_tool_from_ifcopenshell_entity(ifc_elem_path.levels[0])

        return ValueRemovedFromIterable(path, entity_tool.entity, ifc_elem_path.indices[0], parent_entity_tool.entity)

from __future__ import annotations

import copy
import json
import logging
from dataclasses import dataclass, field
from typing import Any

import ifcopenshell
from deepdiff import DeepDiff

from ifcdb.database.bulk_handler import BulkEntityHandler, to_bulk_entity_handler
from ifcdb.entities import (
    Entity,
    EntityResolver,
    EntityTool,
    get_entity_from_source_dict,
)
from ifcdb.io.ifc.optimizing import general_optimization

from .utils import get_elem_paths

_ifc_ent = ifcopenshell.entity_instance
_guid = "GlobalId"


@dataclass
class IfcValueToChange:
    entity: _ifc_ent
    index: str | int
    value: Any


@dataclass
class OverlinkedEntity:
    index: int
    item: _ifc_ent
    inverse_entities: list[_ifc_ent]


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


@dataclass
class EntityDiffBase:
    guid: str
    class_name: str

    def to_dict(self):
        ...

    def to_json_file(self, filepath):
        ...


@dataclass
class ValueChange:
    path: str
    old_value: Any
    new_value: Any
    key: int | str
    ifc_elem: _ifc_ent
    levels: list[_ifc_ent | float | tuple]
    indices: list[str | int]
    new_value_alt: Any


@dataclass
class EntityDiffChange(EntityDiffBase):
    diff: dict
    value_changes: dict[str, ValueChange]
    entity: Entity = None
    overlinked_entities: dict[str, IfcValueToChange] = field(default_factory=dict)

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
    def to_dict(self) -> dict:
        return dict(guid=self.guid)


@dataclass
class IfcDiffTool:
    f1: ifcopenshell.file
    f2: ifcopenshell.file = None
    schema_ver: str = "IFC4x1"
    optimize_before_diffing: bool = True

    changed: list[EntityDiffChange] = field(default_factory=list)
    added: list[EntityDiffAdd] = field(default_factory=list)
    removed: list[EntityDiffRemove] = field(default_factory=list)

    def __post_init__(self):
        if self.f2 is not None:
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
            self.removed.append(EntityDiffRemove(guid, el.is_a()))

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

        # Walk hierarchy and pop linked elements that are already diffed
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

        res = DeepDiff(new_info1, new_info2)
        keys = list(res)
        if len(keys) > 0:
            entity = get_entity_from_source_dict(info1, schema_ver=self.schema_ver)
            diff = {key: res[key] for key in keys}
            vcs = diff_to_value_changes(self.f2, el1.GlobalId, diff)
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


def path_to_value_change(path: str, elem: _ifc_ent, old_value, new_value) -> ValueChange:
    levels, indices = get_elem_paths(elem, path)
    levels_rev = [x for x in levels]
    levels_rev.reverse()

    ifc_elem_to_change = None
    level_index = None
    for i, lvl in enumerate(levels_rev):
        if isinstance(lvl, _ifc_ent):
            ifc_elem_to_change = lvl
            level_index = i
            break

    # Insert a new IfcLocalPlacement if path root i
    index = len(levels) - level_index
    key = indices[index - 1]
    new_value_alt = levels[index]

    return ValueChange(path, old_value, new_value, key, ifc_elem_to_change, levels, indices, new_value_alt)


def diff_to_value_changes(f, guid: str, diff: dict) -> dict[str, ValueChange]:
    vc = dict()
    elem = f.by_guid(guid)
    for key, value in diff.items():
        if key == "values_changed":
            for path, value_changes in value.items():
                vc[path] = path_to_value_change(path, elem, **value_changes)
        else:
            raise NotImplementedError(f"{key=} is not yet supported")

    return vc

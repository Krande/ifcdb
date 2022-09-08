from __future__ import annotations

from dataclasses import dataclass, field
from itertools import count
from typing import TYPE_CHECKING, Any, Iterable

import toposort

from ifcdb.entities import Entity, EntityResolver

if TYPE_CHECKING:
    from ifcdb.diffing.tool import IfcDiffTool, ElDiff

from ifcdb.database.inserts.utils import to_insert_str
from ifcdb.database.select import EdgeFilter, EdgeSelect, FilterType

from .diff_ifcopen import _RE_COMP


def clean_path_elem(elem: str) -> str | int:
    elem = elem.replace("'", "")
    if elem.isnumeric():
        return int(elem)
    else:
        return elem


def dict_path_to_iterable(path) -> Iterable:
    return map(clean_path_elem, _RE_COMP.findall(path))


def iterable_path_to_edgedb_path(path_iter: Iterable) -> str:
    path_str = ""
    for i, elem in enumerate(path_iter):
        if isinstance(elem, int):
            path_str += f"[{elem}]"
        else:
            if i != 0:
                path_str += "."
            path_str += elem
    return path_str


def dict_path_to_edgedb_path(path: str) -> str:
    return iterable_path_to_edgedb_path(dict_path_to_iterable(path))


def add_entity(elem: ElDiff):
    return EntityResolver.create_insert_entity_from_ifc_dict(elem.diff)


def remove_entity(elem: ElDiff):
    return EntityResolver.create_insert_entity_from_ifc_dict(elem.diff)


@dataclass
class EntityUpdateValue:
    value: Any
    old_value: Any
    key: str = None
    index: int | None = None
    len: int | None = None

    def to_update_str(self) -> str:
        edql_str = ""
        if self.index is not None:
            array_str = "["
            for i in range(0, self.len):
                if i != 0:
                    array_str += ", "
                if i == self.index:
                    array_str += f"{self.value}"
                else:
                    array_str += f".{self.key}[{i}]"
            array_str += "]"
            edql_str += f"{self.key} := {array_str}\n"
        else:
            edql_str += f"{self.key} := {self.value}\n"

        return edql_str


@dataclass
class EntityPropUpdate:
    root_object: Entity
    property_path: str = field(repr=False)
    update_value: EntityUpdateValue

    selects: list[EdgeSelect] = field(default=None)
    last_select: EdgeSelect = field(default=None)

    _levels: list[str] = field(default=None)
    _classes: list[str] = field(default=None)

    def __post_init__(self):
        self._resolve_levels_and_classes()

    def _get_classes_from_entity_subpath(self, entity: Entity = None, classes: list[str] = None, lvl: int = 0):
        if entity is None:
            entity = self.root_object

        if classes is None:
            classes = []

        curr_level = self._levels[lvl]
        next_level_idx = lvl + 1
        next_level = None
        if next_level_idx < len(self._levels) and isinstance(self._levels[next_level_idx], int):
            next_level = self._levels[next_level_idx]
            sub_entity = entity.links.get(curr_level)[next_level]

            lvl += 1
        else:
            sub_entity = entity.links.get(curr_level)

        if sub_entity is None:
            # Check props
            sub_entity = entity.props.get(curr_level)
            if sub_entity is None:
                raise ValueError("Unable to trace nested object path")

        if isinstance(sub_entity, Entity) is False:
            insert_key = curr_level
            self.update_value.key = insert_key
            if isinstance(next_level, int):
                self.update_value.index = next_level
                self.update_value.len = len(entity.links.get(curr_level))

            return classes

        if next_level is not None:
            classes.append(((curr_level, next_level), sub_entity.name))
        else:
            classes.append((curr_level, sub_entity.name))

        self._get_classes_from_entity_subpath(sub_entity, classes, lvl + 1)

        return classes

    def _chunk_classes(self):
        chunks = []
        chunk = []
        for i, (keys, class_name) in enumerate(self._classes):
            if isinstance(keys, str):
                chunk.append((keys, class_name))
            else:
                chunk.append((keys, class_name))
                chunks.append(chunk)
                chunk = []

        if len(chunk) > 0:
            chunks.append(chunk)
        return chunks

    def _resolve_levels_and_classes(self):
        res = [r.replace("'", "") for r in _RE_COMP.findall(self.property_path)]
        self._levels = [int(r) if r.isnumeric() else r for r in res]
        self._classes = self._get_classes_from_entity_subpath()
        all_selects = self.resolve_selects()
        self.selects = all_selects[:-1]
        self.last_select = all_selects[-1]

    def resolve_selects(self):
        root_guid = self.root_object.props.get("GlobalId")
        root_select = EdgeSelect(
            "root", self.root_object, None, filter=EdgeFilter("GlobalId", root_guid, FilterType.STR)
        )
        select_objects = []

        prev_ref = root_select
        for i, chunk in enumerate(self._chunk_classes(), start=1):
            curr_ref = f"lvl{i}"
            is_agg = False
            path_neutral_str = ""
            index = None
            assert_class = None
            for j, (keys, class_name) in enumerate(chunk):
                if j != 0:
                    path_neutral_str += "."
                if isinstance(keys, str):
                    path_neutral_str += keys
                else:
                    path_neutral_str += keys[0]
                    is_agg = True
                    index = keys[1]
                    assert_class = class_name

            es = EdgeSelect(
                curr_ref,
                prev_ref,
                path_neutral_str,
                index,
                assert_class=assert_class,
                is_multi_link=is_agg,
            )
            select_objects.append(es)
            prev_ref = es

        return [root_select] + select_objects


@dataclass
class BulkEntityRemoval:
    entities: list[Entity]

    def to_edql_str(self):
        insert_str = ""
        for entity in self.entities:
            insert_str += to_insert_str(entity)
        return insert_str


@dataclass
class BulkEntityInsert:
    entities: list[Entity]

    def to_edql_str(self):
        insert_str = ""
        for entity in self.entities:
            insert_str += to_insert_str(entity)
        return insert_str


@dataclass
class BulkEntityUpdate:
    updates: list[EntityPropUpdate]

    global_with_selects: dict[str, EdgeSelect] = field(default_factory=dict)
    local_with_selects: dict[str, EdgeSelect] = field(default_factory=dict)
    insert_items: list[EdgeSelect] = field(default_factory=list)

    def __post_init__(self):
        self.insert_items = [u.last_select for u in self.updates]

    def _get_unique_entities(self) -> dict[str, list[EdgeSelect]]:
        unique_entity_paths = dict()
        select_chunks = [update.selects for update in self.updates]
        for update_list in select_chunks:
            for prop_path in update_list:
                epath = prop_path.get_absolute_path()
                if epath not in unique_entity_paths.keys():
                    unique_entity_paths[epath] = []
                unique_entity_paths[epath].append(prop_path)

        return unique_entity_paths

    def _resolve_global_with_statements(self):
        unique_entity_paths = self._get_unique_entities()
        c = count(1)

        # Define global variables
        for key, value in unique_entity_paths.items():
            name = f"obj{next(c)}"
            first_entry = value.pop(0)
            first_entry.name = name

            self.global_with_selects[name] = first_entry

        # resolve internal name references
        path_ref_map = {value.get_absolute_path(): value for key, value in self.global_with_selects.items()}
        value_changes = []
        for key, value in self.global_with_selects.items():
            if isinstance(value.entity_top, Entity):
                continue
            abs_path = value.entity_top.get_absolute_path()
            existing_parent = path_ref_map.get(abs_path)
            if existing_parent is not None and value.entity_top != existing_parent:
                value_changes.append((value, existing_parent))

        for value, replacement in value_changes:
            value.entity_top = replacement

    def global_with_str(self) -> str:
        self._resolve_global_with_statements()
        global_wstr = "with\n"
        for key, value in self.global_with_selects.items():
            global_wstr += "    " + value.to_edql_str() + "\n"
        return global_wstr

    def to_edql_str(self) -> str:
        edql_str = self.global_with_str() + "\n"

        path_ref_map = {value.get_absolute_path(): value for key, value in self.global_with_selects.items()}

        edql_str += "SELECT {\n"
        indent = "    "
        upc = count(1)
        for i, insert_item in enumerate(self.insert_items):
            parent_abs_path = insert_item.entity_top.get_absolute_path()
            parent_object = path_ref_map.get(parent_abs_path)

            if insert_item.entity_top != parent_object:
                insert_item.entity_top = parent_object

            curr_abs_path = insert_item.get_absolute_path()

            update_name = f"update{next(upc)}"
            edql_str += indent + f"{update_name} := (\n"

            existing_with_select = path_ref_map.get(curr_abs_path, None)
            if existing_with_select is None:
                edql_str += 2 * indent + f"with\n{3*indent}{insert_item.to_edql_str()}\n"
            else:
                insert_item.name = existing_with_select.name

            edql_str += 2 * indent + f"UPDATE {insert_item.name}\n{2*indent}" + "SET {\n"
            prop_update = self.updates[i]
            edql_str += 3 * indent + prop_update.update_value.to_update_str()
            edql_str += 2 * indent + "}\n"
            edql_str += indent + "),\n"

        edql_str += "}"
        return edql_str


def change_entity(elem: ElDiff) -> BulkEntityUpdate | None:
    updates = []
    for diff_type, diff in elem.diff.items():
        if diff_type == "values_changed":
            # find_unique_selects(diff)
            updates += [
                EntityPropUpdate(elem.entity, path, EntityUpdateValue(values["new_value"], values["old_value"]))
                for path, values in diff.items()
            ]
    if len(updates) == 0:
        return None
    eu = BulkEntityUpdate(updates)
    # edql_str = eu.to_edql_str()
    # print(edql_str)
    return eu


def create_edgedb_diff_objects(diff_tool: IfcDiffTool) -> list[BulkEntityUpdate | BulkEntityInsert | BulkEntityRemoval]:
    bulk_updates = []
    for diff_el in diff_tool.added:
        bulk_updates.append(add_entity(diff_el))

    for diff_el in diff_tool.removed:
        bulk_updates.append(remove_entity(diff_el))

    for diff_el in diff_tool.changed:
        change_object = change_entity(diff_el)
        if change_object is not None:
            bulk_updates.append(change_object)

    # Should instead look for ways of merging bulk update objects is not yet supported instead of returning list
    return bulk_updates


def find_unique_selects(source: dict):
    all_path_deps = dict()
    value_keys = []
    for key, value in source.items():
        path = tuple(dict_path_to_iterable(key))
        value_keys.append((path[-1], value))
        all_prev = []
        for p in path:
            abs_path = iterable_path_to_edgedb_path(all_prev + [p])
            parent_path = iterable_path_to_edgedb_path(all_prev)
            if abs_path not in all_path_deps.keys():
                all_path_deps[abs_path] = []
            all_path_deps[abs_path].append(parent_path)
            all_prev.append(p)

    result_list = list(toposort.toposort(all_path_deps))

    branches = []
    for result_set in result_list:
        if len(result_set) > 1:
            branches.append(result_set)

    # find common paths

    print("sd")

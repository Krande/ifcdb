from __future__ import annotations

from dataclasses import dataclass, field
from enum import Enum
from itertools import count
from typing import Any

from ifcdb.database.inserts import EdgeInsert
from ifcdb.database.select import EdgeFilter, EdgeSelect, FilterType
from ifcdb.diffing.utils import _RE_COMP
from ifcdb.entities import Entity


@dataclass
class EntityUpdateValue:
    value: Any
    old_value: Any
    key: str = None
    index: int | None = None
    len: int | None = None

    def to_update_str(self) -> str:
        if self.key is None:
            raise ValueError("Key cannot be zero")
        if isinstance(self.value, Entity):
            ei = EdgeInsert(self.value)
            insert_str = ei.to_edql_str()
            value = f"({insert_str})"
        else:
            value = self.value
        edql_str = ""
        if self.index is not None:
            array_str = "["
            for i in range(0, self.len):
                if i != 0:
                    array_str += ", "
                if i == self.index:
                    array_str += f"{value}"
                else:
                    array_str += f".{self.key}[{i}]"
            array_str += "]"
            edql_str += f"{self.key} := {array_str}\n"
        else:
            edql_str += f"{self.key} := {value}\n"

        return edql_str


class PropUpdateType(Enum):
    UPDATE = "update"
    ADD_TO_ITERABLE = "add_to_iterable"
    REMOVE_FROM_ITERABLE = "remove_from_iterable"


@dataclass
class SelectResolver:
    root_object: Entity
    classes: list[str]

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
                assert_class = class_name
                if isinstance(keys, str):
                    path_neutral_str += keys
                else:
                    path_neutral_str += keys[0]
                    is_agg = True
                    index = keys[1]
                if assert_class is not None:
                    path_neutral_str += f"[is {assert_class}]"

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

    def _chunk_classes(self):
        chunks = []
        chunk = []
        for i, (keys, class_name) in enumerate(self.classes):
            if isinstance(keys, str):
                chunk.append((keys, class_name))
            else:
                chunk.append((keys, class_name))
                chunks.append(chunk)
                chunk = []

        if len(chunk) > 0:
            chunks.append(chunk)
        return chunks


@dataclass
class EntityPropUpdate:
    root_object: Entity
    property_path: str = field(repr=False)
    update_value: EntityUpdateValue
    update_type: PropUpdateType

    all_selects: list[EdgeSelect] = field(default=None)
    selects: list[EdgeSelect] = field(default=None)
    last_select: EdgeSelect = field(default=None)

    _levels: list[str] = field(default=None)

    def __post_init__(self):
        self._resolve_levels_and_classes()

    def _get_classes_from_entity_subpath(self, entity: Entity = None, classes: list[str] = None, lvl: int = 0):
        if entity is None:
            entity = self.root_object

        if classes is None:
            classes = []
        out_of_level_bounds = lvl > len(self._levels) - 1
        if out_of_level_bounds:
            if self.update_type == PropUpdateType.UPDATE and isinstance(self.update_value.value, Entity):
                classes.pop()

            return classes

        curr_level = self._levels[lvl]
        next_level_idx = lvl + 1
        next_level = None
        sub_entity = entity.links.get(curr_level)
        if next_level_idx < len(self._levels) and isinstance(self._levels[next_level_idx], int):
            next_level = self._levels[next_level_idx]
        if sub_entity is not None:
            if next_level is not None:
                intermediate_level = sub_entity
                exceeding_len_of_intermediary = next_level > len(intermediate_level) - 1
                if self.update_type == PropUpdateType.ADD_TO_ITERABLE and exceeding_len_of_intermediary:
                    self.update_value.key = curr_level
                    self.update_value.index = next_level
                    return classes
                sub_entity = intermediate_level[next_level]
                lvl += 1
        else:
            sub_entity = entity.props.get(curr_level)
            if sub_entity is None:
                raise ValueError("Unable to trace nested object path")

        if isinstance(sub_entity, Entity) is False:
            insert_key = curr_level
            self.update_value.key = insert_key
            if isinstance(next_level, int):
                self.update_value.index = next_level
                self.update_value.len = len(sub_entity)

            return classes

        if next_level is not None:
            classes.append(((curr_level, next_level), sub_entity.name))
        else:
            classes.append((curr_level, sub_entity.name))

        self._get_classes_from_entity_subpath(sub_entity, classes, lvl + 1)

        return classes

    def _resolve_levels_and_classes(self):
        res = [r.replace("'", "") for r in _RE_COMP.findall(self.property_path)]
        self._levels = [int(r) if r.isnumeric() else r for r in res]

        classes = self._get_classes_from_entity_subpath()
        select_resolver = SelectResolver(self.root_object, classes)
        self.all_selects = select_resolver.resolve_selects()

        self.selects = self.all_selects[:-1]
        self.last_select = self.all_selects[-1]


@dataclass
class BulkEntityAppend:
    updates: list[EntityPropUpdate]


@dataclass
class BulkEntityUpdate:
    updates: list[EntityPropUpdate]

    global_with_selects: dict[str, EdgeSelect] = field(default_factory=dict)
    select_items: list[EdgeSelect] = field(default_factory=list)
    all_select_items: list[EdgeSelect] = field(default_factory=list)
    indent: str = "    "

    def __post_init__(self):
        self.select_items = [u.last_select for u in self.updates]
        self.all_select_items = [s for u in self.updates for s in u.all_selects]

    def _get_unique_entities(self) -> dict[str, list[EdgeSelect]]:
        unique_entity_paths = dict()
        select_chunks = [update.selects for update in self.updates]
        for update_list in select_chunks:
            for select_object in update_list:
                epath = select_object.get_absolute_path()
                if epath not in unique_entity_paths.keys():
                    unique_entity_paths[epath] = []
                unique_entity_paths[epath].append(select_object)

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
        if len(self.global_with_selects.keys()) == 0:
            return ""
        global_wstr = "with\n"
        for key, value in self.global_with_selects.items():
            global_wstr += "    " + value.to_edql_str() + "\n"
        return global_wstr

    def _change_property_str(self, insert_item: EdgeSelect, prop_update: EntityPropUpdate, path_ref_map):
        parent_abs_path = insert_item.entity_top.get_absolute_path()
        parent_object = path_ref_map.get(parent_abs_path)

        if insert_item.entity_top != parent_object:
            insert_item.entity_top = parent_object
        edql_str = 2 * self.indent + f"UPDATE {insert_item.name}\n{2 * self.indent}" + "SET {\n"
        edql_str += 3 * self.indent + prop_update.update_value.to_update_str()
        edql_str += 2 * self.indent + "}\n"

        return edql_str

    def _append_property_str(self, insert_item: EdgeSelect, prop_update: EntityPropUpdate, path_ref_map) -> str:
        edql_str = 2 * self.indent + f"UPDATE {insert_item.name}\n{2 * self.indent}" + "SET {\n"
        entity = prop_update.update_value.value
        if isinstance(entity, EdgeInsert):
            select_str = entity.name
        else:
            select_str = f"select {entity.class_name} FILTER .GlobalId=<str>'{entity.guid}'"
        edql_str += 3 * self.indent + f"{prop_update.update_value.key} += ({select_str})\n"
        edql_str += 2 * self.indent + "}\n"

        return edql_str

    def _remove_property_str(self, insert_item: EdgeSelect, prop_update: EntityPropUpdate, path_ref_map):
        edql_str = 2 * self.indent + f"UPDATE {insert_item.name}\n{2 * self.indent}" + "SET {\n"
        entity = prop_update.update_value.old_value
        guid = entity.props.get("GlobalId")
        key = prop_update.last_select.entity_path
        select_str = f"select {entity.name} FILTER .GlobalId=<str>'{guid}'"
        edql_str += 3 * self.indent + f"{key} -= ({select_str})\n"
        edql_str += 2 * self.indent + "}\n"

        return edql_str

    def to_edql_str(self, use_select_wrapper=True, variable_assignment=None, embed_with_statements=False) -> str:
        edql_str = ""
        if variable_assignment is not None:
            edql_str = f"{variable_assignment} := (\n"

        if embed_with_statements:
            edql_str += self.global_with_str() + "\n"

        path_ref_map = {value.get_absolute_path(): value for key, value in self.global_with_selects.items()}

        if use_select_wrapper:
            edql_str += "SELECT {\n"

        upc = count(1)
        for i, select_item in enumerate(self.select_items):
            prop_update = self.updates[i]
            update_name = f"update_{next(upc)}"
            edql_str += self.indent + f"{update_name} := (\n"

            # Check if the insert_item path is already selected
            curr_abs_path = select_item.get_absolute_path()
            existing_with_select = path_ref_map.get(curr_abs_path, None)

            # Check if the insert_item entity top path is already selected
            if isinstance(select_item.entity_top, EdgeSelect):
                entity_top_abs_path = select_item.entity_top.get_absolute_path()
                res = path_ref_map.get(entity_top_abs_path, None)
                if res is not None:
                    select_item.entity_top = res

            if existing_with_select is None:
                if (
                    prop_update.update_type == PropUpdateType.REMOVE_FROM_ITERABLE
                    and select_item.entity_index is not None
                ):
                    select_item.name = select_item.entity_top.name
                else:
                    edql_str += 2 * self.indent + f"with\n{3 * self.indent}{select_item.to_edql_str()}\n"
            else:
                select_item.name = existing_with_select.name

            if prop_update.update_type == PropUpdateType.ADD_TO_ITERABLE:
                edql_str += self._append_property_str(select_item, prop_update, path_ref_map)
            elif prop_update.update_type == PropUpdateType.UPDATE:
                edql_str += self._change_property_str(select_item, prop_update, path_ref_map)
            elif prop_update.update_type == PropUpdateType.REMOVE_FROM_ITERABLE:
                edql_str += self._remove_property_str(select_item, prop_update, path_ref_map)
            else:
                raise NotImplementedError(f'Unrecognized "{prop_update.update_type}"')

            edql_str += self.indent + "),\n"

        if use_select_wrapper:
            edql_str += "}\n"

        if variable_assignment is not None:
            edql_str += "), \n"

        return edql_str

from __future__ import annotations

import edgedb
import toposort
from dataclasses import dataclass, field
from typing import TYPE_CHECKING, Any

from ifcdb.entities import Entity

if TYPE_CHECKING:
    from ifcdb.diffing.tool import IfcDiffTool, ElDiff

from .diff_ifcopen import _RE_COMP
from ifcdb.database.select import create_select_obj, FilterType, EdgeFilter, EdgeSelect


def dict_path_to_edgedb_path(path: str) -> str:
    res = _RE_COMP.findall(path)
    path_str = ""
    num_close = 0
    for r in res:
        prop = r.replace("'", "")
        if prop.isnumeric():
            path_str += f"[{prop}]"
        else:
            path_str += ": {"
            num_close += 1
            path_str += prop
    path_str += num_close * "}"
    return path_str


def add_entity(elem: ElDiff):
    _ = "SELECT (INSERT"
    raise NotImplementedError()


def remove_entity(elem: ElDiff):
    raise NotImplementedError()


@dataclass
class EntityPropUpdate:
    root_object: Entity
    property_path: str = field(repr=False)
    new_value: Any

    _levels: list[str] = field(default=None)

    insert_key: str = None
    # Only applicable if the insert key points to an array or tuple
    insert_index: int | None = None
    insert_len: int | None = None

    def __post_init__(self):
        res = [r.replace("'", "") for r in _RE_COMP.findall(self.property_path)]
        self._levels = [int(r) if r.isnumeric() else r for r in res]
        self.classes = self._get_classes_from_entity_subpath()

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
            self.insert_key = curr_level
            if isinstance(next_level, int):
                self.insert_index = next_level
                self.insert_len = len(entity.links.get(curr_level))
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

    def resolve_selects(self):
        root_class = self.root_object.name
        root_guid = self.root_object.props.get("GlobalId")
        root_select = EdgeSelect("root", root_class, filter=EdgeFilter("GlobalId", root_guid, FilterType.STR))
        select_objects = []

        prev_ref = root_select.name
        for i, chunk in enumerate(self._chunk_classes(), start=1):
            curr_ref = f"lvl{i}"
            is_agg = False
            path_neutral_str = prev_ref
            index = None
            assert_class = None
            for keys, class_name in chunk:
                if isinstance(keys, str):
                    path_neutral_str += "." + keys
                else:
                    path_neutral_str += "." + keys[0]
                    is_agg = True
                    index = keys[1]
                    assert_class = class_name

            select_objects.append(
                EdgeSelect(curr_ref, path_neutral_str, index, assert_class=assert_class, is_multi_link=is_agg)
            )
            prev_ref = curr_ref

        return [root_select] + select_objects

    def to_edql_update_str(self, new_value=None):
        new_value = self.new_value if new_value is None else new_value
        root_class = self.root_object.name
        root_guid = self.root_object.props.get("GlobalId")

        edql_str = f"with\n  root := (select {root_class} FILTER .GlobalId=<str>'{root_guid}'),\n"
        prev_ref = "root"

        for i, chunk in enumerate(self._chunk_classes(), start=1):
            curr_ref = f"lvl{i}"
            obj_ref = f"  {curr_ref} := (select "
            path_str = prev_ref
            is_agg = False
            path_neutral_str = prev_ref
            for keys, class_name in chunk:
                if isinstance(keys, str):
                    path_str += "." + keys
                    path_neutral_str += "." + keys
                else:
                    path_neutral_str += "." + keys[0]
                    is_agg = True
                    path_str += f".{keys[0]})[{keys[1]}][is {class_name}]"

            if is_agg:
                obj_ref += "array_agg("

            obj_ref += path_str + "),\n"
            edql_str += obj_ref
            prev_ref = curr_ref

        edql_str += f"UPDATE {prev_ref}\nSET" + " {\n  "
        if self.insert_index is not None:
            array_str = "["
            for i in range(0, self.insert_len):
                if i != 0:
                    array_str += ", "
                if i == self.insert_index:
                    array_str += f"{new_value}"
                else:
                    array_str += f".{self.insert_key}[{i}]"
            array_str += "]"
            edql_str += f"{self.insert_key} := {array_str}\n"
        else:
            edql_str += f"{self.insert_key} := {new_value}\n"
        edql_str += "}"
        return edql_str


@dataclass
class BulkEntityUpdate:
    updates: list[EntityPropUpdate]
    global_with_selects: dict[str, EdgeSelect] = field(default_factory=dict)

    def __post_init__(self):
        # sort and find similar paths
        global_with_selects = dict()
        unique_entity_paths = dict()
        for update in self.updates:
            update_list = update.resolve_selects()
            update_variable = update_list[-1].name
            new_val = update.new_value

            for prop_path in update_list:
                epath = prop_path.entity_path + f'_{prop_path.entity_index}'
                if epath not in unique_entity_paths.keys():
                    unique_entity_paths[epath] = []

                unique_entity_paths[epath].append(prop_path)
        for key, value in unique_entity_paths.items():
            if len(value) == 1:
                continue

        # # use toposort to sort the dependency order.
        # res = list(toposort.toposort(unique_entity_paths))

        print('sd')

        self.global_with_selects = global_with_selects


    def global_with_str(self):
        pass


def change_entity(client: edgedb.Client, elem: ElDiff) -> str:
    query_strings = []
    for diff_type, diff in elem.diff.items():
        if diff_type == "values_changed":
            updates = [EntityPropUpdate(elem.entity, path, values["new_value"]) for path, values in diff.items()]
            eu = BulkEntityUpdate(updates)

            # pp = PropPath(elem.entity, path, values["new_value"])
            # edql_str = pp.to_edql_update_str(values["new_value"])
            # query_strings.append(edql_str)

    # TODO: create a single compose statement and add client query execution code
    raise NotImplementedError()


def apply_diffs_edgedb(client: edgedb.Client, diff_tool: IfcDiffTool):
    for diff_el in diff_tool.added:
        add_entity(diff_el)

    for diff_el in diff_tool.removed:
        remove_entity(diff_el)

    for diff_el in diff_tool.changed:
        change_entity(client, diff_el)

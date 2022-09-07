from __future__ import annotations

import edgedb
from dataclasses import dataclass, field
from typing import TYPE_CHECKING, Any

from itertools import count
from ifcdb.entities import Entity

if TYPE_CHECKING:
    from ifcdb.diffing.tool import IfcDiffTool, ElDiff

from .diff_ifcopen import _RE_COMP
from ifcdb.database.select import FilterType, EdgeFilter, EdgeSelect


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
        root_select = EdgeSelect("root", root_class, None, filter=EdgeFilter("GlobalId", root_guid, FilterType.STR))
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

    def to_update_str(self) -> str:
        edql_str = ""
        if self.insert_index is not None:
            array_str = "["
            for i in range(0, self.insert_len):
                if i != 0:
                    array_str += ", "
                if i == self.insert_index:
                    array_str += f"{self.new_value}"
                else:
                    array_str += f".{self.insert_key}[{i}]"
            array_str += "]"
            edql_str += f"{self.insert_key} := {array_str}\n"
        else:
            edql_str += f"{self.insert_key} := {self.new_value}\n"
        return edql_str


@dataclass
class BulkEntityUpdate:
    updates: list[EntityPropUpdate]
    global_with_selects: dict[str, EdgeSelect] = field(default_factory=dict)
    local_with_selects: dict[str, EdgeSelect] = field(default_factory=dict)
    insert_items: list[EdgeSelect] = field(default_factory=list)

    def __post_init__(self):
        self._create_global_with_statements()

    def _get_unique_entities(self) -> dict:
        unique_entity_paths = dict()
        select_chunks = [update.resolve_selects() for update in self.updates]

        for update_list in select_chunks:
            insert_item = update_list.pop(-1)
            self.insert_items.append(insert_item)

            for prop_path in update_list:
                entity_path = prop_path.entity_top.name
                if prop_path.entity_path is not None:
                    entity_path += f".{prop_path.entity_path}"

                epath = entity_path + f"_{prop_path.entity_index}"
                if epath not in unique_entity_paths.keys():
                    unique_entity_paths[epath] = []

                unique_entity_paths[epath].append(prop_path)

        return unique_entity_paths

    def _create_global_with_statements(self):
        unique_entity_paths = self._get_unique_entities()
        c = count(1)
        for key, value in sorted(unique_entity_paths.items(), key=lambda item: len(item[1]), reverse=True):
            if len(value) == 1:
                self.local_with_selects[value[0].name] = value[0]
                continue

            names = set([v.name for v in value])
            if len(names) == 1:
                common_obj = value[0]
                name = common_obj.name
                if name in self.global_with_selects.keys():
                    name = f"{common_obj.name}_{next(c)}"
                    for v in value:
                        v.name = name

                self.global_with_selects[name] = common_obj
            else:
                raise ValueError()

            print("sd")

    def global_with_str(self) -> str:
        global_wstr = "with\n"
        for key, value in self.global_with_selects.items():
            global_wstr += "    " + value.to_edql_str() + "\n"
        return global_wstr

    def to_edql_str(self) -> str:
        edql_str = self.global_with_str() + "\n"

        edql_str += "SELECT {\n"
        indent = "    "
        upc = count(1)
        for i, insert_item in enumerate(self.insert_items):
            ref_name = insert_item.entity_top
            if ref_name not in self.global_with_selects.keys():
                raise ValueError()

            update_name = f"update{next(upc)}"
            edql_str += indent + f"{update_name} := (\n"

            existing_with_select = self.global_with_selects.get(insert_item.name, None)
            if existing_with_select is not None and insert_item.entity_path == existing_with_select.entity_path:
                print('sd')
                pass
            else:
                edql_str += 2 * indent + f"with\n{3*indent}{insert_item.to_edql_str()}\n"

            edql_str += 2 * indent + f"UPDATE {insert_item.name}\n{2*indent}" + "SET {\n"
            prop_update = self.updates[i]
            edql_str += 3*indent + prop_update.to_update_str()
            edql_str += 2 * indent + "}\n"
            edql_str += indent + "),\n"

        edql_str += '}'
        return edql_str


def change_entity(client: edgedb.Client, elem: ElDiff) -> str:
    for diff_type, diff in elem.diff.items():
        if diff_type == "values_changed":
            updates = [EntityPropUpdate(elem.entity, path, values["new_value"]) for path, values in diff.items()]
            eu = BulkEntityUpdate(updates)
            wstr = eu.global_with_str()
            edql_str = eu.to_edql_str()
            print("s")
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

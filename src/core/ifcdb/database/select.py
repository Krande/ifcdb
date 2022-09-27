from __future__ import annotations

from dataclasses import dataclass, field
from enum import Enum
from typing import ClassVar

from ifcdb.diffing.types import PropUpdateType
from ifcdb.diffing.utils import dict_path_to_iterable
from ifcdb.entities import Entity


class FilterType(Enum):
    STR = "str"
    UUID = "uuid"


@dataclass
class EdgeFilter:
    key: str
    value: str
    value_type: FilterType

    TYPES: ClassVar[FilterType] = FilterType

    def to_edql_str(self):
        return f"FILTER .{self.key}=<{self.value_type.value}>'{self.value}'"


@dataclass
class EdgeSelect:
    name: str

    entity_top: Entity | EdgeSelect
    entity_path: str | None = None
    entity_index: int = None

    is_multi_link: bool = False
    filter: EdgeFilter = None

    use_agg_array: ClassVar[bool] = False

    referred_selects: list[EdgeSelect] = field(default_factory=list)

    def __post_init__(self):
        if isinstance(self.entity_top, EdgeSelect):
            self.entity_top.referred_selects.append(self)

    def get_absolute_path(self) -> str:
        if self.entity_path is None:
            return self.entity_top.name
        abs_path = f"{self.entity_top.get_absolute_path()}.{self.entity_path}"
        if self.entity_index is not None:
            abs_path += f"[{self.entity_index}]"
        return abs_path

    def get_ancestry(self, ancestor=None, ancestors: list[Entity | EdgeSelect] = None):
        if ancestors is None:
            ancestors = []
        if ancestor is None:
            ancestor = self.entity_top

        if isinstance(ancestor, Entity):
            return ancestors

        ancestors.append(ancestor)

        self.get_ancestry(ancestor.entity_top, ancestors)
        return ancestors

    def create_agg_select_str(self, entity_path):
        if self.use_agg_array:
            return f"array_agg({entity_path})[{self.entity_index}]"
        else:
            select_str = f"{entity_path} ORDER BY .id"
            if self.entity_index != 0:
                select_str += f" offset {self.entity_index}"
            select_str += " limit 1"
            return select_str

    def to_edql_str(self, assign_to_variable=True, sep=",", detached=False):
        select_str = "select "
        if detached:
            select_str += "detached "

        entity_path = (
            f"{self.entity_top.name}.{self.entity_path}" if self.entity_path is not None else self.entity_top.name
        )
        if self.entity_index is not None and self.is_multi_link:
            select_str += self.create_agg_select_str(entity_path)
        else:
            select_str += entity_path

        # assert_str = ""
        # if self.assert_class is not None:
        #     assert_str = f"[is {self.assert_class}]"

        if self.filter is not None:
            select_str += " " + self.filter.to_edql_str()

        if assign_to_variable:
            return f"{self.name} := ({select_str}){sep}"
        else:
            return select_str


@dataclass
class SelectPathInfo:
    path_str: str
    index: int
    is_agg: bool


@dataclass
class PropSelectResolver:
    root_object: Entity
    property_path: str
    update_type: PropUpdateType

    def get_resolved_selects(self) -> list[EdgeSelect]:
        root_guid = self.root_object.props.get("GlobalId")
        root_select = EdgeSelect(
            "root", self.root_object, None, filter=EdgeFilter("GlobalId", root_guid, FilterType.STR)
        )
        select_objects = []
        prev_ref = root_select

        classes = self._resolve_classes()
        chunked_classes = self._split_classes_by_aggregates(classes)

        for i, chunk in enumerate(chunked_classes, start=1):
            curr_ref = f"lvl{i}"
            path_info = self._get_select_path_info(chunk)
            es = EdgeSelect(curr_ref, prev_ref, path_info.path_str, path_info.index, is_multi_link=path_info.is_agg)
            select_objects.append(es)
            prev_ref = es

        return [root_select] + select_objects

    def _get_select_path_info(self, chunk) -> SelectPathInfo:
        path_neutral_str = ""
        is_agg = False
        index = None
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
        return SelectPathInfo(path_neutral_str, index, is_agg)

    def _split_classes_by_aggregates(self, classes):
        chunks = []
        chunk = []
        for i, (keys, class_name) in enumerate(classes):
            if isinstance(keys, str):
                chunk.append((keys, class_name))
            else:
                chunk.append((keys, class_name))
                chunks.append(chunk)
                chunk = []

        if len(chunk) > 0:
            chunks.append(chunk)
        return chunks

    def _resolve_classes(
        self, entity: Entity = None, classes: list[str] = None, lvl: int = 0, levels: list[str] = None
    ) -> list[str]:

        if levels is None:
            levels = list(dict_path_to_iterable(self.property_path))

        if entity is None:
            entity = self.root_object

        if classes is None:
            classes = []
        out_of_level_bounds = lvl > len(levels) - 1
        if out_of_level_bounds:
            # if self.update_type == PropUpdateType.UPDATE and isinstance(self.update_value.value, Entity):
            #     classes.pop()

            return classes

        curr_level = levels[lvl]
        next_level_idx = lvl + 1
        next_level = None
        sub_entity = entity.links.get(curr_level)
        if next_level_idx < len(levels) and isinstance(levels[next_level_idx], int):
            next_level = levels[next_level_idx]
        if sub_entity is not None:
            if next_level is not None:
                intermediate_level = sub_entity
                exceeding_len_of_intermediary = next_level > len(intermediate_level) - 1
                if self.update_type == PropUpdateType.ADD_TO_ITERABLE and exceeding_len_of_intermediary:
                    # self.update_value.key = curr_level
                    # self.update_value.index = next_level
                    return classes
                try:
                    sub_entity = intermediate_level[next_level]
                except IndexError as e:
                    raise IndexError(e)
                lvl += 1
        else:
            sub_entity = entity.props.get(curr_level)
            if sub_entity is None:
                raise ValueError("Unable to trace nested object path")

        if isinstance(sub_entity, Entity) is False:
            # insert_key = curr_level
            # self.update_value.key = insert_key
            # if isinstance(next_level, int):
            #     self.update_value.index = next_level
            #     self.update_value.len = len(sub_entity)

            return classes

        if next_level is not None:
            classes.append(((curr_level, next_level), sub_entity.name))
        else:
            classes.append((curr_level, sub_entity.name))

        self._resolve_classes(sub_entity, classes, lvl + 1)

        return classes

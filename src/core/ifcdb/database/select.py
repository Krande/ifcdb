from __future__ import annotations

from dataclasses import dataclass
from enum import Enum
from typing import ClassVar

from ifcdb.entities import Entity


class FilterType(Enum):
    STR = "str"
    UUID = "uuid"


@dataclass
class EdgeFilter:
    key: str
    value: str
    value_type: FilterType

    def to_edql_str(self):
        return f"FILTER .{self.key}=<{self.value_type.value}>'{self.value}'"


@dataclass
class EdgeSelect:
    name: str

    entity_top: Entity | EdgeSelect
    entity_path: str | None
    entity_index: int = None

    assert_class: str = None
    is_multi_link: bool = False
    filter: EdgeFilter = None

    use_agg_array: ClassVar[bool] = False

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

    def to_edql_str(self, assign_to_variable=True, sep=","):
        select_str = "select "
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
class SelectResolver:
    root_object: Entity
    classes: list[str]

    def resolve_selects(self) -> list[EdgeSelect]:
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

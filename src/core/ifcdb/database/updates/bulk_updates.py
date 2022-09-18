from __future__ import annotations

from dataclasses import dataclass, field
from itertools import count
from typing import TYPE_CHECKING, Any

from ifcdb.database.inserts import EdgeInsert
from ifcdb.database.select import EdgeSelect
from ifcdb.diffing.diff_types import PropUpdateType
from ifcdb.entities import Entity
from ifcdb.utils import change_case

if TYPE_CHECKING:
    from ifcdb.diffing.tool import ValueChange


_UPDATE_VAR = count(1)


@dataclass
class EdgeUpdate:
    select_obj: EdgeSelect | EdgeInsert
    update_value: EntityUpdateValue = None
    name: str = None

    def __post_init__(self):
        if self.name is None:
            self.name = f"{change_case(self.select_obj.name)}_{next(_UPDATE_VAR)}"

    def to_edql_str(self, assign_to_variable=False, indent=2 * " ", sep=",\n"):
        update_str = indent + f"UPDATE {self.select_obj.name}\n{2 * indent}" + "SET {\n"
        update_str += 3 * indent + self.update_value.to_edql_str()
        update_str += 2 * indent + "}\n"

        if assign_to_variable:
            return f"{indent}{self.name} := ({update_str}){sep}"
        else:
            return update_str


@dataclass
class EntityUpdateValue:
    value: Any
    old_value: Any
    prop_update_type: PropUpdateType

    key: str = None

    # Optional params relevant only for tuple insertions
    index: int | None = None
    len: int | None = None

    def to_edql_str(self) -> str:
        if self.key is None:
            raise ValueError("Key cannot be zero")

        if isinstance(self.value, EdgeInsert):
            value = f"({self.value.name})"
        else:
            value = self.value

        edql_str = ""

        if self.prop_update_type == PropUpdateType.UPDATE:
            assignment_type = ":="
        elif self.prop_update_type == PropUpdateType.ADD_TO_ITERABLE:
            assignment_type = "+="
        elif self.prop_update_type == PropUpdateType.REMOVE_FROM_ITERABLE:
            assignment_type = "-="
        else:
            raise NotImplementedError(f"Unsupported assignment type '{self.prop_update_type}'")

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
            edql_str += f"{self.key} {assignment_type} {array_str}\n"
        else:
            edql_str += f"{self.key} {assignment_type} {value}\n"

        return edql_str


@dataclass
class EntityPropUpdate:
    root_object: Entity
    property_path: str = field(repr=False)
    update_value: EntityUpdateValue
    update_type: PropUpdateType
    selects: list[EdgeSelect]


@dataclass
class BulkEntityAppend:
    updates: list[EntityPropUpdate]


@dataclass
class BulkEntityUpdate:
    updates: list[EntityPropUpdate]

    global_with_selects: dict[str, EdgeSelect] = field(default_factory=dict)
    select_items: list[EdgeSelect] = field(default_factory=list)
    all_select_items: list[EdgeSelect] = field(default_factory=list)
    indent: str = 2 * " "

    def __post_init__(self):
        for u in self.updates:
            self.select_items.append(u.selects[-1])
            for s in u.selects:
                if s in self.all_select_items:
                    continue
                self.all_select_items.append(s)

    def _get_unique_entities(self) -> dict[str, list[EdgeSelect]]:
        unique_entity_paths = dict()
        select_chunks = [update.selects[:-1] for update in self.updates]
        for update_list in select_chunks:
            for select_object in update_list:
                epath = select_object.get_absolute_path()
                if epath not in unique_entity_paths.keys():
                    unique_entity_paths[epath] = []
                unique_entity_paths[epath].append(select_object)

        return unique_entity_paths

    def resolve_global_with_statements(self):
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
        self.resolve_global_with_statements()
        if len(self.global_with_selects.keys()) == 0:
            return ""
        global_wstr = "with\n"
        for key, value in self.global_with_selects.items():
            global_wstr += "    " + value.to_edql_str() + "\n"
        return global_wstr

    def _change_property_str(self, select_item: EdgeSelect, prop_update: EntityPropUpdate, path_ref_map):
        parent_abs_path = select_item.entity_top.get_absolute_path()
        parent_object = path_ref_map.get(parent_abs_path)

        if select_item.entity_top != parent_object:
            select_item.entity_top = parent_object

        eu = EdgeUpdate(select_item, prop_update.update_value)
        edql_str = eu.to_edql_str()

        return edql_str

    def _append_property_str(self, insert_item: EdgeSelect, prop_update: EntityPropUpdate, path_ref_map) -> str:

        entity = prop_update.update_value.value
        if isinstance(entity, EdgeInsert):
            select_str = entity.name
        else:
            select_str = f"select {entity.class_name} FILTER .GlobalId=<str>'{entity.guid}'"

        edql_str = 2 * self.indent + f"UPDATE {insert_item.name}\n{2 * self.indent}" + "SET {\n"
        edql_str += 3 * self.indent + f"{prop_update.update_value.key} += ({select_str})\n"
        edql_str += 2 * self.indent + "}\n"

        return edql_str

    def _remove_property_str(self, insert_item: EdgeSelect, prop_update: EntityPropUpdate, path_ref_map):

        entity = prop_update.update_value.old_value
        guid = entity.props.get("GlobalId")
        key = prop_update.selects[-1].entity_path

        select_str = f"select {entity.name} FILTER .GlobalId=<str>'{guid}'"

        edql_str = 2 * self.indent + f"UPDATE {insert_item.name}\n{2 * self.indent}" + "SET {\n"
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

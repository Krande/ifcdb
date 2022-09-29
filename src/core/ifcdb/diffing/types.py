from __future__ import annotations

from dataclasses import dataclass
from enum import Enum
from typing import TYPE_CHECKING, Any

import ifcopenshell

if TYPE_CHECKING:
    from ifcdb.entities import Entity

_ifc_ent = ifcopenshell.entity_instance


class PropUpdateType(Enum):
    UPDATE = "values_changed"
    ADD_TO_ITERABLE = "iterable_item_added"
    REMOVE_FROM_ITERABLE = "iterable_item_removed"
    DICT_ITEM_ADDED = 'dictionary_item_added'

    @staticmethod
    def get_prop_type(key: str) -> PropUpdateType:
        keymap = {e.value: e for e in PropUpdateType}
        return keymap.get(key)


@dataclass
class ValueChange:
    path: str
    new_value: Any
    key: int | str
    index: int = None
    tuple_len: int = None


@dataclass
class ValueAddedToIterable:
    path: str
    new_entity: Entity
    key: str
    owning_entity: Entity


@dataclass
class ValueRemovedFromIterable:
    path: str
    entity: Entity
    key: str
    owning_entity: Entity

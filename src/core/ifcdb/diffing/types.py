from __future__ import annotations

from dataclasses import dataclass
from enum import Enum
from typing import TYPE_CHECKING, Any

import ifcopenshell

if TYPE_CHECKING:
    from ifcdb.entities import Entity

_ifc_ent = ifcopenshell.entity_instance


class PropUpdateType(Enum):
    UPDATE = "update"
    ADD_TO_ITERABLE = "add_to_iterable"
    REMOVE_FROM_ITERABLE = "remove_from_iterable"

    @staticmethod
    def get_prop_type(key: str) -> PropUpdateType:
        keymap = dict(
            iterable_item_added=PropUpdateType.ADD_TO_ITERABLE,
            values_changed=PropUpdateType.UPDATE,
            iterable_item_removed=PropUpdateType.REMOVE_FROM_ITERABLE,
        )

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

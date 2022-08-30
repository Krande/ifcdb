from __future__ import annotations

import ifcopenshell
from dataclasses import dataclass

from ifcdb.database.inserts.model import InsertBase

_IFC_ENTITY = ifcopenshell.entity_instance


@dataclass
class InsertSeq(InsertBase):
    def create_bulk_insert_str(self, ifc_items: list[_IFC_ENTITY], silent=False) -> tuple[_IFC_ENTITY, str]:
        for i, item in enumerate(ifc_items, start=1):
            if self.specific_ifc_ids is not None and item.id() not in self.specific_ifc_ids:
                continue
            if silent is False:
                print(f'inserting ifc item ({i} of {len(ifc_items)}) "{item}"')
            yield item, self.create_entity_insert_str(item)

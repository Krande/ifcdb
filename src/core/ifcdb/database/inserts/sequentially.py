from __future__ import annotations

from dataclasses import dataclass

import ifcopenshell

from ifcdb.database.inserts.base import EdgeInsert
from ifcdb.database.inserts.seq_model import InsertBase

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

    def create_bulk_entity_inserts(self, ifc_items: list[_IFC_ENTITY], silent=False) -> list[EdgeInsert]:
        from ifcdb.entities import EntityResolver

        er = EntityResolver(self.ifc_schema)
        res = er.create_ordered_insert_entities_from_multiple_entities(ifc_items)
        return [EdgeInsert(r) for r in res]

from __future__ import annotations

import json
from dataclasses import dataclass, field

import edgedb
import ifcopenshell

from ifcdb.schema.model import IfcSchemaModel
from ifcdb.database.utils import get_att_insert_str


@dataclass
class SeqInsert:
    ifc_schema: str
    ifc_items: [ifcopenshell.entity_instance]
    specific_ifc_ids: list[int] = None

    _uuid_map: dict[ifcopenshell.entity_instance, str] = field(default_factory=dict)
    _ism: IfcSchemaModel = None

    def __post_init__(self):
        self._ism = IfcSchemaModel(schema_version=self.ifc_schema)

    def create_insert_str(self):
        for i, item in enumerate(self.ifc_items, start=1):
            if self.specific_ifc_ids is not None and item.id() not in self.specific_ifc_ids:
                continue

            entity = self._ism.get_entity_by_name(item.is_a())
            all_atts = entity.get_entity_atts(item)
            print(f'inserting ifc item ({i} of {len(self.ifc_items)}) "{item}"')
            # INSERT block
            with_map = dict()
            insert_str = f"SELECT (INSERT {entity.name} {{\n    "
            for j, att in enumerate(all_atts):
                att_str = get_att_insert_str(att, item, self._ism, uuid_map=self._uuid_map, with_map=with_map)
                if j == len(all_atts) - 1:
                    comma_str = ""
                else:
                    comma_str = ",\n    "

                insert_str += att_str + comma_str
            insert_str += "\n   }\n)"

            with_str = "WITH\n" if len(with_map.keys()) > 0 else ""
            for key, value in with_map.items():
                with_str += 4 * " " + f"{key} := {value},\n"

            total_insert_str = with_str + insert_str
            yield item, total_insert_str
            print(total_insert_str)

    def insert(self, tx: edgedb.blocking_client):
        for item, insert_str in self.create_insert_str():
            query_res = json.loads(tx.query_single_json(insert_str))
            self._uuid_map[item] = query_res["id"]

    async def insert_async(self, tx: edgedb.asyncio_client.AsyncIOIteration):
        for item, insert_str in self.create_insert_str():
            single_json = tx.query_single_json(insert_str)
            query_res = json.loads(single_json)
            self._uuid_map[item] = query_res["id"]

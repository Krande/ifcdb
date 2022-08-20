from __future__ import annotations

import json
from dataclasses import dataclass

import edgedb
import ifcopenshell

from ifcdb.edge_model.query.utils import get_att_insert_str
from ifcdb.edge_model.schema_gen.model import SchemaGen


def create_insert_str(ifc_items, em: SchemaGen, specific_ifc_ids, uuid_map):
    for i, item in enumerate(ifc_items, start=1):
        if specific_ifc_ids is not None and item.id() not in specific_ifc_ids:
            continue

        entity = em.get_entity_by_name(item.is_a())
        all_atts = entity.get_entity_atts(item)
        print(f'inserting ifc item ({i} of {len(ifc_items)}) "{item}"')
        # INSERT block
        with_map = dict()
        insert_str = f"SELECT (INSERT {entity.name} {{\n    "
        for j, att in enumerate(all_atts):
            att_str = get_att_insert_str(att, item, em, uuid_map=uuid_map, with_map=with_map)
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


@dataclass
class SeqInsert:
    em: SchemaGen
    ifc_items: [ifcopenshell.entity_instance]
    specific_ifc_ids: list[int] = None

    def insert(self, tx: edgedb.blocking_client):
        uuid_map = dict()
        for item, insert_str in create_insert_str(self.ifc_items, self.em, self.specific_ifc_ids, uuid_map):
            query_res = json.loads(tx.query_single_json(insert_str))
            uuid_map[item] = query_res["id"]

    async def insert_async(self, tx: edgedb.asyncio_client.AsyncIOIteration):
        uuid_map = dict()
        for item, insert_str in create_insert_str(self.ifc_items, self.em, self.specific_ifc_ids, uuid_map):
            single_json = tx.query_single_json(insert_str)
            query_res = json.loads(single_json)
            uuid_map[item] = query_res["id"]

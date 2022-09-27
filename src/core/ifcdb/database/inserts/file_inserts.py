import edgedb
import json
import logging
import time
from typing import ClassVar

from .sequentially import InsertSeq


class INSERTS:
    SEQ: ClassVar[str] = "seq"


def insert_ifc_file(ifc_items, client: edgedb.Client, method: INSERTS, schema: str, limit_ifc_ids: list[int] = None):
    sq = InsertSeq(schema, specific_ifc_ids=limit_ifc_ids)
    start = time.time()
    for tx in client.transaction():
        with tx:
            if method == INSERTS.SEQ:
                insert_sequentially_using_new_insert_objects(sq, ifc_items, tx)
            else:
                raise NotImplementedError(f'Unrecognized IFC insert method "{method}". ')
    end = time.time()
    print(f'Upload finished in "{end - start:.2f}" seconds')


def safe_insert(insert_str: str, tx: edgedb.blocking_client.Iteration) -> str:
    try:
        single_json = tx.query_single_json(insert_str)
    except Exception as e:
        logging.exception(insert_str)
        raise e
    print(insert_str, single_json)
    return single_json


def insert_sequentially_using_new_insert_objects(sq: InsertSeq, ifc_items, tx: edgedb.blocking_client.Iteration):
    inserts = sq.create_bulk_entity_inserts(ifc_items=ifc_items)
    skipped_map = dict()
    for insert in inserts:
        if insert.entity.props.get("wrappedValue", None) is not None:
            skipped_map[insert.entity.temp_unique_identifier] = insert
            continue

        links = insert.entity.links
        wrapped = {}
        for key, value in links.items():
            if isinstance(value, tuple):
                continue
            wrapped_value = value.props.get("wrappedValue", None)
            if wrapped_value is None:
                continue
            wrapped[key] = value

        if len(wrapped) > 0:
            for key, value in wrapped.items():
                insert.entity.links[key] = skipped_map.get(value.temp_unique_identifier).entity

        insert_str = insert.to_edql_str(assign_to_variable=False)
        query_res = json.loads(safe_insert(insert_str, tx))
        insert.entity.uuid = query_res["id"]
        # print(insert_str)


def insert_using_old_insert_method(sq: InsertSeq, ifc_items, tx: edgedb.blocking_client.Iteration):
    for item, insert_str in sq.create_bulk_insert_str(ifc_items):
        try:
            single_json = tx.query_single_json(insert_str)
        except edgedb.errors.InvalidLinkTargetError as e:
            logging.error(insert_str)
            raise edgedb.errors.InvalidLinkTargetError(e)
        query_res = json.loads(single_json)
        sq.uuid_map[item] = query_res["id"]

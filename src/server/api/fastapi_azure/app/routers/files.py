from __future__ import annotations

from http import HTTPStatus

import json
from fastapi import APIRouter, Depends, Security
from fastapi_azure_auth.user import User

from app.dependencies import azure_scheme
from app.internal.database import get_client
from ifcdb import EdgeIO
from ifcdb.database.inserts.sequentially import SeqInsert
from ifcdb.io.ifc import IfcIO

router = APIRouter()


@router.get("/file", status_code=HTTPStatus.CREATED, dependencies=[Security(azure_scheme)])
async def get_file_str(dbname: str, class_filter: list[str] = None) -> str:
    client = get_client(database=dbname)
    with EdgeIO(client=client, database=dbname) as io:
        return io.to_ifc_str(specific_classes=class_filter)


@router.post("/file", status_code=HTTPStatus.CREATED, dependencies=[Security(azure_scheme)])
async def post_file_str(ifc_file_str: str, user: User = Depends(azure_scheme), dbname: str = None) -> str:
    client = get_client(database=dbname)
    ifc_io = IfcIO(ifc_str=ifc_file_str)

    sq = SeqInsert(ifc_io.schema)
    for tx in client.transaction():
        with tx:
            for item, insert_str in sq.create_bulk_insert_str(ifc_io.get_ifc_objects_by_sorted_insert_order_flat()):
                single_json = tx.query_single_json(insert_str)
                query_res = json.loads(single_json)
                sq._uuid_map[item] = query_res["id"]

    return "SUCCESS"

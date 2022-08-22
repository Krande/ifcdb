from __future__ import annotations

import json
from http import HTTPStatus

from app.dependencies import azure_scheme
from app.internal.database import get_client
from fastapi import APIRouter, Depends, Security
from fastapi_azure_auth.user import User

from ifcdb.io.ifc import IfcIO
from ifcdb.database.inserts.sequentially import SeqInsert

router = APIRouter()


@router.get("/file", status_code=HTTPStatus.CREATED, dependencies=[Security(azure_scheme)])
async def get_file_str(user: User = Depends(azure_scheme), dbname: str = None, id_filter: list[str] = None) -> str:
    return "Not Implemented"


@router.post("/file", status_code=HTTPStatus.CREATED, dependencies=[Security(azure_scheme)])
async def post_file_str(ifc_file_str: str, user: User = Depends(azure_scheme), dbname: str = None) -> str:
    client = get_client(database=dbname)
    ifc_io = IfcIO(ifc_str=ifc_file_str)

    sq = SeqInsert(ifc_io.schema, ifc_io.get_ifc_objects_by_sorted_insert_order_flat())
    for tx in client.transaction():
        with tx:
            for item, insert_str in sq.create_insert_str():
                single_json = tx.query_single_json(insert_str)
                query_res = json.loads(single_json)
                sq._uuid_map[item] = query_res["id"]

    return "SUCCESS"

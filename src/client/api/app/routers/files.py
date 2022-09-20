from __future__ import annotations

import json
from http import HTTPStatus

from app.dependencies import azure_scheme
from app.internal.database import get_client
from fastapi import APIRouter, Depends, Security, UploadFile
from fastapi_azure_auth.user import User

from ifcdb import EdgeIO
from ifcdb.database.inserts.sequentially import InsertSeq
from ifcdb.io.ifc import IfcIO

router = APIRouter()


@router.get("/file", status_code=HTTPStatus.CREATED, dependencies=[Security(azure_scheme)])
async def get_file_str(dbname: str, class_filter: list[str] = None) -> str:
    client = get_client(database=dbname)
    with EdgeIO(client=client, database_name=dbname) as io:
        return io.to_ifc_str(specific_classes=class_filter)


@router.post("/file", status_code=HTTPStatus.CREATED, dependencies=[Security(azure_scheme)])
async def post_file_str(ifc_file_str: str, user: User = Depends(azure_scheme), dbname: str = None) -> str:
    client = get_client(database=dbname)
    ifc_io = IfcIO(ifc_str=ifc_file_str)

    sq = InsertSeq(ifc_io.schema)
    for tx in client.transaction():
        with tx:
            for item, insert_str in sq.create_bulk_insert_str(ifc_io.get_ifc_objects_by_sorted_insert_order_flat()):
                single_json = tx.query_single_json(insert_str)
                query_res = json.loads(single_json)
                sq.uuid_map[item] = query_res["id"]

    return "SUCCESS"


@router.post("/fileb", status_code=HTTPStatus.CREATED, dependencies=[Security(azure_scheme)])
async def post_file(file: UploadFile, user: User = Depends(azure_scheme), dbname: str = None) -> str:
    ifc_str = await file.read()
    ifc_io = IfcIO(ifc_str=str(ifc_str, encoding="utf-8"))
    client = get_client(database=dbname)

    first_update = True
    with EdgeIO("ifc001", client=client) as io:
        existing_ifc_obj = io.to_ifcopenshell_object()
        if len(list(existing_ifc_obj.by_type("IfcRoot"))) > 0:
            io.update_db_from_ifc_delta(ifc_io.ifc_obj, existing_ifc_obj, resolve_overlinking=True)
            first_update = False

    if first_update is False:
        return "SUCCESS"

    sq = InsertSeq(ifc_io.schema)
    for tx in client.transaction():
        with tx:
            for item, insert_str in sq.create_bulk_insert_str(ifc_io.get_ifc_objects_by_sorted_insert_order_flat()):
                single_json = tx.query_single_json(insert_str)
                query_res = json.loads(single_json)
                sq.uuid_map[item] = query_res["id"]

    return "SUCCESS"

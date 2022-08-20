from __future__ import annotations

from http import HTTPStatus

from app.dependencies import azure_scheme
from app.internal.database import get_client
from fastapi import APIRouter, Depends, Security
from fastapi_azure_auth.user import User

from ifcdb import EdgeIO

router = APIRouter()


@router.get("/file", status_code=HTTPStatus.CREATED, dependencies=[Security(azure_scheme)])
async def get_file_str(user: User = Depends(azure_scheme), dbname: str = None, id_filter: list[str] = None) -> str:
    client = get_client(database=dbname)
    with EdgeIO(_client=client) as io:
        return io.to_ifc_str()


@router.post("/file", status_code=HTTPStatus.CREATED, dependencies=[Security(azure_scheme)])
async def post_file_str(ifc_file_str: str, user: User = Depends(azure_scheme), dbname: str = None) -> str:
    client = get_client(database=dbname)

    io = EdgeIO(_client=client)
    await io.insert_ifc_async(ifc_file_str=ifc_file_str)

    return "SUCCESS"

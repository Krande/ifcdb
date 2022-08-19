from __future__ import annotations

from http import HTTPStatus

import edgedb
from fastapi import APIRouter, Depends, Security
from fastapi_azure_auth.user import User

from app.dependencies import azure_scheme
from ifcdb import EdgeIO
from io import StringIO

router = APIRouter()


@router.get("/file", status_code=HTTPStatus.CREATED, dependencies=[Security(azure_scheme)])
async def get_file_str(user: User = Depends(azure_scheme), dbname: str = None, id_filter: list[str] = None) -> str:
    with EdgeIO(database=dbname) as io:
        return io.to_ifc_str()


@router.post("/file", status_code=HTTPStatus.CREATED, dependencies=[Security(azure_scheme)])
async def post_file_str(ifc_file_str: str, user: User = Depends(azure_scheme), dbname: str = None) -> str:
    with EdgeIO(database=dbname) as io:
        io.insert_ifc(ifc_file_str=ifc_file_str)

    return "SUCCESS"

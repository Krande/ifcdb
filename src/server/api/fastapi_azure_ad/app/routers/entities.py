from __future__ import annotations

from http import HTTPStatus

import edgedb
from app.dependencies import azure_scheme
from fastapi import APIRouter, Depends, Security
from fastapi_azure_auth.user import User
from pydantic import BaseModel

router = APIRouter()


class IfcGeneric(BaseModel):
    class_name: str
    global_id: str
    props: dict
    links: dict[str, IfcGeneric]


@router.get("/entities", status_code=HTTPStatus.CREATED, dependencies=[Security(azure_scheme)])
async def get_entities(
    user: User = Depends(azure_scheme), dbname: str = None, id_filter: list[str] = None
) -> list[IfcGeneric]:
    pass


@router.post("/entities", status_code=HTTPStatus.CREATED, dependencies=[Security(azure_scheme)])
async def post_entities(
    ifc_generic: list[IfcGeneric], user: User = Depends(azure_scheme), dbname: str = None
) -> list[IfcGeneric]:
    keys = []
    key_value_str = "GlobalId:=<str>$GlobalId,\n"
    for key in ifc_generic.props.keys():
        key_value_str += f"{key}:=<str>${key},\n"

    insert_str = f"""SELECT (
    INSERT {ifc_generic.class_name} {{
        {key_value_str}
    }})
) {{ {keys} }};"""

    client = edgedb.create_async_client(database=dbname)
    (created_entity,) = await client.query(insert_str, **ifc_generic.props)

    response = IfcGeneric(
        FamilyName=created_entity.FamilyName,
        GivenName=created_entity.GivenName,
        Identification=created_entity.Identification,
    )
    return response

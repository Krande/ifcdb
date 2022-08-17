from __future__ import annotations

from http import HTTPStatus

import edgedb
from app.dependencies import azure_scheme
from fastapi import APIRouter, Depends, Security
from fastapi_azure_auth.user import User
from pydantic import BaseModel

router = APIRouter()


class IfcGeneric(BaseModel):
    ifc_class: str
    props: dict
    global_id: str


@router.post("/entities", status_code=HTTPStatus.CREATED, dependencies=[Security(azure_scheme)])
async def post_entities(ifc_generic: IfcGeneric, user: User = Depends(azure_scheme), dbname: str = None) -> IfcGeneric:
    client = edgedb.create_async_client(database=dbname)

    keys = []
    key_value_str = "GlobalId:=<str>$GlobalId,\n"
    for key in ifc_generic.props.keys():
        key_value_str += f"{key}:=<str>${key},\n"

    insert_str = f"""SELECT (
    INSERT {ifc_generic.ifc_class} {{
        {key_value_str}
    }})
) {{ {keys} }};"""

    (created_entity,) = await client.query(insert_str, **ifc_generic.props)

    response = IfcGeneric(
        FamilyName=created_entity.FamilyName,
        GivenName=created_entity.GivenName,
        Identification=created_entity.Identification,
    )
    return response

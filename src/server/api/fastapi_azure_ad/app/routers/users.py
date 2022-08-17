from __future__ import annotations

from http import HTTPStatus

import edgedb
from fastapi import APIRouter, Depends, HTTPException, Query, Security
from fastapi_azure_auth.user import User
from pydantic import BaseModel
from typing import Iterable

from app.dependencies import azure_scheme

router = APIRouter()


class IfcPerson(BaseModel):
    FamilyName: str = None
    GivenName: str = None
    Identification: str = None
    MiddleNames: tuple[str] = None
    PrefixTitles: tuple[str] = None
    SuffixTitles: tuple[str] = None
    Roles: dict = None
    Addresses: dict = None


IFCP_CONTENT = "FamilyName, GivenName, Identification, Roles, Addresses"

################################
# Get users
################################


@router.get("/users", dependencies=[Security(azure_scheme)])
async def get_users(name: str = Query(None, max_length=50), dbname: str = None) -> Iterable[IfcPerson]:
    client = edgedb.create_async_client(database=dbname)
    if not name:
        users = await client.query(f"SELECT IfcPerson {IFCP_CONTENT};")
    else:
        users = await client.query(
            f"""SELECT IfcPerson {IFCP_CONTENT} FILTER IfcPerson.GivenName=<str>$name""",
            name=name,
        )
    response = (
        IfcPerson(
            FamilyName=user.FamilyName,
            GivenName=user.GivenName,
            Identification=user.Identification,
            Roles=user.Roles,
            Addresses=user.Addresses,
        )
        for user in users
    )
    return response


################################
# Create users
################################


@router.post("/users", status_code=HTTPStatus.CREATED, dependencies=[Security(azure_scheme)])
async def post_user(user: User = Depends(azure_scheme), dbname: str = None) -> IfcPerson:
    client = edgedb.create_async_client(database=dbname)

    (created_user,) = await client.query(
        """SELECT (
    INSERT IfcPerson {
        FamilyName:=<str>$FamilyName, 
        GivenName:=<str>$GivenName,
        Identification:=<str>$Identification
    } 
    unless conflict on .Identification else (
        update IfcPerson
        set {
            FamilyName:=<str>$FamilyName, GivenName:=<str>$GivenName
        }
    )
) {FamilyName, GivenName, Identification, Roles, Addresses};""",
        FamilyName=user.name,
        GivenName=user.name,
        Identification=user.claims["preferred_username"],
    )

    response = IfcPerson(
        FamilyName=created_user.FamilyName,
        GivenName=created_user.GivenName,
        Identification=created_user.Identification,
    )
    return response


################################
# Update users
################################


@router.put("/users", dependencies=[Security(azure_scheme)])
async def put_user(user: IfcPerson, identification_name: str, dbname: str = None) -> Iterable[IfcPerson]:
    client = edgedb.create_async_client(database=dbname)
    try:
        updated_users = await client.query(
            """
            SELECT (
                UPDATE IfcPerson FILTER .Identification=<str>$filter_name
                SET {FamilyName:=<str>$name}
            ) {FamilyName, GivenName, Identification, Roles, Addresses};
            """,
            family_name=user.FamilyName,
            given_name=user.GivenName,
            filter_name=identification_name,
        )
    except edgedb.errors.ConstraintViolationError:
        raise HTTPException(
            status_code=HTTPStatus.BAD_REQUEST,
            detail={"error": f"Username '{identification_name}' already exists."},
        )

    response = (IfcPerson(name=user.name, created_at=user.created_at) for user in updated_users)
    return response


################################
# Delete users
################################


@router.delete("/users", dependencies=[Security(azure_scheme)])
async def delete_user(id_name: str, dbname: str = None) -> Iterable[IfcPerson]:
    client = edgedb.create_async_client(database=dbname)
    try:
        deleted_users = await client.query(
            """SELECT (
                DELETE IfcPerson FILTER .Identification=<str>$name
            ) {FamilyName, GivenName, Identification, Roles, Addresses};
            """,
            name=id_name,
        )
    except edgedb.errors.ConstraintViolationError:
        raise HTTPException(
            status_code=HTTPStatus.BAD_REQUEST,
            detail={"error": "User attached to an event. Cannot delete."},
        )

    response = (
        IfcPerson(
            FamilyName=deleted_user.FamilyName,
            GivenName=deleted_user.GivenName,
            Identification=deleted_user.Identification,
        )
        for deleted_user in deleted_users
    )

    return response
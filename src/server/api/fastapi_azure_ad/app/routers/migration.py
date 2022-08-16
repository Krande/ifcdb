from __future__ import annotations

import logging
import os
import pathlib
from http import HTTPStatus

import edgedb
from app.dependencies import azure_scheme
from fastapi import APIRouter, Security
from pydantic import BaseModel

router = APIRouter()


class MigrationData(BaseModel):
    name: str
    success: bool


@router.post("/migrate", dependencies=[Security(azure_scheme)], status_code=HTTPStatus.CREATED)
async def initial_migration(db_name: str = None) -> MigrationData:
    top_dir = get_top_dir()

    print("Migrating schema to fresh database")
    # Extend wait time to give docker compose setup enough time to start
    client = edgedb.create_client()
    if db_name is not None:
        try:
            print(f"Dropping database {db_name}")
            client.execute(f"DROP database {db_name}")
        except edgedb.errors.UnknownDatabaseError as e:
            logging.debug(e)

        client.execute(f"CREATE DATABASE {db_name}")
        client.close()

        client = edgedb.create_client(database=db_name)

    migrations_dir = pathlib.Path(top_dir / "config/schema/basic/dbschema/migrations")
    for migration_file in os.listdir(migrations_dir):
        with open(migrations_dir / str(migration_file), "r") as f:
            migration_body = f.read()
            client.execute(migration_body)
    client.close()
    print("Migration complete")

    return MigrationData(name=db_name, success=True)


def get_top_dir() -> pathlib.Path:
    path = pathlib.Path(__file__)
    top_level_dirs = {"app", "config", "scripts"}
    for p in path.parents:
        if top_level_dirs.intersection(set(os.listdir(p))) == {"config", "app", "scripts"}:
            return p

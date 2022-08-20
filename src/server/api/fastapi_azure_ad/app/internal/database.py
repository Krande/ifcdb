import os

import edgedb


def _get_props(database: str) -> dict:
    props = dict(database=database)
    # Use a default username/password. It seems logging into edgedb ui is not possible without it.
    user = os.getenv("EDGEDB_USER")
    pwd = os.getenv("EDGEDB_PASSWORD")
    if user is None:
        props["user"] = "ifcdbadmin"
        props["host"] = "localhost"
        props["port"] = "5656"
        props["tls_security"] = "insecure"
    if pwd is None:
        props["password"] = "secret"

    return props


def get_async_client(database: str) -> edgedb.AsyncIOClient:
    return edgedb.create_async_client(**_get_props(database))


def get_client(database: str) -> edgedb.Client:
    return edgedb.create_client(**_get_props(database))

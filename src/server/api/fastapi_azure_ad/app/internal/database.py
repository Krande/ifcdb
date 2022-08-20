import os

import edgedb


def get_client(database: str) -> edgedb.AsyncIOClient:
    props = dict(database=database)
    # Use a default username/password. It seems logging into edgedb ui is not possible without it.
    user = os.getenv("EDGEDB_USER")
    pwd = os.getenv("EDGEDB_PASSWORD")
    if user is None:
        props["user"] = "ifcdbadmin"
    if pwd is None:
        props["password"] = "secret"
    return edgedb.create_async_client(**props)

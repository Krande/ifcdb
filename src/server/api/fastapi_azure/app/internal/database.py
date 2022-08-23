import edgedb


def get_async_client(database: str) -> edgedb.AsyncIOClient:
    return edgedb.create_async_client(database=database)


def get_client(database: str) -> edgedb.Client:
    return edgedb.create_client(database=database)

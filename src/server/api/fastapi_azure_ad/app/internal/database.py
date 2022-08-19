import edgedb


def get_client(database: str) -> edgedb.AsyncIOClient:

    return edgedb.create_async_client(database=database)

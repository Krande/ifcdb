import os

from ifcdb import EdgeIO


def main():
    props = dict(ifc_schema="IFC4x1")
    cred_file = os.getenv("IFCDB_LOCAL_CRED")
    database = os.getenv("IFCDB_DB_NAME")
    batch_size = os.getenv("IFCDB_BATCH_SIZE")

    if cred_file is not None:
        props["credentials_file"] = cred_file

    if database is not None:
        props["database"] = database

    migrate_props = dict(batch_size=600)
    if batch_size is not None:
        migrate_props["batch_size"] = int(batch_size)

    io = EdgeIO(**props)
    io.stepwise_migration(**migrate_props)


if __name__ == "__main__":
    main()

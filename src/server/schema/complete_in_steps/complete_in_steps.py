import os

from ifcdb import EdgeIO


def main():
    props = dict(ifc_schema="IFC4x1")
    cred_file = os.getenv("IFCDB_LOCAL_CRED")
    database = os.getenv("IFCDB_DB_NAME")
    if cred_file is not None:
        props["credentials_file"] = cred_file

    if database is not None:
        props["database"] = database

    io = EdgeIO(**props)
    io.stepwise_migration(batch_size=300)


if __name__ == "__main__":
    main()

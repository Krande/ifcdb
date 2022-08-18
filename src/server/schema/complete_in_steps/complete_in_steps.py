import os

from ifcdb import EdgeIO


def main():
    props = dict(ifc_schema="IFC4x1", )
    cred_file = os.getenv('IFCDB_LOCAL_CRED')
    if cred_file is not None:
        props["credentials_file"] = cred_file
    io = EdgeIO(**props)
    io.stepwise_migration(batch_size=300)


if __name__ == "__main__":
    main()

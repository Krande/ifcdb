from shared import ADD_CLASSES, FILES

from ifcdb import EdgeIO
from ifcdb.utils import top_dir


def main(database: str, ifc_file: list[str], extra_ifc_classes: list[str]):
    ifc_paths = [top_dir() / "files" / f for f in ifc_file]
    with EdgeIO(database_name=database, load_env=True) as io:
        io.create_schema_from_ifc_file(ifc_path=ifc_paths, extra_entities=extra_ifc_classes)
        # io.setup_database(delete_existing_migrations=True)


if __name__ == "__main__":
    main("ifc001", FILES, ADD_CLASSES)

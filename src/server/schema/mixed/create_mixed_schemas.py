from dotenv import load_dotenv

from ifcdb import EdgeIO
from ifcdb.utils import top_dir
from shared import FILES, ADD_CLASSES

load_dotenv()  # take environment variables from .env.


def main(database: str, ifc_file: list[str], extra_ifc_classes: list[str]):
    ifc_paths = [top_dir() / "files" / f for f in ifc_file]
    with EdgeIO(database=database) as io:
        io.create_schema_from_ifc_file(ifc_path=ifc_paths, extra_entities=extra_ifc_classes)
        io.setup_database(delete_existing_migrations=True)


if __name__ == "__main__":
    main("ifc002", FILES, ADD_CLASSES)

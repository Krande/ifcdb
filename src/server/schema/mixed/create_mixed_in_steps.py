from dotenv import load_dotenv

from shared import FILES, ADD_CLASSES
from ifcdb import EdgeIO
from ifcdb.utils import top_dir

load_dotenv()  # take environment variables from .env.


def main(database: str, ifc_schema: str, batch_size: int, ifc_files: list[str], extra_entities: list[str]):
    ifc_paths = [top_dir() / "files" / f for f in ifc_files]
    with EdgeIO(database) as io:
        entities = io.get_entities_from_ifc_files(ifc_paths)
        entities += extra_entities
        io.create_database()
        io.stepwise_migration(ifc_schema_ver=ifc_schema, entities=entities, batch_size=batch_size)


if __name__ == "__main__":
    main("ifc001", "IFC4x1", 50, FILES, ADD_CLASSES)

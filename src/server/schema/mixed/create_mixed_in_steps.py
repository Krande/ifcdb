from ifcdb import EdgeIO
from ifcdb.utils import top_dir
from shared import ADD_CLASSES, FILES


def main(database: str, ifc_schema: str, batch_size: int, ifc_files: list[str], extra_entities: list[str]):
    ifc_paths = [top_dir() / "files" / f for f in ifc_files]
    with EdgeIO(database, load_env=True) as io:
        entities = io.get_entities_from_ifc_files(ifc_paths)
        entities += extra_entities
        io.create_database()
        io.stepwise_migration(ifc_schema_ver=ifc_schema, entities=entities, batch_size=batch_size, begin_step=None)


if __name__ == "__main__":
    main("ifc001", "IFC4x1", 50, FILES, ADD_CLASSES)

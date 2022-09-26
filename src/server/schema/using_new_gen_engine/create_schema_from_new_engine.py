from ifcdb import EdgeIO
from ifcdb.utils import top_dir


def main(database: str, ifc_files: list[str], extra_entities: list[str] = None):
    ifc_paths = [top_dir() / "files" / f for f in ifc_files]
    with EdgeIO(database, load_env=True, use_new_schema_gen=True) as io:
        entities = io.get_entities_from_ifc_files(ifc_paths)
        if extra_entities is not None:
            entities += extra_entities

        io.create_schema(entities)
        io.setup_database()


if __name__ == "__main__":
    main("test", ["SimpleStru.ifc"])

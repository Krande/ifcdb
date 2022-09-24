from ifcdb import EdgeIO
from ifcdb.utils import top_dir


def main(database: str, ifc_schema: str, batch_size: int, ifc_files: list[str], extra_entities: list[str] = None):
    ifc_paths = [top_dir() / "files" / f for f in ifc_files]
    with EdgeIO(database, load_env=True) as io:
        entities = io.get_entities_from_ifc_files(ifc_paths)
        if extra_entities is not None:
            entities += extra_entities

        io.create_schema(entities, use_new_esdl_engine=False, module_name="old_engine")
        io.create_schema(entities, use_new_esdl_engine=True)


if __name__ == "__main__":
    main("simplestru", "IFC4x1", 50, ["SimpleStru.ifc"])

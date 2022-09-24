from ifcdb import EdgeIO
from ifcdb.utils import top_dir


def main(database: str, ifc_files: list[str], extra_entities: list[str] = None):
    ifc_paths = [top_dir() / "files" / f for f in ifc_files]
    with EdgeIO(database, load_env=True) as io:
        entities = io.get_entities_from_ifc_files(ifc_paths)
        if extra_entities is not None:
            entities += extra_entities

        # entities = io.schema_model.get_all_entities()
        # print(f"Old Engine: {len(entities)=}")
        # io.create_schema(entities, module_name="old_engine")

        # Test new engine
        db_resolver = io.schema_model.to_db_entity_resolver()
        db_resolver.resolve()
        print(f"New Engine: {len(db_resolver.db_entities)=}")
        db_resolver.to_esdl_file(io.db_schema_dir / "new_engine.esdl")
        # db_resolver.unwrap_enums()
        # print(f'after unwrapping enums: {len(db_resolver.db_entities)=}')
        # db_resolver.to_esdl_file(io.db_schema_dir / "new_engine_unwrap_enums.esdl")
        # db_resolver.unwrap_selects()
        # print(f'after unwrapping selects: {len(db_resolver.db_entities)=}')
        # db_resolver.to_esdl_file(io.db_schema_dir / "new_engine_unwrap_enums_selects.esdl")
        io.setup_database()


if __name__ == "__main__":
    main("simplestru", ["SimpleStru.ifc"])

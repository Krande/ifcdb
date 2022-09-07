from ifcdb import EdgeIO
from ifcdb.utils import top_dir


def main(ifc_file):
    db_name = ifc_file.replace(".ifc", "").replace("-", "_")
    ifc_path = top_dir() / "files" / ifc_file

    with EdgeIO(db_schema_dir=f"temp/{db_name}/dbschema", ifc_schema="IFC4x1", database_name=db_name) as io:
        if io.database_exists() is False:
            io.create_schema_from_ifc_file(ifc_path=ifc_path)
            io.setup_database(delete_existing_migrations=True)
            io.insert_ifc(ifc_path)

        # Queries
        result_by_name = io.get_by_name("MyBeam", top_level_only=True)
        result_by_id = io.get_by_global_id("3PXsnq_3qHxBd2w2f4ZOUQ", top_level_only=True)

        assert result_by_id == result_by_name


if __name__ == "__main__":
    main("MyBeam.ifc")

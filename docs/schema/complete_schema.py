from ifcdb import EdgeIO

with EdgeIO(db_schema_dir="temp/complete/dbschema", ifc_schema="IFC4x1", database_name="complete_db") as io:
    io.create_schema()
    io.setup_database(delete_existing_migrations=True)

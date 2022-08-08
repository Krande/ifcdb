# import pathlib
# import shutil
#
# from ifcdb import EdgeIO
#
#
# def test_roundtrip_ifc_files_validation(ifc_files_dir):
#     db_name = "complete"
#     db_schema_dir = pathlib.Path("temp").resolve().absolute() / db_name / "dbschema"
#     if db_schema_dir.exists():
#         shutil.rmtree(db_schema_dir)
#
#     with EdgeIO(ifc_schema="IFC4X1", db_schema_dir=db_schema_dir, database=db_name) as io:
#         io.setup_database(delete_existing_migrations=True)

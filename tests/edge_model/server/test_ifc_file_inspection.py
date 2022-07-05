import pathlib
import shutil

from ifcdb import EdgeIO


def test_roundtrip_ifc_files_validation(ifc_files_dir, em_ifc4x1):
    db_name = "ifc_file_inspection"
    ifc_file = ifc_files_dir / "cube-advanced-brep.ifc"

    db_schema_dir = pathlib.Path("temp").resolve().absolute() / db_name / "dbschema"
    if db_schema_dir.exists():
        shutil.rmtree(db_schema_dir)

    with EdgeIO(em=em_ifc4x1, db_schema_dir=db_schema_dir, database=db_name) as io:
        # Set up Schema & Database
        io.create_schema(from_ifc_file=ifc_file)
        io.setup_database(delete_existing_migrations=True)
        io.insert_ifc(ifc_file)

        result_by_id = io.get_by_global_id("3qzoyCPy1CtfV237Rle9$t")
        result_by_name = io.get_by_name("Grasshopper Building")

        assert result_by_id == result_by_name

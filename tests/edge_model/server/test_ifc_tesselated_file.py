import pathlib
import shutil

from ifcdb import EdgeIO
import pytest


@pytest.mark.parametrize("ifc_file_name", ["tessellated-item.ifc", "cube-advanced-brep.ifc"])
def test_roundtrip_ifc_tesselated(ifc_files_dir, em_ifc4x1, ifc_file_name):
    db_name = "tess_db"
    ifc_file = ifc_files_dir / ifc_file_name

    db_schema_dir = pathlib.Path("temp").resolve().absolute() / db_name / "dbschema"
    if db_schema_dir.exists():
        shutil.rmtree(db_schema_dir)

    with EdgeIO(ifc_file, em=em_ifc4x1, db_schema_dir=db_schema_dir, database=db_name) as io:
        # Set up Schema & Database
        io.create_schema_from_ifc_file()
        io.setup_database(delete_existing_migrations=True)

        # Insert IFC elements
        io.insert_ifc()

        # Query Data
        result = io.get_all(limit_to_ifc_entities=True)
        # io.export_ifc_elements_to_ifc_str()

        # Validate Data
        obj_set = {key: value for key, value in result[0].items() if len(value) != 0}

        # assert len(ifc_bld_proxy_elements) == len(result)

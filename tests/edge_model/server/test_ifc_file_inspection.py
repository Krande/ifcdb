import pathlib
import shutil

import pytest

from ifcdb import EdgeIO
from ifcdb.interop.edge_model.query_utils import validate_ifc_objects


def test_roundtrip_ifc_files_validation(ifc_files_dir, em_ifc4x1):
    db_name = "ifc_file_inspection"
    ifc_file = ifc_files_dir / "cube-advanced-brep.ifc"

    db_schema_dir = pathlib.Path("temp").resolve().absolute() / db_name / "dbschema"
    if db_schema_dir.exists():
        shutil.rmtree(db_schema_dir)

    with EdgeIO(ifc_file, em=em_ifc4x1, db_schema_dir=db_schema_dir, database=db_name) as io:
        # Set up Schema & Database
        io.create_schema(from_ifc_file=True)
        io.setup_database(delete_existing_migrations=True)
        io.insert_ifc()

        io.qu

import pathlib
import shutil

import pytest

from ifcdb import EdgeIO
from ifcdb.interop.edge_model.query_utils import validate_ifc_content, validate_ifc_objects


@pytest.mark.parametrize("ifc_file_name", ["tessellated-item.ifc", "cube-advanced-brep.ifc", "SpatialHierarchy1.ifc"])
def test_roundtrip_ifc_files_validation(ifc_files_dir, em_ifc4x1, ifc_file_name):
    db_name = ifc_file_name.replace(".ifc", "").replace("-", "_")
    ifc_file = ifc_files_dir / ifc_file_name

    db_schema_dir = pathlib.Path("temp").resolve().absolute() / db_name / "dbschema"
    if db_schema_dir.exists():
        shutil.rmtree(db_schema_dir)

    with EdgeIO(ifc_file, em=em_ifc4x1, db_schema_dir=db_schema_dir, database=db_name) as io:
        # Set up Schema & Database
        client = io.create_client()
        io.create_schema_from_ifc_file()
        io.setup_database(delete_existing_migrations=True)

        # Insert IFC elements
        for tx in client.transaction():
            with tx:
                io._insert_items_sequentially(tx)

        # Query & Validate Data using ifcopenshell objects only
        validate_ifc_objects(io.ifc_io.ifc_obj, io.to_ifcopenshell_object(client=client))

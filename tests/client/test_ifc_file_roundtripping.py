import pathlib
import shutil

import pytest

from ifcdb import EdgeIO
from ifcdb.validation_utils import validate_ifc_objects


@pytest.mark.parametrize(
    "ifc_file_name",
    [
        # "tessellated-item.ifc",
        # "cube-advanced-brep.ifc",
        # "SpatialHierarchy1.ifc",
        "MyBeamWithHoles.ifc",
    ],
)
def test_roundtrip_ifc_files_validation(ifc_files_dir, ifc_file_name):
    db_name = ifc_file_name.replace(".ifc", "").replace("-", "_")
    ifc_file = ifc_files_dir / ifc_file_name

    db_schema_dir = pathlib.Path("temp").resolve().absolute() / db_name / "dbschema"
    if db_schema_dir.exists():
        shutil.rmtree(db_schema_dir)

    with EdgeIO(db_schema_dir=db_schema_dir, database=db_name) as io:
        # Set up Schema & Database
        if io.database_exists() is False:
            io.create_schema_from_ifc_file(ifc_path=ifc_file)
            io.setup_database(delete_existing_migrations=True)

        # Insert IFC elements
        ifc_io = io.insert_ifc(ifc_file)

        # Query & Validate Data using IfcOpenShell
        ifc_obj = io.to_ifcopenshell_object()
        validate_ifc_objects(ifc_io.ifc_obj, ifc_obj)
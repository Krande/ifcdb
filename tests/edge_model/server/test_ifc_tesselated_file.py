import os
import pathlib
import shutil

from ifc_schema.interop.edge_model import EdgeIO


def test_roundtrip_ifc_tesselated(ifc_files_dir, em_ifc4x1, server_name):
    db_name = "tess_db"
    ifc_file = ifc_files_dir / "tessellated-item.ifc"

    db_schema_dir = pathlib.Path("temp") / db_name / "dbschema"
    if db_schema_dir.exists():
        shutil.rmtree(db_schema_dir)

    os.makedirs(db_schema_dir, exist_ok=True)

    with EdgeIO(
        ifc_file, em=em_ifc4x1, instance_name=server_name, database=db_name
    ) as io:
        # Set up Schema
        io.create_schema_from_ifc_file(db_schema_dir)
        io.setup_database(db_schema_dir)

        # Insert IFC elements
        io.insert_ifc()

        # Query Data
        result = io.get_all(limit_to_ifc_entities=True)
        io.export_ifc_elements_to_ifc_str()
        # assert len(ifc_bld_proxy_elements) == len(result)

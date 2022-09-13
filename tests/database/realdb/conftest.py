import pytest

from ifcdb import EdgeIO
from ifcdb.utils import top_dir


@pytest.fixture
def my_beam_4x1_db(root_dir):
    ifc_file = "MyBeam.ifc"
    db_name = ifc_file.replace(".ifc", "").replace("-", "_")
    ifc_path = top_dir() / "files" / ifc_file

    with EdgeIO(db_schema_dir=f"temp/{db_name}/dbschema", ifc_schema="IFC4x1", database_name=db_name) as io:
        io.create_schema_from_ifc_file(ifc_path=ifc_path)
        io.setup_database(delete_existing_migrations=True)
        io.insert_ifc(ifc_path)
        return io

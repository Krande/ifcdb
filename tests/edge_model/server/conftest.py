import pytest
from ifcdb import EdgeIO
from ifcdb.utils import top_dir

SERVER_NAME = "ifc_test_server"


@pytest.fixture
def server_name():
    return SERVER_NAME


@pytest.fixture
def my_beam_4x1_db():
    ifc_file = "MyBeam.ifc"
    db_name = ifc_file.replace(".ifc", "").replace("-", "_")
    ifc_path = top_dir() / "files" / ifc_file

    with EdgeIO(db_schema_dir=f"temp/{db_name}/dbschema", ifc_schema="IFC4x1", database=db_name) as io:
        if io.database_exists() is False:
            io.create_schema(from_ifc_file=ifc_path)
            io.setup_database(delete_existing_migrations=True)
            io.insert_ifc(ifc_path)
        return io

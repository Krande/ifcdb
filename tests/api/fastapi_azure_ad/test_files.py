from __future__ import annotations

import pytest
from httpx import AsyncClient

from ifcdb import EdgeIO
from ifcdb.io.ifc import IfcIO


@pytest.fixture
def mock_db_name():
    return "MyCube"


@pytest.fixture
def cube_ifc_str(ifc_files_dir, mock_db_name):
    ifc_io = IfcIO(ifc_files_dir / "MyCube.ifc")

    with EdgeIO(db_schema_dir=f"temp/{mock_db_name}/dbschema", ifc_schema="IFC4x1", database=mock_db_name) as io:
        io.create_schema_from_ifc_file(ifc_path=ifc_io.ifc_file)
        io.setup_database(delete_existing_migrations=True)

    return ifc_io.ifc_obj.wrapped_data.to_string()


@pytest.mark.anyio
async def test_post_cube_ifc_str(normal_user_client: AsyncClient, cube_ifc_str, mock_db_name):
    response = await normal_user_client.post("/file", params={"dbname": mock_db_name, "ifc_file_str": cube_ifc_str})
    assert response.status_code == 201

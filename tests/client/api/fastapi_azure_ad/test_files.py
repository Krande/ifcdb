from __future__ import annotations

import pytest
from httpx import AsyncClient

from ifcdb.edge_model.io.ifc import IfcIO


@pytest.fixture
def cube_ifc_str(ifc_files_dir):
    ifc_io = IfcIO(ifc_files_dir / "MyCube.ifc")
    return ifc_io.ifc_obj.wrapped_data.to_string()


@pytest.mark.anyio
async def test_post_cube_ifc_str(normal_user_client: AsyncClient, cube_ifc_str, mock_db_name):
    response = await normal_user_client.post("/file", params={"dbname": mock_db_name, "ifc_file_str": cube_ifc_str})
    assert response.status_code == 401

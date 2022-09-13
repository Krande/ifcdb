from __future__ import annotations

import pytest


@pytest.fixture
def mock_db_name():
    return "MyCubeEntities"


# @pytest.mark.anyio
# async def test_cube_delta(normal_user_client: AsyncClient, mock_db_name):
#     response = await normal_user_client.post("/entities", params={"dbname": mock_db_name, "ifc_file": cube_ifc_data})
#     assert response.status_code == 401

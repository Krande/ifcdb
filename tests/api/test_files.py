from __future__ import annotations

import pytest
from httpx import AsyncClient


@pytest.fixture
def mock_db_name():
    return "MyCube"


@pytest.mark.anyio
async def test_post_cube_ifc_str(normal_user_client: AsyncClient, cube_ifc_str, mock_db_name):
    response = await normal_user_client.post("/file", params={"dbname": mock_db_name, "ifc_file_str": cube_ifc_str})
    assert response.status_code == 201


@pytest.mark.anyio
async def test_post_cube_ifc_file(normal_user_client: AsyncClient, cube_ifc_str, mock_db_name):
    files = {"file": bytes(cube_ifc_str, encoding="utf8")}
    response = await normal_user_client.post("/fileb", params={"dbname": mock_db_name}, files=files)
    assert response.status_code == 201


@pytest.mark.anyio
async def test_get_cube_ifc_str(normal_user_client: AsyncClient, mock_db_name):
    response = await normal_user_client.get(
        "/file", params={"dbname": mock_db_name, "id_filter": [], "class_filter": []}
    )
    assert response.status_code == 201

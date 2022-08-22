import pytest
from httpx import AsyncClient


@pytest.mark.anyio
async def test_auth_view(client: AsyncClient, mock_db_name):
    response = await client.get("/users", params={"dbname": mock_db_name})
    assert response.status_code == 200


@pytest.mark.anyio
async def test_auth_view_not_admin(normal_user_client: AsyncClient, mock_db_name):
    response = await normal_user_client.get("/users", params={"dbname": mock_db_name})
    assert response.status_code == 401


@pytest.mark.anyio
async def test_auth_view_admin(admin_user_client: AsyncClient, mock_db_name):
    response = await admin_user_client.get("/users", params={"dbname": mock_db_name})
    assert response.status_code == 200

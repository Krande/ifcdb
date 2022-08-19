from httpx import AsyncClient
import pytest


@pytest.mark.anyio
async def test_auth_view(client: AsyncClient):
    response = await client.get("/users")
    assert response.status_code == 200


@pytest.mark.anyio
async def test_auth_view_not_admin(normal_user_client: AsyncClient):
    response = await normal_user_client.get("/users")
    assert response.status_code == 401


@pytest.mark.anyio
async def test_auth_view_admin(admin_user_client: AsyncClient):
    response = await admin_user_client.get("/users")
    assert response.status_code == 200

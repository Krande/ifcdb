from httpx import AsyncClient
import pytest


@pytest.mark.asyncio
async def test_auth_view(client: AsyncClient):
    response = await client.get("api/v1/hello")
    assert response.status_code == 200


@pytest.mark.asyncio
async def test_auth_view_not_admin(normal_user_client: AsyncClient):
    response = await normal_user_client.get("api/v1/hello-admin")
    assert response.status_code == 401


@pytest.mark.asyncio
async def test_auth_view_admin(admin_user_client: AsyncClient):
    response = await admin_user_client.get("api/v1/hello-admin")
    assert response.status_code == 200

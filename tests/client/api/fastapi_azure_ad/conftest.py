import pytest
from httpx import AsyncClient

from app.dependencies import azure_scheme
from fastapi import Request
from fastapi_azure_auth.user import User
from app.main import app as fastapi_app


@pytest.fixture
async def normal_user_client():
    async def mock_normal_user(request: Request):
        user = User(
            claims={"preferred_username": "NormalUser"}, roles=["role1"], aud="aud", tid="tid", access_token="123"
        )
        request.state.user = user
        return user

    fastapi_app.dependency_overrides[azure_scheme] = mock_normal_user
    async with AsyncClient(app=fastapi_app, base_url="http://test") as ac:
        yield ac


@pytest.fixture
async def admin_user_client():
    async def mock_admin_user(request: Request):
        user = User(
            claims={"preferred_username": "NormalUser"}, roles=["AdminUser"], aud="aud", tid="tid", access_token="123"
        )
        request.state.user = user
        return user

    fastapi_app.dependency_overrides[azure_scheme] = mock_admin_user
    async with AsyncClient(app=fastapi_app, base_url="http://test") as ac:
        yield ac


@pytest.fixture
async def client():
    async with AsyncClient(app=fastapi_app, base_url="http://test") as ac:
        yield ac

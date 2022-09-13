import ifcopenshell
import pytest
from app.dependencies import azure_scheme
from app.main import app as fastapi_app
from fastapi import Request
from fastapi_azure_auth.user import User
from httpx import AsyncClient

from ifcdb import EdgeIO
from ifcdb.io.ifc import IfcIO


@pytest.fixture
def anyio_backend():
    return "asyncio"


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


@pytest.fixture
def cube_ifc_obj(my_cube_ifc_filepath, mock_db_name) -> ifcopenshell.file:
    ifc_io = IfcIO(my_cube_ifc_filepath)

    with EdgeIO(db_schema_dir=f"temp/{mock_db_name}/dbschema", ifc_schema="IFC4x1", database_name=mock_db_name) as io:
        io.create_schema_from_ifc_file(ifc_path=ifc_io.ifc_file)
        io.setup_database(delete_existing_migrations=True)

    return ifc_io.ifc_obj


@pytest.fixture
def cube_ifc_str(cube_ifc_obj):
    return cube_ifc_obj.wrapped_data.to_string()

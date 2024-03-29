import pytest
from httpx import AsyncClient

from ifcdb import EdgeIO


@pytest.fixture
def mock_db_name():
    db_name = "UserDb"
    with EdgeIO(db_name, db_schema_dir=f"temp/{db_name}/dbschema") as io:
        if io.database_exists() is False:
            io.create_schema(["IfcPerson"])
            io.setup_database(delete_existing_migrations=True)

    yield "UserDb"

    return "UserDb"


@pytest.mark.anyio
async def test_auth_view(unwanted_client: AsyncClient, mock_db_name):
    response = await unwanted_client.get("/users", params={"dbname": mock_db_name})
    assert response.status_code == 401


@pytest.mark.anyio
async def test_auth_view_not_admin(normal_user_client: AsyncClient, mock_db_name):
    response = await normal_user_client.get("/users", params={"dbname": mock_db_name})
    assert response.status_code == 200


# @pytest.mark.anyio
# async def test_auth_view_admin(admin_user_client: AsyncClient, mock_db_name):
#     response = await admin_user_client.get("/users", params={"dbname": mock_db_name})
#     assert response.status_code == 200

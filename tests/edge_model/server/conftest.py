import pytest

SERVER_NAME = "ifc_test_server"


@pytest.fixture
def server_name():
    return SERVER_NAME

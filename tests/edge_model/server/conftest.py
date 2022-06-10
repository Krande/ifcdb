import os

import pytest
import subprocess

SERVER_NAME = "ifc_test_server"


@pytest.fixture
def server_name():
    return SERVER_NAME


def pytest_sessionstart(session):
    """
    Called after the Session object has been created and
    before performing collection and entering the run test loop.
    """
    res = os.environ.get("EDGEDB_SERVER", None)
    if res is None:
        return
    subprocess.run(f"edgedb instance destroy {SERVER_NAME} --force")
    subprocess.run(f"edgedb instance create {SERVER_NAME}")

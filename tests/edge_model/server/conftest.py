import os

import pytest
import subprocess

SERVER_NAME = "ifc_test_server"


@pytest.fixture
def server_name():
    return SERVER_NAME


# def pytest_sessionstart(session):
#     """
#     Called after the Session object has been created and
#     before performing collection and entering the run test loop.
#     """
#     res = os.environ.get("EDGEDB_SERVER", None)
#     if res is not None:
#         return
#     edgedb_exe = os.environ.get("EDGEDB_EXE", "edgedb")
#     subprocess.run(f"{edgedb_exe} instance destroy {SERVER_NAME} --force", shell=True)
#     subprocess.run(f"{edgedb_exe} instance create {SERVER_NAME}", shell=True)

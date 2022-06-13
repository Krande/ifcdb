import os
import pathlib
import shutil

from ifc_schema.interop.edge_model.insert_model import IfcToEdge, insert_ifc
import subprocess


def connect(server_name):
    """
    Called after the Session object has been created and
    before performing collection and entering the run test loop.
    """
    res = os.environ.get("EDGEDB_SERVER", None)
    if res is not None:
        return
    edgedb_exe = os.environ.get("EDGEDB_EXE", "edgedb")
    subprocess.run(f"{edgedb_exe} instance destroy {server_name} --force", shell=True)
    subprocess.run(f"{edgedb_exe} instance create {server_name}", shell=True)


def test_roundtrip_ifc_tesselated(ifc_files_dir, em_ifc4x1, server_name):
    db_name = "tess_db"
    ifc_file_name = "tessellated-item.ifc"

    connect(server_name)
    db_schema_dir = pathlib.Path("temp") / db_name / "dbschema"
    if db_schema_dir.exists():
        shutil.rmtree(db_schema_dir)
    os.makedirs(db_schema_dir, exist_ok=True)

    conn_str = os.environ.get("EDGEDB_SERVER", f"-I {server_name}")

    instance_name = None
    if "-I" in conn_str:
        instance_name = server_name

    edgedb_exe = os.environ.get("EDGEDB_EXE", "edgedb")
    server_prefix = f"{edgedb_exe} {conn_str}"

    with open(db_schema_dir.parent / "edgedb.toml", "w") as f:
        f.write('[edgedb]\nserver-version = "1.4"')

    # Set up schema
    with IfcToEdge(ifc_files_dir / ifc_file_name, em=em_ifc4x1, instance_name=instance_name) as ie:
        ie.write_ifc_entities_to_esdl_file(db_schema_dir / "default.esdl")
        subprocess.run(f"{server_prefix} migration create --non-interactive", cwd=db_schema_dir.parent, shell=True)
        subprocess.run(f"{server_prefix} migrate", cwd=db_schema_dir.parent, shell=True)

    # Insert Objects
    insert_ifc(ifc_files_dir / ifc_file_name, em=em_ifc4x1, instance_name=instance_name)

    # Queries
    # result = get_all_proxy_elements(client)
    #
    # assert len(ifc_bld_proxy_elements) == len(result)

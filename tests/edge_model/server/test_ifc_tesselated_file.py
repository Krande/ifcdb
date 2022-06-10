import os
import pathlib
import shutil

from ifc_schema.interop.edge_model.insert_model import IfcToEdge
import subprocess


def test_roundtrip_ifc_tesselated(ifc_files_dir, em_ifc4x1, server_name):
    db_name = "tess_db"
    ifc_file_name = "tessellated-item.ifc"

    db_schema_dir = pathlib.Path("temp") / db_name / "dbschema"
    if db_schema_dir.exists():
        shutil.rmtree(db_schema_dir)
    os.makedirs(db_schema_dir, exist_ok=True)

    conn_str = os.environ.get('EDGEDB_SERVER', f"-I {server_name}")

    instance_name = None
    if '-I' in conn_str:
        instance_name = server_name

    server_prefix = f"edgedb {conn_str}"

    with open(db_schema_dir.parent / "edgedb.toml", 'w') as f:
        f.write('[edgedb]\nserver-version = "1.4"')

    with IfcToEdge(ifc_files_dir / ifc_file_name, em=em_ifc4x1, instance_name=instance_name) as ie:
        # Set up schema
        ie.write_ifc_entities_to_esdl_file(db_schema_dir / "default.esdl")
        subprocess.run(f"{server_prefix} migration create --non-interactive", cwd=db_schema_dir.parent)
        subprocess.run(f"{server_prefix} migrate", cwd=db_schema_dir.parent)

        # Insert Objects
        ifc_items = ie.get_ifc_objects_by_sorted_insert_order()
        for tx in ie.client.transaction():
            with tx:
                for item in ifc_items:
                    insert_str = ie.em.get_entity_insert_str(item)
                    print(40 * "-" + str(item) + "START")
                    print(insert_str)
                    tx.execute(insert_str)
                    print(40 * "-" + str(item) + "END")

        # Queries
        # result = get_all_proxy_elements(client)
        #
        # assert len(ifc_bld_proxy_elements) == len(result)

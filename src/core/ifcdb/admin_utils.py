import os
import shutil
import subprocess


def create_local_instance(server_name):
    """
    Called after the Session object has been created and
    before performing collection and entering the run test loop.
    """
    edgedb_exe = os.environ.get("EDGEDB_EXE", "edgedb")
    subprocess.run(f"{edgedb_exe} instance destroy {server_name} --force", shell=True)
    subprocess.run(f"{edgedb_exe} instance create {server_name}", shell=True)


def copy_server_files(output_dir):
    """Copy files necessary to run EdgeDB with the auto-generated dbschema"""
    from ifcdb.utils import top_dir

    docker_files_dir = top_dir() / "dbs/ifcedge"
    file_names = ["docker-compose.yml", "edgedb.toml", "Makefile"]
    for fname in file_names:
        shutil.copy(docker_files_dir / fname, output_dir / fname)


def clean_name(n, module_name="default"):
    if isinstance(n, dict):
        str_data = n["name"]
    else:
        str_data = n
    return str_data.replace(f"{module_name}::", "")


def walk_edge_results_and_make_uuid_map(input_dict):
    uuid_complete_map = dict()

    def walk_it(obj):
        if isinstance(obj, dict):
            if obj.get("__type__") is not None:
                cls_name = clean_name(obj["__type__"])
                if cls_name not in uuid_complete_map.keys():
                    uuid_complete_map[cls_name] = []
                if obj.get("id") not in uuid_complete_map[cls_name]:
                    uuid_complete_map[cls_name].append(obj.get("id"))
            for value in obj.values():
                if isinstance(value, (dict, list)):
                    walk_it(value)
        elif isinstance(obj, list):
            for value in obj:
                walk_it(value)
        else:
            raise NotImplementedError(f"type '{type(obj)}' is not supported")

    walk_it(input_dict)
    return uuid_complete_map

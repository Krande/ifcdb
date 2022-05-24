import shutil
import pathlib


def copy_server_files(output_dir):
    """Copy files necessary to run EdgeDB with the auto-generated dbschema"""
    parent_dirs = list(pathlib.Path(__file__).parents)
    index = [x.stem for x in parent_dirs].index("ifcdb")
    docker_files_dir = parent_dirs[index] / "dbs/ifcedge"
    file_names = ["docker-compose.yml", "edgedb.toml", "Makefile"]
    for fname in file_names:
        shutil.copy(docker_files_dir / fname, output_dir / fname)

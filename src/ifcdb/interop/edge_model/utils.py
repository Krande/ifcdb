import pathlib
import shutil


def copy_server_files(output_dir):
    """Copy files necessary to run EdgeDB with the auto-generated dbschema"""
    from ifcdb.utils import top_dir

    docker_files_dir = top_dir() / "dbs/ifcedge"
    file_names = ["docker-compose.yml", "edgedb.toml", "Makefile"]
    for fname in file_names:
        shutil.copy(docker_files_dir / fname, output_dir / fname)

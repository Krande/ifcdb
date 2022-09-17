import os
import time

import ifcopenshell

from ifcdb import EdgeIO
from ifcdb.utils import top_dir

CUBE_DIR = top_dir() / "files/MyCube"


def reset_db():
    cubepath = CUBE_DIR / "MyCube.ifc"
    with EdgeIO("MyCube", load_env=True) as io:
        io.create_schema_from_ifc_file(cubepath)
        io.setup_database(delete_existing_migrations=True)
        io.insert_ifc(cubepath)


def upload(in_sequence=True):
    cubepath = CUBE_DIR / "MyCube.ifc"
    with EdgeIO("MyCube", load_env=True) as io:
        if in_sequence:
            io.insert_ifc(cubepath)
        else:
            io.update_db_from_ifc_delta(updated_ifc=cubepath)


def run_model_update(filename: str, extra_identifier: str = None):
    os.makedirs("temp", exist_ok=True)
    filepath = CUBE_DIR / filename
    identifier = filepath.stem
    if extra_identifier is not None:
        identifier += extra_identifier
    with EdgeIO("MyCube", load_env=True) as io:
        ifc_obj = io.to_ifcopenshell_object()

        with open(f"temp/before_{identifier}_model.ifc", "w") as f:
            f.write(ifc_obj.wrapped_data.to_string())
        diff_log = f"temp/edit_{identifier}_diff.json"

        io.update_db_from_ifc_delta(ifcopenshell.open(filepath), ifc_obj, save_diff_as=diff_log)

        ifc_obj = io.to_ifcopenshell_object()
        with open(f"temp/after_{identifier}_model.ifc", "w") as f:
            f.write(ifc_obj.wrapped_data.to_string())


def wipe_db(in_sequence=True):
    with EdgeIO("MyCube", load_env=True) as io:
        start = time.time()
        io.wipe_database(delete_in_sequence=in_sequence)
        end = time.time()

        print(f"Wiped database in {end-start:.2f} seconds {in_sequence=}")


def download():
    with EdgeIO("MyCube", load_env=True) as io:
        start = time.time()
        io.to_ifc_file("temp/MyCube.ifc")
        end = time.time()

        print(f"Downloaded from database in {end-start:.2f} seconds")


# if __name__ == "__main__":
#     upload()
#     run_model_update()

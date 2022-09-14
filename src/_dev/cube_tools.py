import os

import ifcopenshell

from ifcdb import EdgeIO
from ifcdb.utils import top_dir

CUBE_DIR = top_dir() / "files/MyCube"


def upload():
    cubepath = CUBE_DIR / "MyCube.ifc"
    with EdgeIO("MyCube", load_env=True) as io:
        io.create_schema_from_ifc_file(cubepath)
        io.setup_database(delete_existing_migrations=True)
        io.insert_ifc(cubepath)


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

        io.update_db_from_ifc_delta(ifc_obj, ifcopenshell.open(filepath), save_diff_as=diff_log)

        ifc_obj = io.to_ifcopenshell_object()
        with open(f"temp/after_{identifier}_model.ifc", "w") as f:
            f.write(ifc_obj.wrapped_data.to_string())


def wipe_db():
    with EdgeIO("MyCube", load_env=True) as io:
        io.wipe_database()


# if __name__ == "__main__":
#     upload()
#     run_model_update()

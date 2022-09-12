import os

import ifcopenshell as ifc

from ifcdb import EdgeIO
from ifcdb.utils import top_dir
from ifcdb.diffing.tool import IfcDiffTool, EntityDiffChange
from ifcdb.diffing.diff_ifcopen import apply_diffs_ifcopenshell

CUBE_DIR = top_dir() / "files/MyCube"


def create_revert_diff_from_two_files():
    diff = IfcDiffTool(ifc.open(CUBE_DIR / "MyCubeEdited.ifc"), ifc.open(CUBE_DIR / "MyCube.ifc"))
    diff.changed[0].to_json_file("diff_revert.json")


def edit_file(io: EdgeIO):
    os.makedirs('temp', exist_ok=True)
    old_ifc_file = "temp/old.ifc"
    new_ifc_file = "temp/new.ifc"

    ifc_obj = io.to_ifcopenshell_object()

    with open(old_ifc_file, "w") as f:
        f.write(ifc_obj.wrapped_data.to_string())

    diff_json = CUBE_DIR / "diff_edited.json"
    diff_change = EntityDiffChange.from_json_file(diff_json, ifc_obj)

    ifc_diff_tool = IfcDiffTool(ifc_obj, changed=[diff_change])
    apply_diffs_ifcopenshell(ifc_obj, ifc_diff_tool)

    with open(new_ifc_file, "w") as f:
        f.write(ifc_obj.wrapped_data.to_string())

    # io.update_from_diff_tool(ifc_diff_tool)


def main():

    with EdgeIO("ifc001", load_env=True) as io:
        edit_file(io)

    print("res")


if __name__ == "__main__":
    # create_revert_diff_from_two_files()
    main()

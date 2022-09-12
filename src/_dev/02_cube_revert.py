from ifcdb import EdgeIO
from ifcdb.diffing.tool import EntityDiffChange, IfcDiffTool
from ifcdb.utils import top_dir

CUBE_DIR = top_dir() / "files/MyCube"


def main():
    with EdgeIO("ifc001", load_env=True) as io:
        ifc_obj = io.to_ifcopenshell_object()
        diff_change = EntityDiffChange.from_json_file(CUBE_DIR / "diff_revert.json", ifc_obj)
        io.update_from_diff_tool(IfcDiffTool(ifc_obj, changed=[diff_change]))


if __name__ == "__main__":
    # create_revert_diff_from_two_files()
    main()

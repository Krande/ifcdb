import ifcopenshell

from ifcdb import EdgeIO
from ifcdb.diffing.tool import EntityDiffChange, IfcDiffTool
from ifcdb.utils import top_dir

CUBE_DIR = top_dir() / "files/MyCube"


def make_mods(ifc_obj: ifcopenshell.file):
    elem = ifc_obj.by_guid("3vJeEVZYzA3vP81uCmY9l4")
    solid = [x for x in elem.Representation.Representations if x.RepresentationType == "SweptSolid"][0].Items[0]
    coords = list(solid.Position.Location.Coordinates)
    coords[2] = -5.68906497955322
    solid.Position.Location.Coordinates = tuple(coords)


def main():
    with EdgeIO("ifc001", load_env=True) as io:
        ifc_obj = io.to_ifcopenshell_object()
        diff_change = EntityDiffChange.from_json_file(CUBE_DIR / "diff_edited.json", ifc_obj)
        io.update_from_diff_tool(IfcDiffTool(ifc_obj, changed=[diff_change]))


if __name__ == "__main__":
    main()

import os

import ifcopenshell

from ifcdb.io.ifc.optimizing import general_optimization
from ifcdb.utils import top_dir


def main(file_data):
    top_path, files = file_data
    parent_dir = top_dir() / "files"
    if top_path is not None:
        parent_dir = parent_dir / top_path
    os.makedirs("temp", exist_ok=True)
    for x in files:
        f_old = ifcopenshell.open(parent_dir / x)
        try:
            opt_f = general_optimization(f_old)
        except TypeError:
            continue
        with open(f"temp/{x}", "w") as f:
            f.write(opt_f.wrapped_data.to_string())


if __name__ == "__main__":
    f1 = ("MyCube", ["MyCube.ifc", "MyCubeAdded.ifc", "MyCubeEdited.ifc"])
    f2 = ("MyBeam_w_holes", ["MyBeamWithHoles.ifc"])
    f3 = (None, ["MyBeam.ifc", "cube-advanced-brep.ifc", "SpatialHierarchy1.ifc", "tessellated-item.ifc"])
    main(f1)

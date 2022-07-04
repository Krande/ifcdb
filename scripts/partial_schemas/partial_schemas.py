import os
import time

from ifcdb import EdgeIO
from ifcdb.edge_model.query_utils import (
    validate_ifc_content,
    validate_ifc_objects,
    validate_using_ifc_diff,
)
from ifcdb.utils import top_dir


def main(ifc_file, refresh_db=False, validate_data=False, create_ifc_str=False):
    db_name = ifc_file.replace(".ifc", "").replace("-", "_")
    ifc_path = top_dir() / "files" / ifc_file

    with EdgeIO(ifc_file=ifc_path, db_schema_dir=f"db/{db_name}/dbschema", ifc_schema="IFC4x1", database=db_name) as io:
        if refresh_db:
            io.create_schema(from_ifc_file=True)
            io.setup_database(delete_existing_migrations=True)
            io.insert_ifc()

        # Validate Data
        if validate_data:
            validate_using_ifc_diff(io.ifc_io.ifc_obj, io.to_ifcopenshell_object(), "temp/export.json")
            validate_ifc_objects(io.ifc_io.ifc_obj, io.to_ifcopenshell_object())
            validate_ifc_content(io.ifc_io.ifc_obj, io.get_all(limit_to_ifc_entities=True))

        # # Do a "warm up" query first
        # result_all = io.get_all(limit_to_ifc_entities=True)
        #
        # start = time.time()
        # result_all = io.get_all(limit_to_ifc_entities=True)
        # diff1 = time.time() - start

        # start = time.time()
        # result_a = io.get_spatial_content_a("Sublevel_1_a")
        # diff2 = time.time() - start

        # Get "Sublevel_1_a" by GlobalId
        # res_id = io.get_by_global_id("1dGALjyLuHxAG601fzsd4G")

        # Get "Sublevel_1_a" by GlobalId

        _ = io.get_by_name("MyBeam")

        start = time.time()
        _ = io.get_spatial_content_b("Sublevel_1_a")
        _ = time.time() - start

        # print(f"time 1: {diff1}, time 2: {diff2}, time 3: {diff3}")
        if create_ifc_str:
            res = io.to_ifc_str()
            os.makedirs("temp", exist_ok=True)
            with open(f"temp/{ifc_path.stem}-roundtripped.ifc", "w") as f:
                f.write(res)


if __name__ == "__main__":
    # main("cube-advanced-brep.ifc")
    # main("SpatialHierarchy1.ifc", refresh_db=False)
    main("MyBeam.ifc", refresh_db=False)
    # main("tessellated-item.ifc")

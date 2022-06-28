import os

from ifcdb import EdgeIO
from ifcdb.interop.edge_model.query_utils import validate_ifc_content, validate_ifc_objects, validate_using_ifc_diff
from ifcdb.utils import top_dir


def main(ifc_file):
    db_name = ifc_file.replace(".ifc", "").replace("-", "_")
    ifc_path = top_dir() / "files" / ifc_file

    with EdgeIO(ifc_file=ifc_path, db_schema_dir=f"{db_name}/dbschema", ifc_schema="IFC4x1", database=db_name) as io:
        io.create_schema(from_ifc_file=True)# , specific_entities=["IfcCartesianPointList3D"])
        io.setup_database(delete_existing_migrations=True)
        # io.insert_ifc(specific_ifc_ids=[37])
        io.insert_ifc()

        # Validate Data
        # validate_using_ifc_diff(io.ifc_io.ifc_obj, io.to_ifcopenshell_object(), "temp/export.json")
        # validate_ifc_objects(io.ifc_io.ifc_obj, io.to_ifcopenshell_object())

        # validate_ifc_content(io.ifc_io.ifc_obj, io.get_all(limit_to_ifc_entities=True))
        # result_all = io.get_all(limit_to_ifc_entities=True)

        # result = io.get_spatial_content_b('Sublevel_1_a')

        res = io.to_ifc_str()

    os.makedirs("temp", exist_ok=True)
    with open(f"temp/{ifc_path.stem}-roundtripped.ifc", "w") as f:
        f.write(res)


if __name__ == "__main__":
    # main("cube-advanced-brep.ifc")
    # main("SpatialHierarchy1.ifc")
    main("tessellated-item.ifc")

import os

from ifcdb import EdgeIO
from ifcdb.utils import top_dir


def main(ifc_file, validate_data=False):
    ifc_path = top_dir() / "files" / ifc_file

    with EdgeIO(db_schema_dir="complete/dbschema", ifc_schema="IFC4x1", database_name="complete") as io:
        io.create_schema_from_ifc_file(ifc_path=ifc_path)
        io.setup_database(delete_existing_migrations=True)
        io.insert_ifc()

        # Validate Data
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

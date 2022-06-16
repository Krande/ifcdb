import os

from ifcdb import EdgeIO
from ifcdb.utils import top_dir


def main():
    ifc_file = "tessellated-item.ifc"
    # ifc_file = "cube-advanced-brep.ifc"
    ifc_path = top_dir() / "files" / ifc_file

    with EdgeIO(ifc_file=ifc_path, db_schema_dir="db/dbschema", ifc_schema="IFC4x1", database="testdb") as io:
        io.create_schema_from_ifc_file()
        io.setup_database(delete_existing_migrations=True)
        # io.insert_ifc(specific_ifc_ids=[36])
        io.insert_ifc()
        # result = io.get_all(limit_to_ifc_entities=True)
        res = io.export_ifc_elements_to_ifc_str()

        # obj_set = {key: value for key, value in result[0].items() if len(value) != 0}
        #
        # for key, value in obj_set.items():
        #     print('sd')

    os.makedirs("temp", exist_ok=True)
    with open(f"temp/{ifc_path.stem}-roundtripped.ifc", "w") as f:
        f.write(res)


if __name__ == "__main__":
    main()

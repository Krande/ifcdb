import json

from ifcdb import EdgeIO
from ifcdb.utils import top_dir


def main(ifc_file, refresh_db=False):
    db_name = ifc_file.replace(".ifc", "").replace("-", "_")
    ifc_path = top_dir() / "files" / ifc_file

    with EdgeIO(db_schema_dir=f"temp/{db_name}/dbschema", ifc_schema="IFC4x1", database=db_name) as io:
        if refresh_db:
            io.create_schema(from_ifc_file=ifc_path)
            io.setup_database(delete_existing_migrations=True)
            io.insert_ifc(ifc_path)

        # Queries
        for qref in ["q1", "q2", "q3"]:
            q1_res = json.loads(io.client.query_json(open(f"{qref}.esdl", "r").read()))
            with open(f"{qref}_output.json", "w", encoding="utf-8") as f:
                json.dump(q1_res, f, indent=4)


if __name__ == "__main__":
    main("MyBeam.ifc", refresh_db=False)

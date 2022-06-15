from __future__ import annotations

from ifc_schema.interop.edge_model import EdgeIO
from ifc_schema.utils import top_dir

if __name__ == "__main__":
    ifc_f = top_dir() / "files/tessellated-item.ifc"
    db_schema_dir = "db/dbschema"
    with EdgeIO(ifc_file=ifc_f, schema_name="IFC4x1", database="testdb") as io:
        # io.create_schema_from_ifc_file(db_schema_dir)
        io.setup_database(db_schema_dir)
        io.insert_ifc()
        res = io.export_ifc_elements_to_ifc_str()
        print(res)

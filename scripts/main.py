from __future__ import annotations

import pathlib

from ifc_schema.interop.edge_model import EdgeIO


def main(schema_name):
    dbschema_dir = pathlib.Path("temp/edge_model/dbschema")
    eio = EdgeIO(schema_name=schema_name)
    eio.em.write_entities_to_esdl_file(eio.em.get_all_entities(), dbschema_dir / "default.esdl", include_server_files=True)


if __name__ == "__main__":
    main("IFC4x1")

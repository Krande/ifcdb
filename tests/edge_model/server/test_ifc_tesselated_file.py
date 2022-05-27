import edgedb
import ifcopenshell
from ifc_schema.interop.edge_model.inserts import insert_ifc_building_element_proxies
from ifc_schema.interop.edge_model.query import get_all_proxy_elements


def test_roundtrip_ifc_tesselated(ifc_files_dir):
    client = edgedb.create_client("edgedb://edgedb@localhost:5656", tls_security="insecure")

    ifc = ifcopenshell.open(ifc_files_dir / "tessellated-item.ifc")

    # Insertions
    # Insert Geometries
    ifc_bld_proxy_elements = list(ifc.by_type("IfcBuildingElementProxy"))
    insert_ifc_building_element_proxies(client, ifc_bld_proxy_elements)

    # TODO: Insert Spatial Hierarchy and link with geometry ID's using guids
    # TODO: Insert Project Data

    # Queries
    result = get_all_proxy_elements(client)

    client.close()

    assert len(ifc_bld_proxy_elements) == len(result)

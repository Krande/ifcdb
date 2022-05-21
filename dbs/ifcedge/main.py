import json
import logging

import edgedb
import ifcopenshell


def insert_query(client: edgedb.Client, query_str, **kwargs):
    try:
        client.query(query_str, **kwargs)
    except edgedb.errors.ConstraintViolationError as e:
        logging.warning(e)


def tria_face_element(ifc_tria: ifcopenshell.entity_instance) -> str:
    ifc_coords = ifc_tria.Coordinates
    normals = f"Normals := {ifc_tria.Normals}," if ifc_tria.Normals is not None else ""
    coord_index = f"{list(ifc_tria.CoordIndex)}"
    coord_list = f"INSERT IfcCartesianPointList3D {{CoordList := {list(ifc_coords.CoordList)},}}"

    return f"""INSERT IfcTriangulatedFaceSet {{
    Coordinates := ({coord_list}),
    Closed := {ifc_tria.Closed},
    CoordIndex := {coord_index},
    {normals}
}}
"""


def create_ifc_building_element_proxy(client: edgedb.Client, ifc_bld_proxy: ifcopenshell.entity_instance):
    items_str = ""
    for rep in ifc_bld_proxy.Representation.Representations:
        for item in rep.Items:
            item_type = item.is_a()
            if item_type == "IfcTriangulatedFaceSet":
                items_str += tria_face_element(item)
            else:
                logging.warning(f'Unsupported type "{item_type}"')
    repr_context = f"INSERT IfcGeometricRepresentationContext {{}}"
    representation = f"INSERT IfcShapeRepresentation {{ ContextOfItems := ({repr_context}), Items := ({items_str}) }}"
    prod_repr = f"INSERT IfcProductDefinitionShape {{ Representations:=({representation}) }}"

    insert_query(
        client,
        f"""INSERT IfcBuildingElementProxy {{
                GlobalId := <str>$guid,
                Name := <str>$name,
                Description := <str>$descr,
                Representation:= ({prod_repr}),
            }}
            """,
        guid=ifc_bld_proxy.GlobalId,
        name=ifc_bld_proxy.Name,
        descr=ifc_bld_proxy.Description,
    )


def get_element_proxy_products():
    ifc = ifcopenshell.open("../../files/tessellated-item.ifc")
    return list(ifc.by_type("IfcBuildingElementProxy"))


def main():
    import pprint
    client = edgedb.create_client("edgedb://edgedb@localhost:5656", tls_security="insecure")
    # Create a User object type
    # for ifc_el_proxy in get_element_proxy_products():
    #     create_ifc_building_element_proxy(client, ifc_el_proxy)

    # Select IfcTriangulatedFaceSet objects.
    user_set = client.query_json(
        """
        SELECT IfcBuildingElementProxy {
            Name, 
            GlobalId, 
            Representation: {
                Representations: {
                        Items: {
                            [IS IfcTriangulatedFaceSet].Coordinates: { CoordList },
                            [IS IfcTriangulatedFaceSet].Normals,
                            [IS IfcTriangulatedFaceSet].CoordIndex,
                        }
                    }
                },
            }
            filter .GlobalId = <str>$guid
        """,
        guid="1kTvXnbbzCWw8lcMd1dR4o",
    )
    res = json.loads(user_set)
    # print(res)
    pprint.pprint(res)
    # *user_set* now contains
    # Set{Object{name := 'Bob', dob := datetime.date(1984, 3, 1)}}

    # Close the client.
    client.close()


if __name__ == "__main__":
    main()

import json
import logging
from typing import List, Tuple
import ifcopenshell
import edgedb


def insert_query(client: edgedb.Client, query_str, **kwargs):
    try:
        client.query(query_str, **kwargs)
    except edgedb.errors.ConstraintViolationError as e:
        logging.warning(e)


def create_ifc_tria(client: edgedb.Client, ifc_tria: ifcopenshell.entity_instance):
    # Insert a new IfcTriangulatedFaceSet object

    ifc_coords = ifc_tria.Coordinates
    insert_query(
        client,
        """INSERT IfcTriangulatedFaceSet {
                Coords := (
                    INSERT IfcCartesianPointList3D {
                        CoordList := array<tuple<x: float64, y: float64, z: float64>>$CoordList
                    }
                ),
                Closed := <bool>$Closed,
                CoordIndex := array<tuple<x: float64, y: float64, z: float64>>$CoordIndex,
                Normals := array<tuple<x: float64, y: float64, z: float64>>$Normals,
            }""",
        CoordList=ifc_coords.CoordList,
        Closed=ifc_tria.Closed,
        CoordIndex=ifc_tria.CoordIndex,
        Normals=ifc_tria.Normals,
    )


def get_faceted_products():
    ifc = ifcopenshell.open("../../files/slab-tessellated-unique-vertices.ifc")
    return list(ifc.by_type("IfcTriangulatedFaceSet"))


def main():
    client = edgedb.create_client("edgedb://edgedb@localhost:5656", tls_security="insecure")
    # Create a User object type
    for ifc_tria in get_faceted_products():
        create_ifc_tria(client, ifc_tria)

    # Select IfcTriangulatedFaceSet objects.
    user_set = client.query_json(
        "SELECT IfcTriangulatedFaceSet {GlobalId, Name, Coordinates} FILTER .GlobalId = <str>$guid", guid="BobGUID"
    )
    res = json.loads(user_set)
    print(res)
    # *user_set* now contains
    # Set{Object{name := 'Bob', dob := datetime.date(1984, 3, 1)}}

    # Close the client.
    client.close()


if __name__ == "__main__":
    main()

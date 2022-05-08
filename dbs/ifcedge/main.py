import json
import logging
from typing import List, Tuple
import edgedb


def create_ifc_tria(client: edgedb.Client, name: str, guid: str, coords: List[Tuple[float, float, float]]):
    # Insert a new IfcTriangulatedFaceSet object
    try:
        client.query(
            """
            INSERT IfcTriangulatedFaceSet {
                GlobalId := <str>$GlobalId,
                Name := <str>$Name,
                Coords := <str>$Coords
            }
        """,
            GlobalId=guid,
            Name=name,
            Coords=coords
        )
    except edgedb.errors.ConstraintViolationError as e:
        logging.info(e)


def main():
    client = edgedb.create_client("edgedb://edgedb@localhost:5656", tls_security="insecure")
    # Create a User object type
    create_ifc_tria(client, "Bob", "BobGUID")
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

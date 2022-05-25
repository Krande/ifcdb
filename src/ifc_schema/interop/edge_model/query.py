import edgedb
import json


def get_all_proxy_elements(client: edgedb.Client):
    user_set = client.query_json(
        """
        SELECT IfcBuildingElementProxy {
            Name, 
            GlobalId,
            Representation: {
                Representations: {
                        Items: {
                            # [IS IfcTriangulatedFaceSet].Coordinates: { CoordList },
                            # [IS IfcTriangulatedFaceSet].Normals,
                            # [IS IfcTriangulatedFaceSet].CoordIndex,
                        }
                    }
                },
            }
        
        """,
    )
    return json.loads(user_set)


def get_geometry_by_guid(client: edgedb.Client, guid):
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
        guid=guid,
    )
    return json.loads(user_set)

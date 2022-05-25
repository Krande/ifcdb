from __future__ import annotations

import json

import ifcopenshell
import edgedb
import logging


def tria_face_element_data(ifc_tria: ifcopenshell.entity_instance) -> dict:
    ifc_coords = ifc_tria.Coordinates
    closed = ifc_tria.Closed if ifc_tria.Closed is not None else True
    normals = ifc_tria.Normals

    return dict(
        coords=ifc_coords.CoordList,
        closed=closed,
        coordindex=ifc_tria.CoordIndex,
        normals=normals,
    )


def insert_ifc_building_element_proxies(client: edgedb.Client, ifc_bld_proxies: list[ifcopenshell.entity_instance]):
    bld_proxies = []
    for ifc_bld_proxy in ifc_bld_proxies:
        if ifc_bld_proxy.Representation is None:
            logging.warning(f'IFC element "{ifc_bld_proxy.Name}" Representation object is None')
            continue

        repr_items = []
        for rep in ifc_bld_proxy.Representation.Representations:
            for item in rep.Items:
                item_type = item.is_a()
                if item_type == "IfcTriangulatedFaceSet":
                    repr_items.append(tria_face_element_data(item))
                else:
                    logging.warning(f'Unsupported type "{item_type}"')
        bld_prox = dict(
            guid=ifc_bld_proxy.GlobalId,
            name=ifc_bld_proxy.Name,
            descr=ifc_bld_proxy.Description if ifc_bld_proxy.Description is not None else "",
            csysdim=3,
            coords=(0, 0, 0),
            axis=(0, 0, 1),
            refdir=(1, 0, 0),
            repr_items=repr_items,
        )
        bld_proxies.append(bld_prox)

    logging.info("Finished with dict creation")

    context_items_insert = """
INSERT IfcGeometricRepresentationContext {
    CoordinateSpaceDimension := <int64>bld_prox['csysdim'],
    WorldCoordinateSystem := (
        INSERT IfcAxis2Placement3D { 
            Location := (
                INSERT IfcCartesianPoint { 
                    Coordinates := <tuple<float64, float64, float64>>bld_prox['coords'] 
                }
            ), 
            Axis:= (
                INSERT IfcDirection { 
                    DirectionRatios := <tuple<float64, float64, float64>>bld_prox['axis'] 
                }
            ), 
            RefDirection:= (
                INSERT IfcDirection { 
                    DirectionRatios := <tuple<float64, float64, float64>>bld_prox['refdir']
                }
            ) 
        }
    ),
}
"""
    items_str_insert = """
FOR geom IN json_array_unpack(bld_prox['repr_items']) UNION (
    INSERT IfcTriangulatedFaceSet {
            Coordinates := (
                INSERT IfcCartesianPointList3D {
                    CoordList := <array<tuple<float64, float64, float64>>>geom['coords'] 
                }
            ),
            Closed := <bool>geom['closed'],
            CoordIndex := <array<tuple<int64, int64, int64>>>geom['coordindex'],
            Normals := <array<tuple<float64, float64, float64>>>json_get(geom['normals'])
        }
    )
"""

    query_str = f"""
WITH 
    bld_proxies := <json>$bld_proxies_json
FOR bld_prox IN json_array_unpack(bld_proxies) UNION (
    INSERT IfcBuildingElementProxy {{
        GlobalId := <str>bld_prox['guid'],
        Name := <str>bld_prox['name'],
        Description := <str>bld_prox['descr'],
        Representation:= (
            INSERT IfcProductDefinitionShape {{
                Representations:=(
                    INSERT IfcShapeRepresentation {{
                        ContextOfItems := ({context_items_insert}), 
                        Items := ({items_str_insert}),
                    }}
                )
            }}
        ),
    }}
)
"""
    logging.info("Beginning EdgeDB insert query")
    client.query(query_str, bld_proxies_json=json.dumps(bld_proxies))
    logging.info("Edge Query Finished")

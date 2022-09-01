from itertools import count

import ifcopenshell

from ifcdb.database.base import Entity, EntityResolver
from ifcdb.io.ifc.optimizing import general_optimization


def test_insert_beam(my_beam_w_holes_ifc):
    start_entities = len(list(my_beam_w_holes_ifc))
    my_beam_w_holes_optimized = general_optimization(my_beam_w_holes_ifc)
    end_entities = len(list(my_beam_w_holes_optimized))
    assert start_entities == 179
    assert end_entities == 110

    er = EntityResolver("IFC4x1")
    skippable_classes = [
        "IfcOwnerHistory",
        "IfcObjectPlacement",
        "IfcRepresentationContext",
        "IfcRepresentationItem",
    ]

    for skip_it in skippable_classes:
        uuid_id_gen = count(1)
        for ifc_owner in my_beam_w_holes_optimized.by_type(skip_it):
            er.uuid_map[ifc_owner] = Entity(skip_it, uuid=f"a_random_uuid_replacement_for_IfcOwner{next(uuid_id_gen)}")

    # Adding a single ifc element should return UUID for use later
    bm: ifcopenshell.entity_instance = my_beam_w_holes_optimized.by_type("IfcBeam")[0]

    _ = my_beam_w_holes_optimized.get_inverse(bm)

    insert_entity = er.create_insert_entity(bm)
    assert frozenset(insert_entity.props) == frozenset(
        {
            "GlobalId": "1Yi29q_3qHx8aIw2f4ZOUQ",
            "Name": "MyBeam",
            "Description": "IPE400",
            "ObjectType": "Beam",
            "Tag": "MyBeam",
        }
    )
    insert_str = insert_entity.to_str()

    er.uuid_map[bm] = Entity("IfcBeam", uuid="a_random_uuid_replacement_for_IfcBeam")
    print(insert_str)

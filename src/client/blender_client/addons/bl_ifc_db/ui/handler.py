from __future__ import annotations

import ifcopenshell.api
from bpy.app.handlers import persistent

from blenderbim.bim.ifc import IfcStore


def print_this(usecase_path, ifc_file, settings):
    # print(usecase_path, ifc_file, settings)
    bl_obj = settings["blender_object"]
    f: ifcopenshell.file = IfcStore.get_file()
    ifc_elem: ifcopenshell.entity_instance = f.by_id(bl_obj.BIMObjectProperties.ifc_definition_id)
    inverse = f.get_inverse(ifc_elem)
    tot_inverse = f.get_total_inverses(ifc_elem)
    print(ifc_elem, inverse, tot_inverse)


@persistent
def load_post(*args):
    ifcopenshell.api.add_post_listener("geometry.add_representation", "IFCDB.print_this", print_this)

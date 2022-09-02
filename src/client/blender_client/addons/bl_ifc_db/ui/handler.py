from __future__ import annotations

import ifcopenshell.api
from blenderbim.bim.ifc import IfcStore
from bpy.app.handlers import persistent


def print_this(usecase_path, ifc_file, settings):
    print(usecase_path, ifc_file, settings)
    bl_obj = settings["blender_object"]
    f: ifcopenshell.file = IfcStore.get_file()
    ifc_elem: ifcopenshell.entity_instance = f.by_id(bl_obj.BIMObjectProperties.ifc_definition_id)
    inverse = f.get_inverse(ifc_elem)
    tot_inverse = f.get_total_inverses(ifc_elem)
    info = ifc_elem.get_info(False, True)
    print(ifc_elem, inverse, tot_inverse, info)


@persistent
def load_post(*args):
    ifcopenshell.api.add_pre_listener("geometry.add_representation", "IFCDB.print_this_pre", print_this)
    ifcopenshell.api.add_post_listener("geometry.add_representation", "IFCDB.print_this_post", print_this)

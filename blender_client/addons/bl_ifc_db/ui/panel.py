import bpy


class IFC_DB_MAIN_PT_Panel(bpy.types.Panel):
    bl_idname = "IFC_DB_MAIN_PT_Panel"
    bl_label = "Updates"
    bl_space_type = "VIEW_3D"
    bl_region_type = "UI"
    bl_category = "IfcDb"

    def draw(self, context):
        layout = self.layout
        layout.row()
        layout.row().operator("view3d.ifc_db_test_connection", text="Test Connection")

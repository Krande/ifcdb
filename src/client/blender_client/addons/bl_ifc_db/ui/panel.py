import bpy


class IFC_DB_MAIN_PT_Panel(bpy.types.Panel):
    bl_idname = "IFC_DB_MAIN_PT_Panel"
    bl_label = "IFC Database Client"
    bl_space_type = "VIEW_3D"
    bl_region_type = "UI"
    bl_category = "IfcDb"

    def draw(self, context):
        layout = self.layout
        layout.row()
        layout.row().operator("view3d.ifc_db_login", text="Login")
        layout.row().operator("view3d.ifc_db_push", text="Push")
        layout.row().operator("view3d.ifc_db_pull", text="Pull")
        layout.row().operator("view3d.ifc_db_live", text="Go Live")

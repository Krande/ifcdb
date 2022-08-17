import bpy
from bpy.props import BoolProperty, StringProperty, IntProperty


class IFC_DB_MAIN_PT_Panel(bpy.types.Panel):
    bl_idname = "IFC_DB_MAIN_PT_Panel"
    bl_label = "IFC Database Client"
    bl_space_type = "VIEW_3D"
    bl_region_type = "UI"
    bl_category = "IfcDb"

    def draw(self, context):
        layout = self.layout
        layout.row()
        props = context.scene.IfcDb_Connection_Props

        layout.row().operator("view3d.ifc_db_login", text="Login")
        layout.row().prop(props, "db_name")
        layout.row().operator("view3d.ifc_db_push", text="Push")
        layout.row().operator("view3d.ifc_db_pull", text="Pull")
        layout.row().operator("view3d.ifc_db_live", text="Go Live")


class IFC_DB_CLIENT_preferences(bpy.types.AddonPreferences):
    bl_idname = "ifcdbclient"
    svg2pdf_command: StringProperty(name="SVG to PDF Command", description="E.g. [['inkscape', svg, '-o', pdf]]")
    svg2dxf_command: StringProperty(
        name="SVG to DXF Command",
        description="E.g. [['inkscape', svg, '-o', eps], ['pstoedit', '-dt', '-f', 'dxf:-polyaslines -mm', eps, dxf, '-psarg', '-dNOSAFER']]",
    )
    svg_command: StringProperty(name="SVG Command", description="E.g. [['firefox', path]]")
    pdf_command: StringProperty(name="PDF Command", description="E.g. [['firefox', path]]")
    spreadsheet_command: StringProperty(name="Spreadsheet Command", description="E.g. [['libreoffice', path]]")
    openlca_port: IntProperty(name="OpenLCA IPC Port", default=8080)
    should_hide_empty_props: BoolProperty(name="Should Hide Empty Properties", default=True)
    should_play_chaching_sound: BoolProperty(
        name="Should Make A Cha-Ching Sound When Project Costs Updates", default=False
    )

    def draw(self, context):
        layout = self.layout
        row = layout.row()
        row.label(
            text="To upgrade, first uninstall your current BlenderBIM Add-on, then install the new version.",
            icon="ERROR",
        )
        row = layout.row()
        row.label(
            text="To uninstall, first disable the add-on. Then restart Blender before pressing the 'Remove' button.",
            icon="ERROR",
        )
        row = layout.row()
        row.operator("bim.open_upstream", text="Visit Homepage").page = "home"
        row.operator("bim.open_upstream", text="Visit Documentation").page = "docs"
        row = layout.row()
        row.operator("bim.open_upstream", text="Visit Wiki").page = "wiki"
        row.operator("bim.open_upstream", text="Visit Community").page = "community"
        row = layout.row()
        row.prop(self, "svg2pdf_command")
        row = layout.row()
        row.prop(self, "svg2dxf_command")
        row = layout.row()
        row.prop(self, "svg_command")
        row = layout.row()
        row.prop(self, "pdf_command")
        row = layout.row()
        row.prop(self, "spreadsheet_command")
        row = layout.row()
        row.prop(self, "openlca_port")
        row = layout.row()
        row.prop(self, "should_hide_empty_props")
        row = layout.row()
        row.prop(self, "should_play_chaching_sound")

        row = layout.row()
        row.prop(context.scene.BIMModelProperties, "occurrence_name_style")
        row = layout.row()
        row.prop(context.scene.BIMModelProperties, "occurrence_name_function")

        row = self.layout.row()
        row.prop(context.scene.DocProperties, "decorations_colour")

        row = self.layout.row(align=True)
        row.prop(context.scene.BIMProperties, "schema_dir")
        row.operator("bim.select_schema_dir", icon="FILE_FOLDER", text="")

        row = self.layout.row(align=True)
        row.prop(context.scene.BIMProperties, "data_dir")
        row.operator("bim.select_data_dir", icon="FILE_FOLDER", text="")

        row = layout.row()
        row.operator("bim.configure_visibility")

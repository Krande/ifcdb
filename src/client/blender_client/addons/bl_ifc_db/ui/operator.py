import bpy


def get_ifc_store():
    # Assuming you already have blenderbim installed
    from blenderbim.bim.ifc import IfcStore

    return IfcStore


class IfcDb_TestConnection_Operator(bpy.types.Operator):
    bl_idname = "view3d.ifc_db_test_connection"
    bl_label = "Test Connection"
    bl_description = "Test Connection"

    def execute(self, context):
        # Get the current scene
        scene = context.scene
        print("Button Pressed")

        return {"FINISHED"}
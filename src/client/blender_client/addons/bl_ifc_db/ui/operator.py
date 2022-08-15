import bpy


def get_ifc_store():
    # Assuming you already have blenderbim installed
    from blenderbim.bim.ifc import IfcStore

    return IfcStore


def run_listener():
    try:
        from azure.storage.queue import QueueClient
    except ModuleNotFoundError:
        raise ModuleNotFoundError(
            "Unable to find Azure Storage Queue package. " "Please install using pip install azure-storage-queue"
        )

    QueueClient.from_connection_string(con_str, QueueNames.IN)


def login():
    from azure.identity import InteractiveBrowserCredential


class IfcDb_Login_Operator(bpy.types.Operator):
    bl_idname = "view3d.ifc_db_login"
    bl_label = "Login"
    bl_description = "Login"

    def execute(self, context):
        print("User Login shall take place here")

        return {"FINISHED"}


class IfcDb_Pull_Operator(bpy.types.Operator):
    bl_idname = "view3d.ifc_db_pull"
    bl_label = "Pull"
    bl_description = "Pull"

    def execute(self, context):
        print("Pulling of IFC data should start now")

        return {"FINISHED"}


class IfcDb_Push_Operator(bpy.types.Operator):
    bl_idname = "view3d.ifc_db_push"
    bl_label = "Push"
    bl_description = "Push"

    def execute(self, context):
        print("Pushing of IFC data should start now")

        return {"FINISHED"}


class IfcDb_Live_Operator(bpy.types.Operator):
    bl_idname = "view3d.ifc_db_live"
    bl_label = "Go Live"
    bl_description = "Listen to live updates from the IfcDb"

    def execute(self, context):
        run_listener()

        return {"FINISHED"}

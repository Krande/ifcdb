import os
import requests

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

    QueueClient.from_connection_string(os.environ.get("AZ_QUEUE_CONN_STR"), os.environ.get("AZ_QUEUE_NAME"))


def login_and_get_access_token() -> str:
    from azure.identity import InteractiveBrowserCredential

    cred = InteractiveBrowserCredential(
        client_id=os.environ.get("AZ_BL_API_CLIENT_ID"), tenant_id=os.environ.get("AZ_TENANT_ID")
    )

    return cred.get_token(f'api://{os.environ.get("AZ_CLIENT_ID")}/.default').token


class IfcDb_Login_Operator(bpy.types.Operator):
    bl_idname = "view3d.ifc_db_login"
    bl_label = "Login"
    bl_description = "Login"

    def execute(self, context):
        print("User Login shall take place here")
        scene = context.scene
        scene.IfcDb_Connection_Props.conn_jwt_token = login_and_get_access_token()
        return {"FINISHED"}


class IfcDb_Pull_Operator(bpy.types.Operator):
    bl_idname = "view3d.ifc_db_pull"
    bl_label = "Pull"
    bl_description = "Pull"

    def execute(self, context):
        print("Pulling of IFC data should start now")
        props = context.scene.IfcDb_Connection_Props
        token = props.conn_jwt_token
        if token == "":
            print("Please Log in first")
            return {"FINISHED"}
        api_url = props.conn_api_url

        r = requests.get(
            f"{api_url}/users", headers={"Authorization": f"Bearer {token}"}, params={"dbname": props.db_name}
        )
        print("REST RESPONSE: " + r.text)

        return {"FINISHED"}


class IfcDb_Push_Operator(bpy.types.Operator):
    bl_idname = "view3d.ifc_db_push"
    bl_label = "Push"
    bl_description = "Push"

    def execute(self, context):
        print("Pushing of IFC data should start now")
        props = context.scene.IfcDb_Connection_Props
        token = props.conn_jwt_token
        if token == "":
            print("Please Log in first")
            return {"FINISHED"}

        api_url = props.conn_api_url
        print(f'Pushing User as IfcPerson to "{props.db_name}"')
        r = requests.post(
            f"{api_url}/users", headers={"Authorization": f"Bearer {token}"}, params={"dbname": props.db_name}
        )
        print("REST RESPONSE: " + r.text)

        return {"FINISHED"}


class IfcDb_Live_Operator(bpy.types.Operator):
    bl_idname = "view3d.ifc_db_live"
    bl_label = "Go Live"
    bl_description = "Listen to live updates from the IfcDb"

    def execute(self, context):
        props = context.scene.IfcDb_Connection_Props
        token = props.conn_jwt_token
        if token == "":
            print("Please Log in first")
            return {"FINISHED"}
        run_listener()

        return {"FINISHED"}

from __future__ import annotations

import os

import bpy
import requests


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


def create_session(context) -> requests.Session | None:
    props = context.scene.IfcDb_Connection_Props
    token = props.conn_jwt_token
    if token == "":
        print("No token found. Logging User into Azure")
        props.conn_jwt_token = login_and_get_access_token()
        token = props.conn_jwt_token

    s = requests.Session()
    s.headers = {"Authorization": f"Bearer {token}"}

    return s


def login_and_get_access_token() -> str:
    from azure.identity import InteractiveBrowserCredential

    cred = InteractiveBrowserCredential(
        client_id=os.environ.get("AZ_BL_API_CLIENT_ID"), tenant_id=os.environ.get("AZ_TENANT_ID")
    )
    token = cred.get_token(f'api://{os.environ.get("AZ_CLIENT_ID")}/.default').token
    print('Succesfully Logged into Azure')
    return token


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
        api_url = props.conn_api_url
        s = create_session(context)
        if s is None:
            return {"FINISHED"}

        r = s.get(f"{api_url}/users", params={"dbname": props.db_name})
        print("REST RESPONSE: " + r.text)

        return {"FINISHED"}


class IfcDb_Push_Operator(bpy.types.Operator):
    bl_idname = "view3d.ifc_db_push"
    bl_label = "Push"
    bl_description = "Push"

    def execute(self, context):
        print("Pushing of IFC data should start now")
        props = context.scene.IfcDb_Connection_Props
        api_url = props.conn_api_url

        s = create_session(context)
        r = s.post(f"{api_url}/users", params={"dbname": props.db_name})
        print("REST RESPONSE: " + r.text)

        return {"FINISHED"}


class IfcDb_Live_Operator(bpy.types.Operator):
    bl_idname = "view3d.ifc_db_live"
    bl_label = "Go Live"
    bl_description = "Listen to live updates from the IfcDb"

    def execute(self, context):
        # props = context.scene.IfcDb_Connection_Props
        # s = create_session(context)
        run_listener()

        return {"FINISHED"}


def push_objects():
    """Simple example where this loops over geometries and exports them"""
    import ifcopenshell
    from blenderbim.bim.ifc import IfcStore

    # from blenderbim import tool
    # import blenderbim.core.geometry as core
    meshes = dict()
    ifc_file = IfcStore.get_file()
    for obj in IfcStore.id_map.values():
        ifc_elem = IfcStore.get_file().by_id(obj.BIMObjectProperties.ifc_definition_id)
        assert isinstance(ifc_elem, ifcopenshell.entity_instance)
        res = ifc_elem.get_info_2(recursive=True)
        print(res)
        print(ifc_elem)
        if obj.type == "MESH":
            # res = core.get_representation_ifc_parameters(tool.Geometry, obj=obj)
            mesh = obj.to_mesh()
            verts = []
            faces = []
            for vert in mesh.vertices.values():
                verts.append(tuple(vert.undeformed_co))
            for face in mesh.polygons:
                faces.append(tuple(face.vertices))

from __future__ import annotations

import pathlib

import bpy
import ifcopenshell.api
import os
import requests
from bpy.app.handlers import persistent

import blenderbim.core.project as core
import blenderbim.tool as tool
from blenderbim.bim.ifc import IfcStore
from blenderbim.bim.module.model import product

import tempfile

@persistent
def load_post(*args):
    ifcopenshell.api.add_post_listener(
        "geometry.add_representation", "BlenderBIM.Product.GenerateBox", product.generate_box
    )


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
    print("Successfully Logged into Azure")
    return token


class IfcDb_Login_Operator(bpy.types.Operator):
    bl_idname = "view3d.ifc_db_login"
    bl_label = "Login"
    bl_description = "Login"

    def execute(self, context):
        props = context.scene.IfcDb_Connection_Props

        s = create_session(context)
        # Use token to query the REST /users endpoint to add user as IfcPerson to IfcDb and return the class as json
        r = s.post(f"{props.conn_api_url}/users", params={"dbname": props.db_name})
        user_data = r.json()

        # Initialize a project
        IfcStore.begin_transaction(self)
        IfcStore.add_transaction_operation(self, rollback=self.rollback, commit=lambda data: True)
        self._execute(context)
        self.transaction_data = {"file": tool.Ifc.get()}
        IfcStore.add_transaction_operation(self, rollback=lambda data: True, commit=self.commit)
        IfcStore.end_transaction(self)

        ifc = IfcStore.get_file()
        person = ifc.createIfcPerson(**user_data)
        bpy.context.scene.BIMOwnerProperties.active_person_id = person.id()

        return {"FINISHED"}

    def _execute(self, context):
        props = context.scene.BIMProjectProperties
        template = None if props.template_file == "0" else props.template_file
        core.create_project(tool.Ifc, tool.Project, schema=props.export_schema, template=template)

    def rollback(self, data):
        IfcStore.file = None

    def commit(self, data):
        IfcStore.file = data["file"]


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

        r = s.get(f"{api_url}/file", params={"dbname": props.db_name})
        ifc_str = str(r.content[1:-1], encoding="utf8").replace(r'\n', '\n')
        IfcStore.purge()
        temp_dir = tempfile.gettempdir()
        tmp_file = pathlib.Path(temp_dir) / 'temp.ifc'
        print(f'Writing to "{tmp_file}"')
        with open(tmp_file, 'w') as f:
            f.write(ifc_str)

        tmp_file = str(tmp_file)
        IfcStore.load_file(tmp_file)
        context.scene.BIMProperties.ifc_file = tmp_file
        context.scene.BIMProjectProperties.is_loading = True
        context.scene.BIMProjectProperties.total_elements = len(tool.Ifc.get().by_type("IfcElement"))

        bpy.ops.bim.load_project_elements()
        # bpy.ops.bim.load_project(filepath=str(tmp_file))
        # IfcStore.load_file(tmp_file)
        # new_ifc = ifcopenshell.file.from_string(r.text)
        # ifc: ifcopenshell.file = IfcStore.get_file()
        #
        # for elem in new_ifc:
        #     print(f'adding "elem"')
        #     ifc.add(elem)

        # bpy.ops.bim.load_project_elements()
        # print("REST RESPONSE: " + r.text)

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

        ifc: ifcopenshell.file = IfcStore.get_file()
        ifc_str = ifc.wrapped_data.to_string()
        print(api_url)
        r = s.post(f"{api_url}/file", params={"dbname": props.db_name, "ifc_file_str": ifc_str})
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

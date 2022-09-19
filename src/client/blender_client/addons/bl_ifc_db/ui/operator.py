from __future__ import annotations

import logging
import os
import pathlib
import tempfile

import blenderbim.tool as tool
import bpy
import ifcopenshell.api
import ifcopenshell.util.element
import requests
from blenderbim.bim.ifc import IfcStore


def run_listener():
    try:
        from azure.storage.queue import QueueClient
    except ModuleNotFoundError:
        raise ModuleNotFoundError(
            "Unable to find Azure Storage Queue package. Please install using 'pip install azure-storage-queue'"
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

        props.username = user_data["FamilyName"]
        props.identification = user_data["Identification"]

        return {"FINISHED"}


class IfcDb_Pull_Operator(bpy.types.Operator):
    bl_idname = "view3d.ifc_db_pull"
    bl_label = "Pull"
    bl_description = "Pull"

    def execute(self, context):
        props = context.scene.IfcDb_Connection_Props
        api_url = props.conn_api_url
        s = create_session(context)
        if s is None:
            return {"FINISHED"}

        r = s.get(f"{api_url}/file", params={"dbname": props.db_name})
        if r.status_code != 201:
            logging.error(f"{r.text=}")
            return {"FINISHED"}

        ifc_str = str(r.content[1:-1], encoding="utf8").replace(r"\n", "\n")

        if IfcStore.file is None:
            self.load_new_project(context, ifc_str, props)
        else:
            self.merge_into_existing_project(context, ifc_str, props)

        return {"FINISHED"}

    def load_new_project(self, context, ifc_str, props):
        temp_dir = tempfile.gettempdir()
        tmp_file = pathlib.Path(temp_dir) / "temp_.ifc"

        print(f'Writing to temporary IFC file "{tmp_file}"')
        with open(tmp_file, "w") as f:
            f.write(ifc_str)

        tmp_file = str(tmp_file)
        try:
            IfcStore.load_file(tmp_file)
        except ifcopenshell.Error as e:
            logging.error(f"{tmp_file=}\n\n{ifc_str=}")
            raise ifcopenshell.Error(e)

        context.scene.BIMProperties.ifc_file = tmp_file
        context.scene.BIMProjectProperties.is_loading = True
        context.scene.BIMProjectProperties.total_elements = len(tool.Ifc.get().by_type("IfcElement"))

        ifc: ifcopenshell.file = IfcStore.get_file()
        if len(list(ifc.by_type("IfcRoot"))) == 0:
            print("Downloaded IFC model has no rooted elements.")
            return None

        people = {ifcp.Identification: ifcp for ifcp in ifc.by_type("IfcPerson")}

        current_user = people.get(props.identification, None)
        if current_user is None:
            current_user = ifc.createIfcPerson(FamilyName=props.username, Identification=props.identification)
        else:
            print(f'user "{current_user.Identification}" already exists in DB')

        bpy.context.scene.BIMOwnerProperties.active_person_id = current_user.id()

        bpy.ops.bim.load_project_elements()

    def merge_into_existing_project(self, context, ifc_str, props):
        print("Updating model with latest data from IFC DB")
        fold: ifcopenshell.file = IfcStore.get_file()
        fnew = ifcopenshell.file.from_string(ifc_str)
        # For now loop over rooted elements and
        original_project = fold.by_type("IfcProject")[0]
        merged_project = fold.add(fold.by_type("IfcProject")[0])

        compare_ifcopenshell_objects_element_by_element(fold, fnew)

        for element in fnew.by_type("IfcRoot"):
            print(f'Adding element "{element}"')
            existing_element = fold.by_guid(element.GlobalId)
            if existing_element is None:
                fold.add(element)
            else:
                ifcopenshell.util.element.replace_attribute(existing_element, merged_project, original_project)
            print(f"element: {element}, existing: {existing_element}")


class IfcDb_Push_Operator(bpy.types.Operator):
    bl_idname = "view3d.ifc_db_push"
    bl_label = "Push"
    bl_description = "Push"

    def execute(self, context):
        print("Pushing of IFC data should start now")
        props = context.scene.IfcDb_Connection_Props
        api_url = props.conn_api_url

        s = create_session(context)
        if IfcStore.file is None:
            logging.warning("IFC project path not found. Please save project before attempting to push")
            return {"FINISHED"}

        print(api_url)
        files = {"file": open(IfcStore.path, "rb")}
        print(files)
        r = s.post(f"{api_url}/fileb", params={"dbname": props.db_name}, files=files)

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


def fingerprint(file: ifcopenshell.file):
    get_info_props = dict(include_identifier=False, recursive=True, return_type=frozenset)
    return frozenset(inst.get_info(**get_info_props) for inst in file)


def compare_ifcopenshell_objects_element_by_element(f1: ifcopenshell.file, f2: ifcopenshell.file):
    results = sorted(fingerprint(f1).symmetric_difference(fingerprint(f2)), key=lambda x: len(str(x)))

    res = [set([name for name, value in result]) for result in results]

    matches = []
    i = 0
    while i < len(res):
        x = res[i]
        for k, match_eval in enumerate(res):
            if k == i or x != match_eval:
                continue
            found = tuple(sorted([i, k]))
            if found not in matches:
                matches.append(found)
            break
        i += 1

    # Compare element by element
    for a, b in matches:
        m_a = {key: value for key, value in results[a]}
        m_b = {key: value for key, value in results[b]}
        ifc_class = m_a["type"]
        for key, value in m_a.items():
            other_val = m_b[key]
            if isinstance(value, frozenset):
                continue
            if isinstance(value, tuple) and isinstance(value[0], frozenset):
                continue
            if other_val != value:
                logging.error(f'Diff in Ifc Class "{ifc_class}" property: {key} := "{value}" != "{other_val}"')

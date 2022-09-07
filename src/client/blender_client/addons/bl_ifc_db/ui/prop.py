from bpy.props import CollectionProperty, StringProperty
from bpy.types import PropertyGroup


class IfcDbChanges(PropertyGroup):
    guid: StringProperty(name="GUID")
    reference: StringProperty(name="Reference")
    description: StringProperty(name="Description")


class IfcDb_Connection_Props(PropertyGroup):
    db_name: StringProperty(default="ifc001", name="IfcDb name", description="Name of database")
    conn_api_url: StringProperty(default="http://localhost:8000", name="API url", description="REST api url")
    conn_jwt_token: StringProperty(default="", name="IfcDb api JWT token", description="API JWT token")

    username: StringProperty(default="", name="User name", description="Name of user")
    identification: StringProperty(default="", name="User ID", description="User identification")
    changes: CollectionProperty(name="IFC Changes", type=IfcDbChanges)

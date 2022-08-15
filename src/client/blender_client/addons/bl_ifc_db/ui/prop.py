from bpy.props import BoolProperty, FloatProperty, FloatVectorProperty, StringProperty
from bpy.types import PropertyGroup


class IfcDb_Connection_Props(PropertyGroup):
    conn_db_name: StringProperty(default="edgedb", name="IfcDb name", description="Name of database")
    conn_api_url: StringProperty(default="localhost:5000", name="IfcDb Rest api url", description="IfcDb Rest api url")
    conn_jwt_token: StringProperty(default="none", name="IfcDb api JWT token", description="IfcDb api JWT token")

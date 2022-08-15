import bpy

from . import operator, panel, prop

classes = [
    # Props
    prop.IfcDb_Connection_Props,
    # Operators
    operator.IfcDb_Login_Operator,
    operator.IfcDb_Pull_Operator,
    operator.IfcDb_Push_Operator,
    operator.IfcDb_Live_Operator,
    # Panels
    panel.IFC_DB_MAIN_PT_Panel,
]


def register():
    for cls in classes:
        bpy.utils.register_class(cls)

    bpy.types.Scene.IfcDb_Connection_Props = bpy.props.PointerProperty(type=prop.IfcDb_Connection_Props)


def unregister():
    for cls in classes:
        bpy.utils.unregister_class(cls)

    del bpy.types.Scene.IfcDb_Connection_Props

from __future__ import annotations

from typing import Any

import ifcopenshell

from ifcdb.schema.new_model import DbLink, DbProp


def check_prop(prop: DbProp, ifc_entity_value: Any):
    if prop.is_enum is True:
        if ifc_entity_value in prop.prop_value:
            return True
        return False

    if prop.array_def is not None:
        if isinstance(ifc_entity_value, tuple) is False:
            return False
        curr_level = ifc_entity_value
        for shape in prop.array_def.shapes:
            if shape.lower_bound > len(curr_level) > shape.upper_bound:
                return False
            curr_level = ifc_entity_value[0]

        content = curr_level
        if prop.prop_value == "float64" and isinstance(content, float) is True:
            return True

        raise NotImplementedError()

    if prop.prop_value == "str" and isinstance(ifc_entity_value, str):
        return True

    if prop.prop_value == "int64" and isinstance(ifc_entity_value, int):
        return True

    if prop.prop_value == "float64" and isinstance(ifc_entity_value, float):
        return True

    raise NotImplementedError()


def check_link(link: DbLink, ifc_entity_value: Any):
    if isinstance(ifc_entity_value, ifcopenshell.entity_instance) is False:
        return False

    raise NotImplementedError()


def is_valid(prop: DbProp | DbLink, ifc_entity_value: Any):
    if prop.optional is True and ifc_entity_value is None:
        return True

    if isinstance(prop, DbProp):
        return check_prop(prop, ifc_entity_value)
    else:
        return check_link(prop, ifc_entity_value)

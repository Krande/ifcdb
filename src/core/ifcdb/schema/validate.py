from __future__ import annotations

from typing import Any

from ifcdb.entities import Entity
from ifcdb.schema.new_model import DbEntity, DbLink, DbProp


def check_prop(prop: DbProp, ifc_entity_value: Any):
    if prop.optional is True and ifc_entity_value is None:
        return True

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

    return check_prop_value(prop, ifc_entity_value)


def check_prop_value(prop: DbProp, ifc_entity_value):
    if prop.prop_value == "str" and isinstance(ifc_entity_value, str):
        return True

    if prop.prop_value == "int64" and isinstance(ifc_entity_value, int):
        return True

    if prop.prop_value == "float64" and isinstance(ifc_entity_value, float):
        return True

    return False


def check_array_link(link: DbLink, entity: tuple[Entity]):
    if isinstance(entity, tuple) is False:
        raise ValueError()

    # array_def = link.array_def
    entity0 = entity[0]
    db_entity = link.get_value_if_valid_linked_to(entity0.name)
    if db_entity.name != entity0.name:
        db_entity = link.get_derived_type(entity0.name)

    return check_entity_props(entity0, db_entity)


def check_entity_props(entity: Entity, db_entity: DbEntity):
    if "wrappedValue" in entity.props.keys():
        db_prop = db_entity.props.get(db_entity.name)
        return check_prop_value(db_prop, entity.props["wrappedValue"])

    all_props = db_entity.get_all_props()
    for key, value in entity.props.items():
        db_prop = all_props.get(key)
        if isinstance(db_prop, DbProp):
            result = check_prop(db_prop, value)
        else:
            result = check_link(db_prop, value)
        if result is False:
            return False
    return True


def check_link(link: DbLink, entity: Entity | tuple[Entity]):
    if link.optional is True and entity is None:
        return True

    if link.array_def is not None:
        return check_array_link(link, entity)
    else:
        if isinstance(entity, tuple):
            raise ValueError()

    db_entity = link.get_value_if_valid_linked_to(entity.name)

    if db_entity is None:
        raise ValueError()

    if db_entity.name != entity.name:
        db_entity = link.get_derived_type(entity.name)

    return check_entity_props(entity, db_entity)


def is_valid(db_prop: DbProp | DbLink, ifc_entity_value: Any):
    if db_prop.optional is True and ifc_entity_value is None:
        return True

    if isinstance(db_prop, DbProp):
        result = check_prop(db_prop, ifc_entity_value)
    else:
        result = check_link(db_prop, ifc_entity_value)

    return result

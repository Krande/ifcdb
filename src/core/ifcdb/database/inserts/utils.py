from __future__ import annotations

from ifcdb.entities import Entity


def props_str(entity: Entity):
    return ",\n".join([f"{key}:= {value}" for key, value in entity.props.items()])


def links_str(entity: Entity):
    lstr = ""
    for key, value in entity.links.items():
        if isinstance(value, Entity):
            value = [value]

        for v in value:
            if v.uuid is None:
                value_str = to_insert_str(v)
            else:
                value_str = f'SELECT {v.name} filter .id = <uuid>"{v.uuid}"'
            lstr += f"{key}:= ({value_str}),\n"
    return lstr


def to_insert_str(entity: Entity):
    prop_str = props_str(entity)
    lstr = links_str(entity)
    if prop_str != '':
        prop_str += ',\n'
    return f"INSERT {entity.name} {{\n    {prop_str}{lstr} }};"

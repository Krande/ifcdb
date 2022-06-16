from __future__ import annotations

import logging
import os
import subprocess

import ifcopenshell

from ifcdb.interop.edge_model.edge_model_base import (
    ArrayEdgeModel,
    AttributeEdgeModel,
    EdgeModel,
    SelectEdgeModel,
)
from itertools import count

_INSERT_COUNTER = count(start=1)


def create_local_instance(server_name):
    """
    Called after the Session object has been created and
    before performing collection and entering the run test loop.
    """
    edgedb_exe = os.environ.get("EDGEDB_EXE", "edgedb")
    subprocess.run(f"{edgedb_exe} instance destroy {server_name} --force", shell=True)
    subprocess.run(f"{edgedb_exe} instance create {server_name}", shell=True)


def get_att_str(
    att: AttributeEdgeModel,
    entity: ifcopenshell.entity_instance,
    em: EdgeModel,
    uuid_map: dict = None,
    with_map: dict[str, str] = None,
) -> str | None:
    res = getattr(entity, att.name)
    att_ref = att.get_type_ref()
    name = att.name

    if name is None:
        raise ValueError()
    if res is None:
        logging.debug(f'Property att: "{name}" is None')
        return None

    if isinstance(res, str):
        value_str = f"'{res}'"
    elif (
        isinstance(res, tuple)
        and isinstance(att_ref, ArrayEdgeModel)
        and isinstance(res[0], ifcopenshell.entity_instance)
    ):
        value_str = "{"
        value_str += ','.join([insert_ifc_entity(r, uuid_map, att_ref, with_map, em) for r in res])
        value_str += "}"
    elif isinstance(res, tuple) and isinstance(att_ref, ArrayEdgeModel):
        levels = att_ref.get_levels()
        num_levels = len(levels)
        curr_level = levels[-1]
        ptype = att_ref.parameter_type
        b1 = curr_level.bound1()
        b2 = curr_level.bound2()
        if num_levels > 1 and isinstance(ptype, str) is False:
            if att.needs_intermediate_class_str is True and att.intermediate_class_name is not None:
                int_class = att.intermediate_class_name
                value_str = "{"
                for i, x in enumerate(res, start=1):
                    int_name = f"{int_class}_{next(_INSERT_COUNTER)}"
                    int_value_str = "{"
                    int_value_str += ",".join([insert_ifc_entity(r, uuid_map, att_ref, with_map, em) for r in x])
                    int_value_str += "}"
                    with_map[int_name] = f"(INSERT {int_class} {{ {ptype.name}s := {int_value_str} }})"
                    value_str += int_name
                    value_str += "," if i != len(res) else ""

                value_str += "}"
            else:
                value_str = "["
                for x in res:
                    value_str += "("
                    value_str += ",".join([f"{insert_ifc_entity(r, uuid_map, att_ref, with_map, em)}" for r in x])
                    value_str += "),"
                value_str += "]"
        elif num_levels > 1 and isinstance(ptype, str):
            value_str = list(res)
        else:
            if b1 != b2 and b2 != -1:
                res = list(res)
            value_str = res
    elif isinstance(res, tuple) and isinstance(att_ref, ArrayEdgeModel) is False:
        value_str = res
    elif isinstance(res, (int, float)):
        value_str = res
    elif isinstance(res, ifcopenshell.entity_instance):
        value_str = insert_ifc_entity(res, uuid_map, att_ref, with_map, em)
    else:
        raise NotImplementedError(f'Currently not added support for att: "{name}" -> {type(res)}')

    return f"{name} := {value_str}"


def insert_ifc_entity(res, uuid_map, att_ref, with_map, em: EdgeModel) -> str:
    uuid_obj = uuid_map.get(res, None)

    if uuid_obj is None:
        entity_str = f"({em.get_entity_insert_str(res, uuid_map=uuid_map, with_map=with_map)})"
    else:
        res_name = res.is_a()
        entity_str = f'(SELECT {res_name} filter .id = <uuid>"{uuid_obj}")'

    res_id = res.id()
    if isinstance(att_ref, ArrayEdgeModel):
        ptype = att_ref.parameter_type
        if isinstance(ptype, SelectEdgeModel):
            aname = ptype.name
            unique_ref_name_a = f"ifc_{res_id + 100000}"
            with_map[unique_ref_name_a] = entity_str
            ref_str = f"(INSERT {aname} {{ {aname} := {unique_ref_name_a} }})"
        else:
            ref_str = entity_str
    elif isinstance(att_ref, SelectEdgeModel):
        aname = att_ref.name
        unique_ref_name_a = f"ifc_{res_id + 100000}"
        with_map[unique_ref_name_a] = entity_str
        ref_str = f"(INSERT {aname} {{ {aname} := {unique_ref_name_a} }})"
    else:
        ref_str = entity_str

    unique_ref_name = f"ifc_{res_id}"
    with_map[unique_ref_name] = ref_str
    return unique_ref_name

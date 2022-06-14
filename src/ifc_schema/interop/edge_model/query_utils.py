from __future__ import annotations

import logging
import os
import subprocess

import ifcopenshell

from ifc_schema.interop.edge_model.edge_model_base import (ArrayEdgeModel,
                                                           AttributeEdgeModel,
                                                           EdgeModel,
                                                           SelectEdgeModel)


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
        for i, r in enumerate(res):
            value_str += insert_ifc_entity(r, uuid_map, att_ref, with_map, em)
            value_str += "" if i == len(r) - 1 else ","
        value_str += "}"
    elif isinstance(res, tuple) and isinstance(att_ref, ArrayEdgeModel):
        if isinstance(res[0], tuple):
            value_str = list(res)
        else:
            value_str = res
    elif isinstance(res, tuple) and isinstance(att_ref, ArrayEdgeModel) is False:
        value_str = res
    elif isinstance(res, (int, float)):
        value_str = res
    elif isinstance(res, ifcopenshell.entity_instance):
        value_str = insert_ifc_entity(res, uuid_map, att_ref, with_map, em)
    else:
        raise NotImplementedError(
            f'Currently not added support for att: "{name}" -> {type(res)}'
        )

    return f"{name} := {value_str}"


def insert_ifc_entity(res, uuid_map, att_ref, with_map, em: EdgeModel) -> str:
    uuid_obj = uuid_map.get(res, None)

    if uuid_obj is None:
        entity_str = f"({em.get_entity_insert_str(res)})"
    else:
        res_name = res.is_a()
        entity_str = f'(SELECT {res_name} filter .id = <uuid>"{uuid_obj}")'

    if isinstance(att_ref, ArrayEdgeModel):
        ptype = att_ref.parameter_type
        if isinstance(ptype, SelectEdgeModel):
            aname = ptype.name
            unique_ref_name_a = f"ifc_{res.id() + 100000}"
            with_map[unique_ref_name_a] = entity_str
            ref_str = f"(INSERT {aname} {{ {aname} := {unique_ref_name_a} }})"
        else:
            ref_str = entity_str
    elif isinstance(att_ref, SelectEdgeModel):
        aname = att_ref.name
        unique_ref_name_a = f"ifc_{res.id() + 100000}"
        with_map[unique_ref_name_a] = entity_str
        ref_str = f"(INSERT {aname} {{ {aname} := {unique_ref_name_a} }})"
    else:
        ref_str = entity_str

    unique_ref_name = f"ifc_{res.id()}"
    with_map[unique_ref_name] = ref_str
    return unique_ref_name

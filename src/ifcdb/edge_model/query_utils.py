from __future__ import annotations

import logging
import os
import subprocess
from itertools import count

import ifcopenshell

from ifcdb.edge_model.schema_gen import (
    ArrayEdgeModel,
    AttributeEdgeModel,
    EdgeModel,
    SelectEdgeModel,
)
from ifcdb.ifcdiff import IfcDiff

_INSERT_COUNTER = count(start=1)


def create_local_instance(server_name):
    """
    Called after the Session object has been created and
    before performing collection and entering the run test loop.
    """
    edgedb_exe = os.environ.get("EDGEDB_EXE", "edgedb")
    subprocess.run(f"{edgedb_exe} instance destroy {server_name} --force", shell=True)
    subprocess.run(f"{edgedb_exe} instance create {server_name}", shell=True)


def get_att_insert_str(
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
        value_str += ",".join([insert_ifc_entity(r, uuid_map, att_ref, with_map, em) for r in res])
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


def validate_ifc_content(ofile: ifcopenshell.file, results: dict):
    obj_set = {key: value for key, value in results[0].items() if len(value) != 0}

    # Try to manually edit a single property to ensure that it fails if discrepancies are found
    # obj_set["IfcCartesianPointList3D"][0]["CoordList"][0][1] = 200

    for ifc_class, instances in obj_set.items():
        for instance in instances:
            original_instance_found = False
            ifc_class_entities = list(ofile.by_type(ifc_class, True))
            for original_instance in ifc_class_entities:
                match_found = True
                for prop_name, prop_value in instance.items():
                    if prop_name == "id":
                        continue
                    if isinstance(prop_value, (list, tuple)) and len(prop_value) == 0:
                        prop_value = None
                    inst_value = getattr(original_instance, prop_name)
                    if isinstance(inst_value, ifcopenshell.entity_instance):
                        continue
                    elif isinstance(inst_value, (list, tuple)) and isinstance(
                        inst_value[0], ifcopenshell.entity_instance
                    ):
                        if len(inst_value) != len(prop_value):
                            match_found = False
                            break
                    elif isinstance(inst_value, (list, tuple)) and isinstance(inst_value[0], float):
                        for x, y in zip(inst_value, prop_value):
                            if x != y:
                                match_found = False
                                break
                    elif isinstance(inst_value, (list, tuple)) and isinstance(inst_value[0], (list, tuple)):
                        for a1, a2 in zip(inst_value, prop_value):
                            for x, y in zip(a1, a2):
                                if x != y:
                                    match_found = False
                                    break
                    else:
                        if inst_value != prop_value:
                            match_found = False
                            break
                if match_found is True:
                    original_instance_found = True
                    break

            if len(ifc_class_entities) > 0 and original_instance_found is False:
                entity_description = "[" + ",\n".join([str(x) for x in ifc_class_entities]) + "]"
                raise ValueError(f'Instance "{instance}" not found among\n{entity_description}')

    print("Successfully Validated IFC Content")


def fingerprint(file: ifcopenshell.file):
    get_info_props = dict(include_identifier=False, recursive=True, return_type=frozenset)
    return frozenset(inst.get_info(**get_info_props) for inst in file)


def validate_ifc_objects(f1: ifcopenshell.file, f2: ifcopenshell.file):
    compare_ifcopenshell_objects_element_by_element(f1, f2)

    assert fingerprint(f1) == fingerprint(f2)


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


def validate_using_ifc_diff(
    f1: ifcopenshell.file,
    f2: ifcopenshell.file,
    output_file: str,
    inverse_classes: list[str] = None,
):
    ifc_diff = IfcDiff(f1, f2, output_file, inverse_classes)
    ifc_diff.diff()
    ifc_diff.export()

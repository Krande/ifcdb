from __future__ import annotations

import copy
import logging
from itertools import count

import ifcopenshell
from toposort import toposort_flatten

from ifcdb.schema.model import (
    ArrayModel,
    AttributeModel,
    IfcSchemaModel,
    SelectModel,
)

_INSERT_COUNTER = count(start=1)


def get_att_insert_str(
    att: AttributeModel,
    entity: ifcopenshell.entity_instance,
    em: IfcSchemaModel,
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
        and isinstance(att_ref, ArrayModel)
        and isinstance(res[0], ifcopenshell.entity_instance)
    ):
        value_str = "{"
        value_str += ",".join([insert_ifc_entity(r, uuid_map, att_ref, with_map, em) for r in res])
        value_str += "}"
    elif isinstance(res, tuple) and isinstance(att_ref, ArrayModel):
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
    elif isinstance(res, tuple) and isinstance(att_ref, ArrayModel) is False:
        value_str = res
    elif isinstance(res, (int, float)):
        value_str = res
    elif isinstance(res, ifcopenshell.entity_instance):
        value_str = insert_ifc_entity(res, uuid_map, att_ref, with_map, em)
    else:
        raise NotImplementedError(f'Currently not added support for att: "{name}" -> {type(res)}')

    return f"{name} := {value_str}"


def insert_ifc_entity(res, uuid_map, att_ref, with_map, em: IfcSchemaModel) -> str:
    uuid_obj = uuid_map.get(res, None)

    if uuid_obj is None:
        entity_str = f"({em.get_entity_insert_str(res, uuid_map=uuid_map, with_map=with_map)})"
    else:
        res_name = res.is_a()
        entity_str = f'(SELECT {res_name} filter .id = <uuid>"{uuid_obj}")'

    res_id = res.id()
    if isinstance(att_ref, ArrayModel):
        ptype = att_ref.parameter_type
        if isinstance(ptype, SelectModel):
            aname = ptype.name
            unique_ref_name_a = f"ifc_{res_id + 100000}"
            with_map[unique_ref_name_a] = entity_str
            ref_str = f"(INSERT {aname} {{ {aname} := {unique_ref_name_a} }})"
        else:
            ref_str = entity_str
    elif isinstance(att_ref, SelectModel):
        aname = att_ref.name
        unique_ref_name_a = f"ifc_{res_id + 100000}"
        with_map[unique_ref_name_a] = entity_str
        ref_str = f"(INSERT {aname} {{ {aname} := {unique_ref_name_a} }})"
    else:
        ref_str = entity_str

    unique_ref_name = f"ifc_{res_id}"
    with_map[unique_ref_name] = ref_str
    return unique_ref_name


ID_PARAMS = {"id", "_e_type"}


def get_uuid_refs(data, path="", return_list: list[tuple] = None):
    return_list = [] if return_list is None else return_list
    for element, val in data.items():
        if isinstance(val, dict):
            if len(set(val.keys()).difference(ID_PARAMS)) == 0:
                return_list.append((val, path + element))
                continue
            get_uuid_refs(val, element + "/", return_list)
        elif isinstance(val, list):
            list_path = path + element + "/"
            for i, item in enumerate(val):
                if isinstance(item, dict) and len(set(item.keys()).difference(ID_PARAMS)) == 0:
                    return_list.append((item, path + element))
                    continue
                get_uuid_refs(item, list_path + str(i) + "/", return_list)
        else:
            # logging.debug(path + element, val)
            pass
    return return_list


def dict_value_replace(path, replacement, pointer: dict):
    for key in path[:-1]:
        try:
            key = int(float(key))
        except ValueError:
            pass
        pointer = pointer[key]

    if isinstance(pointer[path[-1]], list):
        pointer[path[-1]].append(replacement)
    else:
        pointer[path[-1]] = replacement
    return True


def get_ids(obj: dict, id_list):
    top_id = obj.get("id", None)
    if top_id is not None:
        id_list.append(top_id)
    for key, value in obj.items():
        if isinstance(value, dict):
            get_ids(value, id_list)
        elif isinstance(value, list):
            for subinst in value:
                if isinstance(subinst, dict):
                    get_ids(subinst, id_list)


def resolve_order_of_result_entities(results: dict, em: IfcSchemaModel) -> list:
    id_map = dict()
    key_map = dict()
    for key, value in results.items():
        for instance in value:
            ids = []
            get_ids(instance, ids)
            instance_id = instance.pop("id")
            ids.pop(ids.index(instance_id))
            if instance_id is None:
                raise ValueError(f'Instance ID is missing for "{instance}"')

            if instance_id in key_map.keys() or instance_id in id_map.keys():
                existing_obj = key_map.get(instance_id)
                existing_ifc_class = existing_obj["class"]
                entity = em.get_entity_by_name(existing_ifc_class)
                ancestors = [x.name for x in entity.get_ancestors()]
                if key in ancestors:
                    logging.debug(f'Skipping Ancestor class "{key}" of existing IFC class "{existing_ifc_class}"')
                    continue
                else:
                    entity = em.get_entity_by_name(key)
                    ancestors = [x.name for x in entity.get_ancestors()]
                    if existing_ifc_class not in ancestors:
                        raise ValueError(f"DB IFC classes {existing_ifc_class} & {key} share uuid but are not related")
                    logging.debug(f'Replacing Ancestor class "{existing_ifc_class}" of existing IFC class "{key}"')

            key_map[instance_id] = {"class": key, "props": instance, "id": instance_id}
            id_map[instance_id] = ids

    result = toposort_flatten(id_map, sort=True)
    output = []
    for x in result:
        key_res = key_map.get(x)
        if key_res is not None:
            output.append(key_res)
        else:
            raise ValueError(f'Unable to find related object uuid "{str(x)}"')

    if None in output:
        raise ValueError("Key Map contains 'None' elements. Likely missing object dependencies in export")

    return output


def flatten_uuid_source(source: dict) -> dict:
    rdict = dict()
    for key, value in source.items():
        if isinstance(value, list) is False:
            raise ValueError("Unknown format of source dictionary")
        for v in value:
            if "id" not in v.keys():
                continue
            rdict[v.pop("id")] = v

    # Replace nested uuids
    ordict = copy.deepcopy(rdict)
    for uuid, obj in ordict.items():
        for key, value in obj.items():
            if isinstance(value, dict):
                res = value.get("id")
                if res is None:
                    raise ValueError("")
                if res not in rdict.keys():
                    print("sd")
                rdict[uuid][key] = rdict[res]

    return rdict


def insert_uuid_objects_from_source(flat_source: dict, destination: dict):
    new_d = dict()
    for key, value in destination.items():
        if isinstance(value, dict) is False:
            new_d[key] = value
            continue

        obj_id = value.pop("id")
        source_res = flat_source[obj_id]
        new_d[key] = source_res

    return new_d

from __future__ import annotations

import copy
import logging
from toposort import toposort_flatten

from ifcdb.schema.model import (
    IfcSchemaModel,
)

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

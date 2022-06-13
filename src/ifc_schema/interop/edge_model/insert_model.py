from __future__ import annotations
import pathlib
import json
import time
import logging
from dataclasses import dataclass
from multiprocessing.pool import ThreadPool
from toposort import toposort_flatten, toposort
from ifc_schema.interop.edge_model.edge_model_base import (
    EdgeModel,
    AttributeEdgeModel,
    ArrayEdgeModel,
    SelectEdgeModel,
    EdgeIO,
)

import edgedb
import ifcopenshell


@dataclass
class IfcToEdge(EdgeIO):


    def upload_ifc_w_threading(self):
        proxy_elements = list(self.ifc_obj.by_type("IFCBuildingElementProxy"))
        num = 10
        num_elements = len(proxy_elements)
        chunks = [proxy_elements[x : x + num] for x in range(0, num_elements, num)]

        total_start = time.time()
        print(f'Beginning Upload of "{num_elements}" IFCBuildingElementProxy elements')
        with ThreadPool(processes=10) as pool:
            start = time.time()
            for i, chunk in enumerate(pool.imap_unordered(self.chunk_uploader, chunks), start=1):
                now = time.time()
                print(f'Finished ({i} of {len(chunks)}) -> {len(chunk)} elements @ "{now - start:.1f}" seconds ')
                start = time.time()
        print(f"Total run time {time.time() - total_start:.1f} seconds")

    def chunk_uploader(self, chunk):
        start = time.time()
        # insert_ifc_building_element_proxies(self.client, chunk)
        diff = time.time() - start
        logging.info(f'Insert complete in "{diff:.1f}" seconds')

        return chunk

    def write_ifc_entities_to_esdl_file(self, esdl_file_path: str | pathlib.Path, module_name: str = "default"):
        unique_entities = self.get_unique_class_entities_of_ifc_content(True)
        self.em.write_entities_to_esdl_file(self.em.get_related_entities(unique_entities), esdl_file_path, module_name)


def insert_ifc(ifc_file, schema_name: str = None, em: EdgeModel = None, instance_name: str = None):
    with IfcToEdge(ifc_file, schema_name=schema_name, em=em, instance_name=instance_name) as ifc:
        for tx in ifc.client.transaction():
            with tx:
                insert_items(ifc, tx)


def insert_items(i2e: IfcToEdge, tx: edgedb.blocking_client):
    ifc_items = i2e.get_ifc_objects_by_sorted_insert_order_flat()
    ifc_items_grouped = i2e.get_ifc_objects_by_sorted_insert_order_grouped()
    res = i2e.get_ifc_dep_map(False)

    uuid_map = dict()

    for i, item in enumerate(ifc_items, start=1):
        entity = i2e.em.get_entity_by_name(item.is_a())
        all_atts = entity.get_entity_atts(item)
        deps = res.get(item, None)
        print(f'inserting ifc item ({i} of {len(ifc_items)}) "{item}"')
        # INSERT block
        with_map = dict()
        insert_str = f"SELECT (INSERT {entity.name} {{\n    "
        for j, att in enumerate(all_atts):
            att_str = get_att_str(att, item, i2e.em, uuid_map=uuid_map, with_map=with_map)
            if j == len(all_atts) - 1:
                comma_str = ""
            else:
                comma_str = ",\n    "

            insert_str += att_str + comma_str
        insert_str += "\n   }\n)"

        with_str = "WITH\n" if len(with_map.keys()) > 0 else ""
        for key, value in with_map.items():
            with_str += 4 * " " + f"{key} := {value},\n"

        total_insert_str = with_str + insert_str
        print(total_insert_str)
        query_res = json.loads(tx.query_single_json(total_insert_str))
        uuid_map[item] = query_res["id"]


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
        raise NotImplementedError(f'Currently not added support for att: "{name}" -> {type(res)}')

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

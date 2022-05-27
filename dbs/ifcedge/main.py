from __future__ import annotations

import logging
import os
import pathlib
from enum import Enum
import asyncio
from multiprocessing.pool import ThreadPool
import pprint
import time

import edgedb
import ifcopenshell

from ifc_schema.interop.edge_model.inserts import insert_ifc_building_element_proxies
from ifc_schema.interop.edge_model.query import get_geometry_by_guid, get_all_proxy_elements


def get_element_proxy_products(ifc_file: pathlib.Path | str) -> list[ifcopenshell.entity_instance]:
    print(f'Reading IFC file "{ifc_file}"')
    ifc = ifcopenshell.open(ifc_file)
    print(f"Reading Complete")
    return list(ifc.by_type("IfcBuildingElementProxy"))


def chunk_uploader(chunk):
    client = edgedb.create_client("edgedb://edgedb@localhost:5656", tls_security="insecure")
    start = time.time()
    insert_ifc_building_element_proxies(client, chunk)
    diff = time.time() - start
    logging.info(f'Insert complete in "{diff:.1f}" seconds')
    client.close()
    return chunk


def upload_ifc_sync(ifc_file):
    client = edgedb.create_client("edgedb://edgedb@localhost:5656", tls_security="insecure")
    # client = edgedb.create_async_client("edgedb://edgedb@localhost:5656", tls_security="insecure", max_concurrency=32)

    proxy_elements = get_element_proxy_products(ifc_file)

    num = 10
    chunks = [proxy_elements[x : x + num] for x in range(0, len(proxy_elements), num)]
    start0 = time.time()
    for i, chunk in enumerate(chunks, start=1):
        start = time.time()
        insert_ifc_building_element_proxies(client, chunk)
        diff = time.time() - start
        print(f'Insert chunk ({i} of {len(chunks)}) @ "{diff:.1f}" seconds')
    diff0 = time.time() - start0
    print(f'Upload completed in "{diff0:.1f}" seconds')

    client.close()


def query(ifc_file=None):
    client = edgedb.create_client("edgedb://edgedb@localhost:5656", tls_security="insecure")
    res2 = get_all_proxy_elements(client)
    # for el in res2:
    #     print(el)
    print(len(res2))
    guid_map = {x["GlobalId"]:x for x in res2}
    # Compare IFC elements with contents of IFC file
    if ifc_file is not None:
        ifc_elements = {x.GlobalId: x for x in get_element_proxy_products(ifc_file)}
        key_set = set(guid_map.keys())
        ifc_set = set(ifc_elements.keys())
        res = key_set.intersection(ifc_set)
        if len(res) != len(res2):
            logging.warning(f'Number of EdgeDB objects found in IFC {len(res)} != {len(res2)} EdgeDB objects ')

        for guid, value in guid_map.items():
            ifc_elem = ifc_elements.get(guid)
            if ifc_elem is None:
                logging.warning(f'EdgeDB object "{value}" is not in IFC file')
                continue
            ifc_repr_len = len(ifc_elem.Representation.Representations)
            edge_elem_len = len(value['Representation']['Representations'])
            if ifc_repr_len != edge_elem_len:
                logging.warning(f'Length of representation of "{guid}" is wrong')

    # res = get_geometry_by_guid(client, "1kTvXnbbzCWw8lcMd1dR4o")
    # pprint.pprint(res2)
    client.close()


def upload_ifc_w_threading(ifc_file):
    proxy_elements = get_element_proxy_products(ifc_file)
    num = 10
    num_elements = len(proxy_elements)
    chunks = [proxy_elements[x : x + num] for x in range(0, num_elements, num)]

    total_start = time.time()
    print(f'Beginning Upload of "{num_elements}" IFCBuildingElementProxy elements')
    with ThreadPool(processes=10) as pool:
        start = time.time()
        for i, chunk in enumerate(pool.imap_unordered(chunk_uploader, chunks), start=1):
            now = time.time()
            print(f'Finished ({i} of {len(chunks)}) -> {len(chunk)} elements @ "{now - start:.1f}" seconds ')
            start = time.time()
    print(f"Total run time {time.time() - total_start:.1f} seconds")


class UploadTypes(Enum):
    SYNC = 1
    THREADING = 2
    ASYNC = 3


def main(ifc_file, upload_type: UploadTypes):
    if upload_type == UploadTypes.SYNC:
        upload_ifc_sync(ifc_file)
    elif upload_type == UploadTypes.THREADING:
        upload_ifc_w_threading(ifc_file)
    elif upload_type == UploadTypes.ASYNC:
        # asyncio.run(upload_ifc_async(ifc_file))
        raise NotImplementedError("ASYNC is not yet added")
    else:
        raise ValueError("Unknown Upload type")


if __name__ == "__main__":
    # ifc = rf"{os.environ.get('TESTFILES')}\LargeStru1.ifc"
    ifc = "../../files/tessellated-item.ifc"
    # main(ifc, UploadTypes.THREADING)
    query(ifc)

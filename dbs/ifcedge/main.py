from __future__ import annotations

import logging
import pathlib
import asyncio
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
    return chunk


async def main(ifc_file):
    client = edgedb.create_client("edgedb://edgedb@localhost:5656", tls_security="insecure")
    # client = edgedb.create_async_client("edgedb://edgedb@localhost:5656", tls_security="insecure", max_concurrency=32)

    proxy_elements = get_element_proxy_products(ifc_file)

    num = 10
    chunks = [proxy_elements[x : x + num] for x in range(0, len(proxy_elements), num)]
    start0 = time.time()
    for i, chunk in enumerate(chunks, start=1):
        start = time.time()
        await insert_ifc_building_element_proxies(client, chunk)
        diff = time.time() - start
        print(f'Insert chunk ({i} of {len(chunks)}) @ "{diff:.1f}" seconds')
    diff0 = time.time() - start0
    print(f'Upload completed in "{diff0:.1f}" seconds')

    client.close()


def query():
    client = edgedb.create_client("edgedb://edgedb@localhost:5656", tls_security="insecure")
    res2 = get_all_proxy_elements(client)

    for el in res2:
        print(el)
    print(len(res2))
    # res = get_geometry_by_guid(client, "1kTvXnbbzCWw8lcMd1dR4o")
    # pprint.pprint(res2)


def main2(ifc_file):
    from multiprocessing.pool import ThreadPool

    proxy_elements = get_element_proxy_products(ifc_file)
    num = 10
    num_elements = len(proxy_elements)
    chunks = [proxy_elements[x: x + num] for x in range(0, num_elements, num)]
    total_start = time.time()
    print(f'Beginning Upload of "{num_elements}" IFCBuildingElementProxy elements')
    with ThreadPool(processes=12) as pool:
        start = time.time()
        for i, chunk in enumerate(pool.imap_unordered(chunk_uploader, chunks), start=1):
            now = time.time()
            print(f'Finished ({i} of {len(chunks)}) @ "{now - start:.1f}" seconds ')
            start = time.time()
    print(f"Total run time {time.time() - total_start:.1f} seconds")


if __name__ == "__main__":
    ifc = r"C:\Users\ofskrand\Desktop\P050-STRU.ifc"
    # ifc = "../../files/tessellated-item.ifc"
    # main(ifc)
    # main2(ifc)
    query()
    # asyncio.run(main(ifc))

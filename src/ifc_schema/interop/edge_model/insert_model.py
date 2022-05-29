import time
import logging
from dataclasses import dataclass
from multiprocessing.pool import ThreadPool

import edgedb
import ifcopenshell


@dataclass
class IfcToEdge:
    ifc_file: str
    ifc_obj: ifcopenshell.file = None
    client: edgedb.Client = None
    wrap: ifcopenshell.ifcopenshell_wrapper = None

    def __enter__(self):
        self.ifc_obj = ifcopenshell.open(self.ifc_file)
        self.client = edgedb.create_client("edgedb://edgedb@localhost:5656", tls_security="insecure")

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.client.close()

    def upload_ifc_w_threading(self):
        proxy_elements = list(self.ifc_obj.by_type('IFCBuildingElementProxy'))
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
        insert_ifc_building_element_proxies(self.client, chunk)
        diff = time.time() - start
        logging.info(f'Insert complete in "{diff:.1f}" seconds')

        return chunk


@dataclass
class IfcEntity:
    ifc_entity: ifcopenshell.entity_instance
    em: Ed

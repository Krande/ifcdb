from __future__ import annotations
import pathlib
import time
import logging
from dataclasses import dataclass
from multiprocessing.pool import ThreadPool
from toposort import toposort_flatten
from ifc_schema.interop.edge_model.edge_model_base import EdgeModel

import edgedb
import ifcopenshell


@dataclass
class IfcToEdge:
    ifc_file: str | pathlib.Path
    em: EdgeModel
    ifc_obj: ifcopenshell.file = None
    client: edgedb.Client = None
    wrap: ifcopenshell.ifcopenshell_wrapper = None
    database: str = None
    port: int | None = 5656
    instance_name: str = None

    def __enter__(self):
        self.ifc_obj = ifcopenshell.open(self.ifc_file)
        if self.instance_name is None:
            conn_str = f"edgedb://edgedb@localhost:{self.port}"
        else:
            conn_str = self.instance_name

        self.client = edgedb.create_client(
            conn_str,
            tls_security="insecure",
            database=self.database,
        )

        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.client.close()

    def get_ifc_objects_by_sorted_insert_order(self):
        dep_map = dict()
        for inst in self.ifc_obj:
            if inst.id() not in dep_map.keys():
                dep_map[inst.id()] = []
            for dep in self.ifc_obj.traverse(inst, max_levels=1)[1:]:
                dep_map[inst.id()].append(dep.id())
        return [self.ifc_obj.by_id(x) for x in toposort_flatten(dep_map, sort=True) if x != 0]

    def get_unique_class_entities_of_ifc_content(self, include_related=False) -> list[str]:
        entities = list(set([x.is_a() for x in self.get_ifc_objects_by_sorted_insert_order()]))
        if include_related is False:
            return entities

        return self.em.get_related_entities(entities)

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
        insert_ifc_building_element_proxies(self.client, chunk)
        diff = time.time() - start
        logging.info(f'Insert complete in "{diff:.1f}" seconds')

        return chunk

    def write_ifc_entities_to_esdl_file(self, esdl_file_path: str | pathlib.Path, module_name: str = "default"):
        unique_entities = self.get_unique_class_entities_of_ifc_content(True)
        self.em.write_entities_to_esdl_file(self.em.get_related_entities(unique_entities), esdl_file_path, module_name)


@dataclass
class IfcEntity:
    ifc_entity: ifcopenshell.entity_instance
    em: Ed

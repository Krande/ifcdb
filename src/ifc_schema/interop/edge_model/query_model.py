from __future__ import annotations

import json
import logging
import os
import pathlib
import subprocess
import time
from dataclasses import dataclass
from io import StringIO
from multiprocessing.pool import ThreadPool
from typing import ClassVar

import edgedb
import ifcopenshell
from toposort import toposort, toposort_flatten

from ifc_schema.interop.edge_model.edge_model_base import AttributeEdgeModel, EdgeModel, EntityEdgeModel


class INSERTS:
    SEQ: ClassVar[str] = "seq"


@dataclass
class IfcIO:
    ifc_file: str | pathlib.Path
    ifc_obj: ifcopenshell.file = None
    edge_io: EdgeIOBase = None

    def __post_init__(self):
        self.ifc_obj = ifcopenshell.open(self.ifc_file)

    def get_ifc_dep_map(self, use_ids=True):
        dep_map = dict()
        for inst in self.ifc_obj:
            id_ref = inst.id() if use_ids else inst
            if id_ref not in dep_map.keys():
                dep_map[id_ref] = []
            for dep in self.ifc_obj.traverse(inst, max_levels=1)[1:]:
                dep_ref = dep.id() if use_ids else dep
                dep_map[id_ref if use_ids else inst].append(dep_ref)
        return dep_map

    def get_ifc_objects_by_sorted_insert_order_flat(self):
        dep_map = self.get_ifc_dep_map()
        return [self.ifc_obj.by_id(x) for x in toposort_flatten(dep_map, sort=True) if x != 0]

    def get_ifc_objects_by_sorted_insert_order_grouped(self):
        dep_map = self.get_ifc_dep_map()
        return [[self.ifc_obj.by_id(x) for x in group if x != 0] for group in toposort(dep_map)]

    def get_unique_class_entities_of_ifc_content(self, include_related=False) -> list[str]:
        entities = list(set([x.is_a() for x in self.get_ifc_objects_by_sorted_insert_order_flat()]))
        if include_related is False:
            return entities

        return self.edge_io.em.get_related_entities(entities)


@dataclass
class EdgeIOBase:
    ifc_file: str | pathlib.Path = None
    ifc_io: IfcIO = None
    schema_name: str = None
    em: EdgeModel = None
    client: edgedb.Client = None
    database: str = None
    port: int | None = 5656
    instance_name: str = None

    def __post_init__(self):
        self.wrap = ifcopenshell.ifcopenshell_wrapper
        if self.em is None:
            self.em = EdgeModel(schema=self.wrap.schema_by_name(self.schema_name))

    @property
    def conn_str(self):
        if self.instance_name is None:
            conn_str = f"edgedb://edgedb@localhost:{self.port}"
        else:
            conn_str = self.instance_name
        return conn_str

    @property
    def cli_prefix(self):
        if self.instance_name is None:
            return f"--tls-security=insecure -P {self.port}"
        else:
            return f"-I {self.instance_name}"

    def __enter__(self):
        if self.ifc_file is not None:
            self.ifc_io = IfcIO(ifc_file=self.ifc_file, edge_io=self)

        self.client = edgedb.create_client(self.conn_str, tls_security="insecure", database=self.database)

        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.client.close()

    # IFC utils

    def create_schema_from_ifc_file(self, dbschema_dir, should_copy_server_files=False):
        from ifc_schema.interop.edge_model.utils import copy_server_files

        dbschema_dir = pathlib.Path(dbschema_dir)
        self.write_ifc_entities_to_esdl_file(dbschema_dir / "default.esdl")

        if should_copy_server_files:
            copy_server_files(dbschema_dir.parent)

    def setup_database(self, dbschema_dir):
        from .query_utils import create_local_instance

        dbschema_dir = pathlib.Path(dbschema_dir).resolve().absolute()

        print(f"Dropping existing database '{self.database}' and creating a new in its place")
        if self.instance_name is not None:
            res = subprocess.run(
                "edgedb instance list",
                shell=True,
                capture_output=True,
                encoding="utf-8",
            )
            if "No instances found" in res.stderr:
                print(f'Creating instance "{self.instance_name}" due to instance query returned -> "{res.stderr}"')
                create_local_instance(self.instance_name)

        client = edgedb.create_client(self.conn_str, tls_security="insecure")
        try:
            print(f"Dropping database {self.database}")
            client.execute(f"DROP database {self.database}")
        except edgedb.errors.UnknownDatabaseError as e:
            logging.error(e)

        print(f"Creating database {self.database}")
        client.execute(f"CREATE DATABASE {self.database}")
        client.close()

        print("Migrating schema to fresh database")
        client = edgedb.create_client(self.conn_str, tls_security="insecure", database=self.database)
        migrations_dir = pathlib.Path(dbschema_dir / "migrations")
        if migrations_dir.exists() is False:
            if dbschema_dir.exists() is False:
                raise NotADirectoryError()

            server_prefix = f"edgedb {self.cli_prefix} migration create --non-interactive"

            print(f'Create Migration using CLI command "{server_prefix}" @"{dbschema_dir}"')
            subprocess.run(server_prefix, cwd=dbschema_dir.parent, shell=True)
            print("CLI command complete")

        for migration_file in os.listdir(migrations_dir):
            with open(migrations_dir / str(migration_file), "r") as f:
                migration_body = f.read()
                client.execute(migration_body)
        client.close()
        print("Migration complete")

    def upload_ifc_w_threading(self):
        proxy_elements = list(self.ifc_io.ifc_obj.by_type("IFCBuildingElementProxy"))
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
        unique_entities = self.ifc_io.get_unique_class_entities_of_ifc_content(True)
        self.em.write_entities_to_esdl_file(self.em.get_related_entities(unique_entities), esdl_file_path, module_name)

    def _insert_items_sequentially(self, tx: edgedb.blocking_client):
        from .query_utils import get_att_str

        ifc_items = self.ifc_io.get_ifc_objects_by_sorted_insert_order_flat()
        ifc_items_grouped = self.ifc_io.get_ifc_objects_by_sorted_insert_order_grouped()
        res = self.ifc_io.get_ifc_dep_map(False)

        uuid_map = dict()
        for i, item in enumerate(ifc_items, start=1):
            entity = self.em.get_entity_by_name(item.is_a())
            all_atts = entity.get_entity_atts(item)
            deps = res.get(item, None)
            print(f'inserting ifc item ({i} of {len(ifc_items)}) "{item}"')
            # INSERT block
            with_map = dict()
            insert_str = f"SELECT (INSERT {entity.name} {{\n    "
            for j, att in enumerate(all_atts):
                att_str = get_att_str(att, item, self.em, uuid_map=uuid_map, with_map=with_map)
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


@dataclass
class EdgeIO(EdgeIOBase):
    # READ
    def get_spatial_content(self, spatial_name) -> dict:
        """First export Spatial Hierarchy, filter in script and then do a single client query export"""
        in_str = f"""SELECT IfcRelContainedInSpatialStructure {{
    id,
    RelatingStructure : {{ Name, id }},
    RelatedElements : {{ Name, id }}
}}"""
        result = json.loads(self.client.query_json(in_str))
        children = []
        parent = None
        for r in result:
            pobj = r["RelatingStructure"]
            if pobj == spatial_name:
                children = r["RelatedElements"]
                parent = pobj
                break
        if parent is None:
            raise ValueError("Parent object is not found")

        dmap = {parent["id"]: {"atts": parent, "children": dict()}}
        curr_level = dmap[parent["id"]]

        return result

    def get_all(self, entities: list[str] = None, limit_to_ifc_entities=False) -> dict:
        """This will query the EdgeDB for all known IFC entities."""
        from ifc_schema.interop.edge_model.edge_model_base import (
            EntityEdgeModel,
            EnumEdgeModel,
            SelectEdgeModel,
            TypeEdgeModel,
        )

        if limit_to_ifc_entities is True and entities is None:
            entities = self.ifc_io.get_unique_class_entities_of_ifc_content(True)

        select_str = "select {\n"
        if entities is None:
            ent_dict = self.em.entities
        else:
            ent_dict = {x: self.em.get_entity_by_name(x) for x in self.em.get_related_entities(entities)}

        for entity_name, entity in ent_dict.items():
            if isinstance(entity, EnumEdgeModel):
                continue
            if isinstance(entity, EntityEdgeModel) and entity.entity.is_abstract():
                continue
            select_str += f"{entity_name} := (SELECT {entity_name} {{"
            if isinstance(entity, (SelectEdgeModel, TypeEdgeModel)):
                select_str += 4 * " " + f"id,\n"
                select_str += 4 * " " + f"`{entity.name}`"
            else:
                all_atts = entity.get_attributes(True)
                select_str += 4 * " " + f"id,\n"
                for i, att in enumerate(all_atts):
                    select_str += 4 * " " + f"`{att.name}`"
                    select_str += "" if i == len(all_atts) - 1 else ","
            select_str += "}),\n"
        select_str += "}"
        return json.loads(self.client.query_json(select_str))

    # WRITE
    def insert_ifc(self, method=INSERTS.SEQ):
        """Upload all IFC elements to EdgeDB instance"""
        for tx in self.client.transaction():
            with tx:
                if method == INSERTS.SEQ:
                    self._insert_items_sequentially(tx)
                else:
                    raise NotImplementedError(f'Unrecognized IFC insert method "{method}". ')

    # Exports
    def export_ifc_elements_to_ifc_str(self) -> str:
        from toposort import toposort_flatten

        res = self.get_all(limit_to_ifc_entities=True)
        obj_set = {key: value for key, value in res[0].items() if len(value) != 0}

        # Ensure objects are inserted in the order of dependencies
        edm = dict()
        self.em.get_related_entities([x for x, value in obj_set.items()], entity_dep_map=edm)

        ordered_seq = [x for x in toposort_flatten(edm, sort=True) if x in obj_set.keys()]
        ordered_dict = {x: obj_set.get(x) for x in ordered_seq}

        f = ifcopenshell.file(schema=self.schema_name)
        id_map: dict[str, Node] = dict()
        for ifc_class, instances in ordered_dict.items():
            # print(ifc_class, len(instances), instances)

            for v in instances:
                vid = v.pop("id")
                props = get_props(ifc_class, v, id_map, self.em)

                ifc_id = None
                if ifc_class != "IfcValue":
                    if isinstance(props, dict):
                        ifc_id = f.create_entity(ifc_class, **props)
                    else:
                        ifc_id = f.create_entity(ifc_class, props)

                print(ifc_id)
                id_map[vid] = Node(ifc_class, vid, props, ifc_id=ifc_id)

        print(f"Number of EdgeDB objects with content = {len(obj_set.keys())}")
        return StringIO(f.wrapped_data.to_string()).read()


@dataclass
class Node:
    name: str
    id: str
    props: dict
    ifc_id: ifcopenshell.entity_instance = None


def get_props(ifc_class: str, v: dict, id_map: dict, em: EdgeModel) -> str | dict:
    entity = em.get_entity_by_name(ifc_class)
    atts = None
    if isinstance(entity, EntityEdgeModel):
        atts = {att.name: att for att in entity.get_attributes(True)}

    props = dict()
    for key, value in v.items():
        if isinstance(value, dict):
            node = id_map.get(value.get("id"))
            if node is None:
                print("missing " + value.get("id"))
            props[key] = node.ifc_id
        elif isinstance(value, list) and len(value) > 0:
            att_type: AttributeEdgeModel = atts.get(key)
            arr_ref = att_type.array_ref()
            if arr_ref is None:
                print("sd")
            par_type = arr_ref.parameter_type
            if par_type in ("float64", "float32"):
                if type(value[0]) != list:
                    value = [float(x) for x in value]
                else:
                    value = [[float(y) for y in x] for x in value]
            elif isinstance(par_type, EntityEdgeModel) and isinstance(value[0], dict):
                value = []
                for subr in value:
                    node = id_map.get(subr.get("id"))
                    value.append(node.ifc_id)
            else:
                print("do_something")

            props[key] = value
        else:
            if key == ifc_class:
                props = value
                break
            props[key] = value

    return props

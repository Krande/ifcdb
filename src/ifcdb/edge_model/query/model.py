from __future__ import annotations

import copy
import json
import logging
import os
import pathlib
import shutil
import subprocess
import time
from dataclasses import dataclass, field
from io import StringIO
from multiprocessing.pool import ThreadPool
from typing import ClassVar

import edgedb
import ifcopenshell

from ifcdb.edge_model.io.ifc import IfcIO
from ifcdb.edge_model.query.builder import EQBuilder
from ifcdb.edge_model.query.utils import (
    dict_value_replace,
    flatten_uuid_source,
    get_att_insert_str,
    get_uuid_refs,
    insert_uuid_objects_from_source,
    resolve_order_of_result_entities,
)
from ifcdb.edge_model.schema_gen.model import (
    ArrayEdgeModel,
    AttributeEdgeModel,
    EdgeModel,
    EntityEdgeModel,
    EnumEdgeModel,
    IntermediateClass,
    SelectEdgeModel,
    TypeEdgeModel,
)
from ifcdb.edge_model.utils import (
    clean_name,
    create_local_instance,
    walk_edge_results_and_make_uuid_map,
)


class INSERTS:
    SEQ: ClassVar[str] = "seq"


@dataclass
class EntityQueryModel:
    entity: EntityEdgeModel

    def to_select_str(
        self, with_map: dict[str, WithNode] = None, include_type_ref=False, include_id_ref=False, skip_properties=False
    ) -> str | None:
        all_atts = self.entity.get_attributes(True)

        if len(all_atts) == 0:
            return None

        select_str = "{"
        if include_id_ref:
            select_str += "id,"
        if include_type_ref:
            select_str += "__type__ : { name },"

        for i, att in enumerate(all_atts):
            type_ref = att.get_type_ref()
            if isinstance(type_ref, ArrayEdgeModel):
                type_ref = type_ref.parameter_type

            if skip_properties is True and isinstance(type_ref, EntityEdgeModel) is False:
                print(f'skipping "{att.name}"')
                continue
            att_select_str = f"{att.name}"
            if isinstance(type_ref, EntityEdgeModel):
                select_ref = self.add_entity_ref(
                    ref_type=type_ref,
                    with_map=with_map,
                    include_type_ref=include_type_ref,
                    include_id_ref=include_id_ref,
                    skip_properties=skip_properties,
                )
                if skip_properties is True and select_ref == "{}":
                    att_select_str += " : {id, __type__ : { name }}"
                    print(f'skipping "{att.name}"')
                    continue
                if select_ref is None:
                    att_select_str += " : {id, __type__ : { name }}"
                else:
                    att_select_str += f" : {select_ref}"
            elif isinstance(type_ref, (str, EnumEdgeModel)):
                pass
            elif isinstance(type_ref, SelectEdgeModel):
                print("sd")
            else:
                raise ValueError(f'Unknown type ref "{type_ref}"')

            select_str += att_select_str
            select_str += "" if i == len(all_atts) - 1 else ","
        select_str += "}"
        return select_str

    def to_insert_str(
        self,
        entity: ifcopenshell.entity_instance,
        indent: str = "",
        uuid_map: dict = None,
        with_map: dict[str, str] = None,
    ):

        all_atts = self.entity.get_entity_atts(entity)
        newline = "" if len(all_atts) == 1 else "\n"
        insert_str = f"{indent}INSERT {self.entity.name} {{{newline}  "
        for i, att in enumerate(all_atts):
            res = get_att_insert_str(att, entity, self.entity.edge_model, uuid_map=uuid_map, with_map=with_map)
            if res is None:
                continue

            comma_str = "" if i == len(all_atts) - 1 else ","
            insert_str += res + comma_str

        return insert_str + f"}}{newline}"

    def add_entity_ref(self, ref_type, with_map, include_type_ref=False, include_id_ref=False, skip_properties=False):
        from ifcdb.utils import change_case

        props = dict(
            with_map=with_map,
            include_type_ref=include_type_ref,
            skip_properties=skip_properties,
            include_id_ref=include_id_ref,
        )

        if with_map is None:
            ref_str = ref_type.to_select_str(**props)
        else:
            ref_str = change_case(self.entity.name)
            query_str = ref_type.to_select_str(**props)
            with_map[ref_str] = WithNode(ref_str, self.entity.name, query_str)
        return ref_str


@dataclass
class WithNode:
    name: str
    class_name: str
    query_str: str


@dataclass
class EdgeIOBase:
    ifc_file: str | pathlib.Path = None
    ifc_io: IfcIO = None
    ifc_schema: str = None
    db_schema_dir: str | pathlib.Path = None
    em: EdgeModel = None
    client: edgedb.Client = None
    database: str = None
    port: int | None = 5656
    instance_name: str = None
    eq_builder: EQBuilder = None

    # Class level variables
    skippable_classes = [
        "IfcOwnerHistory",
        "IfcObjectPlacement",
        "IfcRepresentationContext",
        "IfcRepresentationItem",
    ]

    def __post_init__(self):
        self.wrap = ifcopenshell.ifcopenshell_wrapper

        if self.db_schema_dir is not None:
            self.db_schema_dir = pathlib.Path(self.db_schema_dir).resolve().absolute()

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

    def create_client(self, database=None) -> edgedb.Client:
        client = edgedb.create_client(self.conn_str, tls_security="insecure", database=database)
        try:
            self.eq_builder = EQBuilder(client)
        except edgedb.errors.UnknownDatabaseError as e:
            logging.warning(e)

        return client

    def database_exists(self):
        client = self.create_client()
        try:
            client.execute(f"CREATE DATABASE {self.database}")
        except edgedb.errors.DuplicateDatabaseDefinitionError:
            return True

        client.execute(f"DROP DATABASE {self.database}")
        return False

    def load_ifc(self, ifc_file):
        self.ifc_io = IfcIO(ifc_file=ifc_file)
        self.ifc_schema = self.ifc_io.schema
        if self.em is None:
            self.em = EdgeModel(schema=self.wrap.schema_by_name(self.ifc_schema))

    def __enter__(self):
        self.client = self.create_client(self.database)

        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        if self.client is not None:
            self.client.close()

    # IFC utils

    def import_ifc_entities(self):
        return self.ifc_io.get_unique_class_entities_of_ifc_content()

    def import_ifc_entities_w_related(self):
        ifc_ents = self.ifc_io.get_unique_class_entities_of_ifc_content()
        return self.em.get_related_entities(ifc_ents)

    def create_schema(self, dbschema_dir=None, module_name="default", from_ifc_file=None, specific_entities=None):
        if dbschema_dir is not None:
            dbschema_dir = pathlib.Path(dbschema_dir).resolve().absolute()
        else:
            dbschema_dir = self.db_schema_dir

        esdl_file_path = dbschema_dir / "default.esdl"
        if from_ifc_file is not None:
            self.load_ifc(ifc_file=from_ifc_file)
            unique_entities = self.import_ifc_entities_w_related()
        else:
            if self.ifc_schema is None:
                raise ValueError('No IFC file is passed. Set the "ifc_schema" variable to a valid IFC schema version')
            if self.em is None:
                self.em = EdgeModel(schema=self.wrap.schema_by_name(self.ifc_schema))
            unique_entities = self.em.get_all_entities()

        if specific_entities is not None:
            unique_entities = specific_entities

        related_entities = self.em.get_related_entities(unique_entities)
        self.em.write_entities_to_esdl_file(related_entities, esdl_file_path, module_name)

        if len(self.em.intermediate_classes) > 0:
            print("The following intermediate classes was created to enable nested entity relationships")
        for class_name in self.em.intermediate_classes:
            print(class_name)

    def setup_database(self, dbschema_dir=None, delete_existing_migrations=False):

        if dbschema_dir is not None:
            dbschema_dir = pathlib.Path(dbschema_dir).resolve().absolute()
        else:
            dbschema_dir = self.db_schema_dir

        schema_dir = None
        if dbschema_dir.name != "dbschema":
            schema_dir = dbschema_dir.name

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
            logging.debug(e)

        print(f"Creating database {self.database}")
        client.execute(f"CREATE DATABASE {self.database}")
        client.close()

        print("Migrating schema to fresh database")
        client = edgedb.create_client(self.conn_str, tls_security="insecure", database=self.database)
        migrations_dir = pathlib.Path(dbschema_dir / "migrations")
        if delete_existing_migrations is True and migrations_dir.exists():
            shutil.rmtree(migrations_dir)
        if migrations_dir.exists() is False:
            if dbschema_dir.exists() is False:
                raise NotADirectoryError()

            server_prefix = f"edgedb {self.cli_prefix} migration create --non-interactive"
            if schema_dir is not None:
                server_prefix += f"--schema-dir ./{schema_dir}"
            print(f'Create Migration using CLI command "{server_prefix}" @"{dbschema_dir}"')
            res = subprocess.run(server_prefix, cwd=dbschema_dir.parent, shell=True, capture_output=True)
            print(res.stderr)
            print("CLI command complete")

        for migration_file in os.listdir(migrations_dir):
            with open(migrations_dir / str(migration_file), "r") as f:
                migration_body = f.read()
                client.execute(migration_body)
        client.close()
        print("Migration complete")
        self.eq_builder = EQBuilder(self.client)

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
        unique_entities = self.import_ifc_entities_w_related()
        self.em.write_entities_to_esdl_file(unique_entities, esdl_file_path, module_name)

    def _insert_items_sequentially(self, ifc_file, tx: edgedb.blocking_client, specific_ifc_ids: list[int] = None):
        from .utils import get_att_insert_str

        self.load_ifc(ifc_file)
        ifc_items = self.ifc_io.get_ifc_objects_by_sorted_insert_order_flat()
        uuid_map = dict()
        for i, item in enumerate(ifc_items, start=1):
            if specific_ifc_ids is not None and item.id() not in specific_ifc_ids:
                continue
            entity = self.em.get_entity_by_name(item.is_a())

            all_atts = entity.get_entity_atts(item)
            print(f'inserting ifc item ({i} of {len(ifc_items)}) "{item}"')
            # INSERT block
            with_map = dict()
            insert_str = f"SELECT (INSERT {entity.name} {{\n    "
            for j, att in enumerate(all_atts):
                att_str = get_att_insert_str(att, item, self.em, uuid_map=uuid_map, with_map=with_map)
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

    def _insert_intermediate_classes(self, ent_dict: dict):
        to_be_added = dict()
        for key, value in ent_dict.items():
            if isinstance(value, EntityEdgeModel) is False:
                continue
            for att in value.get_attributes(True):
                if att.needs_intermediate_class_str is False:
                    continue
                intermediate_class = att.get_intermediate_array_class()
                to_be_added[intermediate_class.name] = intermediate_class

        ent_dict.update(to_be_added)

    # Base Queries
    def get_spatial_hierarchy(self, filter_by_name: str = None) -> dict[str, SpatialNode]:
        in_str = self.eq_builder.get_spatial_hierarchy_str(filter_by_name=filter_by_name)

        def get_class_name(type_obj):
            return type_obj["_e_type"].replace("default::", "")

        result = json.loads(self.client.query_json(in_str))
        # out_str = json.dumps(result, indent=4)
        # print(out_str)
        rel_aggs = result[0]["rel_aggs"]
        spatial_nodes: dict[str, SpatialNode] = dict()
        for rel in rel_aggs:
            relo = rel["RelatingObject"]
            name = relo.get("Name")
            o_id = relo.get("id")
            owner_hist = relo.get("OwnerHistory")
            class_name = get_class_name(relo)
            sn = spatial_nodes.get(o_id)
            if sn is None:
                sn = SpatialNode(name, o_id, class_name, owner_history_id=owner_hist)
            spatial_nodes[o_id] = sn
            for rel_object in rel["RelatedObjects"]:
                sub_name = rel_object.get("Name")
                sub_id = rel_object.get("id")
                sub_n = spatial_nodes.get(sub_id)
                class_name = get_class_name(rel_object)
                if sub_n is None:
                    sub_n = SpatialNode(sub_name, sub_id, class_name=class_name, parent=sn)
                sn.children.append(sub_n)
                spatial_nodes[sub_id] = sub_n

        # Traverse IfcRelContainedInSpatialStructure classes
        spatial_stru = result[0]["spatial_stru"]
        for r in spatial_stru:
            pobj = r["RelatingStructure"]
            sn = spatial_nodes.get(pobj.get("id"))
            for child in r["RelatedElements"]:
                name = child.get("Name")
                child_id = child.get("id")
                owner_hist = child.get("OwnerHistory")
                class_name = get_class_name(child)
                sub_n = SpatialNode(name, child_id, class_name, owner_history_id=owner_hist)
                sn.children.append(sub_n)
                spatial_nodes[child_id] = sub_n

        return spatial_nodes

    def get_owner_history(self) -> dict:
        """Returns all OwnerHistory related objects as a flat dictionary dict[uuid:result]"""
        query_str = self.eq_builder.get_owner_history_str()
        result = json.loads(self.client.query_single_json(query_str))
        return flatten_uuid_source(result)

    def get_object_placements(self) -> dict:
        """Returns all related objects and properties needed to resolve locations of all IFC objects"""
        query_str = self.eq_builder.get_object_placements_str()
        result = json.loads(self.client.query_single_json(query_str))
        # Make object placement dict flat

        return result

    def get_object_shape(self, identifier: str, value: str):
        uuid, class_name = self._get_id_class_name_from_simple_filter(identifier, value)
        query_str = self.eq_builder.get_select_str(
            class_name, uuid, max_depth=None, skip_link_classes=self.skippable_classes
        )
        result = json.loads(self.client.query_single_json(query_str))
        if len(result.keys()) == 0:
            raise ValueError(f'Unable to find any result using the input "{value}"')

        return result

    def get_representations(self, object_shape: dict) -> dict:
        query_str_2 = "SELECT {\n"
        obj_num = 1
        obj_map = dict()
        for shapes in object_shape["Representation"]["Representations"]:
            for item in shapes["Items"]:
                uuid = item["id"]
                class_name = item["_e_type"].replace("default::", "")
                sub_str = self.eq_builder.get_select_str(class_name, uuids=uuid, max_depth=None)
                query_str_2 += f"    obj_{obj_num} := ({sub_str}),\n"
                obj_map[obj_num] = uuid
                obj_num += 1
        query_str_2 += "    }"
        results = json.loads(self.client.query_single_json(query_str_2))
        output_results = dict()
        for key, value in results.items():
            uuid = obj_map[int(float(key.replace("obj_", "")))]
            output_results[uuid] = value
        return output_results

    def _get_by_uuid_and_class_name(self, uuid, class_name, top_level_only=False):
        select_str_a = self.eq_builder.select_object_str(class_name, include_all_nested_objects=not top_level_only)
        query_str = f"SELECT {class_name} {{ {select_str_a} }} filter .id = <uuid>'{uuid}'"
        return json.loads(self.client.query_json(query_str))

    # Introspection
    def _get_id_class_name_from_simple_filter(self, identifier: str, value: str, base_object="IfcRoot"):
        query_str = f"""SELECT {base_object} {{ id, __type__ : {{ name }} }} filter .{identifier} = '{value}'"""
        result = json.loads(self.client.query_json(query_str))
        if len(result) != 1:
            raise ValueError

        uuid = result[0]["id"]
        class_name = clean_name(result[0]["__type__"])

        return uuid, class_name


@dataclass
class EdgeIO(EdgeIOBase):
    # Queries

    def get_by_name_v2(self, name: str):
        """Splits the query into Object Shape, OwnerHistory, Placement and Representation to be more efficient"""
        owner = self.get_owner_history()
        place = self.get_object_placements()
        object_shape = self.get_object_shape("Name", name)

        # Get Representations
        representations = self.get_representations(object_shape)
        logging.debug(representations)

        final_shape: dict = copy.deepcopy(object_shape)
        uuid_refs = get_uuid_refs(object_shape)
        for value, path in uuid_refs:
            dpath = path.split("/")
            # uuid = value["id"]
            # class_name = clean_name(value["_e_type"])
            dict_value_replace(dpath, "test", final_shape)

        # Insert Owner History into object shape
        owner_id = object_shape["OwnerHistory"]["id"]
        owner_map = {o.pop("id"): o for o in copy.deepcopy(owner["IfcOwnerHistory"])}
        _ = insert_uuid_objects_from_source(owner, owner_map[owner_id])

        # Insert Object Placement
        obj_place_id = object_shape["ObjectPlacement"]["id"]
        place_map = {p.pop("id"): p for p in place["IfcLocalPlacement"]}
        _ = place_map[obj_place_id]

        print("sd")

    def get_by_global_id(self, global_id: str, class_name: str = None, top_level_only=True):
        """Get rooted IFC element based on its 'GlobalId' property"""
        uuid, class_name = self._get_id_class_name_from_simple_filter("GlobalId", global_id)
        final_result = self._get_by_uuid_and_class_name(uuid, class_name, top_level_only=top_level_only)
        return final_result

    def get_by_name(self, name: str, class_name: str = None, top_level_only=False):
        """Get rooted IFC element based on its 'Name' property"""
        uuid, class_name = self._get_id_class_name_from_simple_filter("Name", name)
        final_result = self._get_by_uuid_and_class_name(uuid, class_name, top_level_only=top_level_only)
        return final_result

    def get_slice_in_spatial_hierarchy(self, spatial_name: str):
        uuid_map = self.get_spatial_hierarchy()

        name_map = {n.name: n for n in uuid_map.values()}
        if len(uuid_map) != len(name_map):
            names = [x.name for x in uuid_map.values()]
            error_str = "Unequal length of name and uuid maps. Due to\n\n"
            for i, o in enumerate(names.count(x) for x in names):
                if o > 1:
                    error_str += f"{names[i]}: {o}"
            raise ValueError(error_str)

        s_node = name_map.get(spatial_name)
        parent_uuids = s_node.traverse_parents()
        uuid_list = s_node.traverse_children() + parent_uuids
        uuid_map_slice = {key: uuid_map.get(key) for key in uuid_list}
        return uuid_map_slice

    def get_spatial_content_a(self, spatial_name: str) -> dict:
        """Slice in the Spatial Hierarchy using the name of a specific spatial node and return its sub elements"""

        uuid_map_slice = self.get_slice_in_spatial_hierarchy(spatial_name)

        with_map: dict[str, WithNode] = dict()
        fin_select_str = "SELECT ( "
        for i, (key, value) in enumerate(uuid_map_slice.items()):
            class_name = value.class_name
            entity_class = EntityQueryModel(self.em.get_entity_by_name(class_name))
            select_str = entity_class.to_select_str()
            fin_select_str += f"(SELECT {class_name} {select_str} filter .id = <uuid>'{key}'),\n"
        fin_select_str += ")\n"

        with_str = "WITH\n" if len(with_map.keys()) > 0 else ""
        for key, value in with_map.items():
            with_str += 4 * " " + f"{key} := (SELECT {value.class_name} {value.query_str}),\n"

        query_str = with_str + fin_select_str
        result = json.loads(self.client.query_json(query_str))

        return result

    def get_spatial_content_b(self, spatial_name) -> dict:
        """Slice in the Spatial Hierarchy using the name of a specific spatial node and return its sub elements"""
        uuid_map_slice = self.get_slice_in_spatial_hierarchy(spatial_name)
        slice_values: list[SpatialNode] = list(uuid_map_slice.items())

        # Build Query to select all objects and related linked objects
        select_linked_objects_str = "SELECT (\n"
        for i, (key, value) in enumerate(slice_values):
            class_name = value.class_name
            select_str = self.eq_builder.select_linked_objects_query_str(class_name)
            select_linked_objects_str += f"(SELECT {class_name} {{\n{select_str}\n}} filter .id = <uuid>'{key}'),\n"
        select_linked_objects_str += ")\n"

        result = json.loads(self.client.query_json(select_linked_objects_str))
        # result_str = json.dumps(result, indent=4)
        uuid_map_final = walk_edge_results_and_make_uuid_map(result)

        # Perform final query all related objects and their properties (excluding
        final_query_str = "SELECT {\n"
        for class_name, uuids in uuid_map_final.items():
            uuids_str = ",".join([f"'{x}'" for x in uuids])
            select_str = self.eq_builder.select_object_str(class_name, include_all_nested_objects=False)
            final_query_str += f"{class_name} := "
            final_query_str += f"(SELECT {class_name} {{\n{select_str}\n}} filter .id = <uuid>{{{uuids_str}}}),\n"
        final_query_str += "}"

        final_result = json.loads(self.client.query_json(final_query_str))
        final_result_str = json.dumps(final_result, indent=4)
        print(final_result_str)
        return result

    def get_all(self, entities: list[str] = None, limit_to_ifc_entities=False, client=None) -> dict:
        """This will query the EdgeDB for all known IFC entities."""
        if limit_to_ifc_entities is True:
            if entities is None:
                entities = []

            entities += self.import_ifc_entities_w_related()

        select_str = "select {\n"
        if entities is None:
            ent_dict = self.em.entities
        else:
            ent_dict = {x: self.em.get_entity_by_name(x) for x in self.em.get_related_entities(entities)}

        self._insert_intermediate_classes(ent_dict)

        for entity_name, entity in ent_dict.items():
            if isinstance(entity, EnumEdgeModel):
                continue
            if isinstance(entity, EntityEdgeModel) and entity.entity.is_abstract():
                continue
            select_str += f"{entity_name} := (SELECT {entity_name} {{"
            if isinstance(entity, (SelectEdgeModel, TypeEdgeModel)):
                select_str += 4 * " " + "id,\n"
                select_str += 4 * " " + f"`{entity.name}`"
            elif isinstance(entity, IntermediateClass):
                select_str += 4 * " " + "id,\n"
                select_str += 4 * " " + f"`{entity.att_name}`"
            else:
                all_atts = entity.get_attributes(True)
                select_str += 4 * " " + "id,\n"
                for i, att in enumerate(all_atts):
                    select_str += 4 * " " + f"`{att.name}`"
                    select_str += "" if i == len(all_atts) - 1 else ","
            select_str += "}),\n"
        select_str += "}"
        client = self.client if client is None else client
        return json.loads(client.query_json(select_str))

    # Insertions
    def insert_ifc(self, ifc_file, method=INSERTS.SEQ, specific_ifc_ids: list[int] = None):
        """Upload all IFC elements to EdgeDB instance"""
        for tx in self.client.transaction():
            with tx:
                if method == INSERTS.SEQ:
                    self._insert_items_sequentially(ifc_file, tx, specific_ifc_ids)
                else:
                    raise NotImplementedError(f'Unrecognized IFC insert method "{method}". ')

    # Exports
    def to_ifcopenshell_object(
        self, specific_classes: list[str] = None, only_ifc_entities=True, client=None
    ) -> ifcopenshell.file:
        res = self.get_all(entities=specific_classes, limit_to_ifc_entities=only_ifc_entities, client=client)
        obj_set = {key: value for key, value in res[0].items() if len(value) != 0}
        ordered_results = resolve_order_of_result_entities(obj_set, self.em)

        f = ifcopenshell.file(schema=self.ifc_schema)
        id_map: dict[str, IfcNode] = dict()
        for instance_data in ordered_results:
            if instance_data is None:
                continue
            ifc_class = instance_data.get("class")
            instance_props = instance_data.get("props")
            vid = instance_data.get("id")
            props = get_props(ifc_class, instance_props, id_map, self.em)
            if ifc_class in self.em.intermediate_classes.keys():
                id_map[vid] = IfcNode(ifc_class, vid, props, intermediate_class=self.em.intermediate_classes[ifc_class])
                continue

            if isinstance(props, dict) and ifc_class not in instance_props.keys():
                entity = self.em.get_entity_by_name(ifc_class)
                if isinstance(entity, EntityEdgeModel):
                    derive_list = entity.entity.derived()
                    all_atts = entity.get_attributes(True)
                    for i, x in enumerate(all_atts):
                        if derive_list[i] is False:
                            continue
                        if props[x.name] is not None:
                            logging.debug(f"Removing insert of derived property ({x.name} = {props[x.name]})")
                            props.pop(x.name)

                if ifc_class == "IfcPropertySingleValue":
                    fix_props = dict()
                    for key, value in props.items():
                        if isinstance(value, float):
                            fix_props[key] = f.create_entity("IfcReal", value)
                        elif isinstance(value, int) and value != 0:
                            fix_props[key] = f.create_entity("IfcReal", value)
                        else:
                            fix_props[key] = value
                else:
                    fix_props = props
                try:
                    ifc_id = f.create_entity(ifc_class, **fix_props)
                except TypeError as e:
                    raise TypeError(f"{ifc_class} insert error -> {e}")
                except IndexError as e:
                    raise IndexError(f"{ifc_class} insert error -> {e}")

            elif isinstance(props, (float, str, ifcopenshell.entity_instance)):
                ifc_id = f.create_entity(ifc_class, props)
            else:
                ifc_id = None

            if ifc_id is not None:
                print(ifc_id)

            id_map[vid] = IfcNode(ifc_class, vid, props, ifc_id=ifc_id)

        print(f"Number of EdgeDB objects with content = {len(obj_set.keys())}")
        return f

    def to_ifc_str(self, specific_classes: list[str] = None, only_ifc_entities=True) -> str:
        f = self.to_ifcopenshell_object(specific_classes, only_ifc_entities)
        return StringIO(f.wrapped_data.to_string()).read()

    def to_ifc_file(
        self, ifc_file_path: str | pathlib.Path, specific_classes: list[str] = None, only_ifc_entities=True
    ):
        ifc_file_path = pathlib.Path(ifc_file_path)
        res = self.to_ifc_str(specific_classes, only_ifc_entities)

        os.makedirs(ifc_file_path.parent, exist_ok=True)
        with open(str(ifc_file_path), "w") as f:
            f.write(res)


@dataclass
class SpatialNode:
    name: str
    id: str
    class_name: str
    children: list[SpatialNode] = field(default_factory=list)
    parent: SpatialNode = None
    owner_history_id: str = None

    def traverse_children(self, current_level=None, ulist: list[str] = None) -> list[str]:
        """Returns a list of uuid of all child elements (including self)"""
        ulist = [self.id] if ulist is None else ulist
        current_level = self if current_level is None else current_level

        for p_obj in current_level.children:
            ulist.append(p_obj.id)
            self.traverse_children(p_obj, ulist)

        return ulist

    def traverse_parents(self, current_level=None, ulist: list[str] = None) -> list[str]:
        """Returns a list of uuid of all parent elements"""
        ulist = [] if ulist is None else ulist
        current_level = self if current_level is None else current_level
        if current_level.parent is None:
            return ulist
        ulist.append(current_level.parent.id)

        self.traverse_parents(current_level.parent, ulist)
        return ulist


@dataclass
class IfcNode:
    name: str
    id: str
    props: dict
    ifc_id: ifcopenshell.entity_instance = None
    intermediate_class: IntermediateClass = None


def get_ref_id(ref_id, id_map):
    n: IfcNode = id_map.get(ref_id.get("id"))
    if n is None:
        raise ValueError("missing " + ref_id.get("id"))

    if n.intermediate_class is not None:
        return n

    if n.ifc_id is None:
        if isinstance(n.props, (float, int)):
            return n.props

        res = n.props.get(n.name)

        if res is None:
            raise ValueError(f'IFC refers to empty IFC id "{n.ifc_id}"')
        return res

    return n.ifc_id


def get_props(ifc_class: str, db_props: dict, id_map: dict, em: EdgeModel) -> str | dict:
    entity = em.get_entity_by_name(ifc_class)
    atts = None
    if isinstance(entity, EntityEdgeModel):
        atts = {att.name: att for att in entity.get_attributes(True)}

    props = dict()
    for key, value in db_props.items():
        if value is None:
            props[key] = value
            continue

        if isinstance(value, dict):
            props[key] = get_ref_id(value, id_map)
        elif isinstance(entity, IntermediateClass):
            # This is an Intermediate Class
            output = []
            for subr in value:
                output.append(get_ref_id(subr, id_map))
            value = output
            props[key] = value
        elif isinstance(value, list) and len(value) > 0:
            att_type: AttributeEdgeModel = atts.get(key)
            arr_ref = att_type.array_ref()
            par_type = arr_ref.parameter_type
            if par_type in ("float64", "float32"):
                if type(value[0]) != list:
                    value = [float(x) for x in value]
                else:
                    value = [[float(y) for y in x] for x in value]
            elif isinstance(par_type, (EntityEdgeModel, SelectEdgeModel)) and isinstance(value[0], dict):
                output = []
                for subr in value:
                    ref_obj = get_ref_id(subr, id_map)
                    if isinstance(ref_obj, IfcNode):
                        prop = ref_obj.props
                        output.append(prop[ref_obj.intermediate_class.att_name])
                    else:
                        output.append(ref_obj)
                value = output
            else:
                logging.debug(f"Do nothing with '{par_type}'")

            props[key] = value
        elif isinstance(value, list) and len(value) == 0:
            props[key] = None
        elif key == ifc_class:
            props = value
            break
        else:
            props[key] = value

    return props

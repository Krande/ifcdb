from __future__ import annotations

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
from toposort import toposort, toposort_flatten

from ifcdb.interop.edge_model.edge_model_base import (
    AttributeEdgeModel,
    ArrayEdgeModel,
    EdgeModel,
    EntityEdgeModel,
    EnumEdgeModel,
    SelectEdgeModel,
    TypeEdgeModel,
    IntermediateClass,
)


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
    ifc_schema: str = None
    db_schema_dir: str | pathlib.Path = None
    em: EdgeModel = None
    client: edgedb.Client = None
    database: str = None
    port: int | None = 5656
    instance_name: str = None

    def __post_init__(self):
        self.wrap = ifcopenshell.ifcopenshell_wrapper
        if self.em is None:
            self.em = EdgeModel(schema=self.wrap.schema_by_name(self.ifc_schema))

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

    def create_client(self) -> edgedb.Client:
        return edgedb.create_client(self.conn_str, tls_security="insecure", database=self.database)

    def __enter__(self):
        if self.ifc_file is not None:
            self.ifc_io = IfcIO(ifc_file=self.ifc_file, edge_io=self)

        self.client = self.create_client()

        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        if self.client is not None:
            self.client.close()

    # IFC utils

    def create_schema_from_ifc_file(self, dbschema_dir=None, should_copy_server_files=False):
        from ifcdb.interop.edge_model.utils import copy_server_files

        if dbschema_dir is not None:
            dbschema_dir = pathlib.Path(dbschema_dir).resolve().absolute()
        else:
            dbschema_dir = self.db_schema_dir

        self.write_ifc_entities_to_esdl_file(dbschema_dir / "default.esdl")

        if should_copy_server_files:
            copy_server_files(dbschema_dir.parent)

        if len(self.em.intermediate_classes) > 0:
            print("The following intermediate classes was created to enable nested entity relationships")
        for class_name in self.em.intermediate_classes:
            print(class_name)

    def setup_database(self, dbschema_dir=None, delete_existing_migrations=False):
        from .query_utils import create_local_instance

        if dbschema_dir is not None:
            dbschema_dir = pathlib.Path(dbschema_dir).resolve().absolute()
        else:
            dbschema_dir = self.db_schema_dir

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

        print(f"Migrating schema to fresh database")
        client = edgedb.create_client(self.conn_str, tls_security="insecure", database=self.database)
        migrations_dir = pathlib.Path(dbschema_dir / "migrations")
        if delete_existing_migrations is True and migrations_dir.exists():
            shutil.rmtree(migrations_dir)
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

    def _insert_items_sequentially(self, tx: edgedb.blocking_client, specific_ifc_ids: list[int] = None):
        from .query_utils import get_att_str

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

    def get_spatial_hierarchy(self) -> dict[str, SpatialNode]:
        in_str = """SELECT {
            spatial_stru := (
                SELECT IfcRelContainedInSpatialStructure {
                    id,
                    RelatingStructure : { Name, id, __type__ : { name } },
                    RelatedElements : { Name, id, __type__ : { name } }
                }
            ),
            rel_aggs := (
                SELECT IfcRelAggregates {
                    id,
                    RelatingObject : { Name, id, __type__ : { name } },
                    RelatedObjects : { Name, id, __type__ : { name } }
                }
            ) 
        }"""

        def get_class_name(type_obj):
            return type_obj["__type__"]["name"].replace("default::", "")

        result = json.loads(self.client.query_json(in_str))

        rel_aggs = result[0]["rel_aggs"]
        spatial_nodes: dict[str, SpatialNode] = dict()
        for rel in rel_aggs:
            relo = rel["RelatingObject"]
            name = relo.get("Name")
            o_id = relo.get("id")
            class_name = get_class_name(relo)
            sn = spatial_nodes.get(o_id)
            if sn is None:
                sn = SpatialNode(name, o_id, class_name)
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
                class_name = get_class_name(child)
                sub_n = SpatialNode(name, child_id, class_name)
                sn.children.append(sub_n)
                spatial_nodes[child_id] = sub_n

        return spatial_nodes


@dataclass
class EdgeIO(EdgeIOBase):
    def get_spatial_content(self, spatial_name) -> dict:
        """Slice in the Spatial Hierarchy using the name of a specific spatial node and return its sub elements"""
        from itertools import chain

        uuid_map = self.get_spatial_hierarchy()
        name_map = {n.name: n for n in uuid_map.values()}
        if len(uuid_map) != len(name_map):
            names = [x.name for x in uuid_map.values()]
            error_str = 'Unequal length of name and uuid maps. Due to\n\n'
            for i, o in enumerate(names.count(x) for x in names):
                if o > 1:
                    error_str += f"{names[i]}: {o}"
            raise ValueError(error_str)
        s_node = name_map.get(spatial_name)

        parent_uuids = s_node.traverse_parents()
        uuid_list = s_node.traverse_children() + parent_uuids

        # Get all subelements
        def walk_entity_children(curr_child: EntityEdgeModel, att_names: list, level: int) -> str:
            output_str = ""
            if isinstance(curr_child, (EnumEdgeModel, SelectEdgeModel)):
                return ""

            attributes = curr_child.get_attributes()
            if len(attributes) == 0 and curr_child.entity.is_abstract():
                for prop_entity_child in curr_child.get_children():
                    if prop_entity_child.entity.is_abstract():
                        continue
                    walk_entity_children(prop_entity_child, att_names, level=level + 1)
            if level > 100:
                raise ValueError("Recursion depth is out of control")
            for att in attributes:
                att_type = att.get_type_ref()
                if level == 0:
                    if att.name in att_names:
                        continue
                    att_names.append(att.name)

                if isinstance(att_type, ArrayEdgeModel):
                    att_type = att_type.parameter_type
                if isinstance(att_type, EntityEdgeModel):
                    insert_str = walk_entity_children(att_type, att_names, level + 1)
                    output_str += f"[is {curr_child.name}].{att.name} : {{ {insert_str} }},\n"
                elif isinstance(att_type, (str, EnumEdgeModel)):
                    output_str += f"[is {curr_child.name}].{att.name},\n"
                elif isinstance(att_type, SelectEdgeModel):
                    output_str += f"[is {curr_child.name}].{att.name},\n"
                else:
                    raise NotImplementedError(f'Entity type "{att_type}" is not yet added')
            return output_str

        # for child_uuid in s_node.traverse_children()
        all_classes = list(set([uuid_map.get(cn).class_name for cn in uuid_list]))
        entities = [self.em.get_entity_by_name(cn) for cn in all_classes]
        ancestors = set([x.name for x in chain.from_iterable([e.get_ancestors() for e in entities])])
        all_entities = entities + [self.em.get_entity_by_name(cn) for cn in ancestors]

        fin_select_str = "SELECT IfcProduct { __type__ : {name},"
        atn = []
        for child in all_entities:
            fin_select_str += walk_entity_children(child, atn, 0)

        uuid_list_str = ",".join([f"'{x}'" for x in uuid_list])
        fin_select_str += f"}} filter .id = <uuid>{{ {uuid_list_str} }}"

        result_2 = json.loads(self.client.query_json(fin_select_str))

        return result_2

    def get_all(self, entities: list[str] = None, limit_to_ifc_entities=False, client=None) -> dict:
        """This will query the EdgeDB for all known IFC entities."""
        if limit_to_ifc_entities is True:
            if entities is None:
                entities = []
            entities += self.ifc_io.get_unique_class_entities_of_ifc_content(True)

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
                select_str += 4 * " " + f"id,\n"
                select_str += 4 * " " + f"`{entity.name}`"
            elif isinstance(entity, IntermediateClass):
                select_str += 4 * " " + f"id,\n"
                select_str += 4 * " " + f"`{entity.att_name}`"
            else:
                all_atts = entity.get_attributes(True)
                select_str += 4 * " " + f"id,\n"
                for i, att in enumerate(all_atts):
                    select_str += 4 * " " + f"`{att.name}`"
                    select_str += "" if i == len(all_atts) - 1 else ","
            select_str += "}),\n"
        select_str += "}"
        client = self.client if client is None else client
        return json.loads(client.query_json(select_str))

    # WRITE
    def insert_ifc(self, method=INSERTS.SEQ, specific_ifc_ids: list[int] = None):
        """Upload all IFC elements to EdgeDB instance"""
        for tx in self.client.transaction():
            with tx:
                if method == INSERTS.SEQ:
                    self._insert_items_sequentially(tx, specific_ifc_ids)
                else:
                    raise NotImplementedError(f'Unrecognized IFC insert method "{method}". ')

    # Exports
    def to_ifcopenshell_object(self, specific_classes: list[str] = None, only_ifc_entities=True, client=None) -> ifcopenshell.file:
        res = self.get_all(entities=specific_classes, limit_to_ifc_entities=only_ifc_entities,client=client)
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


@dataclass
class IfcNode:
    name: str
    id: str
    props: dict
    ifc_id: ifcopenshell.entity_instance = None
    intermediate_class: IntermediateClass = None


@dataclass
class SpatialNode:
    name: str
    id: str
    class_name: str
    children: list[SpatialNode] = field(default_factory=list)
    parent: SpatialNode = None

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


def resolve_order_of_result_entities(results: dict, em: EdgeModel) -> list:
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

from __future__ import annotations

import copy
import json
import logging
import os
import pathlib
import time
from dataclasses import dataclass
from io import StringIO
from multiprocessing.pool import ThreadPool

import edgedb
import ifcopenshell

from ifcdb.admin_utils import clean_name, walk_edge_results_and_make_uuid_map
from ifcdb.database.admin import DbConfig, DbMigration
from ifcdb.database.builder import EQBuilder
from ifcdb.database.model import (
    INSERTS,
    EntityQueryModel,
    IfcNode,
    SpatialNode,
    WithNode,
    get_props,
)
from ifcdb.database.utils import (
    dict_value_replace,
    flatten_uuid_source,
    get_att_insert_str,
    get_uuid_refs,
    insert_uuid_objects_from_source,
    resolve_order_of_result_entities,
)
from ifcdb.io.ifc import IfcIO
from ifcdb.schema.model import (
    EntityModel,
    EnumModel,
    IfcSchemaModel,
    IntermediateClass,
    SelectModel,
    TypeModel,
)


@dataclass
class EdgeIOBase:

    database: str
    client: edgedb.Client | edgedb.AsyncIOClient = None
    db_schema_dir: str | pathlib.Path = "dbschema"
    ifc_schema: str = "IFC4x1"

    _sm: IfcSchemaModel = None
    _eq_builder: EQBuilder = None
    _db_config: DbConfig = None
    _db_migrate: DbMigration = None

    # Class level variables
    skippable_classes = [
        "IfcOwnerHistory",
        "IfcObjectPlacement",
        "IfcRepresentationContext",
        "IfcRepresentationItem",
    ]

    def __post_init__(self):
        self.wrap = ifcopenshell.ifcopenshell_wrapper
        self.db_schema_dir = pathlib.Path(self.db_schema_dir).resolve().absolute()

        if self.client is None:
            self.client = self.default_client()

        self._db_migrate = DbMigration(database=self.database, dbschema_dir=self.db_schema_dir)
        self._sm = IfcSchemaModel(self.ifc_schema)

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        if self.client is not None:
            self.client.close()

    def default_client(self) -> edgedb.Client:
        client = edgedb.create_client(database=self.database)
        return client

    def database_exists(self):
        with DbConfig(self.database) as db_config:
            return db_config.database_exists()

    def setup_database(self, delete_existing_migrations=False):
        with DbConfig(self.database) as db_config:
            db_config.create_database()
        self._db_migrate.migrate_all_in_one(delete_existing_migrations=delete_existing_migrations)
        self._eq_builder = EQBuilder(self.client)

    def stepwise_migration(self, ifc_schema_ver: str, entities: list[str] = None, batch_size=100, **kwargs):
        self._db_migrate.migrate_stepwise(ifc_schema_ver, entities, batch_size, **kwargs)

    def create_schema_from_ifc_file(
        self,
        ifc_path: str | pathlib.Path | list[str | pathlib.Path] = None,
        ifc_str: str = None,
        extra_entities: list[str] = None,
        module_name="default",
    ):
        esdl_file_path = self.db_schema_dir / "default.esdl"
        if isinstance(ifc_path, list):
            ifc_ents = []
            for ifc_p in ifc_path:
                ifc_io = IfcIO(ifc_file=ifc_p)
                res = ifc_io.get_unique_class_entities_of_ifc_content()
                res_set = set(res)
                ifc_ents_set = set(ifc_ents)
                ifc_ents_diff = res_set.difference(ifc_ents_set)
                ifc_ents += list(ifc_ents_diff)
        else:
            ifc_io = IfcIO(ifc_file=ifc_path, ifc_str=ifc_str)
            ifc_ents = ifc_io.get_unique_class_entities_of_ifc_content()
        if extra_entities is not None:
            ifc_ents += extra_entities

        related_entities = self._sm.get_related_entities(ifc_ents)

        self._sm.to_esdl_file(esdl_file_path, related_entities, module_name)

    def create_schema(self, entities: list[str] = None, module_name="default"):
        esdl_file_path = self.db_schema_dir / "default.esdl"
        if entities is None:
            unique_entities = self._sm.get_all_entities()
        else:
            unique_entities = entities
        related_entities = self._sm.get_related_entities(unique_entities)
        self._sm.to_esdl_file(esdl_file_path, related_entities, module_name)

    # IFC utils
    def load_ifc(self, from_path: str = None, from_str: str = None):
        self._ifc_io = IfcIO(ifc_file=from_path, ifc_str=from_str)
        self.ifc_schema = self._ifc_io.schema

    def import_ifc_entities_w_related(self):
        ifc_ents = self._ifc_io.get_unique_class_entities_of_ifc_content()
        return self._sm.get_related_entities(ifc_ents)

    def upload_ifc_w_threading(self):
        proxy_elements = list(self._ifc_io.ifc_obj.by_type("IFCBuildingElementProxy"))
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

    def _insert_items_sequentially(
        self, ifc_items: [ifcopenshell.entity_instance], tx: edgedb.blocking_client, specific_ifc_ids: list[int] = None
    ):
        uuid_map = dict()
        for i, item in enumerate(ifc_items, start=1):
            if specific_ifc_ids is not None and item.id() not in specific_ifc_ids:
                continue

            entity = self._sm.get_entity_by_name(item.is_a())
            all_atts = entity.get_entity_atts(item)
            print(f'inserting ifc item ({i} of {len(ifc_items)}) "{item}"')
            # INSERT block
            with_map = dict()
            insert_str = f"SELECT (INSERT {entity.name} {{\n    "
            for j, att in enumerate(all_atts):
                att_str = get_att_insert_str(att, item, self._sm, uuid_map=uuid_map, with_map=with_map)
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
            if isinstance(value, EntityModel) is False:
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

    @property
    def eq_builder(self):
        if self._eq_builder is None:

            try:
                self._eq_builder = EQBuilder(self.client)
            except edgedb.errors.UnknownDatabaseError as e:
                logging.warning(e)
        return self._eq_builder


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
            entity_class = EntityQueryModel(self._sm.get_entity_by_name(class_name))
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

    def get_all(
        self, entities: list[str] = None, limit_to_ifc_entities=False, client=None, module_name="default"
    ) -> dict:
        """This will query the EdgeDB for all known IFC entities."""

        db_entities = list(self.eq_builder.edgedb_objects.keys())
        if limit_to_ifc_entities is True:
            if entities is None:
                entities = []
            entities += db_entities

        select_str = "select {\n"
        if entities is None:
            ent_dict = self._sm.entities
        else:
            ent_dict = {x: self._sm.get_entity_by_name(x) for x in self._sm.get_related_entities(entities)}

        self._insert_intermediate_classes(ent_dict)

        for entity_name, entity in ent_dict.items():
            if isinstance(entity, EnumModel):
                continue
            if isinstance(entity, EntityModel) and entity.entity.is_abstract():
                continue
            select_str += f"{entity_name} := (SELECT {entity_name} {{"
            if isinstance(entity, (SelectModel, TypeModel)):
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
    def insert_ifc(self, ifc_file_path=None, ifc_file_str=None, method=INSERTS.SEQ, specific_ifc_ids: list[int] = None):
        """Upload all IFC elements to EdgeDB instance"""
        self.load_ifc(from_path=ifc_file_path, from_str=ifc_file_str)

        for tx in self.client.transaction():
            with tx:
                self._perform_method(tx, method, specific_ifc_ids)

    def _perform_method(self, tx, method, specific_ifc_ids):
        if method == INSERTS.SEQ:
            ifc_items = self._ifc_io.get_ifc_objects_by_sorted_insert_order_flat()
            self._insert_items_sequentially(ifc_items, tx, specific_ifc_ids)
        else:
            raise NotImplementedError(f'Unrecognized IFC insert method "{method}". ')

    # Exports
    def to_ifcopenshell_object(
        self, specific_classes: list[str] = None, only_ifc_entities=True, client=None
    ) -> ifcopenshell.file:
        res = self.get_all(entities=specific_classes, limit_to_ifc_entities=only_ifc_entities, client=client)
        obj_set = {key: value for key, value in res[0].items() if len(value) != 0}
        ordered_results = resolve_order_of_result_entities(obj_set, self._sm)

        f = ifcopenshell.file(schema=self.ifc_schema)
        id_map: dict[str, IfcNode] = dict()
        for instance_data in ordered_results:
            if instance_data is None:
                continue
            ifc_class = instance_data.get("class")
            instance_props = instance_data.get("props")
            vid = instance_data.get("id")
            props = get_props(ifc_class, instance_props, id_map, self._sm)
            if ifc_class in self._sm.intermediate_classes.keys():
                id_map[vid] = IfcNode(
                    ifc_class, vid, props, intermediate_class=self._sm.intermediate_classes[ifc_class]
                )
                continue

            if isinstance(props, dict) and ifc_class not in instance_props.keys():
                entity = self._sm.get_entity_by_name(ifc_class)
                if isinstance(entity, EntityModel):
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

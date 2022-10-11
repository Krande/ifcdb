import copy
import json
import logging
from dataclasses import dataclass

import edgedb

from ifcdb.database.builder import EQBuilder
from ifcdb.database.getters.model import EntityQueryModel, SpatialNode, WithNode
from ifcdb.database.utils import (
    clean_name,
    dict_value_replace,
    flatten_uuid_source,
    get_uuid_refs,
    insert_uuid_objects_from_source,
    resolve_order_of_result_entities,
    walk_edge_results_and_make_uuid_map,
)
from ifcdb.schema.model import (
    EntityModel,
    EnumModel,
    IfcSchemaModel,
    IntermediateClass,
    SelectModel,
    TypeModel,
)


@dataclass
class BulkGetter:
    client: edgedb.Client
    _sm: IfcSchemaModel
    # Class level variables
    skippable_classes = [
        "IfcOwnerHistory",
        "IfcObjectPlacement",
        "IfcRepresentationContext",
        "IfcRepresentationItem",
    ]
    _eq_builder: EQBuilder = None

    def get_spatial_hierarchy(self, filter_by_name: str = None) -> dict[str, SpatialNode]:
        in_str = self.eq_builder.get_spatial_hierarchy_str(filter_by_name=filter_by_name)

        def get_class_name(type_obj):
            return type_obj["_e_type"].replace("default::", "")

        result = json.loads(self.client.query_json(in_str))
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
        return json.loads(self.client.query_single_json(query_str))

    def get_object_placements(self) -> dict:
        """Returns all related objects and properties needed to resolve locations of all IFC objects"""
        query_str = self.eq_builder.get_object_placements_str()
        result = json.loads(self.client.query_single_json(query_str))
        # Make object placement dict flat

        return result

    def get_object_shape(self, identifier: str, value: str):
        uuid, class_name = self.get_id_class_name_from_simple_filter(identifier, value)
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

    def get_by_uuid_and_class_name(self, uuid, class_name, top_level_only=False):
        select_str_a = self.eq_builder.select_object_str(class_name, include_all_nested_objects=not top_level_only)
        query_str = f"SELECT {class_name} {{ {select_str_a} }} filter .id = <uuid>'{uuid}'"
        return json.loads(self.client.query_json(query_str))

    # Introspection
    def get_id_class_name_from_simple_filter(self, identifier: str, value: str, base_object="IfcRoot"):
        query_str = f"""SELECT {base_object} {{ id, __type__ : {{ name }} }} filter .{identifier} = '{value}'"""
        result = json.loads(self.client.query_json(query_str))
        if len(result) != 1:
            raise ValueError

        uuid = result[0]["id"]
        class_name = clean_name(result[0]["__type__"])

        return uuid, class_name

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
        owner_flat = flatten_uuid_source(owner)
        owner_map = {o["id"]: o for o in copy.deepcopy(owner["IfcOwnerHistory"])}
        _ = insert_uuid_objects_from_source(owner_flat, owner_map[owner_id])

        # Insert Object Placement
        obj_place_id = object_shape["ObjectPlacement"]["id"]
        place_map = {p.pop("id"): p for p in place["IfcLocalPlacement"]}
        _ = place_map[obj_place_id]

    def get_by_global_id(self, global_id: str, class_name: str = None, top_level_only=True):
        """Get rooted IFC element based on its 'GlobalId' property"""
        uuid, class_name = self.get_id_class_name_from_simple_filter("GlobalId", global_id)
        final_result = self.get_by_uuid_and_class_name(uuid, class_name, top_level_only=top_level_only)
        return final_result

    def get_by_name(self, name: str, class_name: str = None, top_level_only=False):
        """Get rooted IFC element based on its 'Name' property"""
        uuid, class_name = self.get_id_class_name_from_simple_filter("Name", name)
        final_result = self.get_by_uuid_and_class_name(uuid, class_name, top_level_only=top_level_only)
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

    def get_all(self, entities: list[str] = None, client=None) -> dict:
        """This will query the EdgeDB for all known IFC entities."""

        db_entities = list(self.eq_builder.edgedb_objects.keys())

        if entities is None:
            entities = []
        entities += db_entities

        if entities is None:
            ent_dict = self._sm.entities
        else:
            related_ents = self._sm.get_related_entities(entities)
            ent_dict = {x: self._sm.get_entity_by_name(x) for x in related_ents}

        self.update_entity_dict_w_intermediate_classes(ent_dict)

        select_str = "select {\n"
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

    def update_entity_dict_w_intermediate_classes(self, ent_dict: dict):
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

    @property
    def eq_builder(self):
        if self._eq_builder is None:
            try:
                self._eq_builder = EQBuilder(self.client)
            except edgedb.errors.UnknownDatabaseError as e:
                logging.warning(e)
        return self._eq_builder

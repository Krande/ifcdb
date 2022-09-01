from __future__ import annotations

import logging
import pathlib
from dataclasses import dataclass

import ifcopenshell
from toposort import toposort, toposort_flatten

from ifcdb.database.utils import resolve_order_of_result_entities
from ifcdb.io.ifc.optimizing import general_optimization
from ifcdb.schema.model import (
    AttributeModel,
    EntityModel,
    IfcSchemaModel,
    IntermediateClass,
    SelectModel,
)


@dataclass
class IfcIO:
    ifc_file: str | pathlib.Path = None
    ifc_str: str = None
    ifc_obj: ifcopenshell.file = None
    schema: str = None
    optimize: bool = True

    def __post_init__(self):
        if self.ifc_file is not None:
            ifc_obj = ifcopenshell.open(str(self.ifc_file))
        else:
            ifc_obj = ifcopenshell.file.from_string(self.ifc_str)
        if self.optimize:
            self.ifc_obj = general_optimization(ifc_obj)
        else:
            self.ifc_obj = ifc_obj
        self.schema = self.ifc_obj.wrapped_data.schema

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
        return list(set([x.is_a() for x in self.get_ifc_objects_by_sorted_insert_order_flat()]))

    def to_ifc_json(self):
        self.ifc_obj.wrapped_data.write()

    @staticmethod
    def get_ifc_entities_from_multiple_ifcs(ifc_paths: list[str | pathlib.Path]) -> list[str]:
        ifc_ents = []
        for ifc_p in ifc_paths:
            ifc_io = IfcIO(ifc_file=ifc_p, optimize=False)
            res = ifc_io.get_unique_class_entities_of_ifc_content()
            res_set = set(res)
            ifc_ents_set = set(ifc_ents)
            ifc_ents_diff = res_set.difference(ifc_ents_set)
            ifc_ents += list(ifc_ents_diff)
        return ifc_ents

    @staticmethod
    def to_ifcopenshell_object(res: dict, ism: IfcSchemaModel) -> ifcopenshell.file:
        """Convert the json results from a get_all() method to an ifcopenshell model object"""
        obj_set = {key: value for key, value in res[0].items() if len(value) != 0}
        ordered_results = resolve_order_of_result_entities(obj_set, ism)

        f = ifcopenshell.file(schema=ism.schema_version)
        id_map: dict[str, IfcNode] = dict()
        for instance_data in ordered_results:
            if instance_data is None:
                continue
            ifc_class = instance_data.get("class")
            instance_props = instance_data.get("props")
            vid = instance_data.get("id")
            props = get_props(ifc_class, instance_props, id_map, ism)
            if ifc_class in ism.intermediate_classes.keys():
                id_map[vid] = IfcNode(ifc_class, vid, props, intermediate_class=ism.intermediate_classes[ifc_class])
                continue

            if isinstance(props, dict) and ifc_class not in instance_props.keys():
                entity = ism.get_entity_by_name(ifc_class)
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
                elif ifc_class == 'IfcIndexedPolyCurve':
                    fix_props = dict()
                    fix_props.update(props)
                    for i, seg in enumerate(props["Segments"]):
                        fix_props["Segments"][i] = f.create_entity("IfcLineIndex", seg)
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


def walk_info(info: dict):
    def walk(d):
        if isinstance(d, dict):
            for key, value in d.items():
                if isinstance(value, ifcopenshell.entity_instance):
                    pass

    return walk(info)


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
        if isinstance(n.props, (float, int, list)):
            return n.props
        res = n.props.get(n.name)

        if res is None:
            raise ValueError(f'IFC refers to empty IFC id "{n.ifc_id}"')
        return res

    return n.ifc_id


def get_props(ifc_class: str, db_props: dict, id_map: dict, em: IfcSchemaModel) -> str | dict:
    entity = em.get_entity_by_name(ifc_class)
    atts = None
    if isinstance(entity, EntityModel):
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
        elif isinstance(value, list) and len(value) > 0 and atts is not None:
            att_type: AttributeModel = atts.get(key)
            arr_ref = att_type.array_ref()
            par_type = arr_ref.parameter_type
            if par_type in ("float64", "float32"):
                if type(value[0]) != list:
                    value = [float(x) for x in value]
                else:
                    value = [[float(y) for y in x] for x in value]
            elif isinstance(par_type, (EntityModel, SelectModel)) and isinstance(value[0], dict):
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

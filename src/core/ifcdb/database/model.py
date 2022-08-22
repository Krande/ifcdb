from __future__ import annotations

import ifcopenshell
import logging
from dataclasses import dataclass, field
from typing import ClassVar

from ifcdb.database.utils import (
    get_att_insert_str,
)
from ifcdb.schema.model import (
    ArrayModel,
    AttributeModel,
    IfcSchemaModel,
    EntityModel,
    EnumModel,
    IntermediateClass,
    SelectModel,
)


class INSERTS:
    SEQ: ClassVar[str] = "seq"


@dataclass
class EntityQueryModel:
    entity: EntityModel

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
            if isinstance(type_ref, ArrayModel):
                type_ref = type_ref.parameter_type

            if skip_properties is True and isinstance(type_ref, EntityModel) is False:
                print(f'skipping "{att.name}"')
                continue
            att_select_str = f"{att.name}"
            if isinstance(type_ref, EntityModel):
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
            elif isinstance(type_ref, (str, EnumModel)):
                pass
            elif isinstance(type_ref, SelectModel):
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
        elif isinstance(value, list) and len(value) > 0:
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

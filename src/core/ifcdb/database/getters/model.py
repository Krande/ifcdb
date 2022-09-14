from __future__ import annotations

from dataclasses import dataclass, field

from ifcdb.schema.model import (
    ArrayModel,
    EntityModel,
    EnumModel,
    SelectModel,
)


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
                pass
            else:
                raise ValueError(f'Unknown type ref "{type_ref}"')

            select_str += att_select_str
            select_str += "" if i == len(all_atts) - 1 else ","
        select_str += "}"
        return select_str

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
class SelectModel:
    name: str
    props: list[str]
    # filter: FilterModel

    def to_str(self):
        return f"SELECT {self.name} {{ {self.props} }};"

from __future__ import annotations

from dataclasses import dataclass, field

import ifcopenshell

from ifcdb.schema.model import IfcSchemaModel
from ifcdb.database.inserts.attribute_resolver import AttResolver


@dataclass
class SeqInsert:
    ifc_schema: str = None
    specific_ifc_ids: list[int] = None

    _uuid_map: dict[ifcopenshell.entity_instance, str] = field(default_factory=dict)
    _ism: IfcSchemaModel = None

    def __post_init__(self):
        if self._ism is None:
            self._ism = IfcSchemaModel(schema_version=self.ifc_schema)

    def create_entity_insert_str(self, item: ifcopenshell.entity_instance):
        entity = self._ism.get_entity_by_name(item.is_a())
        all_atts = entity.get_entity_atts(item)

        # INSERT block
        with_map = dict()
        insert_str = f"SELECT (INSERT {entity.name} {{\n    "

        for j, att in enumerate(all_atts):
            attr = AttResolver(self._ism, self._uuid_map, with_map)
            att_str = attr.get_att_insert_str(att, item)
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
        return total_insert_str

    def create_bulk_insert_str(
        self, ifc_items: list[ifcopenshell.entity_instance]
    ) -> tuple[ifcopenshell.entity_instance, str]:
        for i, item in enumerate(ifc_items, start=1):
            if self.specific_ifc_ids is not None and item.id() not in self.specific_ifc_ids:
                continue
            print(f'inserting ifc item ({i} of {len(ifc_items)}) "{item}"')
            yield item, self.create_entity_insert_str(item)


@dataclass
class Insert:
    name: str
    props: dict
    with_map: dict

    def to_str(self):
        return f"INSERT {self.name} {{\n    "

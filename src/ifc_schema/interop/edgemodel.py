import operator
import os
import pathlib
from dataclasses import dataclass
from typing import ClassVar

from ifc_schema.entities import Entity
from ifc_schema.att_types import Array
from ifc_schema.exp_reader import ExpReader


@dataclass
class EntityModel:
    entity: Entity

    def to_esdl_str(self):
        att_str = self.attributes_str
        prop_prefix = "abstract " if self.entity.supertype_of is not None and len(self.entity.supertype_of) > 0 else ""
        parent_str = f"extending {self.entity.parent_type}" if self.entity.parent_type is not None else ""

        return f"""
    {prop_prefix}type {self.entity.name} {parent_str} {{
{att_str}    }}
"""

    @property
    def ancestor_str(self):
        ancestor_str = ""
        if self.entity.parent_type is not None:
            ancestor_str = f"({self.entity.parent_type})"
        return ancestor_str

    @property
    def attributes_str(self):
        atts_str = ""
        attributes = sorted(self.entity.instance_attributes.values(), key=operator.attrgetter("optional"))
        for val in attributes:
            if val.parent != self.entity:
                continue
            vtyp = val.type

            if isinstance(vtyp, Array):
                att_ref = array_to_esdl(vtyp)
            elif isinstance(vtyp, Entity):
                att_ref = vtyp.name
            else:
                att_ref = vtyp

            att_prefix = "required " if val.optional is False else ""
            atts_str += 8 * " " + f"{att_prefix}property {val.name} -> {att_ref};\n"

        return atts_str


def array_to_esdl(array: Array) -> str:
    entity = array.of_type
    if isinstance(entity, Entity):
        if entity.is_base_type:
            entity_str = EdgeModel.base_type_map.get(entity.content, None)
        else:
            entity_str = entity.name
    else:
        entity_str = ""

    array_str = ""

    multilevel = False
    shape_len = len(array.shape)

    if shape_len > 1:
        multilevel = True
        end_fix = shape_len * ">"
    else:
        end_fix = ">"

    for i, shape in enumerate(array.shape):
        b = shape[1]
        if "?" not in b:
            col_refs = ['x', 'y', 'z']
            entity_str = ", ".join([f"{col_refs[i]}: {entity_str}" for i in range(int(float(b)))])

        if multilevel is False:
            array_str += f"array<"
        else:
            if i == 0:
                array_str += f"array<"
            else:
                array_str += f"tuple<"

    return array_str + f"{entity_str}{end_fix}"


@dataclass
class EdgeModel:
    exp_reader: ExpReader
    output_dir: pathlib.Path = pathlib.Path("temp/edge_model")

    base_type_map: ClassVar[dict] = dict(IfcInteger="int", REAL="float")

    def export_all_related_to_esdl(self, class_name):
        header_str = "module default {\n"

        if isinstance(class_name, str):
            class_name = [class_name]

        data_model_str = ""
        related_entities = []

        for cnam in class_name:
            triface = self.exp_reader.entity_dict[cnam]
            all_ents = triface.get_related_entities_and_types(related_entities)
            for ent in all_ents:
                entmodel = EntityModel(ent)
                data_model_str += entmodel.to_esdl_str()
        app_str = "\n}"
        os.makedirs(self.output_dir / "dbschema", exist_ok=True)
        with open(self.output_dir / f"dbschema/default.esdl", "w") as f:
            f.write(header_str + data_model_str + app_str)

import operator
import os
import pathlib
import shutil
from dataclasses import dataclass
from typing import Union, List, ClassVar

from ifc_schema.att_types import Array
from ifc_schema.entities import Entity
from .base import BaseModel


@dataclass
class EntityModel:
    entity: Entity

    def to_esdl_enum_str(self) -> str:
        enum_str = ", ".join(self.entity.enum_values)
        return f"\n    scalar type {self.entity.name} extending enum<{enum_str}>;\n\n"

    def to_esdl_str(self) -> str:
        if self.entity.is_enum:
            return self.to_esdl_enum_str()

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
        indent_str = 8 * " "
        attributes = sorted(self.entity.instance_attributes.values(), key=operator.attrgetter("optional"))

        for val in attributes:
            if val.parent != self.entity:
                continue

            vtyp = val.type
            att_prefix = "required " if val.optional is False else ""

            if isinstance(vtyp, Array):
                att_ref = array_to_esdl(vtyp)
                vtype_oftype = vtyp.of_type
                if isinstance(vtype_oftype, Entity) and vtype_oftype.is_base_type is False:
                    atts_str += indent_str + f"{att_prefix}multi link {val.name} -> {att_ref};\n"
                else:
                    atts_str += indent_str + f"{att_prefix}property {val.name} -> {att_ref};\n"
            else:
                if isinstance(vtyp, Entity) is False:
                    atts_str += indent_str + f"{att_prefix}property {val.name} -> {vtyp};\n"
                else:
                    if vtyp.is_base_type:
                        att_ref = EdgeModel.base_type_map.get(vtyp.content)
                        atts_str += indent_str + f"{att_prefix}property {val.name} -> {att_ref};\n"
                    elif vtyp.is_enum:
                        atts_str += indent_str + f"{att_prefix}property {val.name} -> {vtyp.name};\n"
                    else:
                        atts_str += indent_str + f"{att_prefix}link {val.name} -> {vtyp.name};\n"

        return atts_str


def array_to_esdl(array: Array) -> str:
    entity = array.of_type
    multilevel = False
    shape_len = len(array.shape)

    if shape_len > 1:
        multilevel = True
        end_fix = shape_len * ">"
    else:
        end_fix = ">"

    if isinstance(entity, Entity):
        if entity.is_base_type:
            entity_str = EdgeModel.base_type_map.get(entity.content, None)
        else:
            return entity.name

    else:
        entity_str = ""

    array_str = ""

    for i, shape in enumerate(array.shape):
        b = shape[1]
        bnum = int(float(b)) if "?" not in b else None
        if bnum is not None:
            # col_refs = ["x", "y", "z"]
            # entity_str = ", ".join([f"{col_refs[i]}: {entity_str}" for i in range(int(float(b)))])
            entity_str = ", ".join([entity_str for i in range(bnum)])

        if multilevel is False:
            if bnum is None:
                array_str += f"array<"
            else:
                array_str += f"tuple<"
        else:
            if i == 0:
                array_str += f"array<"
            else:
                array_str += f"tuple<"

    return array_str + f"{entity_str}{end_fix}"


@dataclass
class EdgeModel(BaseModel):
    output_dir: pathlib.Path = pathlib.Path("temp/edge_model")

    base_type_map: ClassVar[dict] = {
        "IfcInteger": "int32",
        "REAL": "float32",
        "BOOLEAN": "bool",
        "INTEGER": "int32",
        "STRING": "str",
        "STRING(22) FIXED": "str",
        "BINARY": "str",
        "STRING(255)": "str",
    }

    def export_all_related_to_esdl(self, entity_names: Union[str, List[str]]):
        header_str = "module default {\n"

        if isinstance(entity_names, str):
            entity_names = [entity_names]

        data_model_str = ""
        for ent in self.get_entities(entity_names):
            entity_model = EntityModel(ent)
            data_model_str += entity_model.to_esdl_str()

        app_str = "\n}"
        os.makedirs(self.output_dir / "dbschema", exist_ok=True)
        with open(self.output_dir / f"dbschema/default.esdl", "w") as f:
            f.write(header_str + data_model_str + app_str)

        # Copy files necessary to run EdgeDB with the auto-generated dbschema
        parent_dirs = list(pathlib.Path(__file__).parents)
        index = [x.stem for x in parent_dirs].index("ifcdb")
        docker_files_dir = parent_dirs[index] / "dbs/ifcedge"
        file_names = ["docker-compose.yml", "edgedb.toml", "Makefile"]
        for fname in file_names:
            shutil.copy(docker_files_dir / fname, self.output_dir / fname)

import logging
import operator
import os
import pathlib
from dataclasses import dataclass
from typing import List, Union

from ifcdb.pymodel.att_types import Array
from ifcdb.pymodel.entities import Entity

from .base import BaseModel


def build_test_str():
    return """\nif __name__ == "__main__":
    tria = IfcTriangulatedFaceSet(
        Coordinates=IfcCartesianPointList3D([(0, 0, 0), (1, 0, 0), (1, 1, 0)]),
        CoordIndex=[(0, 1, 2)],
    )
    owner_history = IfcOwnerHistory(
        OwningUser=IfcPersonAndOrganization(
            ThePerson=IfcPerson("Bob"),
            TheOrganization=IfcOrganization("MajorCorp"),
        ),
        OwningApplication=IfcApplication(
            ApplicationDeveloper=IfcOrganization("MinorCorp"), Version="0.0.1-alpha", ApplicationFullName="Autogen"
        ),
        CreationDate=11122645,
    )
    
    product = IfcBuildingElementProxy(
        GlobalId="thisisaguid",
        OwnerHistory=owner_history,
        Name='ABuildingElProxy', Description='A really interesting description',
        Representation=IfcProductRepresentation(
            Representations=[
                IfcRepresentation(
                    ContextOfItems=IfcRepresentationContext(),
                    Items=[tria]
                )
            ]
        )
    )

    bldg = IfcBuilding(GlobalId='yetanotherguid', OwnerHistory=owner_history)
    
    rel_space = IfcRelContainedInSpatialStructure(
        GlobalId='thisisanotherguid', OwnerHistory=owner_history,
        RelatedElements=[product],
        RelatingStructure=bldg
    )
    product.ObjectPlacement = rel_space
    print(product)
"""


@dataclass
class EntityModel:
    entity: Entity

    def to_pydantic_str(self):
        ancestor_str = self.ancestor_str
        if ancestor_str == "":
            ancestor_str = "(pydantic.BaseModel)"
        return f"""

class {self.entity.name}{ancestor_str}:
{self.attributes_str}
"""

    def to_enum_class_str(self) -> str:
        enum_str = "\n".join(f"    {x} = auto()" for x in self.entity.enum_values)
        return f"""
class {self.entity.name}(Enum):
{enum_str}
"""

    def to_dataclass_str(self) -> str:
        att_str = self.attributes_str
        if self.entity.is_enum:
            return self.to_enum_class_str()
        dataclass_props = ""
        if "= None" in att_str and self.entity.supertype_of is not None:
            dataclass_props = "(kw_only=True)"

        return f"""

@dataclass{dataclass_props}
class {self.entity.name}{self.ancestor_str}:
{att_str}
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
        attributes = sorted(
            self.entity.instance_attributes.values(),
            key=operator.attrgetter("optional"),
        )
        for val in attributes:
            if val.parent != self.entity:
                continue

            vtyp = val.type
            if isinstance(vtyp, Entity):
                att_ref = vtyp.name
            elif isinstance(vtyp, Array):
                att_ref = array_to_str(vtyp)
            else:
                att_ref = vtyp

            opt_str = " = None" if val.optional is True else ""
            atts_str += f"    {val.name}: {att_ref}" + opt_str + "\n"
        if atts_str == "":
            atts_str = "    pass"
        return atts_str


def array_to_str(array: Array) -> str:
    entity = array.of_type
    if isinstance(entity, Entity):
        if entity.is_base_type:
            entity_str = PyModel.base_type_map.get(entity.content, None)
        else:
            entity_str = entity.name
    else:
        logging.warning("Entity is None")
        entity_str = ""

    array_str = ""

    multilevel = False
    shape_len = len(array.shape)

    if shape_len > 1:
        multilevel = True
        end_fix = shape_len * "]"
    else:
        end_fix = "]"

    for i, shape in enumerate(array.shape):
        b = shape[1]
        if "?" not in b:
            entity_str = ",".join([f"{entity_str}" for x in range(int(float(b)))])

        if multilevel is False:
            array_str += f"List["
        else:
            if i == 0:
                array_str += f"List["
            else:
                array_str += f"Tuple["

    return array_str + f"{entity_str}{end_fix}"


@dataclass
class PyModel(BaseModel):
    output_dir: pathlib.Path = pathlib.Path("temp/pymodel")

    def export_all_related_to_dataclasses(self, entity_names: Union[str, List[str]], main_str: str = None):
        header_str = "from __future__ import annotations\n"
        header_str += "from dataclasses import dataclass\n"
        header_str += "from enum import Enum, auto\n"
        header_str += "from typing import List, Tuple\n"

        if isinstance(entity_names, str):
            entity_names = [entity_names]

        data_model_str = ""
        for ent in self.get_entities(entity_names):
            entity_model = EntityModel(ent)
            data_model_str += entity_model.to_dataclass_str()

        os.makedirs(self.output_dir, exist_ok=True)
        app_str = main_str if main_str is not None else ""
        with open(self.output_dir / f"ifc_py_model.py", "w") as f:
            f.write(header_str + data_model_str + app_str)

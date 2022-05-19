import os
import operator
from dataclasses import dataclass
from ifc_schema.exp_reader import ExpReader
from ifc_schema.entities import Entity


def build_test_str():
    return """if __name__ == "__main__":
        tria = IfcTriangulatedFaceSet(
            Coordinates=IfcCartesianPointList3D([(0, 0, 0), (1, 0, 0), (1, 1, 0)]),
            CoordIndex=[(0, 1, 0)],
        )
        print(tria)
"""


@dataclass
class EntityModel:
    entity: Entity

    def to_esdl_str(self):
        att_str = self.attributes_str
        dataclass_props = ""
        if "= None" in att_str:
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
        attributes = sorted(self.entity.instance_attributes.values(), key=operator.attrgetter("optional"))
        for val in attributes:
            if val.parent != self:
                continue

            vtyp = val.type
            if isinstance(vtyp, Entity):
                att_ref = vtyp.name
            else:
                att_ref = vtyp

            opt_str = " = None" if val.optional is True else ""
            atts_str += f"    {val.name}: {att_ref}" + opt_str + "\n"
        if atts_str == "":
            atts_str = "    pass"
        return atts_str


@dataclass
class EdgeModel:
    exp_reader: ExpReader

    def export_all_related_to_esdl(self, class_name, main_str: str = None):
        triface = self.exp_reader.entity_dict[class_name]
        test_file_str = "from __future__ import annotations\nfrom dataclasses import dataclass\nimport typing\n"

        all_ents = triface.get_related_entities_and_types()
        for ent in all_ents:
            entmodel = EntityModel(ent)
            test_file_str += entmodel.to_esdl_str()

        os.makedirs("temp/pymodel", exist_ok=True)
        with open(f"temp/pymodel/test{class_name}.py", "w") as f:
            f.write(test_file_str + main_str if main_str is not None else "")

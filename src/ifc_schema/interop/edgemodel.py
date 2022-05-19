import operator
import os
import pathlib
from dataclasses import dataclass

from ifc_schema.entities import Entity
from ifc_schema.exp_reader import ExpReader


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
            if isinstance(vtyp, Entity):
                att_ref = vtyp.name
            else:
                att_ref = vtyp

            if val.optional is False:
                atts_str += 8 * " " + f"required property {val.name} -> {att_ref};\n"
            else:
                atts_str += 8 * " " + f"property {val.name} -> {att_ref};\n"

        return atts_str


@dataclass
class EdgeModel:
    exp_reader: ExpReader
    output_dir: pathlib.Path = pathlib.Path("temp/edge_model")

    def export_all_related_to_esdl(self, class_name):
        triface = self.exp_reader.entity_dict[class_name]
        test_file_str = "module default {\n"

        all_ents = triface.get_related_entities_and_types()
        for ent in all_ents:
            entmodel = EntityModel(ent)
            test_file_str += 4 * " " + entmodel.to_esdl_str()

        os.makedirs(self.output_dir / "dbschema", exist_ok=True)
        with open(self.output_dir / f"dbschema/default.esdl", "w") as f:
            f.write(test_file_str + "\n}")

from dataclasses import dataclass
import json

from ifc_schema.interop.edge_model.edge_model_base import EdgeIO


@dataclass
class EdgeToIfc(EdgeIO):
    ifc_file = None

    def get_spatial_content(self, spatial_name) -> dict:
        """First export Spatial Hierarchy, filter in script and then do a single client query export"""
        in_str = f"""SELECT IfcRelContainedInSpatialStructure {{
    id,
    RelatingStructure : {{ Name, id }},
    RelatedElements : {{ Name, id }}
}}"""
        result = json.loads(self.client.query_json(in_str))
        children = []
        parent = None
        for r in result:
            pobj = r["RelatingStructure"]
            if pobj == spatial_name:
                children = r["RelatedElements"]
                parent = pobj
                break
        if parent is None:
            raise ValueError("Parent object is not found")

        dmap = {parent["id"]: {"atts": parent, "children": dict()}}
        curr_level = dmap[parent["id"]]

        return result

    def get_all(self) -> dict:
        select_str = "" #"set {\n"
        for entity_name, entity in self.em.entities.items():
            select_str += f"SELECT {entity_name} {{"
            all_atts = entity.get_attributes(True)
            for i, att in enumerate(all_atts):
                select_str += 4 * " " + f"`{att.name}`"
                select_str += "" if i == len(all_atts) - 1 else ","
            select_str += "};\n"
        # select_str += "}"
        print(select_str)
        return json.loads(self.client.query_json(select_str))

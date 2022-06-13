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

    def get_all(self, entities: list[str] = None) -> dict:
        from ifc_schema.interop.edge_model.edge_model_base import (
            TypeEdgeModel,
            EnumEdgeModel,
            SelectEdgeModel,
            EntityEdgeModel,
        )

        select_str = "select {\n"
        if entities is None:
            ent_dict = self.em.entities
        else:
            ent_dict = {x: self.em.get_entity_by_name(x) for x in self.em.get_related_entities(entities)}

        for entity_name, entity in ent_dict.items():
            if isinstance(entity, EnumEdgeModel):
                continue
            if isinstance(entity, EntityEdgeModel) and entity.entity.is_abstract():
                continue
            select_str += f"{entity_name} := (SELECT {entity_name} {{"
            if isinstance(entity, (SelectEdgeModel, TypeEdgeModel)):
                select_str += 4 * " " + f"id,\n"
                select_str += 4 * " " + f"`{entity.name}`"
            else:
                all_atts = entity.get_attributes(True)
                select_str += 4 * " " + f"id,\n"
                for i, att in enumerate(all_atts):
                    select_str += 4 * " " + f"`{att.name}`"
                    select_str += "" if i == len(all_atts) - 1 else ","
            select_str += "}),\n"
        select_str += "}"
        return json.loads(self.client.query_json(select_str))

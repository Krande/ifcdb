import pathlib
from dataclasses import dataclass
from typing import ClassVar, List

from ifc_schema.entities import Entity
from ifc_schema.exp_reader import ExpReader


@dataclass
class BaseModel:
    exp_reader: ExpReader
    output_dir: pathlib.Path = pathlib.Path("temp/edge_model")

    base_type_map: ClassVar[dict] = {
        "IfcInteger": "int",
        "REAL": "float",
        "BOOLEAN": "bool",
        "INTEGER": "int",
        "STRING": "str",
        "STRING(22) FIXED": "str",
        "BINARY": "str",
        "STRING(255)": "str",
    }

    def __post_init__(self):
        base_types = set(self.base_type_map.keys())
        all_entity_types = set(Entity.BASE_TYPES)
        result = all_entity_types.difference(base_types)
        if len(result) > 0:
            raise ValueError(
                f'The following IFC base types have not been defined in the output format "{result}"'
            )

    def get_entities(self, entity_names: List[str]) -> List[Entity]:
        related_entities = []
        output_entities = []
        for cnam in entity_names:
            triface = self.exp_reader.entity_dict[cnam]
            all_ents = triface.get_related_entities_and_types(related_entities)
            for ent in all_ents:
                if ent.is_base_type:
                    continue
                if ent not in output_entities:
                    output_entities.append(ent)
        return output_entities

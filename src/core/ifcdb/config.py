from dataclasses import dataclass


@dataclass
class IfcDbConfig:
    ifc_schema_version: str
    unwrapped_enums: bool = True
    unwrapped_selects: bool = True

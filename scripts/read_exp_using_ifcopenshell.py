from __future__ import annotations
import ifcopenshell
from dataclasses import dataclass, field


wrap = ifcopenshell.ifcopenshell_wrapper


@dataclass
class Entity:
    name: str
    _content: wrap.entity = field(repr=False)
    _exp_reader: ExpReader = None

    @property
    def attributes(self):
        return self._content.attributes()

    @property
    def is_abstract(self):
        return self._content.is_abstract()


@dataclass
class ExpReader:
    schema_name: str
    entities: dict[str, Entity] = field(default_factory=dict)
    enums: dict[str, Entity] = field(default_factory=dict)
    types: dict[str, Entity] = field(default_factory=dict)

    def __post_init__(self):
        schema = wrap.schema_by_name(self.schema_name)
        all_decs = schema.declarations()
        self.entities = {x.name(): Entity(x.name(), x) for x in filter(lambda x: isinstance(x, wrap.entity), all_decs)}
        self.enums = {
            x.name(): Entity(x.name(), x) for x in filter(lambda x: isinstance(x, wrap.enumeration_type), all_decs)
        }
        self.types = {
            x.name(): Entity(x.name(), x) for x in filter(lambda x: isinstance(x, wrap.type_declaration), all_decs)
        }


def main(schema_name):
    exp = ExpReader(schema_name)

    res = exp.entities["IfcTriangulatedFaceSet"]
    res2 = exp.entities["IfcBuildingElementProxy"]

    schema = wrap.schema_by_name(schema_name)
    all_decs = schema.declarations()

    entity = schema.declaration_by_name("IfcRoot")
    atts = entity.attributes()
    att_1_type = atts[0].type_of_attribute()
    att_1_declared_type = att_1_type.declared_type()

    print("")


if __name__ == "__main__":
    main("IFC4x1")

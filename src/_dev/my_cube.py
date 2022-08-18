from __future__ import annotations
import ifcopenshell
from dataclasses import dataclass
from pydantic import BaseModel


@dataclass
class IfcGeneric:
    class_name: str
    global_id: str
    props: dict
    links: dict[str, IfcGeneric]

    def to_dict(self):
        return dict(
            class_name=self.class_name,
            global_id=self.global_id,
            props=self.props,
            links={key: value.to_dict() for key, value in self.links.items()},
        )


def to_generic(ifc_elem: ifcopenshell.entity_instance) -> IfcGeneric:
    product_data = ifc_elem.get_info()
    product_data.pop("id")
    guid = product_data.get("GlobalId")
    class_name = product_data.pop("type")
    links = {
        key: to_generic(value) for key, value in product_data.items() if isinstance(value, ifcopenshell.entity_instance)
    }
    props = {key: value for key, value in product_data.items() if not isinstance(value, ifcopenshell.entity_instance)}

    return IfcGeneric(class_name=class_name, global_id=guid, props=props, links=links)


f = ifcopenshell.open("../../files/MyCube.ifc")
product = f.by_type("IfcSlab")[0]
assert isinstance(product, ifcopenshell.entity_instance)
print(f.traverse(product))
ifc_gen = to_generic(product)
print(ifc_gen.to_dict())

# for key, value in product.get_info().items():
#     print(key, value)
# for x in f.traverse(product, breadth_first=True):
#     print(x)
# print(res)

from __future__ import annotations

from dataclasses import dataclass

import ifcopenshell
import pytest
from httpx import AsyncClient

from ifcdb.io.ifc import IfcIO


@pytest.fixture
def mock_db_name():
    return "MyCube2"


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
            links={key: value.global_id for key, value in self.links.items()},
        )


def to_generic(ifc_elem: ifcopenshell.entity_instance) -> IfcGeneric:
    product_data = ifc_elem.get_info()

    product_data.pop("id")
    guid = product_data.get("GlobalId")
    class_name = product_data.pop("type")
    links = {
        key: to_generic(value)
        for key, value in product_data.items()
        if isinstance(value, (ifcopenshell.entity_instance, dict))
    }
    props = {
        key: value for key, value in product_data.items() if not isinstance(value, (ifcopenshell.entity_instance, dict))
    }

    return IfcGeneric(class_name=class_name, global_id=guid, props=props, links=links)


@pytest.fixture
def cube_ifc_data(ifc_files_dir) -> list[IfcGeneric]:
    ifc_io = IfcIO(ifc_files_dir / "MyCube.ifc")
    return [to_generic(f) for f in ifc_io.ifc_obj]


@pytest.mark.anyio
async def test_auth_view_not_admin(normal_user_client: AsyncClient, cube_ifc_data, mock_db_name):
    response = await normal_user_client.post("/entities", params={"dbname": mock_db_name, "ifc_file": cube_ifc_data})
    assert response.status_code == 401

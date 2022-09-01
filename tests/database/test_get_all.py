import json
from ifcdb.io.ifc import IfcIO
from ifcdb.schema.model import IfcSchemaModel


def test_get_all(files_dir):
    res = json.load(open(files_dir / "get_all_res.json"))["results"]
    ifc_obj = IfcIO.to_ifcopenshell_object(res, IfcSchemaModel("IFC4x1"))
    assert len(list(ifc_obj)) == 220
    print(ifc_obj)

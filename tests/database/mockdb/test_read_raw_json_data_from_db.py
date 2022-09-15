from ifcdb.diffing.tool import IfcDiffTool


def test_beam_w_holes_to_ifc_obj(my_beam_w_holes_ifc, mock_db_my_beam_with_holes):
    ifc_obj = mock_db_my_beam_with_holes.to_ifcopenshell_object()
    assert len(list(ifc_obj)) == 110

    tool = IfcDiffTool(my_beam_w_holes_ifc, ifc_obj)

    assert len(tool.added) == 0
    assert len(tool.removed) == 0
    assert len(tool.changed) == 0


def test_my_cube_edited_z(my_cube_edited_z, mock_db_my_cube_original):
    ifc_obj = mock_db_my_cube_original.to_ifcopenshell_object()
    # assert len(list(ifc_obj)) == 110

    tool = IfcDiffTool(my_cube_edited_z, ifc_obj)

    assert len(tool.added) == 0
    assert len(tool.removed) == 0
    assert len(tool.changed) == 0

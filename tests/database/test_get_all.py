from ifcdb.diffing.tool import ifc_diff_tool


def test_get_all(my_beam_w_holes_ifc, mock_db_my_beam_with_holes):
    ifc_obj = mock_db_my_beam_with_holes.to_ifcopenshell_object()
    assert len(list(ifc_obj)) == 110

    tool = ifc_diff_tool(my_beam_w_holes_ifc, ifc_obj)

    assert len(tool.added) == 0
    assert len(tool.removed) == 0
    assert len(tool.changed) == 0

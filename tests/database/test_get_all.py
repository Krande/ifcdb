def test_get_all(mock_db_my_beam_with_holes):
    ifc_obj = mock_db_my_beam_with_holes.to_ifcopenshell_object()
    assert len(list(ifc_obj)) == 110

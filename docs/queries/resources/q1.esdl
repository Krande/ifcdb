SELECT IfcBeam {
    # Properties pointing to native types (str, float64, int64, etc.)
    GlobalId,
    Description,
    Name,
    ObjectType,
    Tag,
    PredefinedType,
    # Links to other objects
    OwnerHistory,
    ObjectPlacement,
    Representation,
    # These are specific EdgeDB attributes to get more information about the object itself
    _e_type := .__type__.name
}
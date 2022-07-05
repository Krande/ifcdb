SELECT IfcBeam {
    # Properties pointing to native types (str, float64, int64, etc.)
    GlobalId,
    Description,
    Name,
    ObjectType,
    Tag,
    PredefinedType,
    # Links to other objects
    OwnerHistory : {
        # Properties
        LastModifiedDate,
        CreationDate,
        # Links to other objects
        OwningUser,
        OwningApplication,
        State,
        ChangeAction,
        LastModifyingUser,
        LastModifyingApplication,
        # These are specific EdgeDB attributes to get more information about the object itself
        __type__ : {name}
    },
    ObjectPlacement : {
        # ObjectPlacement points to an abstract superclass "IfcObjectPlacement".
        # Therefore we need to consider various subtypes using the [is ..].key
        # (to reduce size of this file and since we know that for this scenario ObjectPlacement is pointing to an
        # IfcLocalPlacement, we will skip the other subtypes "IfcLinearPlacement" & "IfcGridPlacement"
        [is IfcLocalPlacement].PlacementRelTo,
        [is IfcLocalPlacement].RelativePlacement,
        # These are specific EdgeDB attributes to get more information about the object itself
        __type__ : {name}
    },
    Representation : {
        # Points to an abstract superclass "IfcProductRepresentation". However only the subtype
        # "IfcMaterialDefinitionRepresentation" has any unique properties not associated with its parent class and
        # it is not used in this particular test IFC file and is therefore omitted.
        # Properties
        Name,
        Description,
        # Links to other objects
        Representations,
        # These are specific EdgeDB attributes to get more information about the object itself
        __type__ : {name}
    }
}
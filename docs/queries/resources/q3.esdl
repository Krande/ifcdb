SELECT IfcBeam {
    # Properties pointing to native types (str, float64, int64, etc.)
    GlobalId,
    Description,
    Name,
    ObjectType,
    Tag,
    PredefinedType,
    # Links to other objects
    OwnerHistory : { # IfcOwnerHistory
        # Properties
        LastModifiedDate,
        CreationDate,
        # Links to other objects
        OwningUser : { # IfcPersonAndOrganization
            ThePerson : { # IfcPerson
                Identification,
                FamilyName,
                GivenName,
                MiddleNames,
                PrefixTitles,
                SuffixTitles,
                Roles : { # IfcActorRole
                    Role,
                    UserDefinedRole,
                    Description,
                    _e_type := .__type__.name
                },
                Addresses : { # IfcAddress
                    Purpose,
                    Description,
                    UserDefinedPurpose,
                    _e_type := .__type__.name
                }
            },
            TheOrganization : { # IfcOrganization
                Identification,
                Name,
                Description,
                Roles : { # IfcActorRole
                    Role,
                    UserDefinedRole,
                    Description,
                    _e_type := .__type__.name
                },
                Addresses : { # IfcAddress
                    Purpose,
                    Description,
                    UserDefinedPurpose,
                    _e_type := .__type__.name
                },
                _e_type := .__type__.name
            },
            Roles : { # IfcActorRole
                Role,
                UserDefinedRole,
                Description,
                _e_type := .__type__.name
            }
        },
        OwningApplication : { # IfcApplication
            ApplicationDeveloper : { # IfcOrganization
                Identification,
                Name,
                Description,
                Roles : { # IfcActorRole
                    Role,
                    UserDefinedRole,
                    Description,
                    _e_type := .__type__.name
                },
                Addresses : { # IfcAddress
                    Purpose,
                    Description,
                    UserDefinedPurpose
                },
                _e_type := .__type__.name
            },
            Version,
            ApplicationFullName,
            ApplicationIdentifier,
            _e_type := .__type__.name
        },
        State,
        ChangeAction,
        LastModifyingUser : { # IfcPersonAndOrganization
            ThePerson : { # IfcPerson
                Identification,
                FamilyName,
                GivenName,
                MiddleNames,
                PrefixTitles,
                SuffixTitles,
                Roles : { # IfcActorRole
                    Role,
                    UserDefinedRole,
                    Description,
                    _e_type := .__type__.name
                },
                Addresses : { # IfcAddress
                    Purpose,
                    Description,
                    UserDefinedPurpose,
                    _e_type := .__type__.name
                },
                _e_type := .__type__.name
            },
            TheOrganization : { # IfcOrganization
                Identification,
                Name,
                Description,
                Roles : { # IfcActorRole
                    Role,
                    UserDefinedRole,
                    Description,
                    _e_type := .__type__.name
                },
                Addresses : { # IfcAddress
                    Purpose,
                    Description,
                    UserDefinedPurpose,
                    _e_type := .__type__.name
                },
                _e_type := .__type__.name
            },
            Roles : { # IfcActorRole
                Role,
                UserDefinedRole,
                Description,
                _e_type := .__type__.name
            },
            _e_type := .__type__.name
        },
        LastModifyingApplication : { # IfcApplication
            ApplicationDeveloper : { # IfcOrganization
                Identification,
                Name,
                Description,
                Roles : { # IfcActorRole
                    Role,
                    UserDefinedRole,
                    Description,
                    _e_type := .__type__.name
                },
                Addresses : { # IfcAddress
                    Purpose,
                    Description,
                    UserDefinedPurpose,
                    _e_type := .__type__.name
                },
                _e_type := .__type__.name
            },
            Version,
            ApplicationFullName,
            ApplicationIdentifier,
            _e_type := .__type__.name
        },
        # These are specific EdgeDB attributes to get more information about the object itself
        _e_type := .__type__.name
    },
    ObjectPlacement : { # IfcObjectPlacement
        # ObjectPlacement points to an abstract superclass "IfcObjectPlacement".
        # Therefore we need to consider various subtypes using the [is ..].key
        # (to reduce size of this file and since we know that for this scenario ObjectPlacement is pointing to an
        # IfcLocalPlacement, we will skip the other subtypes "IfcLinearPlacement" & "IfcGridPlacement"
        [is IfcLocalPlacement].PlacementRelTo,
        # PlacementRelTo links to same type of object "IfcObjectPlacement".
        # Therefore it is considered not necessary to follow the path further, given that this information would have
        # to be collected in a separate step
        [is IfcLocalPlacement].RelativePlacement : { # IfcAxis2Placement
            # IfcAxis2Placement is a Select object. Which means it can be one of many objects.
            # It is however, not known how
            [is IfcAxis2Placement3D].Location : { # IfcPoint
                [is IfcCartesianPoint].Coordinates
            },
            [is IfcAxis2Placement3D].RefDirection: { # IfcDirection
                DirectionRatios
            },
            [is IfcAxis2Placement3D].Axis,
            # These are specific EdgeDB attributes to get more information about the object itself
            _e_type := .__type__.name
        },
        # These are specific EdgeDB attributes to get more information about the object itself
        _e_type := .__type__.name
    },
    Representation : { # IfcProductRepresentation
        # Points to an abstract superclass "IfcProductRepresentation". However only the subtype
        # "IfcMaterialDefinitionRepresentation" has any unique properties not associated with its parent class and
        # it is not used in this particular test IFC file and is therefore omitted.
        # Properties
        Name,
        Description,
        # Links to other objects
        Representations : { # IfcRepresentation
            [is IfcShapeRepresentation].RepresentationIdentifier,
            [is IfcShapeRepresentation].RepresentationType,
            [is IfcShapeRepresentation].ContextOfItems : { # IfcRepresentationContext
                ContextIdentifier,
                ContextType,
                [is IfcGeometricRepresentationContext].CoordinateSpaceDimension,
                [is IfcGeometricRepresentationContext].Precision,
                [is IfcGeometricRepresentationContext].WorldCoordinateSystem : { # IfcAxis2Placement
                    # IfcAxis2Placement is a Select object. Which means it can be one of many objects.
                    # It is however, not known how
                    [is IfcAxis2Placement3D].Location : { # IfcPoint
                        [is IfcCartesianPoint].Coordinates
                    },
                    [is IfcAxis2Placement3D].RefDirection: { # IfcDirection
                        DirectionRatios
                    },
                    [is IfcAxis2Placement3D].Axis,
                    # These are specific EdgeDB attributes to get more information about the object itself
                    _e_type := .__type__.name
                },
                [is IfcGeometricRepresentationContext].TrueNorth : { # IfcDirection
                    DirectionRatios
                },
            },
            [is IfcShapeRepresentation].Items : { # IfcRepresentationItem
                # IfcRepresentationItem is an abstract class that represents > 100 different types of representation
                # types. Therefore only the 2 subtypes found in the IFC file is included
                [is IfcExtrudedAreaSolid].SweptArea : { # IfcProfileDef
                    # IfcProfileDef is an abstract superclass. Here only the IfcIShapeProfileDef is included.
                    [is IfcIShapeProfileDef].ProfileType,
                    [is IfcIShapeProfileDef].ProfileName,
                    [is IfcIShapeProfileDef].Position : { # IfcAxis2Placement2D
                        Location : { # IfcPoint
                            [is IfcCartesianPoint].Coordinates
                        },
                        RefDirection : { # IfcDirection
                            DirectionRatios
                        },
                    },
                    [is IfcIShapeProfileDef].OverallWidth,
                    [is IfcIShapeProfileDef].OverallDepth,
                    [is IfcIShapeProfileDef].WebThickness,
                    [is IfcIShapeProfileDef].FlangeThickness,
                    [is IfcIShapeProfileDef].FilletRadius,
                    [is IfcIShapeProfileDef].FlangeEdgeRadius,
                    [is IfcIShapeProfileDef].FlangeSlope
                },
                [is IfcExtrudedAreaSolid].Position : { # IfcAxis2Placement3D
                    Location : { # IfcPoint
                        [is IfcCartesianPoint].Coordinates
                    },
                    Axis : { # IfcDirection
                        DirectionRatios
                    },
                    RefDirection : { # IfcDirection
                        DirectionRatios
                    },
                },
                [is IfcExtrudedAreaSolid].ExtrudedDirection : { # IfcDirection
                    DirectionRatios
                },
                [is IfcExtrudedAreaSolid].Depth,
                [is IfcPolyline].Points : { # IfcCartesianPoint
                    Coordinates
                }
            }
        },
        # These are specific EdgeDB attributes to get more information about the object itself
        _e_type := .__type__.name
    }
}
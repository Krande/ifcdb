SELECT (
    (
        SELECT IfcBuildingStorey {
            GlobalId,
            OwnerHistory : {
                OwningUser : {
                    ThePerson : {
                        Identification,
                        FamilyName,
                        GivenName,
                        MiddleNames,
                        PrefixTitles,
                        SuffixTitles,
                        Roles : {
                            Role,
                            UserDefinedRole,
                            Description
                        },
                        Addresses : {
                            Purpose,
                            Description,
                            UserDefinedPurpose
                        }
                    },
                TheOrganization : {
                    Identification,
                    Name,
                    Description,
                    Roles : {
                        Role,
                        UserDefinedRole,
                        Description
                    },
                    Addresses : {
                        Purpose,
                        Description,
                        UserDefinedPurpose
                    }
                },
                Roles : {
                    Role,
                    UserDefinedRole,
                    Description
                }
            },
            OwningApplication : {
                ApplicationDeveloper : {
                    Identification,
                    Name,
                    Description,
                    Roles : {
                        Role,
                        UserDefinedRole,
                        Description
                    },
                    Addresses : {
                        Purpose,
                        Description,
                        UserDefinedPurpose
                    }
                },
                Version,
                ApplicationFullName,
                ApplicationIdentifier
            },
            State,
            ChangeAction,
            LastModifiedDate,
            LastModifyingUser : {
                ThePerson : {
                    Identification,
                    FamilyName,
                    GivenName,
                    MiddleNames,
                    PrefixTitles,
                    SuffixTitles,
                    Roles : {
                        Role,
                        UserDefinedRole,
                        Description
                    },
                    Addresses : {
                        Purpose,
                        Description,
                        UserDefinedPurpose
                    }
                },
                TheOrganization : {
                    Identification,
                    Name,
                    Description,
                    Roles : {
                        Role,
                        UserDefinedRole,
                        Description
                    },
                    Addresses : {
                        Purpose,
                        Description,
                        UserDefinedPurpose
                    }
                },
                Roles : {
                    Role,
                    UserDefinedRole,
                    Description
                }
            },
            LastModifyingApplication : {
                ApplicationDeveloper : {
                    Identification,
                    Name,
                    Description,
                    Roles : {
                        Role,
                        UserDefinedRole,
                        Description
                    },
                    Addresses : {
                        Purpose,
                        Description,
                        UserDefinedPurpose
                    }
                },
                Version,
                ApplicationFullName,
                ApplicationIdentifier
            },
            CreationDate
        },
        Name,
        Description,
        ObjectType,
        ObjectPlacement : {id, __type__ : { name }},
        Representation : {
            Name,
            Description,
            Representations : {
                ContextOfItems : {
                    ContextIdentifier,
                    ContextType
                },
                RepresentationIdentifier,
                RepresentationType,
                Items : {id, __type__ : { name }}
            }
        },
        LongName,
        CompositionType,
        Elevation
    } filter .id = <uuid>'fe0e2222-f601-11ec-9720-ffa48bb2d7b1'),
    ...
)
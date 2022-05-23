module default {

    scalar type IfcChangeActionEnum extending enum<NOCHANGE, MODIFIED, ADDED, DELETED, NOTDEFINED>;


    scalar type IfcStateEnum extending enum<READWRITE, READONLY, LOCKED, READWRITELOCKED, READONLYLOCKED>;


    scalar type IfcAddressTypeEnum extending enum<OFFICE, SITE, HOME, DISTRIBUTIONPOINT, USERDEFINED>;


    scalar type IfcRoleEnum extending enum<SUPPLIER, MANUFACTURER, CONTRACTOR, SUBCONTRACTOR, ARCHITECT, STRUCTURALENGINEER, COSTENGINEER, CLIENT, BUILDINGOWNER, BUILDINGOPERATOR, MECHANICALENGINEER, ELECTRICALENGINEER, PROJECTMANAGER, FACILITIESMANAGER, CIVILENGINEER, COMMISSIONINGENGINEER, ENGINEER, OWNER, CONSULTANT, CONSTRUCTIONMANAGER, FIELDCONSTRUCTIONMANAGER, RESELLER, USERDEFINED>;


    type IfcOrganization  {
        required property Name -> str;
        property Identification -> str;
        property Description -> str;
        multi link Roles -> IfcActorRole;
        multi link Addresses -> IfcAddress;
    }

    type IfcApplication  {
        required link ApplicationDeveloper -> IfcOrganization;
        required property Version -> str;
        required property ApplicationFullName -> str;
    }

    type IfcPerson  {
        property Identification -> str;
        property FamilyName -> str;
        property GivenName -> str;
        property MiddleNames -> array<str>;
        property PrefixTitles -> array<str>;
        property SuffixTitles -> array<str>;
        multi link Roles -> IfcActorRole;
        multi link Addresses -> IfcAddress;
    }

    type IfcOwnerHistory  {
        required link OwningUser -> IfcPersonAndOrganization;
        required link OwningApplication -> IfcApplication;
        required property CreationDate -> int32;
        property State -> IfcStateEnum;
        property ChangeAction -> IfcChangeActionEnum;
        property LastModifiedDate -> int32;
        link LastModifyingUser -> IfcPersonAndOrganization;
    }

    abstract type IfcRoot  {
        required property GlobalId -> str;
        link OwnerHistory -> IfcOwnerHistory;
        property Name -> str;
        property Description -> str;
    }

    abstract type IfcRepresentationItem  {
    }

    abstract type IfcAddress  {
        property Purpose -> IfcAddressTypeEnum;
        property Description -> str;
        property UserDefinedPurpose -> str;
    }

    abstract type IfcRepresentation  {
        required link ContextOfItems -> IfcRepresentationContext;
        required multi link Items -> IfcRepresentationItem;
        property RepresentationType -> str;
    }

    type IfcActorRole  {
        required property Role -> IfcRoleEnum;
        property UserDefinedRole -> str;
        property Description -> str;
    }

    abstract type IfcRepresentationContext  {
        property ContextIdentifier -> str;
        property ContextType -> str;
    }

    abstract type IfcProductRepresentation  {
        required multi link Representations -> IfcRepresentation;
        property Name -> str;
        property Description -> str;
    }

    abstract type IfcObjectPlacement  {
    }

    type IfcPersonAndOrganization  {
        required link ThePerson -> IfcPerson;
        required link TheOrganization -> IfcOrganization;
        multi link Roles -> IfcActorRole;
    }

    scalar type IfcBuildingElementProxyTypeEnum extending enum<COMPLEX, ELEMENT, PARTIAL, PROVISIONFORVOID, PROVISIONFORSPACE, USERDEFINED, NOTDEFINED>;


    abstract type IfcObjectDefinition extending IfcRoot {
    }

    abstract type IfcObject extending IfcObjectDefinition {
        property ObjectType -> str;
    }

    abstract type IfcProduct extending IfcObject {
        link ObjectPlacement -> IfcObjectPlacement;
        link Representation -> IfcProductRepresentation;
    }

    abstract type IfcElement extending IfcProduct {
        property Tag -> str;
    }

    abstract type IfcBuildingElement extending IfcElement {
    }

    type IfcBuildingElementProxy extending IfcBuildingElement {
        property PredefinedType -> IfcBuildingElementProxyTypeEnum;
    }

    abstract type IfcGeometricRepresentationItem extending IfcRepresentationItem {
    }

    abstract type IfcTessellatedItem extending IfcGeometricRepresentationItem {
    }

    abstract type IfcTessellatedFaceSet extending IfcTessellatedItem {
        required link Coordinates -> IfcCartesianPointList3D;
    }

    type IfcTriangulatedFaceSet extending IfcTessellatedFaceSet {
        required property CoordIndex -> array<tuple<int32, int32, int32>>;
        property Normals -> array<tuple<float32, float32, float32>>;
        property Closed -> bool;
        property PnIndex -> array<int32>;
    }

    abstract type IfcCartesianPointList extending IfcGeometricRepresentationItem {
    }

    type IfcCartesianPointList3D extending IfcCartesianPointList {
        required property CoordList -> array<tuple<float32, float32, float32>>;
        property TagList -> array<str>;
    }

    type IfcProductDefinitionShape extending IfcProductRepresentation {
    }

    abstract type IfcShapeModel extending IfcRepresentation {
    }

    type IfcShapeRepresentation extending IfcShapeModel {
    }

    type IfcGeometricRepresentationContext extending IfcRepresentationContext {
        property Precision -> float32;
        link TrueNorth -> IfcDirection;
    }

    type IfcDirection extending IfcGeometricRepresentationItem {
        required property DirectionRatios -> tuple<float32, float32, float32>;
    }

    abstract type IfcRelationship extending IfcRoot {
    }

    abstract type IfcRelConnects extending IfcRelationship {
    }

    type IfcRelContainedInSpatialStructure extending IfcRelConnects {
        required multi link RelatedElements -> IfcProduct;
        required link RelatingStructure -> IfcSpatialElement;
    }

    abstract type IfcSpatialElement extending IfcProduct {
        property LongName -> str;
    }

    scalar type IfcElementCompositionEnum extending enum<COMPLEX, ELEMENT, PARTIAL>;


    abstract type IfcSpatialStructureElement extending IfcSpatialElement {
        property CompositionType -> IfcElementCompositionEnum;
    }

    type IfcBuilding extending IfcSpatialStructureElement {
        property ElevationOfRefHeight -> float32;
        property ElevationOfTerrain -> float32;
        link BuildingAddress -> IfcPostalAddress;
    }

    type IfcPostalAddress extending IfcAddress {
        property InternalLocation -> str;
        property AddressLines -> array<str>;
        property PostalBox -> str;
        property Town -> str;
        property Region -> str;
        property PostalCode -> str;
        property Country -> str;
    }

    type IfcUnit  {
    }

    type IfcUnitAssignment  {
        required multi link Units -> IfcUnit;
    }

    abstract type IfcContext extending IfcObjectDefinition {
        property ObjectType -> str;
        property LongName -> str;
        property Phase -> str;
        link UnitsInContext -> IfcUnitAssignment;
    }

    type IfcProject extending IfcContext {
    }

}
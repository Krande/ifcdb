module default {


    scalar type IfcAddressTypeEnum extending enum<DISTRIBUTIONPOINT, HOME, OFFICE, SITE, USERDEFINED>;


    scalar type IfcBuildingElementProxyTypeEnum extending enum<COMPLEX, ELEMENT, NOTDEFINED, PARTIAL, PROVISIONFORSPACE, PROVISIONFORVOID, USERDEFINED>;


    scalar type IfcChangeActionEnum extending enum<ADDED, DELETED, MODIFIED, NOCHANGE, NOTDEFINED>;


    scalar type IfcDerivedUnitEnum extending enum<ACCELERATIONUNIT, ANGULARVELOCITYUNIT, AREADENSITYUNIT, COMPOUNDPLANEANGLEUNIT, CURVATUREUNIT, DYNAMICVISCOSITYUNIT, HEATFLUXDENSITYUNIT, HEATINGVALUEUNIT, INTEGERCOUNTRATEUNIT, IONCONCENTRATIONUNIT, ISOTHERMALMOISTURECAPACITYUNIT, KINEMATICVISCOSITYUNIT, LINEARFORCEUNIT, LINEARMOMENTUNIT, LINEARSTIFFNESSUNIT, LINEARVELOCITYUNIT, LUMINOUSINTENSITYDISTRIBUTIONUNIT, MASSDENSITYUNIT, MASSFLOWRATEUNIT, MASSPERLENGTHUNIT, MODULUSOFELASTICITYUNIT, MODULUSOFLINEARSUBGRADEREACTIONUNIT, MODULUSOFROTATIONALSUBGRADEREACTIONUNIT, MODULUSOFSUBGRADEREACTIONUNIT, MOISTUREDIFFUSIVITYUNIT, MOLECULARWEIGHTUNIT, MOMENTOFINERTIAUNIT, PHUNIT, PLANARFORCEUNIT, ROTATIONALFREQUENCYUNIT, ROTATIONALMASSUNIT, ROTATIONALSTIFFNESSUNIT, SECTIONAREAINTEGRALUNIT, SECTIONMODULUSUNIT, SHEARMODULUSUNIT, SOUNDPOWERLEVELUNIT, SOUNDPOWERUNIT, SOUNDPRESSURELEVELUNIT, SOUNDPRESSUREUNIT, SPECIFICHEATCAPACITYUNIT, TEMPERATUREGRADIENTUNIT, TEMPERATURERATEOFCHANGEUNIT, THERMALADMITTANCEUNIT, THERMALCONDUCTANCEUNIT, THERMALEXPANSIONCOEFFICIENTUNIT, THERMALRESISTANCEUNIT, THERMALTRANSMITTANCEUNIT, TORQUEUNIT, USERDEFINED, VAPORPERMEABILITYUNIT, VOLUMETRICFLOWRATEUNIT, WARPINGCONSTANTUNIT, WARPINGMOMENTUNIT>;


    type IfcDimensionalExponents  {
        required property LengthExponent -> int64;
        required property MassExponent -> int64;
        required property TimeExponent -> int64;
        required property ElectricCurrentExponent -> int64;
        required property ThermodynamicTemperatureExponent -> int64;
        required property AmountOfSubstanceExponent -> int64;
        required property LuminousIntensityExponent -> int64;
    }

    scalar type IfcElementCompositionEnum extending enum<COMPLEX, ELEMENT, PARTIAL>;


    scalar type IfcGeometricProjectionEnum extending enum<ELEVATION_VIEW, GRAPH_VIEW, MODEL_VIEW, NOTDEFINED, PLAN_VIEW, REFLECTED_PLAN_VIEW, SECTION_VIEW, SKETCH_VIEW, USERDEFINED>;


    type IfcMonetaryUnit  {
        required property Currency -> str;
    }

    abstract type IfcObjectPlacement  {
    }

    type IfcParameterValue {
        required property value -> float64;
    }

    abstract type IfcRepresentationContext  {
        property ContextIdentifier -> str;
        property ContextType -> str;
    }

    abstract type IfcRepresentationItem  {
    }

    scalar type IfcRoleEnum extending enum<ARCHITECT, BUILDINGOPERATOR, BUILDINGOWNER, CIVILENGINEER, CLIENT, COMMISSIONINGENGINEER, CONSTRUCTIONMANAGER, CONSULTANT, CONTRACTOR, COSTENGINEER, ELECTRICALENGINEER, ENGINEER, FACILITIESMANAGER, FIELDCONSTRUCTIONMANAGER, MANUFACTURER, MECHANICALENGINEER, OWNER, PROJECTMANAGER, RESELLER, STRUCTURALENGINEER, SUBCONTRACTOR, SUPPLIER, USERDEFINED>;


    scalar type IfcStateEnum extending enum<LOCKED, READONLY, READONLYLOCKED, READWRITE, READWRITELOCKED>;


    scalar type IfcTrimmingPreference extending enum<CARTESIAN, PARAMETER, UNSPECIFIED>;


    scalar type IfcUnitEnum extending enum<ABSORBEDDOSEUNIT, AMOUNTOFSUBSTANCEUNIT, AREAUNIT, DOSEEQUIVALENTUNIT, ELECTRICCAPACITANCEUNIT, ELECTRICCHARGEUNIT, ELECTRICCONDUCTANCEUNIT, ELECTRICCURRENTUNIT, ELECTRICRESISTANCEUNIT, ELECTRICVOLTAGEUNIT, ENERGYUNIT, FORCEUNIT, FREQUENCYUNIT, ILLUMINANCEUNIT, INDUCTANCEUNIT, LENGTHUNIT, LUMINOUSFLUXUNIT, LUMINOUSINTENSITYUNIT, MAGNETICFLUXDENSITYUNIT, MAGNETICFLUXUNIT, MASSUNIT, PLANEANGLEUNIT, POWERUNIT, PRESSUREUNIT, RADIOACTIVITYUNIT, SOLIDANGLEUNIT, THERMODYNAMICTEMPERATUREUNIT, TIMEUNIT, USERDEFINED, VOLUMEUNIT>;


    type IfcActorRole  {
        required property Role -> IfcRoleEnum;
        property UserDefinedRole -> str;
        property Description -> str;
    }

    abstract type IfcAddress  {
        property Purpose -> IfcAddressTypeEnum;
        property Description -> str;
        property UserDefinedPurpose -> str;
    }

    abstract type IfcGeometricRepresentationItem extending IfcRepresentationItem {
    }

    abstract type IfcNamedUnit  {
        required link Dimensions -> IfcDimensionalExponents;
        required property UnitType -> IfcUnitEnum;
    }

    abstract type IfcRepresentation  {
        required link ContextOfItems -> IfcRepresentationContext;
        property RepresentationIdentifier -> str;
        property RepresentationType -> str;
        required multi link Items -> IfcRepresentationItem;
    }

    abstract type IfcCartesianPointList extending IfcGeometricRepresentationItem {
    }

    abstract type IfcCurve extending IfcGeometricRepresentationItem {
    }

    type IfcDerivedUnitElement  {
        required link Unit -> IfcNamedUnit;
        required property Exponent -> int64;
    }

    type IfcDirection extending IfcGeometricRepresentationItem {
        required property DirectionRatios -> tuple<float64, float64, float64>;
    }

    type IfcOrganization  {
        property Identification -> str;
        required property Name -> str;
        property Description -> str;
        multi link Roles -> IfcActorRole;
        multi link Addresses -> IfcAddress;
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

    abstract type IfcPoint extending IfcGeometricRepresentationItem {
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

    abstract type IfcProductRepresentation  {
        property Name -> str;
        property Description -> str;
        required multi link Representations -> IfcRepresentation;
    }

    abstract type IfcShapeModel extending IfcRepresentation {
    }

    abstract type IfcTessellatedItem extending IfcGeometricRepresentationItem {
    }

    type IfcApplication  {
        required link ApplicationDeveloper -> IfcOrganization;
        required property Version -> str;
        required property ApplicationFullName -> str;
        required property ApplicationIdentifier -> str;
    }

    abstract type IfcBoundedCurve extending IfcCurve {
    }

    type IfcCartesianPoint extending IfcPoint {
        required property Coordinates -> tuple<float64, float64, float64>;
    }

    type IfcCartesianPointList3D extending IfcCartesianPointList {
        required property CoordList -> array<tuple<float64, float64, float64>>;
        property TagList -> array<str>;
    }

    type IfcDerivedUnit  {
        required multi link Elements -> IfcDerivedUnitElement;
        required property UnitType -> IfcDerivedUnitEnum;
        property UserDefinedType -> str;
    }

    type IfcPersonAndOrganization  {
        required link ThePerson -> IfcPerson;
        required link TheOrganization -> IfcOrganization;
        multi link Roles -> IfcActorRole;
    }

    type IfcProductDefinitionShape extending IfcProductRepresentation {
    }

    type IfcShapeRepresentation extending IfcShapeModel {
    }

    type IfcOwnerHistory  {
        required link OwningUser -> IfcPersonAndOrganization;
        required link OwningApplication -> IfcApplication;
        property State -> IfcStateEnum;
        property ChangeAction -> IfcChangeActionEnum;
        property LastModifiedDate -> int64;
        link LastModifyingUser -> IfcPersonAndOrganization;
        link LastModifyingApplication -> IfcApplication;
        required property CreationDate -> int64;
    }

    abstract type IfcPlacement extending IfcGeometricRepresentationItem {
        required link Location -> IfcCartesianPoint;
    }

    abstract type IfcTessellatedFaceSet extending IfcTessellatedItem {
        required link Coordinates -> IfcCartesianPointList3D;
    }

    type IfcAxis2Placement2D extending IfcPlacement {
        link RefDirection -> IfcDirection;
    }

    type IfcAxis2Placement3D extending IfcPlacement {
        link Axis -> IfcDirection;
        link RefDirection -> IfcDirection;
    }

    abstract type IfcRoot  {
        required property GlobalId -> str;
        link OwnerHistory -> IfcOwnerHistory;
        property Name -> str;
        property Description -> str;
    }

    type IfcTriangulatedFaceSet extending IfcTessellatedFaceSet {
        property Normals -> array<tuple<float64, float64, float64>>;
        property Closed -> bool;
        required property CoordIndex -> array<tuple<int64, int64, int64>>;
        property PnIndex -> array<int64>;
    }

    type IfcTrimmedCurve extending IfcBoundedCurve {
        required link BasisCurve -> IfcCurve;
        required multi link Trim1 -> IfcCartesianPoint | IfcParameterValue;
        required multi link Trim2 -> IfcCartesianPoint | IfcParameterValue;
        required property SenseAgreement -> bool;
        required property MasterRepresentation -> IfcTrimmingPreference;
    }

    type IfcUnitAssignment  {
        required multi link Units -> IfcDerivedUnit | IfcMonetaryUnit | IfcNamedUnit;
    }

    abstract type IfcObjectDefinition extending IfcRoot {
    }

    abstract type IfcRelationship extending IfcRoot {
    }

    abstract type IfcContext extending IfcObjectDefinition {
        property ObjectType -> str;
        property LongName -> str;
        property Phase -> str;
        multi link RepresentationContexts -> IfcRepresentationContext;
        link UnitsInContext -> IfcUnitAssignment;
    }

    type IfcGeometricRepresentationContext extending IfcRepresentationContext {
        required property CoordinateSpaceDimension -> int64;
        property Precision -> float64;
        required link WorldCoordinateSystem -> IfcAxis2Placement2D | IfcAxis2Placement3D;
        link TrueNorth -> IfcDirection;
    }

    abstract type IfcObject extending IfcObjectDefinition {
        property ObjectType -> str;
    }

    abstract type IfcRelConnects extending IfcRelationship {
    }

    type IfcGeometricRepresentationSubContext extending IfcGeometricRepresentationContext {
        required link ParentContext -> IfcGeometricRepresentationContext;
        property TargetScale -> float64;
        required property TargetView -> IfcGeometricProjectionEnum;
        property UserDefinedTargetView -> str;
    }

    abstract type IfcProduct extending IfcObject {
        link ObjectPlacement -> IfcObjectPlacement;
        link Representation -> IfcProductRepresentation;
    }

    type IfcProject extending IfcContext {
    }

    abstract type IfcElement extending IfcProduct {
        property Tag -> str;
    }

    abstract type IfcSpatialElement extending IfcProduct {
        property LongName -> str;
    }

    abstract type IfcBuildingElement extending IfcElement {
    }

    type IfcRelContainedInSpatialStructure extending IfcRelConnects {
        required multi link RelatedElements -> IfcProduct;
        required link RelatingStructure -> IfcSpatialElement;
    }

    abstract type IfcSpatialStructureElement extending IfcSpatialElement {
        property CompositionType -> IfcElementCompositionEnum;
    }

    type IfcBuilding extending IfcSpatialStructureElement {
        property ElevationOfRefHeight -> float64;
        property ElevationOfTerrain -> float64;
        link BuildingAddress -> IfcPostalAddress;
    }

    type IfcBuildingElementProxy extending IfcBuildingElement {
        property PredefinedType -> IfcBuildingElementProxyTypeEnum;
    }
}
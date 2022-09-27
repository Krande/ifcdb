CREATE MIGRATION m1nm6pttipmjy5zdjxgsz7mkhg3jghylsjgwuovpd6p236peghqfwa
    ONTO m1wcw7nwz6332236orfsbjfwtgfypjwmzhcq6ef3o7rfet73novixq
{
  CREATE ABSTRACT TYPE default::IfcCartesianPointList EXTENDING default::IfcGeometricRepresentationItem;
  CREATE TYPE default::IfcCartesianPointList2D EXTENDING default::IfcCartesianPointList {
      CREATE REQUIRED PROPERTY CoordList -> array<tuple<std::float64, std::float64>>;
      CREATE PROPERTY TagList -> tuple<std::str>;
  };
  CREATE TYPE default::IfcStructuralLoadConfiguration EXTENDING default::IfcStructuralLoad {
      CREATE PROPERTY Locations -> array<tuple<std::float64, std::float64>>;
      CREATE REQUIRED MULTI LINK Values -> default::IfcStructuralLoadOrResult;
  };
  CREATE TYPE default::IfcTextureVertexList EXTENDING default::IfcPresentationItem {
      CREATE REQUIRED PROPERTY TexCoordsList -> array<tuple<std::float64, std::float64>>;
  };
  CREATE TYPE default::IfcValue {
      CREATE LINK IfcValue -> (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((default::IfcBinary | default::IfcElectricCapacitanceMeasure) | default::IfcThermalAdmittanceMeasure) | default::IfcMassDensityMeasure) | default::IfcPlanarForceMeasure) | default::IfcThermodynamicTemperatureMeasure) | default::IfcElectricResistanceMeasure) | default::IfcThermalExpansionCoefficientMeasure) | default::IfcSpecificHeatCapacityMeasure) | default::IfcPositiveLengthMeasure) | default::IfcSoundPowerMeasure) | default::IfcPlaneAngleMeasure) | default::IfcModulusOfLinearSubgradeReactionMeasure) | default::IfcCompoundPlaneAngleMeasure) | default::IfcReal) | default::IfcInductanceMeasure) | default::IfcCurvatureMeasure) | default::IfcMoistureDiffusivityMeasure) | default::IfcThermalConductivityMeasure) | default::IfcEnergyMeasure) | default::IfcMassMeasure) | default::IfcVaporPermeabilityMeasure) | default::IfcThermalResistanceMeasure) | default::IfcMomentOfInertiaMeasure) | default::IfcElectricConductanceMeasure) | default::IfcComplexNumber) | default::IfcIsothermalMoistureCapacityMeasure) | default::IfcMassPerLengthMeasure) | default::IfcTimeStamp) | default::IfcPositiveRatioMeasure) | default::IfcModulusOfRotationalSubgradeReactionMeasure) | default::IfcBoolean) | default::IfcSectionalAreaIntegralMeasure) | default::IfcModulusOfElasticityMeasure) | default::IfcLinearStiffnessMeasure) | default::IfcMonetaryMeasure) | default::IfcDate) | default::IfcAreaMeasure) | default::IfcRotationalFrequencyMeasure) | default::IfcSoundPressureLevelMeasure) | default::IfcRotationalMassMeasure) | default::IfcPositiveInteger) | default::IfcThermalTransmittanceMeasure) | default::IfcIntegerCountRateMeasure) | default::IfcModulusOfSubgradeReactionMeasure) | default::IfcParameterValue) | default::IfcNumericMeasure) | default::IfcAreaDensityMeasure) | default::IfcAbsorbedDoseMeasure) | default::IfcIonConcentrationMeasure) | default::IfcContextDependentMeasure) | default::IfcElectricChargeMeasure) | default::IfcTemperatureGradientMeasure) | default::IfcNonNegativeLengthMeasure) | default::IfcLinearMomentMeasure) | default::IfcSoundPressureMeasure) | default::IfcPHMeasure) | default::IfcKinematicViscosityMeasure) | default::IfcLuminousIntensityDistributionMeasure) | default::IfcDoseEquivalentMeasure) | default::IfcVolumetricFlowRateMeasure) | default::IfcText) | default::IfcLuminousIntensityMeasure) | default::IfcLabel) | default::IfcForceMeasure) | default::IfcFrequencyMeasure) | default::IfcNormalisedRatioMeasure) | default::IfcTorqueMeasure) | default::IfcRatioMeasure) | default::IfcHeatingValueMeasure) | default::IfcPowerMeasure) | default::IfcAngularVelocityMeasure) | default::IfcTemperatureRateOfChangeMeasure) | default::IfcInteger) | default::IfcMolecularWeightMeasure) | default::IfcElectricVoltageMeasure) | default::IfcSectionModulusMeasure) | default::IfcVolumeMeasure) | default::IfcHeatFluxDensityMeasure) | default::IfcLogical) | default::IfcTime) | default::IfcSolidAngleMeasure) | default::IfcWarpingConstantMeasure) | default::IfcDuration) | default::IfcLinearVelocityMeasure) | default::IfcDynamicViscosityMeasure) | default::IfcRotationalStiffnessMeasure) | default::IfcPositivePlaneAngleMeasure) | default::IfcElectricCurrentMeasure) | default::IfcIlluminanceMeasure) | default::IfcAmountOfSubstanceMeasure) | default::IfcPressureMeasure) | default::IfcDateTime) | default::IfcWarpingMomentMeasure) | default::IfcAccelerationMeasure) | default::IfcMagneticFluxDensityMeasure) | default::IfcMassFlowRateMeasure) | default::IfcLengthMeasure) | default::IfcRadioActivityMeasure) | default::IfcLinearForceMeasure) | default::IfcShearModulusMeasure) | default::IfcMagneticFluxMeasure) | default::IfcLuminousFluxMeasure) | default::IfcIdentifier) | default::IfcSoundPowerLevelMeasure) | default::IfcCountMeasure) | default::IfcDescriptiveMeasure) | default::IfcTimeMeasure);
  };
  CREATE TYPE default::IfcSegmentIndexSelect {
      CREATE LINK IfcSegmentIndexSelect -> (default::IfcArcIndex | default::IfcLineIndex);
  };
  CREATE TYPE default::IfcTranslationalStiffnessSelect {
      CREATE LINK IfcTranslationalStiffnessSelect -> (default::IfcLinearStiffnessMeasure | default::IfcBoolean);
  };
  CREATE TYPE default::IfcWarpingStiffnessSelect {
      CREATE LINK IfcWarpingStiffnessSelect -> (default::IfcBoolean | default::IfcWarpingMomentMeasure);
  };
  CREATE TYPE default::IfcClassificationReferenceSelect {
      CREATE LINK IfcClassificationReferenceSelect -> (default::IfcClassification | default::IfcClassificationReference);
  };
  CREATE TYPE default::IfcClassificationSelect {
      CREATE LINK IfcClassificationSelect -> (default::IfcClassification | default::IfcClassificationReference);
  };
  CREATE TYPE default::IfcColourRgb EXTENDING default::IfcColourSpecification {
      CREATE REQUIRED PROPERTY Blue -> std::float64;
      CREATE REQUIRED PROPERTY Green -> std::float64;
      CREATE REQUIRED PROPERTY Red -> std::float64;
  };
  CREATE TYPE default::IfcColourOrFactor {
      CREATE LINK IfcColourOrFactor -> (default::IfcColourRgb | default::IfcNormalisedRatioMeasure);
  };
  CREATE ABSTRACT TYPE default::IfcPreDefinedColour EXTENDING default::IfcPreDefinedItem;
  CREATE TYPE default::IfcColour {
      CREATE LINK IfcColour -> (default::IfcColourSpecification | default::IfcPreDefinedColour);
  };
  CREATE ABSTRACT TYPE default::IfcCurve EXTENDING default::IfcGeometricRepresentationItem;
  CREATE ABSTRACT TYPE default::IfcPoint EXTENDING default::IfcGeometricRepresentationItem;
  CREATE ABSTRACT TYPE default::IfcSurface EXTENDING default::IfcGeometricRepresentationItem;
  CREATE TYPE default::IfcGeometricSetSelect {
      CREATE LINK IfcGeometricSetSelect -> ((default::IfcSurface | default::IfcCurve) | default::IfcPoint);
  };
  CREATE TYPE default::IfcCurveStyleFont EXTENDING default::IfcPresentationItem {
      CREATE PROPERTY Name -> std::str;
      CREATE REQUIRED MULTI LINK PatternList -> default::IfcCurveStyleFontPattern;
  };
  CREATE ABSTRACT TYPE default::IfcPreDefinedCurveFont EXTENDING default::IfcPreDefinedItem;
  CREATE TYPE default::IfcCurveStyleFontSelect {
      CREATE LINK IfcCurveStyleFontSelect -> (default::IfcPreDefinedCurveFont | default::IfcCurveStyleFont);
  };
  CREATE TYPE default::IfcTimeOrRatioSelect {
      CREATE LINK IfcTimeOrRatioSelect -> (default::IfcDuration | default::IfcRatioMeasure);
  };
  CREATE TYPE default::IfcLightDistributionDataSourceSelect {
      CREATE LINK IfcLightDistributionDataSourceSelect -> (default::IfcExternalReference | default::IfcLightIntensityDistribution);
  };
  CREATE TYPE default::IfcLayeredItem {
      CREATE LINK IfcLayeredItem -> (default::IfcRepresentationItem | default::IfcRepresentation);
  };
  CREATE ABSTRACT TYPE default::IfcAlignment2DSegment EXTENDING default::IfcGeometricRepresentationItem {
      CREATE PROPERTY EndTag -> std::str;
      CREATE PROPERTY StartTag -> std::str;
      CREATE PROPERTY TangentialContinuity -> std::bool;
  };
  CREATE ABSTRACT TYPE default::IfcAlignment2DVerticalSegment EXTENDING default::IfcAlignment2DSegment {
      CREATE REQUIRED PROPERTY HorizontalLength -> std::float64;
      CREATE REQUIRED PROPERTY StartDistAlong -> std::float64;
      CREATE REQUIRED PROPERTY StartGradient -> std::float64;
      CREATE REQUIRED PROPERTY StartHeight -> std::float64;
  };
  CREATE TYPE default::IfcAnnotationFillArea EXTENDING default::IfcGeometricRepresentationItem {
      CREATE MULTI LINK InnerBoundaries -> default::IfcCurve;
      CREATE REQUIRED LINK OuterBoundary -> default::IfcCurve;
  };
  CREATE TYPE default::IfcOrganization {
      CREATE MULTI LINK Addresses -> default::IfcAddress;
      CREATE MULTI LINK Roles -> default::IfcActorRole;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Identification -> std::str;
      CREATE REQUIRED PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcApplication {
      CREATE REQUIRED LINK ApplicationDeveloper -> default::IfcOrganization;
      CREATE REQUIRED PROPERTY ApplicationFullName -> std::str;
      CREATE REQUIRED PROPERTY ApplicationIdentifier -> std::str;
      CREATE REQUIRED PROPERTY Version -> std::str;
  };
  CREATE TYPE default::IfcArbitraryClosedProfileDef EXTENDING default::IfcProfileDef {
      CREATE REQUIRED LINK OuterCurve -> default::IfcCurve;
  };
  CREATE TYPE default::IfcBooleanResult EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED PROPERTY Operator -> std::str {
          CREATE CONSTRAINT std::one_of('DIFFERENCE', 'INTERSECTION', 'UNION');
      };
  };
  CREATE TYPE default::IfcBooleanClippingResult EXTENDING default::IfcBooleanResult;
  CREATE TYPE default::IfcBoundaryEdgeCondition EXTENDING default::IfcBoundaryCondition {
      CREATE LINK RotationalStiffnessByLengthX -> default::IfcModulusOfRotationalSubgradeReactionSelect;
      CREATE LINK RotationalStiffnessByLengthY -> default::IfcModulusOfRotationalSubgradeReactionSelect;
      CREATE LINK RotationalStiffnessByLengthZ -> default::IfcModulusOfRotationalSubgradeReactionSelect;
      CREATE LINK TranslationalStiffnessByLengthX -> default::IfcModulusOfTranslationalSubgradeReactionSelect;
      CREATE LINK TranslationalStiffnessByLengthY -> default::IfcModulusOfTranslationalSubgradeReactionSelect;
      CREATE LINK TranslationalStiffnessByLengthZ -> default::IfcModulusOfTranslationalSubgradeReactionSelect;
  };
  CREATE TYPE default::IfcBoundaryFaceCondition EXTENDING default::IfcBoundaryCondition {
      CREATE LINK TranslationalStiffnessByAreaX -> default::IfcModulusOfSubgradeReactionSelect;
      CREATE LINK TranslationalStiffnessByAreaY -> default::IfcModulusOfSubgradeReactionSelect;
      CREATE LINK TranslationalStiffnessByAreaZ -> default::IfcModulusOfSubgradeReactionSelect;
  };
  CREATE TYPE default::IfcBoundaryNodeCondition EXTENDING default::IfcBoundaryCondition {
      CREATE LINK RotationalStiffnessX -> default::IfcRotationalStiffnessSelect;
      CREATE LINK RotationalStiffnessY -> default::IfcRotationalStiffnessSelect;
      CREATE LINK RotationalStiffnessZ -> default::IfcRotationalStiffnessSelect;
      CREATE LINK TranslationalStiffnessX -> default::IfcTranslationalStiffnessSelect;
      CREATE LINK TranslationalStiffnessY -> default::IfcTranslationalStiffnessSelect;
      CREATE LINK TranslationalStiffnessZ -> default::IfcTranslationalStiffnessSelect;
  };
  CREATE TYPE default::IfcBoundaryNodeConditionWarping EXTENDING default::IfcBoundaryNodeCondition {
      CREATE LINK WarpingStiffness -> default::IfcWarpingStiffnessSelect;
  };
  CREATE ABSTRACT TYPE default::IfcBoundedCurve EXTENDING default::IfcCurve;
  CREATE ABSTRACT TYPE default::IfcBoundedSurface EXTENDING default::IfcSurface;
  CREATE TYPE default::IfcCartesianPoint EXTENDING default::IfcPoint {
      CREATE REQUIRED PROPERTY Coordinates -> array<std::float64> {
          CREATE CONSTRAINT std::expression ON ((((std::len(__subject__) = 1) OR (std::len(__subject__) = 2)) OR (std::len(__subject__) = 3)));
      };
  };
  CREATE TYPE default::IfcCartesianPointList3D EXTENDING default::IfcCartesianPointList {
      CREATE REQUIRED PROPERTY CoordList -> array<tuple<std::float64, std::float64, std::float64>>;
      CREATE PROPERTY TagList -> tuple<std::str>;
  };
  CREATE TYPE default::IfcMaterialClassificationRelationship {
      CREATE REQUIRED MULTI LINK MaterialClassifications -> default::IfcClassificationSelect;
      CREATE REQUIRED LINK ClassifiedMaterial -> default::IfcMaterial;
  };
  CREATE ABSTRACT TYPE default::IfcLightSource EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED LINK LightColour -> default::IfcColourRgb;
      CREATE PROPERTY AmbientIntensity -> std::float64;
      CREATE PROPERTY Intensity -> std::float64;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcComplexProperty EXTENDING default::IfcProperty {
      CREATE REQUIRED MULTI LINK HasProperties -> default::IfcProperty;
      CREATE REQUIRED PROPERTY UsageName -> std::str;
  };
  CREATE TYPE default::IfcCompositeCurveSegment EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED LINK ParentCurve -> default::IfcCurve;
      CREATE REQUIRED PROPERTY SameSense -> std::bool;
      CREATE REQUIRED PROPERTY Transition -> std::str {
          CREATE CONSTRAINT std::one_of('CONTINUOUS', 'CONTSAMEGRADIENT', 'CONTSAMEGRADIENTSAMECURVATURE', 'DISCONTINUOUS');
      };
  };
  CREATE TYPE default::IfcCompositeProfileDef EXTENDING default::IfcProfileDef {
      CREATE REQUIRED MULTI LINK Profiles -> default::IfcProfileDef;
      CREATE PROPERTY Label -> std::str;
  };
  CREATE TYPE default::IfcMaterialProfile EXTENDING default::IfcMaterialDefinition {
      CREATE LINK Material -> default::IfcMaterial;
      CREATE REQUIRED LINK Profile -> default::IfcProfileDef;
      CREATE PROPERTY Category -> std::str;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Name -> std::str;
      CREATE PROPERTY Priority -> std::int64;
  };
  CREATE TYPE default::IfcMaterialProfileSet EXTENDING default::IfcMaterialDefinition {
      CREATE LINK CompositeProfile -> default::IfcCompositeProfileDef;
      CREATE REQUIRED MULTI LINK MaterialProfiles -> default::IfcMaterialProfile;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcContextDependentUnit EXTENDING default::IfcNamedUnit {
      CREATE REQUIRED PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcGridAxis {
      CREATE REQUIRED LINK AxisCurve -> default::IfcCurve;
      CREATE PROPERTY AxisTag -> std::str;
      CREATE REQUIRED PROPERTY SameSense -> std::bool;
  };
  CREATE TYPE default::IfcDerivedUnitElement {
      CREATE REQUIRED LINK Unit -> default::IfcNamedUnit;
      CREATE REQUIRED PROPERTY Exponent -> std::int64;
  };
  CREATE TYPE default::IfcDerivedUnit {
      CREATE REQUIRED MULTI LINK Elements -> default::IfcDerivedUnitElement;
      CREATE REQUIRED PROPERTY UnitType -> std::str {
          CREATE CONSTRAINT std::one_of('ACCELERATIONUNIT', 'ANGULARVELOCITYUNIT', 'AREADENSITYUNIT', 'COMPOUNDPLANEANGLEUNIT', 'CURVATUREUNIT', 'DYNAMICVISCOSITYUNIT', 'HEATFLUXDENSITYUNIT', 'HEATINGVALUEUNIT', 'INTEGERCOUNTRATEUNIT', 'IONCONCENTRATIONUNIT', 'ISOTHERMALMOISTURECAPACITYUNIT', 'KINEMATICVISCOSITYUNIT', 'LINEARFORCEUNIT', 'LINEARMOMENTUNIT', 'LINEARSTIFFNESSUNIT', 'LINEARVELOCITYUNIT', 'LUMINOUSINTENSITYDISTRIBUTIONUNIT', 'MASSDENSITYUNIT', 'MASSFLOWRATEUNIT', 'MASSPERLENGTHUNIT', 'MODULUSOFELASTICITYUNIT', 'MODULUSOFLINEARSUBGRADEREACTIONUNIT', 'MODULUSOFROTATIONALSUBGRADEREACTIONUNIT', 'MODULUSOFSUBGRADEREACTIONUNIT', 'MOISTUREDIFFUSIVITYUNIT', 'MOLECULARWEIGHTUNIT', 'MOMENTOFINERTIAUNIT', 'PHUNIT', 'PLANARFORCEUNIT', 'ROTATIONALFREQUENCYUNIT', 'ROTATIONALMASSUNIT', 'ROTATIONALSTIFFNESSUNIT', 'SECTIONAREAINTEGRALUNIT', 'SECTIONMODULUSUNIT', 'SHEARMODULUSUNIT', 'SOUNDPOWERLEVELUNIT', 'SOUNDPOWERUNIT', 'SOUNDPRESSURELEVELUNIT', 'SOUNDPRESSUREUNIT', 'SPECIFICHEATCAPACITYUNIT', 'TEMPERATUREGRADIENTUNIT', 'TEMPERATURERATEOFCHANGEUNIT', 'THERMALADMITTANCEUNIT', 'THERMALCONDUCTANCEUNIT', 'THERMALEXPANSIONCOEFFICIENTUNIT', 'THERMALRESISTANCEUNIT', 'THERMALTRANSMITTANCEUNIT', 'TORQUEUNIT', 'USERDEFINED', 'VAPORPERMEABILITYUNIT', 'VOLUMETRICFLOWRATEUNIT', 'WARPINGCONSTANTUNIT', 'WARPINGMOMENTUNIT');
      };
      CREATE PROPERTY UserDefinedType -> std::str;
  };
  CREATE TYPE default::IfcDirection EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED PROPERTY DirectionRatios -> array<std::float64> {
          CREATE CONSTRAINT std::expression ON (((std::len(__subject__) = 2) OR (std::len(__subject__) = 3)));
      };
  };
  CREATE TYPE default::IfcDistanceExpression EXTENDING default::IfcGeometricRepresentationItem {
      CREATE PROPERTY AlongHorizontal -> std::bool;
      CREATE REQUIRED PROPERTY DistanceAlong -> std::float64;
      CREATE PROPERTY OffsetLateral -> std::float64;
      CREATE PROPERTY OffsetLongitudinal -> std::float64;
      CREATE PROPERTY OffsetVertical -> std::float64;
  };
  CREATE TYPE default::IfcDraughtingPreDefinedColour EXTENDING default::IfcPreDefinedColour;
  CREATE TYPE default::IfcDraughtingPreDefinedCurveFont EXTENDING default::IfcPreDefinedCurveFont;
  CREATE ABSTRACT TYPE default::IfcTopologicalRepresentationItem EXTENDING default::IfcRepresentationItem;
  CREATE TYPE default::IfcVertex EXTENDING default::IfcTopologicalRepresentationItem;
  CREATE TYPE default::IfcEdge EXTENDING default::IfcTopologicalRepresentationItem {
      CREATE LINK EdgeEnd -> default::IfcVertex;
      CREATE LINK EdgeStart -> default::IfcVertex;
  };
  CREATE TYPE default::IfcEventTime EXTENDING default::IfcSchedulingTime {
      CREATE PROPERTY ActualDate -> std::str;
      CREATE PROPERTY EarlyDate -> std::str;
      CREATE PROPERTY LateDate -> std::str;
      CREATE PROPERTY ScheduleDate -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcExtendedProperties EXTENDING default::IfcPropertyAbstraction {
      CREATE REQUIRED MULTI LINK Properties -> default::IfcProperty;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcMaterialProperties EXTENDING default::IfcExtendedProperties {
      CREATE REQUIRED LINK Material -> default::IfcMaterialDefinition;
  };
  CREATE TYPE default::IfcLoop EXTENDING default::IfcTopologicalRepresentationItem;
  CREATE TYPE default::IfcFaceBound EXTENDING default::IfcTopologicalRepresentationItem {
      CREATE REQUIRED LINK Bound -> default::IfcLoop;
      CREATE REQUIRED PROPERTY Orientation -> std::bool;
  };
  CREATE TYPE default::IfcHalfSpaceSolid EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED LINK BaseSurface -> default::IfcSurface;
      CREATE REQUIRED PROPERTY AgreementFlag -> std::bool;
  };
  CREATE ABSTRACT TYPE default::IfcTessellatedItem EXTENDING default::IfcGeometricRepresentationItem;
  CREATE TYPE default::IfcIndexedPolygonalFace EXTENDING default::IfcTessellatedItem {
      CREATE REQUIRED PROPERTY CoordIndex -> tuple<std::int64, std::int64, std::int64>;
  };
  CREATE TYPE default::IfcIrregularTimeSeriesValue {
      CREATE REQUIRED MULTI LINK ListValues -> default::IfcValue;
      CREATE REQUIRED PROPERTY TimeStamp -> std::str;
  };
  CREATE TYPE default::IfcLagTime EXTENDING default::IfcSchedulingTime {
      CREATE REQUIRED LINK LagValue -> default::IfcTimeOrRatioSelect;
      CREATE REQUIRED PROPERTY DurationType -> std::str {
          CREATE CONSTRAINT std::one_of('ELAPSEDTIME', 'NOTDEFINED', 'WORKTIME');
      };
  };
  CREATE TYPE default::IfcMaterialConstituent EXTENDING default::IfcMaterialDefinition {
      CREATE REQUIRED LINK Material -> default::IfcMaterial;
      CREATE PROPERTY Category -> std::str;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Fraction -> std::float64;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcMaterialConstituentSet EXTENDING default::IfcMaterialDefinition {
      CREATE MULTI LINK MaterialConstituents -> default::IfcMaterialConstituent;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcProductRepresentation {
      CREATE REQUIRED MULTI LINK Representations -> default::IfcRepresentation;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcMaterialDefinitionRepresentation EXTENDING default::IfcProductRepresentation {
      CREATE REQUIRED LINK RepresentedMaterial -> default::IfcMaterial;
  };
  CREATE TYPE default::IfcMaterialLayer EXTENDING default::IfcMaterialDefinition {
      CREATE LINK Material -> default::IfcMaterial;
      CREATE PROPERTY Category -> std::str;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY IsVentilated -> std::bool;
      CREATE REQUIRED PROPERTY LayerThickness -> std::float64;
      CREATE PROPERTY Name -> std::str;
      CREATE PROPERTY Priority -> std::int64;
  };
  CREATE TYPE default::IfcMaterialLayerWithOffsets EXTENDING default::IfcMaterialLayer {
      CREATE REQUIRED PROPERTY OffsetDirection -> std::str {
          CREATE CONSTRAINT std::one_of('AXIS1', 'AXIS2', 'AXIS3');
      };
      CREATE REQUIRED MULTI PROPERTY OffsetValues -> std::float64;
  };
  CREATE TYPE default::IfcMaterialLayerSet EXTENDING default::IfcMaterialDefinition {
      CREATE REQUIRED MULTI LINK MaterialLayers -> default::IfcMaterialLayer;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY LayerSetName -> std::str;
  };
  CREATE TYPE default::IfcMaterialList {
      CREATE REQUIRED MULTI LINK Materials -> default::IfcMaterial;
  };
  CREATE TYPE default::IfcMaterialProfileWithOffsets EXTENDING default::IfcMaterialProfile {
      CREATE REQUIRED MULTI PROPERTY OffsetValues -> std::float64;
  };
  CREATE TYPE default::IfcMaterialRelationship EXTENDING default::IfcResourceLevelRelationship {
      CREATE REQUIRED MULTI LINK RelatedMaterials -> default::IfcMaterial;
      CREATE REQUIRED LINK RelatingMaterial -> default::IfcMaterial;
      CREATE PROPERTY Expression -> std::str;
  };
  CREATE TYPE default::IfcPerson {
      CREATE MULTI LINK Addresses -> default::IfcAddress;
      CREATE MULTI LINK Roles -> default::IfcActorRole;
      CREATE PROPERTY FamilyName -> std::str;
      CREATE PROPERTY GivenName -> std::str;
      CREATE PROPERTY Identification -> std::str;
      CREATE PROPERTY MiddleNames -> tuple<std::str>;
      CREATE PROPERTY PrefixTitles -> tuple<std::str>;
      CREATE PROPERTY SuffixTitles -> tuple<std::str>;
  };
  CREATE ABSTRACT TYPE default::IfcPhysicalSimpleQuantity EXTENDING default::IfcPhysicalQuantity {
      CREATE LINK Unit -> default::IfcNamedUnit;
  };
  CREATE TYPE default::IfcPlanarExtent EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED PROPERTY SizeInX -> std::float64;
      CREATE REQUIRED PROPERTY SizeInY -> std::float64;
  };
  CREATE TYPE default::IfcPostalAddress EXTENDING default::IfcAddress {
      CREATE PROPERTY AddressLines -> tuple<std::str>;
      CREATE PROPERTY Country -> std::str;
      CREATE PROPERTY InternalLocation -> std::str;
      CREATE PROPERTY PostalBox -> std::str;
      CREATE PROPERTY PostalCode -> std::str;
      CREATE PROPERTY Region -> std::str;
      CREATE PROPERTY Town -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcPreDefinedTextFont EXTENDING default::IfcPreDefinedItem;
  CREATE TYPE default::IfcProjectedCRS EXTENDING default::IfcCoordinateReferenceSystem {
      CREATE LINK MapUnit -> default::IfcNamedUnit;
      CREATE PROPERTY MapProjection -> std::str;
      CREATE PROPERTY MapZone -> std::str;
  };
  CREATE TYPE default::IfcPropertyDependencyRelationship EXTENDING default::IfcResourceLevelRelationship {
      CREATE REQUIRED LINK DependantProperty -> default::IfcProperty;
      CREATE REQUIRED LINK DependingProperty -> default::IfcProperty;
      CREATE PROPERTY Expression -> std::str;
  };
  CREATE TYPE default::IfcReinforcementBarProperties EXTENDING default::IfcPreDefinedProperties {
      CREATE PROPERTY BarCount -> std::int64;
      CREATE PROPERTY BarSurface -> std::str {
          CREATE CONSTRAINT std::one_of('PLAIN', 'TEXTURED');
      };
      CREATE PROPERTY EffectiveDepth -> std::float64;
      CREATE PROPERTY NominalBarDiameter -> std::float64;
      CREATE REQUIRED PROPERTY SteelGrade -> std::str;
      CREATE REQUIRED PROPERTY TotalCrossSectionArea -> std::float64;
  };
  CREATE TYPE default::IfcResourceTime EXTENDING default::IfcSchedulingTime {
      CREATE PROPERTY ActualFinish -> std::str;
      CREATE PROPERTY ActualStart -> std::str;
      CREATE PROPERTY ActualUsage -> std::float64;
      CREATE PROPERTY ActualWork -> std::str;
      CREATE PROPERTY Completion -> std::float64;
      CREATE PROPERTY IsOverAllocated -> std::bool;
      CREATE PROPERTY LevelingDelay -> std::str;
      CREATE PROPERTY RemainingUsage -> std::float64;
      CREATE PROPERTY RemainingWork -> std::str;
      CREATE PROPERTY ScheduleContour -> std::str;
      CREATE PROPERTY ScheduleFinish -> std::str;
      CREATE PROPERTY ScheduleStart -> std::str;
      CREATE PROPERTY ScheduleUsage -> std::float64;
      CREATE PROPERTY ScheduleWork -> std::str;
      CREATE PROPERTY StatusTime -> std::str;
  };
  CREATE TYPE default::IfcSIUnit EXTENDING default::IfcNamedUnit {
      CREATE REQUIRED PROPERTY Name -> std::str {
          CREATE CONSTRAINT std::one_of('AMPERE', 'BECQUEREL', 'CANDELA', 'COULOMB', 'CUBIC_METRE', 'DEGREE_CELSIUS', 'FARAD', 'GRAM', 'GRAY', 'HENRY', 'HERTZ', 'JOULE', 'KELVIN', 'LUMEN', 'LUX', 'METRE', 'MOLE', 'NEWTON', 'OHM', 'PASCAL', 'RADIAN', 'SECOND', 'SIEMENS', 'SIEVERT', 'SQUARE_METRE', 'STERADIAN', 'TESLA', 'VOLT', 'WATT', 'WEBER');
      };
      CREATE PROPERTY Prefix -> std::str {
          CREATE CONSTRAINT std::one_of('ATTO', 'CENTI', 'DECA', 'DECI', 'EXA', 'FEMTO', 'GIGA', 'HECTO', 'KILO', 'MEGA', 'MICRO', 'MILLI', 'NANO', 'PETA', 'PICO', 'TERA');
      };
  };
  CREATE TYPE default::IfcSectionProperties EXTENDING default::IfcPreDefinedProperties {
      CREATE LINK EndProfile -> default::IfcProfileDef;
      CREATE REQUIRED LINK StartProfile -> default::IfcProfileDef;
      CREATE REQUIRED PROPERTY SectionType -> std::str {
          CREATE CONSTRAINT std::one_of('TAPERED', 'UNIFORM');
      };
  };
  CREATE ABSTRACT TYPE default::IfcShapeModel EXTENDING default::IfcRepresentation;
  CREATE ABSTRACT TYPE default::IfcSimpleProperty EXTENDING default::IfcProperty;
  CREATE ABSTRACT TYPE default::IfcSolidModel EXTENDING default::IfcGeometricRepresentationItem;
  CREATE ABSTRACT TYPE default::IfcStructuralLoadStatic EXTENDING default::IfcStructuralLoadOrResult;
  CREATE ABSTRACT TYPE default::IfcStyleModel EXTENDING default::IfcRepresentation;
  CREATE TYPE default::IfcSurfaceReinforcementArea EXTENDING default::IfcStructuralLoadOrResult {
      CREATE PROPERTY ShearReinforcement -> std::float64;
      CREATE PROPERTY SurfaceReinforcement1 -> array<std::float64> {
          CREATE CONSTRAINT std::expression ON (((std::len(__subject__) = 2) OR (std::len(__subject__) = 3)));
      };
      CREATE PROPERTY SurfaceReinforcement2 -> array<std::float64> {
          CREATE CONSTRAINT std::expression ON (((std::len(__subject__) = 2) OR (std::len(__subject__) = 3)));
      };
  };
  CREATE TYPE default::IfcTaskTime EXTENDING default::IfcSchedulingTime {
      CREATE PROPERTY ActualDuration -> std::str;
      CREATE PROPERTY ActualFinish -> std::str;
      CREATE PROPERTY ActualStart -> std::str;
      CREATE PROPERTY Completion -> std::float64;
      CREATE PROPERTY DurationType -> std::str {
          CREATE CONSTRAINT std::one_of('ELAPSEDTIME', 'NOTDEFINED', 'WORKTIME');
      };
      CREATE PROPERTY EarlyFinish -> std::str;
      CREATE PROPERTY EarlyStart -> std::str;
      CREATE PROPERTY FreeFloat -> std::str;
      CREATE PROPERTY IsCritical -> std::bool;
      CREATE PROPERTY LateFinish -> std::str;
      CREATE PROPERTY LateStart -> std::str;
      CREATE PROPERTY RemainingTime -> std::str;
      CREATE PROPERTY ScheduleDuration -> std::str;
      CREATE PROPERTY ScheduleFinish -> std::str;
      CREATE PROPERTY ScheduleStart -> std::str;
      CREATE PROPERTY StatusTime -> std::str;
      CREATE PROPERTY TotalFloat -> std::str;
  };
  CREATE TYPE default::IfcTelecomAddress EXTENDING default::IfcAddress {
      CREATE PROPERTY ElectronicMailAddresses -> tuple<std::str>;
      CREATE PROPERTY FacsimileNumbers -> tuple<std::str>;
      CREATE PROPERTY MessagingIDs -> tuple<std::str>;
      CREATE PROPERTY PagerNumber -> std::str;
      CREATE PROPERTY TelephoneNumbers -> tuple<std::str>;
      CREATE PROPERTY WWWHomePageURL -> std::str;
  };
  CREATE TYPE default::IfcTextStyleTextModel EXTENDING default::IfcPresentationItem {
      CREATE LINK LetterSpacing -> default::IfcSizeSelect;
      CREATE LINK LineHeight -> default::IfcSizeSelect;
      CREATE LINK TextIndent -> default::IfcSizeSelect;
      CREATE LINK WordSpacing -> default::IfcSizeSelect;
      CREATE PROPERTY TextAlign -> std::str;
      CREATE PROPERTY TextDecoration -> std::str;
      CREATE PROPERTY TextTransform -> std::str;
  };
  CREATE TYPE default::IfcTextureVertex EXTENDING default::IfcPresentationItem {
      CREATE REQUIRED PROPERTY Coordinates -> tuple<std::float64, std::float64>;
  };
  CREATE TYPE default::IfcWorkTime EXTENDING default::IfcSchedulingTime {
      CREATE LINK RecurrencePattern -> default::IfcRecurrencePattern;
      CREATE PROPERTY Finish -> std::str;
      CREATE PROPERTY `Start` -> std::str;
  };
};

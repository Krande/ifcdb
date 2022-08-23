CREATE MIGRATION m1xzibi2wr6oqfp64ffuxwg3ypyats7fl4ip4avmtnimsns5hozf6q
    ONTO m1arjh7cenaco4hci7zuwl5w3hjklaktxhbk77f2hrvqofnnsnndhq
{
  CREATE TYPE default::IfcMetricValueSelect {
      CREATE LINK IfcMetricValueSelect -> ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((default::IfcLinearStiffnessMeasure | default::IfcSectionModulusMeasure) | default::IfcRotationalFrequencyMeasure) | default::IfcHeatFluxDensityMeasure) | default::IfcIlluminanceMeasure) | default::IfcThermalTransmittanceMeasure) | default::IfcSectionalAreaIntegralMeasure) | default::IfcRotationalMassMeasure) | default::IfcElectricCurrentMeasure) | default::IfcSoundPowerLevelMeasure) | default::IfcIdentifier) | default::IfcParameterValue) | default::IfcVolumeMeasure) | default::IfcTimeMeasure) | default::IfcBinary) | default::IfcRatioMeasure) | default::IfcDynamicViscosityMeasure) | default::IfcDoseEquivalentMeasure) | default::IfcLinearMomentMeasure) | default::IfcLengthMeasure) | default::IfcPlanarForceMeasure) | default::IfcDateTime) | default::IfcTemperatureRateOfChangeMeasure) | default::IfcSoundPressureMeasure) | default::IfcInductanceMeasure) | default::IfcPositiveRatioMeasure) | default::IfcRadioActivityMeasure) | default::IfcMolecularWeightMeasure) | default::IfcElectricCapacitanceMeasure) | default::IfcAreaDensityMeasure) | default::IfcLabel) | default::IfcMassDensityMeasure) | default::IfcWarpingConstantMeasure) | default::IfcRotationalStiffnessMeasure) | default::IfcMassFlowRateMeasure) | default::IfcInteger) | default::IfcMoistureDiffusivityMeasure) | default::IfcLinearForceMeasure) | default::IfcTorqueMeasure) | default::IfcNormalisedRatioMeasure) | default::IfcNumericMeasure) | default::IfcMassMeasure) | default::IfcAreaMeasure) | default::IfcLuminousIntensityDistributionMeasure) | default::IfcThermodynamicTemperatureMeasure) | default::IfcThermalResistanceMeasure) | default::IfcMeasureWithUnit) | default::IfcKinematicViscosityMeasure) | default::IfcComplexNumber) | default::IfcPositivePlaneAngleMeasure) | default::IfcEnergyMeasure) | default::IfcLinearVelocityMeasure) | default::IfcLuminousFluxMeasure) | default::IfcText) | default::IfcTime) | default::IfcDescriptiveMeasure) | default::IfcPositiveInteger) | default::IfcPowerMeasure) | default::IfcModulusOfRotationalSubgradeReactionMeasure) | default::IfcCompoundPlaneAngleMeasure) | default::IfcTable) | default::IfcTimeSeries) | default::IfcElectricChargeMeasure) | default::IfcVolumetricFlowRateMeasure) | default::IfcHeatingValueMeasure) | default::IfcAppliedValue) | default::IfcPlaneAngleMeasure) | default::IfcPressureMeasure) | default::IfcContextDependentMeasure) | default::IfcFrequencyMeasure) | default::IfcSpecificHeatCapacityMeasure) | default::IfcTemperatureGradientMeasure) | default::IfcElectricConductanceMeasure) | default::IfcMomentOfInertiaMeasure) | default::IfcNonNegativeLengthMeasure) | default::IfcDate) | default::IfcLuminousIntensityMeasure) | default::IfcAbsorbedDoseMeasure) | default::IfcMonetaryMeasure) | default::IfcPositiveLengthMeasure) | default::IfcMagneticFluxMeasure) | default::IfcReference) | default::IfcIonConcentrationMeasure) | default::IfcLogical) | default::IfcDuration) | default::IfcWarpingMomentMeasure) | default::IfcBoolean) | default::IfcReal) | default::IfcMagneticFluxDensityMeasure) | default::IfcTimeStamp) | default::IfcThermalExpansionCoefficientMeasure) | default::IfcForceMeasure) | default::IfcModulusOfSubgradeReactionMeasure) | default::IfcSoundPressureLevelMeasure) | default::IfcModulusOfElasticityMeasure) | default::IfcMassPerLengthMeasure) | default::IfcShearModulusMeasure) | default::IfcThermalAdmittanceMeasure) | default::IfcModulusOfLinearSubgradeReactionMeasure) | default::IfcCountMeasure) | default::IfcIntegerCountRateMeasure) | default::IfcElectricVoltageMeasure) | default::IfcIsothermalMoistureCapacityMeasure) | default::IfcCurvatureMeasure) | default::IfcSolidAngleMeasure) | default::IfcElectricResistanceMeasure) | default::IfcSoundPowerMeasure) | default::IfcAmountOfSubstanceMeasure) | default::IfcAngularVelocityMeasure) | default::IfcVaporPermeabilityMeasure) | default::IfcPHMeasure) | default::IfcAccelerationMeasure) | default::IfcThermalConductivityMeasure);
  };
  CREATE TYPE default::IfcObjectReferenceSelect {
      CREATE LINK IfcObjectReferenceSelect -> ((((((((default::IfcExternalReference | default::IfcPersonAndOrganization) | default::IfcTable) | default::IfcTimeSeries) | default::IfcPerson) | default::IfcAppliedValue) | default::IfcOrganization) | default::IfcAddress) | default::IfcMaterialDefinition);
  };
  CREATE TYPE default::IfcShell {
      CREATE LINK IfcShell -> (default::IfcOpenShell | default::IfcClosedShell);
  };
  CREATE TYPE default::IfcSolidOrShell {
      CREATE LINK IfcSolidOrShell -> (default::IfcClosedShell | default::IfcSolidModel);
  };
  CREATE TYPE default::IfcFillStyleSelect {
      CREATE LINK IfcFillStyleSelect -> ((((default::IfcExternallyDefinedHatchStyle | default::IfcFillAreaStyleTiles) | default::IfcPreDefinedColour) | default::IfcFillAreaStyleHatching) | default::IfcColourSpecification);
  };
  CREATE TYPE default::IfcGeometricRepresentationContext EXTENDING default::IfcRepresentationContext {
      CREATE LINK TrueNorth -> default::IfcDirection;
      CREATE LINK WorldCoordinateSystem -> default::IfcAxis2Placement;
      CREATE PROPERTY CoordinateSpaceDimension -> std::int64;
      CREATE PROPERTY Precision -> std::float64;
  };
  CREATE TYPE default::IfcCoordinateReferenceSystemSelect {
      CREATE LINK IfcCoordinateReferenceSystemSelect -> (default::IfcGeometricRepresentationContext | default::IfcCoordinateReferenceSystem);
  };
  CREATE TYPE default::IfcSurfaceStyleWithTextures EXTENDING default::IfcPresentationItem {
      CREATE REQUIRED MULTI LINK Textures -> default::IfcSurfaceTexture;
  };
  CREATE TYPE default::IfcSurfaceStyleElementSelect {
      CREATE LINK IfcSurfaceStyleElementSelect -> ((((default::IfcSurfaceStyleShading | default::IfcExternallyDefinedSurfaceStyle) | default::IfcSurfaceStyleWithTextures) | default::IfcSurfaceStyleRefraction) | default::IfcSurfaceStyleLighting);
  };
  CREATE TYPE default::IfcSurfaceOrFaceSurface {
      CREATE LINK IfcSurfaceOrFaceSurface -> ((default::IfcFaceBasedSurfaceModel | default::IfcFaceSurface) | default::IfcSurface);
  };
  CREATE TYPE default::IfcLibrarySelect {
      CREATE LINK IfcLibrarySelect -> (default::IfcLibraryInformation | default::IfcLibraryReference);
  };
  CREATE TYPE default::IfcRepresentationMap {
      CREATE REQUIRED LINK MappedRepresentation -> default::IfcRepresentation;
      CREATE REQUIRED LINK MappingOrigin -> default::IfcAxis2Placement;
  };
  CREATE TYPE default::IfcProductRepresentationSelect {
      CREATE LINK IfcProductRepresentationSelect -> (default::IfcRepresentationMap | default::IfcProductDefinitionShape);
  };
  CREATE ABSTRACT TYPE default::IfcObject EXTENDING default::IfcObjectDefinition {
      CREATE PROPERTY ObjectType -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcControl EXTENDING default::IfcObject {
      CREATE PROPERTY Identification -> std::str;
  };
  CREATE TYPE default::IfcActionRequest EXTENDING default::IfcControl {
      CREATE PROPERTY LongDescription -> std::str;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('EMAIL', 'FAX', 'NOTDEFINED', 'PHONE', 'POST', 'USERDEFINED', 'VERBAL');
      };
      CREATE PROPERTY Status -> std::str;
  };
  CREATE TYPE default::IfcActor EXTENDING default::IfcObject {
      CREATE REQUIRED LINK TheActor -> default::IfcActorSelect;
  };
  CREATE ABSTRACT TYPE default::IfcManifoldSolidBrep EXTENDING default::IfcSolidModel {
      CREATE REQUIRED LINK Outer -> default::IfcClosedShell;
  };
  CREATE TYPE default::IfcAdvancedBrep EXTENDING default::IfcManifoldSolidBrep;
  CREATE TYPE default::IfcAdvancedBrepWithVoids EXTENDING default::IfcAdvancedBrep {
      CREATE REQUIRED MULTI LINK Voids -> default::IfcClosedShell;
  };
  CREATE ABSTRACT TYPE default::IfcProduct EXTENDING default::IfcObject {
      CREATE LINK ObjectPlacement -> default::IfcObjectPlacement;
      CREATE LINK Representation -> default::IfcProductRepresentation;
  };
  CREATE TYPE default::IfcAnnotation EXTENDING default::IfcProduct;
  CREATE TYPE default::IfcCostValue EXTENDING default::IfcAppliedValue;
  CREATE TYPE default::IfcGroup EXTENDING default::IfcObject;
  CREATE TYPE default::IfcAsset EXTENDING default::IfcGroup {
      CREATE LINK CurrentValue -> default::IfcCostValue;
      CREATE LINK DepreciatedValue -> default::IfcCostValue;
      CREATE LINK OriginalValue -> default::IfcCostValue;
      CREATE LINK Owner -> default::IfcActorSelect;
      CREATE LINK ResponsiblePerson -> default::IfcPerson;
      CREATE LINK TotalReplacementCost -> default::IfcCostValue;
      CREATE LINK User -> default::IfcActorSelect;
      CREATE PROPERTY Identification -> std::str;
      CREATE PROPERTY IncorporationDate -> std::str;
  };
  CREATE TYPE default::IfcCircle EXTENDING default::IfcConic {
      CREATE REQUIRED PROPERTY Radius -> std::float64;
  };
  CREATE TYPE default::IfcCircleHollowProfileDef EXTENDING default::IfcCircleProfileDef {
      CREATE REQUIRED PROPERTY WallThickness -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcPropertyTemplateDefinition EXTENDING default::IfcPropertyDefinition;
  CREATE ABSTRACT TYPE default::IfcPropertyTemplate EXTENDING default::IfcPropertyTemplateDefinition;
  CREATE TYPE default::IfcComplexPropertyTemplate EXTENDING default::IfcPropertyTemplate {
      CREATE MULTI LINK HasPropertyTemplates -> default::IfcPropertyTemplate;
      CREATE PROPERTY TemplateType -> std::str {
          CREATE CONSTRAINT std::one_of('P_COMPLEX', 'Q_COMPLEX');
      };
      CREATE PROPERTY UsageName -> std::str;
  };
  CREATE TYPE default::IfcConnectionSurfaceGeometry EXTENDING default::IfcConnectionGeometry {
      CREATE LINK SurfaceOnRelatedElement -> default::IfcSurfaceOrFaceSurface;
      CREATE REQUIRED LINK SurfaceOnRelatingElement -> default::IfcSurfaceOrFaceSurface;
  };
  CREATE TYPE default::IfcConnectionVolumeGeometry EXTENDING default::IfcConnectionGeometry {
      CREATE LINK VolumeOnRelatedElement -> default::IfcSolidOrShell;
      CREATE REQUIRED LINK VolumeOnRelatingElement -> default::IfcSolidOrShell;
  };
  CREATE ABSTRACT TYPE default::IfcResource EXTENDING default::IfcObject {
      CREATE PROPERTY Identification -> std::str;
      CREATE PROPERTY LongDescription -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcConstructionResource EXTENDING default::IfcResource {
      CREATE MULTI LINK BaseCosts -> default::IfcAppliedValue;
      CREATE LINK BaseQuantity -> default::IfcPhysicalQuantity;
      CREATE LINK Usage -> default::IfcResourceTime;
  };
  CREATE TYPE default::IfcCostItem EXTENDING default::IfcControl {
      CREATE MULTI LINK CostQuantities -> default::IfcPhysicalQuantity;
      CREATE MULTI LINK CostValues -> default::IfcCostValue;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCostSchedule EXTENDING default::IfcControl {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BUDGET', 'COSTPLAN', 'ESTIMATE', 'NOTDEFINED', 'PRICEDBILLOFQUANTITIES', 'SCHEDULEOFRATES', 'TENDER', 'UNPRICEDBILLOFQUANTITIES', 'USERDEFINED');
      };
      CREATE PROPERTY Status -> std::str;
      CREATE PROPERTY SubmittedOn -> std::str;
      CREATE PROPERTY UpdateDate -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcCoordinateOperation {
      CREATE REQUIRED LINK SourceCRS -> default::IfcCoordinateReferenceSystemSelect;
      CREATE REQUIRED LINK TargetCRS -> default::IfcCoordinateReferenceSystem;
  };
  CREATE TYPE default::IfcCsgSolid EXTENDING default::IfcSolidModel {
      CREATE REQUIRED LINK TreeRootExpression -> default::IfcCsgSelect;
  };
  CREATE TYPE default::IfcPlane EXTENDING default::IfcElementarySurface;
  CREATE TYPE default::IfcCurveBoundedPlane EXTENDING default::IfcBoundedSurface {
      CREATE REQUIRED LINK BasisSurface -> default::IfcPlane;
      CREATE REQUIRED MULTI LINK InnerBoundaries -> default::IfcCurve;
      CREATE REQUIRED LINK OuterBoundary -> default::IfcCurve;
  };
  CREATE ABSTRACT TYPE default::IfcElement EXTENDING default::IfcProduct {
      CREATE PROPERTY Tag -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcPropertySetDefinition EXTENDING default::IfcPropertyDefinition;
  CREATE ABSTRACT TYPE default::IfcQuantitySet EXTENDING default::IfcPropertySetDefinition;
  CREATE TYPE default::IfcElementQuantity EXTENDING default::IfcQuantitySet {
      CREATE REQUIRED MULTI LINK Quantities -> default::IfcPhysicalQuantity;
      CREATE PROPERTY MethodOfMeasurement -> std::str;
  };
  CREATE TYPE default::IfcEllipse EXTENDING default::IfcConic {
      CREATE REQUIRED PROPERTY SemiAxis1 -> std::float64;
      CREATE REQUIRED PROPERTY SemiAxis2 -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcProcess EXTENDING default::IfcObject {
      CREATE PROPERTY Identification -> std::str;
      CREATE PROPERTY LongDescription -> std::str;
  };
  CREATE TYPE default::IfcEvent EXTENDING default::IfcProcess {
      CREATE LINK EventOccurenceTime -> default::IfcEventTime;
      CREATE PROPERTY EventTriggerType -> std::str {
          CREATE CONSTRAINT std::one_of('EVENTCOMPLEX', 'EVENTMESSAGE', 'EVENTRULE', 'EVENTTIME', 'NOTDEFINED', 'USERDEFINED');
      };
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ENDEVENT', 'INTERMEDIATEEVENT', 'NOTDEFINED', 'STARTEVENT', 'USERDEFINED');
      };
      CREATE PROPERTY UserDefinedEventTriggerType -> std::str;
  };
  CREATE TYPE default::IfcExtrudedAreaSolidTapered EXTENDING default::IfcExtrudedAreaSolid {
      CREATE REQUIRED LINK EndSweptArea -> default::IfcProfileDef;
  };
  CREATE TYPE default::IfcFacetedBrep EXTENDING default::IfcManifoldSolidBrep;
  CREATE TYPE default::IfcGeometricRepresentationSubContext EXTENDING default::IfcGeometricRepresentationContext {
      CREATE REQUIRED LINK ParentContext -> default::IfcGeometricRepresentationContext;
      CREATE PROPERTY TargetScale -> std::float64;
      CREATE REQUIRED PROPERTY TargetView -> std::str {
          CREATE CONSTRAINT std::one_of('ELEVATION_VIEW', 'GRAPH_VIEW', 'MODEL_VIEW', 'NOTDEFINED', 'PLAN_VIEW', 'REFLECTED_PLAN_VIEW', 'SECTION_VIEW', 'SKETCH_VIEW', 'USERDEFINED');
      };
      CREATE PROPERTY UserDefinedTargetView -> std::str;
  };
  CREATE TYPE default::IfcIShapeProfileDef EXTENDING default::IfcParameterizedProfileDef {
      CREATE PROPERTY FilletRadius -> std::float64;
      CREATE PROPERTY FlangeEdgeRadius -> std::float64;
      CREATE PROPERTY FlangeSlope -> std::float64;
      CREATE REQUIRED PROPERTY FlangeThickness -> std::float64;
      CREATE REQUIRED PROPERTY OverallDepth -> std::float64;
      CREATE REQUIRED PROPERTY OverallWidth -> std::float64;
      CREATE REQUIRED PROPERTY WebThickness -> std::float64;
  };
  CREATE TYPE default::IfcImageTexture EXTENDING default::IfcSurfaceTexture {
      CREATE REQUIRED PROPERTY URLReference -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcTextureCoordinate EXTENDING default::IfcPresentationItem {
      CREATE REQUIRED MULTI LINK Maps -> default::IfcSurfaceTexture;
  };
  CREATE ABSTRACT TYPE default::IfcIndexedTextureMap EXTENDING default::IfcTextureCoordinate {
      CREATE REQUIRED LINK MappedTo -> default::IfcTessellatedFaceSet;
      CREATE REQUIRED LINK TexCoords -> default::IfcTextureVertexList;
  };
  CREATE TYPE default::IfcLShapeProfileDef EXTENDING default::IfcParameterizedProfileDef {
      CREATE REQUIRED PROPERTY Depth -> std::float64;
      CREATE PROPERTY EdgeRadius -> std::float64;
      CREATE PROPERTY FilletRadius -> std::float64;
      CREATE PROPERTY LegSlope -> std::float64;
      CREATE REQUIRED PROPERTY Thickness -> std::float64;
      CREATE PROPERTY Width -> std::float64;
  };
  CREATE TYPE default::IfcLocalPlacement EXTENDING default::IfcObjectPlacement {
      CREATE LINK PlacementRelTo -> default::IfcObjectPlacement;
      CREATE REQUIRED LINK RelativePlacement -> default::IfcAxis2Placement;
  };
  CREATE TYPE default::IfcMappedItem EXTENDING default::IfcRepresentationItem {
      CREATE REQUIRED LINK MappingSource -> default::IfcRepresentationMap;
      CREATE REQUIRED LINK MappingTarget -> default::IfcCartesianTransformationOperator;
  };
  CREATE TYPE default::IfcMirroredProfileDef EXTENDING default::IfcDerivedProfileDef;
  CREATE ABSTRACT TYPE default::IfcRelDefines EXTENDING default::IfcRelationship;
  CREATE TYPE default::IfcRelDefinesByObject EXTENDING default::IfcRelDefines {
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcObject;
      CREATE REQUIRED LINK RelatingObject -> default::IfcObject;
  };
  CREATE TYPE default::IfcOuterBoundaryCurve EXTENDING default::IfcBoundaryCurve;
  CREATE TYPE default::IfcPixelTexture EXTENDING default::IfcSurfaceTexture {
      CREATE REQUIRED PROPERTY ColourComponents -> std::int64;
      CREATE REQUIRED PROPERTY Height -> std::int64;
      CREATE REQUIRED PROPERTY Pixel -> tuple<std::bytes>;
      CREATE REQUIRED PROPERTY Width -> std::int64;
  };
  CREATE TYPE default::IfcPlanarBox EXTENDING default::IfcPlanarExtent {
      CREATE REQUIRED LINK Placement -> default::IfcAxis2Placement;
  };
  CREATE ABSTRACT TYPE default::IfcPreDefinedPropertySet EXTENDING default::IfcPropertySetDefinition;
  CREATE TYPE default::IfcProject EXTENDING default::IfcContext;
  CREATE TYPE default::IfcProjectLibrary EXTENDING default::IfcContext;
  CREATE TYPE default::IfcPropertySet EXTENDING default::IfcPropertySetDefinition {
      CREATE REQUIRED MULTI LINK HasProperties -> default::IfcProperty;
  };
  CREATE TYPE default::IfcTypeObject EXTENDING default::IfcObjectDefinition {
      CREATE MULTI LINK HasPropertySets -> default::IfcPropertySetDefinition;
      CREATE PROPERTY ApplicableOccurrence -> std::str;
  };
  CREATE TYPE default::IfcPropertySetDefinitionSet {
      CREATE REQUIRED MULTI LINK IfcPropertySetDefinitionSet -> default::IfcPropertySetDefinition;
  };
  CREATE TYPE default::IfcRationalBSplineSurfaceWithKnots EXTENDING default::IfcBSplineSurfaceWithKnots {
      CREATE REQUIRED PROPERTY WeightsData -> array<tuple<std::float64, std::float64>>;
  };
  CREATE TYPE default::IfcRectangleProfileDef EXTENDING default::IfcParameterizedProfileDef {
      CREATE REQUIRED PROPERTY XDim -> std::float64;
      CREATE REQUIRED PROPERTY YDim -> std::float64;
  };
  CREATE TYPE default::IfcRectangleHollowProfileDef EXTENDING default::IfcRectangleProfileDef {
      CREATE PROPERTY InnerFilletRadius -> std::float64;
      CREATE PROPERTY OuterFilletRadius -> std::float64;
      CREATE REQUIRED PROPERTY WallThickness -> std::float64;
  };
  CREATE TYPE default::IfcRoundedRectangleProfileDef EXTENDING default::IfcRectangleProfileDef {
      CREATE REQUIRED PROPERTY RoundingRadius -> std::float64;
  };
  CREATE TYPE default::IfcRectangularPyramid EXTENDING default::IfcCsgPrimitive3D {
      CREATE REQUIRED PROPERTY Height -> std::float64;
      CREATE REQUIRED PROPERTY XLength -> std::float64;
      CREATE REQUIRED PROPERTY YLength -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcRelDecomposes EXTENDING default::IfcRelationship;
  CREATE TYPE default::IfcRelAggregates EXTENDING default::IfcRelDecomposes {
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcObjectDefinition;
      CREATE REQUIRED LINK RelatingObject -> default::IfcObjectDefinition;
  };
  CREATE ABSTRACT TYPE default::IfcRelAssigns EXTENDING default::IfcRelationship {
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcObjectDefinition;
      CREATE PROPERTY RelatedObjectsType -> std::str {
          CREATE CONSTRAINT std::one_of('ACTOR', 'CONTROL', 'GROUP', 'NOTDEFINED', 'PROCESS', 'PRODUCT', 'PROJECT', 'RESOURCE');
      };
  };
  CREATE ABSTRACT TYPE default::IfcRelAssociates EXTENDING default::IfcRelationship {
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcDefinitionSelect;
  };
  CREATE ABSTRACT TYPE default::IfcRelConnects EXTENDING default::IfcRelationship;
  CREATE TYPE default::IfcRelDeclares EXTENDING default::IfcRelationship {
      CREATE REQUIRED MULTI LINK RelatedDefinitions -> default::IfcDefinitionSelect;
      CREATE REQUIRED LINK RelatingContext -> default::IfcContext;
  };
  CREATE TYPE default::IfcRelNests EXTENDING default::IfcRelDecomposes {
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcObjectDefinition;
      CREATE REQUIRED LINK RelatingObject -> default::IfcObjectDefinition;
  };
  CREATE TYPE default::IfcRevolvedAreaSolid EXTENDING default::IfcSweptAreaSolid {
      CREATE REQUIRED LINK Axis -> default::IfcAxis1Placement;
      CREATE REQUIRED PROPERTY Angle -> std::float64;
  };
  CREATE TYPE default::IfcRevolvedAreaSolidTapered EXTENDING default::IfcRevolvedAreaSolid {
      CREATE REQUIRED LINK EndSweptArea -> default::IfcProfileDef;
  };
  CREATE TYPE default::IfcRightCircularCone EXTENDING default::IfcCsgPrimitive3D {
      CREATE REQUIRED PROPERTY BottomRadius -> std::float64;
      CREATE REQUIRED PROPERTY Height -> std::float64;
  };
  CREATE TYPE default::IfcRightCircularCylinder EXTENDING default::IfcCsgPrimitive3D {
      CREATE REQUIRED PROPERTY Height -> std::float64;
      CREATE REQUIRED PROPERTY Radius -> std::float64;
  };
  CREATE TYPE default::IfcShellBasedSurfaceModel EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED MULTI LINK SbsmBoundary -> default::IfcShell;
  };
  CREATE TYPE default::IfcSphere EXTENDING default::IfcCsgPrimitive3D {
      CREATE REQUIRED PROPERTY Radius -> std::float64;
  };
  CREATE TYPE default::IfcSphericalSurface EXTENDING default::IfcElementarySurface {
      CREATE REQUIRED PROPERTY Radius -> std::float64;
  };
  CREATE TYPE default::IfcSurfaceCurveSweptAreaSolid EXTENDING default::IfcSweptAreaSolid {
      CREATE REQUIRED LINK Directrix -> default::IfcCurve;
      CREATE REQUIRED LINK ReferenceSurface -> default::IfcSurface;
      CREATE PROPERTY EndParam -> std::float64;
      CREATE PROPERTY StartParam -> std::float64;
  };
  CREATE TYPE default::IfcSurfaceOfLinearExtrusion EXTENDING default::IfcSweptSurface {
      CREATE REQUIRED LINK ExtrudedDirection -> default::IfcDirection;
      CREATE REQUIRED PROPERTY Depth -> std::float64;
  };
  CREATE TYPE default::IfcSurfaceOfRevolution EXTENDING default::IfcSweptSurface {
      CREATE REQUIRED LINK AxisPosition -> default::IfcAxis1Placement;
  };
  CREATE TYPE default::IfcTShapeProfileDef EXTENDING default::IfcParameterizedProfileDef {
      CREATE REQUIRED PROPERTY Depth -> std::float64;
      CREATE PROPERTY FilletRadius -> std::float64;
      CREATE PROPERTY FlangeEdgeRadius -> std::float64;
      CREATE PROPERTY FlangeSlope -> std::float64;
      CREATE REQUIRED PROPERTY FlangeThickness -> std::float64;
      CREATE REQUIRED PROPERTY FlangeWidth -> std::float64;
      CREATE PROPERTY WebEdgeRadius -> std::float64;
      CREATE PROPERTY WebSlope -> std::float64;
      CREATE REQUIRED PROPERTY WebThickness -> std::float64;
  };
  CREATE TYPE default::IfcTextLiteral EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED LINK Placement -> default::IfcAxis2Placement;
      CREATE REQUIRED PROPERTY Literal -> std::str;
      CREATE REQUIRED PROPERTY Path -> std::str {
          CREATE CONSTRAINT std::one_of('DOWN', 'LEFT', 'RIGHT', 'UP');
      };
  };
  CREATE TYPE default::IfcTextLiteralWithExtent EXTENDING default::IfcTextLiteral {
      CREATE REQUIRED LINK Extent -> default::IfcPlanarExtent;
      CREATE REQUIRED PROPERTY BoxAlignment -> std::str;
  };
  CREATE TYPE default::IfcTextureCoordinateGenerator EXTENDING default::IfcTextureCoordinate {
      CREATE REQUIRED PROPERTY Mode -> std::str;
      CREATE PROPERTY Parameter -> tuple<std::float64>;
  };
  CREATE TYPE default::IfcTextureMap EXTENDING default::IfcTextureCoordinate {
      CREATE REQUIRED LINK MappedTo -> default::IfcFace;
      CREATE REQUIRED MULTI LINK Vertices -> default::IfcTextureVertex;
  };
  CREATE TYPE default::IfcToroidalSurface EXTENDING default::IfcElementarySurface {
      CREATE REQUIRED PROPERTY MajorRadius -> std::float64;
      CREATE REQUIRED PROPERTY MinorRadius -> std::float64;
  };
  CREATE TYPE default::IfcTrapeziumProfileDef EXTENDING default::IfcParameterizedProfileDef {
      CREATE REQUIRED PROPERTY BottomXDim -> std::float64;
      CREATE REQUIRED PROPERTY TopXDim -> std::float64;
      CREATE REQUIRED PROPERTY TopXOffset -> std::float64;
      CREATE REQUIRED PROPERTY YDim -> std::float64;
  };
  CREATE TYPE default::IfcUShapeProfileDef EXTENDING default::IfcParameterizedProfileDef {
      CREATE REQUIRED PROPERTY Depth -> std::float64;
      CREATE PROPERTY EdgeRadius -> std::float64;
      CREATE PROPERTY FilletRadius -> std::float64;
      CREATE PROPERTY FlangeSlope -> std::float64;
      CREATE REQUIRED PROPERTY FlangeThickness -> std::float64;
      CREATE REQUIRED PROPERTY FlangeWidth -> std::float64;
      CREATE REQUIRED PROPERTY WebThickness -> std::float64;
  };
  CREATE TYPE default::IfcZShapeProfileDef EXTENDING default::IfcParameterizedProfileDef {
      CREATE REQUIRED PROPERTY Depth -> std::float64;
      CREATE PROPERTY EdgeRadius -> std::float64;
      CREATE PROPERTY FilletRadius -> std::float64;
      CREATE REQUIRED PROPERTY FlangeThickness -> std::float64;
      CREATE REQUIRED PROPERTY FlangeWidth -> std::float64;
      CREATE REQUIRED PROPERTY WebThickness -> std::float64;
  };
};

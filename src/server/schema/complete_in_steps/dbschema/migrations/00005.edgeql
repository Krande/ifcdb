CREATE MIGRATION m1arjh7cenaco4hci7zuwl5w3hjklaktxhbk77f2hrvqofnnsnndhq
    ONTO m12xyia6j36obprpjxfq2ujaxqs6qog5aizraqj4i4ycmlhjqrzleq
{
  CREATE TYPE default::IfcMeasureWithUnit {
      CREATE REQUIRED LINK UnitComponent -> default::IfcUnit;
      CREATE REQUIRED LINK ValueComponent -> default::IfcValue;
  };
  CREATE TYPE default::IfcAppliedValueSelect {
      CREATE LINK IfcAppliedValueSelect -> (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((default::IfcVaporPermeabilityMeasure | default::IfcMassMeasure) | default::IfcPressureMeasure) | default::IfcMonetaryMeasure) | default::IfcText) | default::IfcRadioActivityMeasure) | default::IfcInductanceMeasure) | default::IfcLinearVelocityMeasure) | default::IfcThermalExpansionCoefficientMeasure) | default::IfcMolecularWeightMeasure) | default::IfcTemperatureRateOfChangeMeasure) | default::IfcShearModulusMeasure) | default::IfcVolumetricFlowRateMeasure) | default::IfcPositivePlaneAngleMeasure) | default::IfcSectionalAreaIntegralMeasure) | default::IfcLinearMomentMeasure) | default::IfcForceMeasure) | default::IfcCountMeasure) | default::IfcThermalConductivityMeasure) | default::IfcPositiveRatioMeasure) | default::IfcLengthMeasure) | default::IfcLuminousIntensityMeasure) | default::IfcSoundPressureLevelMeasure) | default::IfcModulusOfSubgradeReactionMeasure) | default::IfcPositiveInteger) | default::IfcMagneticFluxDensityMeasure) | default::IfcWarpingMomentMeasure) | default::IfcDateTime) | default::IfcAmountOfSubstanceMeasure) | default::IfcPositiveLengthMeasure) | default::IfcWarpingConstantMeasure) | default::IfcFrequencyMeasure) | default::IfcLuminousFluxMeasure) | default::IfcModulusOfLinearSubgradeReactionMeasure) | default::IfcAngularVelocityMeasure) | default::IfcLogical) | default::IfcDynamicViscosityMeasure) | default::IfcIdentifier) | default::IfcParameterValue) | default::IfcEnergyMeasure) | default::IfcMassFlowRateMeasure) | default::IfcNormalisedRatioMeasure) | default::IfcDuration) | default::IfcRotationalMassMeasure) | default::IfcRotationalStiffnessMeasure) | default::IfcModulusOfRotationalSubgradeReactionMeasure) | default::IfcMeasureWithUnit) | default::IfcPowerMeasure) | default::IfcThermodynamicTemperatureMeasure) | default::IfcIsothermalMoistureCapacityMeasure) | default::IfcContextDependentMeasure) | default::IfcTorqueMeasure) | default::IfcSoundPowerMeasure) | default::IfcSoundPressureMeasure) | default::IfcMoistureDiffusivityMeasure) | default::IfcPlanarForceMeasure) | default::IfcThermalTransmittanceMeasure) | default::IfcReal) | default::IfcElectricResistanceMeasure) | default::IfcElectricVoltageMeasure) | default::IfcThermalAdmittanceMeasure) | default::IfcAreaMeasure) | default::IfcAreaDensityMeasure) | default::IfcDate) | default::IfcSpecificHeatCapacityMeasure) | default::IfcDoseEquivalentMeasure) | default::IfcIlluminanceMeasure) | default::IfcMassPerLengthMeasure) | default::IfcModulusOfElasticityMeasure) | default::IfcHeatFluxDensityMeasure) | default::IfcRotationalFrequencyMeasure) | default::IfcSectionModulusMeasure) | default::IfcNonNegativeLengthMeasure) | default::IfcLabel) | default::IfcLinearStiffnessMeasure) | default::IfcTime) | default::IfcMassDensityMeasure) | default::IfcVolumeMeasure) | default::IfcCompoundPlaneAngleMeasure) | default::IfcNumericMeasure) | default::IfcInteger) | default::IfcCurvatureMeasure) | default::IfcElectricCapacitanceMeasure) | default::IfcLinearForceMeasure) | default::IfcElectricChargeMeasure) | default::IfcIonConcentrationMeasure) | default::IfcBoolean) | default::IfcPHMeasure) | default::IfcIntegerCountRateMeasure) | default::IfcRatioMeasure) | default::IfcTimeMeasure) | default::IfcComplexNumber) | default::IfcReference) | default::IfcMagneticFluxMeasure) | default::IfcElectricCurrentMeasure) | default::IfcElectricConductanceMeasure) | default::IfcSoundPowerLevelMeasure) | default::IfcTemperatureGradientMeasure) | default::IfcBinary) | default::IfcHeatingValueMeasure) | default::IfcSolidAngleMeasure) | default::IfcThermalResistanceMeasure) | default::IfcLuminousIntensityDistributionMeasure) | default::IfcMomentOfInertiaMeasure) | default::IfcPlaneAngleMeasure) | default::IfcKinematicViscosityMeasure) | default::IfcAbsorbedDoseMeasure) | default::IfcDescriptiveMeasure) | default::IfcAccelerationMeasure) | default::IfcTimeStamp);
  };
  CREATE TYPE default::IfcAxis2Placement {
      CREATE LINK IfcAxis2Placement -> (default::IfcAxis2Placement2D | default::IfcAxis2Placement3D);
  };
  CREATE ABSTRACT TYPE default::IfcCsgPrimitive3D EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED LINK Position -> default::IfcAxis2Placement3D;
  };
  CREATE TYPE default::IfcBooleanOperand {
      CREATE LINK IfcBooleanOperand -> ((((default::IfcHalfSpaceSolid | default::IfcSolidModel) | default::IfcCsgPrimitive3D) | default::IfcTessellatedFaceSet) | default::IfcBooleanResult);
  };
  CREATE TYPE default::IfcCsgSelect {
      CREATE LINK IfcCsgSelect -> (default::IfcBooleanResult | default::IfcCsgPrimitive3D);
  };
  CREATE TYPE default::IfcCurveOrEdgeCurve {
      CREATE LINK IfcCurveOrEdgeCurve -> (default::IfcEdgeCurve | default::IfcBoundedCurve);
  };
  CREATE TYPE default::IfcCompositeCurveOnSurface EXTENDING default::IfcCompositeCurve;
  CREATE TYPE default::IfcCurveOnSurface {
      CREATE LINK IfcCurveOnSurface -> ((default::IfcSurfaceCurve | default::IfcCompositeCurveOnSurface) | default::IfcPcurve);
  };
  CREATE TYPE default::IfcCurveFontOrScaledCurveFontSelect {
      CREATE LINK IfcCurveFontOrScaledCurveFontSelect -> ((default::IfcCurveStyleFont | default::IfcPreDefinedCurveFont) | default::IfcCurveStyleFontAndScaling);
  };
  CREATE TYPE default::IfcGridPlacementDirectionSelect {
      CREATE LINK IfcGridPlacementDirectionSelect -> (default::IfcVirtualGridIntersection | default::IfcDirection);
  };
  CREATE TYPE default::IfcDocumentInformation EXTENDING default::IfcExternalInformation {
      CREATE PROPERTY Description -> std::str;
      CREATE REQUIRED PROPERTY Identification -> std::str;
      CREATE PROPERTY Location -> std::str;
      CREATE REQUIRED PROPERTY Name -> std::str;
      CREATE LINK DocumentOwner -> default::IfcActorSelect;
      CREATE MULTI LINK Editors -> default::IfcActorSelect;
      CREATE PROPERTY Confidentiality -> std::str {
          CREATE CONSTRAINT std::one_of('CONFIDENTIAL', 'NOTDEFINED', 'PERSONAL', 'PUBLIC', 'RESTRICTED', 'USERDEFINED');
      };
      CREATE PROPERTY CreationTime -> std::str;
      CREATE PROPERTY ElectronicFormat -> std::str;
      CREATE PROPERTY IntendedUse -> std::str;
      CREATE PROPERTY LastRevisionTime -> std::str;
      CREATE PROPERTY Purpose -> std::str;
      CREATE PROPERTY Revision -> std::str;
      CREATE PROPERTY Scope -> std::str;
      CREATE PROPERTY Status -> std::str {
          CREATE CONSTRAINT std::one_of('DRAFT', 'FINAL', 'FINALDRAFT', 'NOTDEFINED', 'REVISION');
      };
      CREATE PROPERTY ValidFrom -> std::str;
      CREATE PROPERTY ValidUntil -> std::str;
  };
  CREATE TYPE default::IfcDocumentReference EXTENDING default::IfcExternalReference {
      CREATE PROPERTY Description -> std::str;
      CREATE LINK ReferencedDocument -> default::IfcDocumentInformation;
  };
  CREATE TYPE default::IfcDocumentSelect {
      CREATE LINK IfcDocumentSelect -> (default::IfcDocumentInformation | default::IfcDocumentReference);
  };
  CREATE ABSTRACT TYPE default::IfcRoot {
      CREATE LINK OwnerHistory -> default::IfcOwnerHistory;
      CREATE PROPERTY Description -> std::str;
      CREATE REQUIRED PROPERTY GlobalId -> std::str;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcObjectDefinition EXTENDING default::IfcRoot;
  CREATE ABSTRACT TYPE default::IfcPropertyDefinition EXTENDING default::IfcRoot;
  CREATE TYPE default::IfcDefinitionSelect {
      CREATE LINK IfcDefinitionSelect -> (default::IfcObjectDefinition | default::IfcPropertyDefinition);
  };
  CREATE TYPE default::IfcFaceSurface EXTENDING default::IfcFace {
      CREATE REQUIRED LINK FaceSurface -> default::IfcSurface;
      CREATE REQUIRED PROPERTY SameSense -> std::bool;
  };
  CREATE TYPE default::IfcAdvancedFace EXTENDING default::IfcFaceSurface;
  CREATE TYPE default::IfcAlignment2DHorizontal EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED MULTI LINK Segments -> default::IfcAlignment2DHorizontalSegment;
      CREATE PROPERTY StartDistAlong -> std::float64;
  };
  CREATE TYPE default::IfcAlignmentCurve EXTENDING default::IfcBoundedCurve {
      CREATE REQUIRED LINK Horizontal -> default::IfcAlignment2DHorizontal;
      CREATE LINK Vertical -> default::IfcAlignment2DVertical;
      CREATE PROPERTY Tag -> std::str;
  };
  CREATE TYPE default::IfcAppliedValue {
      CREATE LINK AppliedValue -> default::IfcAppliedValueSelect;
      CREATE MULTI LINK Components -> default::IfcAppliedValue;
      CREATE LINK UnitBasis -> default::IfcMeasureWithUnit;
      CREATE PROPERTY ApplicableDate -> std::str;
      CREATE PROPERTY ArithmeticOperator -> std::str {
          CREATE CONSTRAINT std::one_of('ADD', 'DIVIDE', 'MULTIPLY', 'SUBTRACT');
      };
      CREATE PROPERTY Category -> std::str;
      CREATE PROPERTY Condition -> std::str;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY FixedUntilDate -> std::str;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcApprovalRelationship EXTENDING default::IfcResourceLevelRelationship {
      CREATE REQUIRED MULTI LINK RelatedApprovals -> default::IfcApproval;
      CREATE REQUIRED LINK RelatingApproval -> default::IfcApproval;
  };
  CREATE ABSTRACT TYPE default::IfcParameterizedProfileDef EXTENDING default::IfcProfileDef {
      CREATE LINK Position -> default::IfcAxis2Placement2D;
  };
  CREATE TYPE default::IfcAsymmetricIShapeProfileDef EXTENDING default::IfcParameterizedProfileDef {
      CREATE PROPERTY BottomFlangeEdgeRadius -> std::float64;
      CREATE PROPERTY BottomFlangeFilletRadius -> std::float64;
      CREATE PROPERTY BottomFlangeSlope -> std::float64;
      CREATE REQUIRED PROPERTY BottomFlangeThickness -> std::float64;
      CREATE REQUIRED PROPERTY BottomFlangeWidth -> std::float64;
      CREATE REQUIRED PROPERTY OverallDepth -> std::float64;
      CREATE PROPERTY TopFlangeEdgeRadius -> std::float64;
      CREATE PROPERTY TopFlangeFilletRadius -> std::float64;
      CREATE PROPERTY TopFlangeSlope -> std::float64;
      CREATE PROPERTY TopFlangeThickness -> std::float64;
      CREATE REQUIRED PROPERTY TopFlangeWidth -> std::float64;
      CREATE REQUIRED PROPERTY WebThickness -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcConic EXTENDING default::IfcCurve {
      CREATE REQUIRED LINK Position -> default::IfcAxis2Placement;
  };
  CREATE TYPE default::IfcBSplineSurfaceWithKnots EXTENDING default::IfcBSplineSurface {
      CREATE REQUIRED PROPERTY KnotSpec -> std::str {
          CREATE CONSTRAINT std::one_of('PIECEWISE_BEZIER_KNOTS', 'QUASI_UNIFORM_KNOTS', 'UNIFORM_KNOTS', 'UNSPECIFIED');
      };
      CREATE REQUIRED PROPERTY UKnots -> tuple<std::float64, std::float64>;
      CREATE REQUIRED PROPERTY UMultiplicities -> tuple<std::int64, std::int64>;
      CREATE REQUIRED PROPERTY VKnots -> tuple<std::float64, std::float64>;
      CREATE REQUIRED PROPERTY VMultiplicities -> tuple<std::int64, std::int64>;
  };
  CREATE ABSTRACT TYPE default::IfcSurfaceTexture EXTENDING default::IfcPresentationItem {
      CREATE LINK TextureTransform -> default::IfcCartesianTransformationOperator2D;
      CREATE PROPERTY Mode -> std::str;
      CREATE PROPERTY Parameter -> tuple<std::str>;
      CREATE REQUIRED PROPERTY RepeatS -> std::bool;
      CREATE REQUIRED PROPERTY RepeatT -> std::bool;
  };
  CREATE TYPE default::IfcBlobTexture EXTENDING default::IfcSurfaceTexture {
      CREATE REQUIRED PROPERTY RasterCode -> std::bytes;
      CREATE REQUIRED PROPERTY RasterFormat -> std::str;
  };
  CREATE TYPE default::IfcBlock EXTENDING default::IfcCsgPrimitive3D {
      CREATE REQUIRED PROPERTY XLength -> std::float64;
      CREATE REQUIRED PROPERTY YLength -> std::float64;
      CREATE REQUIRED PROPERTY ZLength -> std::float64;
  };
  CREATE TYPE default::IfcBoundaryCurve EXTENDING default::IfcCompositeCurveOnSurface;
  CREATE TYPE default::IfcCurveBoundedSurface EXTENDING default::IfcBoundedSurface {
      CREATE REQUIRED MULTI LINK Boundaries -> default::IfcBoundaryCurve;
      CREATE REQUIRED LINK BasisSurface -> default::IfcSurface;
      CREATE REQUIRED PROPERTY ImplicitOuter -> std::bool;
  };
  CREATE TYPE default::IfcCShapeProfileDef EXTENDING default::IfcParameterizedProfileDef {
      CREATE REQUIRED PROPERTY Depth -> std::float64;
      CREATE REQUIRED PROPERTY Girth -> std::float64;
      CREATE PROPERTY InternalFilletRadius -> std::float64;
      CREATE REQUIRED PROPERTY WallThickness -> std::float64;
      CREATE REQUIRED PROPERTY Width -> std::float64;
  };
  CREATE TYPE default::IfcCartesianTransformationOperator2DnonUniform EXTENDING default::IfcCartesianTransformationOperator2D {
      CREATE PROPERTY Scale2 -> std::float64;
  };
  CREATE TYPE default::IfcCartesianTransformationOperator3D EXTENDING default::IfcCartesianTransformationOperator {
      CREATE LINK Axis3 -> default::IfcDirection;
  };
  CREATE TYPE default::IfcCartesianTransformationOperator3DnonUniform EXTENDING default::IfcCartesianTransformationOperator3D {
      CREATE PROPERTY Scale2 -> std::float64;
      CREATE PROPERTY Scale3 -> std::float64;
  };
  CREATE TYPE default::IfcCenterLineProfileDef EXTENDING default::IfcArbitraryOpenProfileDef {
      CREATE REQUIRED PROPERTY Thickness -> std::float64;
  };
  CREATE TYPE default::IfcCircleProfileDef EXTENDING default::IfcParameterizedProfileDef {
      CREATE REQUIRED PROPERTY Radius -> std::float64;
  };
  CREATE TYPE default::IfcCircularArcSegment2D EXTENDING default::IfcCurveSegment2D {
      CREATE REQUIRED PROPERTY IsCCW -> std::bool;
      CREATE REQUIRED PROPERTY Radius -> std::float64;
  };
  CREATE TYPE default::IfcConnectedFaceSet EXTENDING default::IfcTopologicalRepresentationItem {
      CREATE REQUIRED MULTI LINK CfsFaces -> default::IfcFace;
  };
  CREATE TYPE default::IfcClosedShell EXTENDING default::IfcConnectedFaceSet;
  CREATE TYPE default::IfcOpenShell EXTENDING default::IfcConnectedFaceSet;
  CREATE TYPE default::IfcFaceBasedSurfaceModel EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED MULTI LINK FbsmFaces -> default::IfcConnectedFaceSet;
  };
  CREATE TYPE default::IfcConnectionCurveGeometry EXTENDING default::IfcConnectionGeometry {
      CREATE LINK CurveOnRelatedElement -> default::IfcCurveOrEdgeCurve;
      CREATE REQUIRED LINK CurveOnRelatingElement -> default::IfcCurveOrEdgeCurve;
  };
  CREATE TYPE default::IfcConnectionPointGeometry EXTENDING default::IfcConnectionGeometry {
      CREATE LINK PointOnRelatedElement -> default::IfcPointOrVertexPoint;
      CREATE REQUIRED LINK PointOnRelatingElement -> default::IfcPointOrVertexPoint;
  };
  CREATE TYPE default::IfcConnectionPointEccentricity EXTENDING default::IfcConnectionPointGeometry {
      CREATE PROPERTY EccentricityInX -> std::float64;
      CREATE PROPERTY EccentricityInY -> std::float64;
      CREATE PROPERTY EccentricityInZ -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcConstraint {
      CREATE LINK CreatingActor -> default::IfcActorSelect;
      CREATE REQUIRED PROPERTY ConstraintGrade -> std::str {
          CREATE CONSTRAINT std::one_of('ADVISORY', 'HARD', 'NOTDEFINED', 'SOFT', 'USERDEFINED');
      };
      CREATE PROPERTY ConstraintSource -> std::str;
      CREATE PROPERTY CreationTime -> std::str;
      CREATE PROPERTY Description -> std::str;
      CREATE REQUIRED PROPERTY Name -> std::str;
      CREATE PROPERTY UserDefinedGrade -> std::str;
  };
  CREATE TYPE default::IfcObjective EXTENDING default::IfcConstraint {
      CREATE MULTI LINK BenchmarkValues -> default::IfcConstraint;
      CREATE PROPERTY LogicalAggregator -> std::str {
          CREATE CONSTRAINT std::one_of('LOGICALAND', 'LOGICALNOTAND', 'LOGICALNOTOR', 'LOGICALOR', 'LOGICALXOR');
      };
      CREATE REQUIRED PROPERTY ObjectiveQualifier -> std::str {
          CREATE CONSTRAINT std::one_of('CODECOMPLIANCE', 'CODEWAIVER', 'DESIGNINTENT', 'EXTERNAL', 'HEALTHANDSAFETY', 'MERGECONFLICT', 'MODELVIEW', 'NOTDEFINED', 'PARAMETER', 'REQUIREMENT', 'SPECIFICATION', 'TRIGGERCONDITION', 'USERDEFINED');
      };
      CREATE PROPERTY UserDefinedQualifier -> std::str;
  };
  CREATE TYPE default::IfcUnitAssignment {
      CREATE REQUIRED MULTI LINK Units -> default::IfcUnit;
  };
  CREATE ABSTRACT TYPE default::IfcContext EXTENDING default::IfcObjectDefinition {
      CREATE MULTI LINK RepresentationContexts -> default::IfcRepresentationContext;
      CREATE LINK UnitsInContext -> default::IfcUnitAssignment;
      CREATE PROPERTY LongName -> std::str;
      CREATE PROPERTY ObjectType -> std::str;
      CREATE PROPERTY Phase -> std::str;
  };
  CREATE TYPE default::IfcConversionBasedUnit EXTENDING default::IfcNamedUnit {
      CREATE REQUIRED LINK ConversionFactor -> default::IfcMeasureWithUnit;
      CREATE REQUIRED PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcConversionBasedUnitWithOffset EXTENDING default::IfcConversionBasedUnit {
      CREATE REQUIRED PROPERTY ConversionOffset -> std::float64;
  };
  CREATE TYPE default::IfcLibraryInformation EXTENDING default::IfcExternalInformation {
      CREATE LINK Publisher -> default::IfcActorSelect;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Location -> std::str;
      CREATE REQUIRED PROPERTY Name -> std::str;
      CREATE PROPERTY Version -> std::str;
      CREATE PROPERTY VersionDate -> std::str;
  };
  CREATE TYPE default::IfcCurrencyRelationship EXTENDING default::IfcResourceLevelRelationship {
      CREATE LINK RateSource -> default::IfcLibraryInformation;
      CREATE REQUIRED LINK RelatedMonetaryUnit -> default::IfcMonetaryUnit;
      CREATE REQUIRED LINK RelatingMonetaryUnit -> default::IfcMonetaryUnit;
      CREATE REQUIRED PROPERTY ExchangeRate -> std::float64;
      CREATE PROPERTY RateDateTime -> std::str;
  };
  CREATE TYPE default::IfcCurveStyle EXTENDING default::IfcPresentationStyle {
      CREATE LINK CurveFont -> default::IfcCurveFontOrScaledCurveFontSelect;
      CREATE LINK CurveColour -> default::IfcColour;
      CREATE LINK CurveWidth -> default::IfcSizeSelect;
      CREATE PROPERTY ModelOrDraughting -> std::bool;
  };
  CREATE TYPE default::IfcFillAreaStyleHatching EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED LINK HatchLineAppearance -> default::IfcCurveStyle;
      CREATE LINK PatternStart -> default::IfcCartesianPoint;
      CREATE LINK PointOfReferenceHatchLine -> default::IfcCartesianPoint;
      CREATE REQUIRED LINK StartOfNextHatchLine -> default::IfcHatchLineDistanceSelect;
      CREATE REQUIRED PROPERTY HatchLineAngle -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcElementarySurface EXTENDING default::IfcSurface {
      CREATE REQUIRED LINK Position -> default::IfcAxis2Placement3D;
  };
  CREATE TYPE default::IfcCylindricalSurface EXTENDING default::IfcElementarySurface {
      CREATE REQUIRED PROPERTY Radius -> std::float64;
  };
  CREATE TYPE default::IfcDerivedProfileDef EXTENDING default::IfcProfileDef {
      CREATE LINK Operator -> default::IfcCartesianTransformationOperator2D;
      CREATE REQUIRED LINK ParentProfile -> default::IfcProfileDef;
      CREATE PROPERTY Label -> std::str;
  };
  CREATE TYPE default::IfcDocumentInformationRelationship EXTENDING default::IfcResourceLevelRelationship {
      CREATE REQUIRED MULTI LINK RelatedDocuments -> default::IfcDocumentInformation;
      CREATE REQUIRED LINK RelatingDocument -> default::IfcDocumentInformation;
      CREATE PROPERTY RelationshipType -> std::str;
  };
  CREATE TYPE default::IfcEdgeLoop EXTENDING default::IfcLoop {
      CREATE REQUIRED MULTI LINK EdgeList -> default::IfcOrientedEdge;
  };
  CREATE TYPE default::IfcEllipseProfileDef EXTENDING default::IfcParameterizedProfileDef {
      CREATE REQUIRED PROPERTY SemiAxis1 -> std::float64;
      CREATE REQUIRED PROPERTY SemiAxis2 -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcSweptAreaSolid EXTENDING default::IfcSolidModel {
      CREATE LINK Position -> default::IfcAxis2Placement3D;
      CREATE REQUIRED LINK SweptArea -> default::IfcProfileDef;
  };
  CREATE TYPE default::IfcExtrudedAreaSolid EXTENDING default::IfcSweptAreaSolid {
      CREATE REQUIRED LINK ExtrudedDirection -> default::IfcDirection;
      CREATE REQUIRED PROPERTY Depth -> std::float64;
  };
  CREATE TYPE default::IfcFixedReferenceSweptAreaSolid EXTENDING default::IfcSweptAreaSolid {
      CREATE REQUIRED LINK Directrix -> default::IfcCurve;
      CREATE REQUIRED LINK FixedReference -> default::IfcDirection;
      CREATE PROPERTY EndParam -> std::float64;
      CREATE PROPERTY StartParam -> std::float64;
  };
  CREATE TYPE default::IfcGeometricCurveSet EXTENDING default::IfcGeometricSet;
  CREATE TYPE default::IfcGridPlacement EXTENDING default::IfcObjectPlacement {
      CREATE REQUIRED LINK PlacementLocation -> default::IfcVirtualGridIntersection;
      CREATE LINK PlacementRefDirection -> default::IfcGridPlacementDirectionSelect;
  };
  CREATE TYPE default::IfcIndexedColourMap EXTENDING default::IfcPresentationItem {
      CREATE REQUIRED LINK Colours -> default::IfcColourRgbList;
      CREATE REQUIRED LINK MappedTo -> default::IfcTessellatedFaceSet;
      CREATE REQUIRED PROPERTY ColourIndex -> tuple<std::int64>;
      CREATE PROPERTY Opacity -> std::float64;
  };
  CREATE TYPE default::IfcIntersectionCurve EXTENDING default::IfcSurfaceCurve;
  CREATE ABSTRACT TYPE default::IfcTimeSeries {
      CREATE LINK Unit -> default::IfcUnit;
      CREATE REQUIRED PROPERTY DataOrigin -> std::str {
          CREATE CONSTRAINT std::one_of('MEASURED', 'NOTDEFINED', 'PREDICTED', 'SIMULATED', 'USERDEFINED');
      };
      CREATE PROPERTY Description -> std::str;
      CREATE REQUIRED PROPERTY EndTime -> std::str;
      CREATE REQUIRED PROPERTY Name -> std::str;
      CREATE REQUIRED PROPERTY StartTime -> std::str;
      CREATE REQUIRED PROPERTY TimeSeriesDataType -> std::str {
          CREATE CONSTRAINT std::one_of('CONTINUOUS', 'DISCRETE', 'DISCRETEBINARY', 'NOTDEFINED', 'PIECEWISEBINARY', 'PIECEWISECONSTANT', 'PIECEWISECONTINUOUS');
      };
      CREATE PROPERTY UserDefinedDataOrigin -> std::str;
  };
  CREATE TYPE default::IfcIrregularTimeSeries EXTENDING default::IfcTimeSeries {
      CREATE REQUIRED MULTI LINK Values -> default::IfcIrregularTimeSeriesValue;
  };
  CREATE TYPE default::IfcLibraryReference EXTENDING default::IfcExternalReference {
      CREATE LINK ReferencedLibrary -> default::IfcLibraryInformation;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Language -> std::str;
  };
  CREATE TYPE default::IfcLightSourceGoniometric EXTENDING default::IfcLightSource {
      CREATE LINK ColourAppearance -> default::IfcColourRgb;
      CREATE REQUIRED LINK LightDistributionDataSource -> default::IfcLightDistributionDataSourceSelect;
      CREATE REQUIRED LINK Position -> default::IfcAxis2Placement3D;
      CREATE REQUIRED PROPERTY ColourTemperature -> std::float64;
      CREATE REQUIRED PROPERTY LightEmissionSource -> std::str {
          CREATE CONSTRAINT std::one_of('COMPACTFLUORESCENT', 'FLUORESCENT', 'HIGHPRESSUREMERCURY', 'HIGHPRESSURESODIUM', 'LIGHTEMITTINGDIODE', 'LOWPRESSURESODIUM', 'LOWVOLTAGEHALOGEN', 'MAINVOLTAGEHALOGEN', 'METALHALIDE', 'NOTDEFINED', 'TUNGSTENFILAMENT');
      };
      CREATE REQUIRED PROPERTY LuminousFlux -> std::float64;
  };
  CREATE TYPE default::IfcLightSourceSpot EXTENDING default::IfcLightSourcePositional {
      CREATE REQUIRED LINK Orientation -> default::IfcDirection;
      CREATE REQUIRED PROPERTY BeamWidthAngle -> std::float64;
      CREATE PROPERTY ConcentrationExponent -> std::float64;
      CREATE REQUIRED PROPERTY SpreadAngle -> std::float64;
  };
  CREATE TYPE default::IfcLineSegment2D EXTENDING default::IfcCurveSegment2D;
  CREATE TYPE default::IfcLinearPlacement EXTENDING default::IfcObjectPlacement {
      CREATE LINK CartesianPosition -> default::IfcAxis2Placement3D;
      CREATE REQUIRED LINK Distance -> default::IfcDistanceExpression;
      CREATE LINK Orientation -> default::IfcOrientationExpression;
      CREATE REQUIRED LINK PlacementRelTo -> default::IfcCurve;
  };
  CREATE TYPE default::IfcMaterialProfileSetUsageTapering EXTENDING default::IfcMaterialProfileSetUsage {
      CREATE REQUIRED LINK ForProfileEndSet -> default::IfcMaterialProfileSet;
      CREATE PROPERTY CardinalEndPoint -> std::int64;
  };
  CREATE TYPE default::IfcPath EXTENDING default::IfcTopologicalRepresentationItem {
      CREATE REQUIRED MULTI LINK EdgeList -> default::IfcOrientedEdge;
  };
  CREATE TYPE default::IfcPolygonalBoundedHalfSpace EXTENDING default::IfcHalfSpaceSolid {
      CREATE REQUIRED LINK PolygonalBoundary -> default::IfcBoundedCurve;
      CREATE REQUIRED LINK Position -> default::IfcAxis2Placement3D;
  };
  CREATE TYPE default::IfcPolygonalFaceSet EXTENDING default::IfcTessellatedFaceSet {
      CREATE REQUIRED MULTI LINK Faces -> default::IfcIndexedPolygonalFace;
      CREATE PROPERTY Closed -> std::bool;
      CREATE PROPERTY PnIndex -> tuple<std::int64>;
  };
  CREATE TYPE default::IfcPropertyBoundedValue EXTENDING default::IfcSimpleProperty {
      CREATE LINK LowerBoundValue -> default::IfcValue;
      CREATE LINK SetPointValue -> default::IfcValue;
      CREATE LINK Unit -> default::IfcUnit;
      CREATE LINK UpperBoundValue -> default::IfcValue;
  };
  CREATE TYPE default::IfcPropertyEnumeration EXTENDING default::IfcPropertyAbstraction {
      CREATE REQUIRED MULTI LINK EnumerationValues -> default::IfcValue;
      CREATE LINK Unit -> default::IfcUnit;
      CREATE REQUIRED PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcPropertyEnumeratedValue EXTENDING default::IfcSimpleProperty {
      CREATE LINK EnumerationReference -> default::IfcPropertyEnumeration;
      CREATE MULTI LINK EnumerationValues -> default::IfcValue;
  };
  CREATE TYPE default::IfcPropertyListValue EXTENDING default::IfcSimpleProperty {
      CREATE MULTI LINK ListValues -> default::IfcValue;
      CREATE LINK Unit -> default::IfcUnit;
  };
  CREATE TYPE default::IfcPropertySingleValue EXTENDING default::IfcSimpleProperty {
      CREATE LINK NominalValue -> default::IfcValue;
      CREATE LINK Unit -> default::IfcUnit;
  };
  CREATE TYPE default::IfcPropertyTableValue EXTENDING default::IfcSimpleProperty {
      CREATE LINK DefinedUnit -> default::IfcUnit;
      CREATE MULTI LINK DefinedValues -> default::IfcValue;
      CREATE LINK DefiningUnit -> default::IfcUnit;
      CREATE MULTI LINK DefiningValues -> default::IfcValue;
      CREATE PROPERTY CurveInterpolation -> std::str {
          CREATE CONSTRAINT std::one_of('LINEAR', 'LOG_LINEAR', 'LOG_LOG', 'NOTDEFINED');
      };
      CREATE PROPERTY Expression -> std::str;
  };
  CREATE TYPE default::IfcRationalBSplineCurveWithKnots EXTENDING default::IfcBSplineCurveWithKnots {
      CREATE REQUIRED PROPERTY WeightsData -> tuple<std::float64, std::float64>;
  };
  CREATE TYPE default::IfcRegularTimeSeries EXTENDING default::IfcTimeSeries {
      CREATE REQUIRED MULTI LINK Values -> default::IfcTimeSeriesValue;
      CREATE REQUIRED PROPERTY TimeStep -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcRelationship EXTENDING default::IfcRoot;
  CREATE TYPE default::IfcSeamCurve EXTENDING default::IfcSurfaceCurve;
  CREATE TYPE default::IfcSectionedSpine EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED MULTI LINK CrossSectionPositions -> default::IfcAxis2Placement3D;
      CREATE REQUIRED MULTI LINK CrossSections -> default::IfcProfileDef;
      CREATE REQUIRED LINK SpineCurve -> default::IfcCompositeCurve;
  };
  CREATE ABSTRACT TYPE default::IfcSweptSurface EXTENDING default::IfcSurface {
      CREATE LINK Position -> default::IfcAxis2Placement3D;
      CREATE REQUIRED LINK SweptCurve -> default::IfcProfileDef;
  };
  CREATE TYPE default::IfcTableColumn {
      CREATE LINK ReferencePath -> default::IfcReference;
      CREATE LINK Unit -> default::IfcUnit;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Identifier -> std::str;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcTable {
      CREATE MULTI LINK Columns -> default::IfcTableColumn;
      CREATE MULTI LINK Rows -> default::IfcTableRow;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcTextStyle EXTENDING default::IfcPresentationStyle {
      CREATE LINK TextCharacterAppearance -> default::IfcTextStyleForDefinedFont;
      CREATE REQUIRED LINK TextFontStyle -> default::IfcTextFontSelect;
      CREATE LINK TextStyle -> default::IfcTextStyleTextModel;
      CREATE PROPERTY ModelOrDraughting -> std::bool;
  };
  CREATE TYPE default::IfcTransitionCurveSegment2D EXTENDING default::IfcCurveSegment2D {
      CREATE PROPERTY EndRadius -> std::float64;
      CREATE REQUIRED PROPERTY IsEndRadiusCCW -> std::bool;
      CREATE REQUIRED PROPERTY IsStartRadiusCCW -> std::bool;
      CREATE PROPERTY StartRadius -> std::float64;
      CREATE REQUIRED PROPERTY TransitionCurveType -> std::str {
          CREATE CONSTRAINT std::one_of('BIQUADRATICPARABOLA', 'BLOSSCURVE', 'CLOTHOIDCURVE', 'COSINECURVE', 'CUBICPARABOLA', 'SINECURVE');
      };
  };
  CREATE TYPE default::IfcTriangulatedFaceSet EXTENDING default::IfcTessellatedFaceSet {
      CREATE PROPERTY Closed -> std::bool;
      CREATE REQUIRED PROPERTY CoordIndex -> array<tuple<std::int64, std::int64, std::int64>>;
      CREATE PROPERTY Normals -> array<tuple<std::float64, std::float64, std::float64>>;
      CREATE PROPERTY PnIndex -> tuple<std::int64>;
  };
  CREATE TYPE default::IfcTriangulatedIrregularNetwork EXTENDING default::IfcTriangulatedFaceSet {
      CREATE REQUIRED PROPERTY Flags -> tuple<std::int64>;
  };
  CREATE TYPE default::IfcTrimmedCurve EXTENDING default::IfcBoundedCurve {
      CREATE REQUIRED LINK BasisCurve -> default::IfcCurve;
      CREATE REQUIRED MULTI LINK Trim1 -> default::IfcTrimmingSelect;
      CREATE REQUIRED MULTI LINK Trim2 -> default::IfcTrimmingSelect;
      CREATE REQUIRED PROPERTY MasterRepresentation -> std::str {
          CREATE CONSTRAINT std::one_of('CARTESIAN', 'PARAMETER', 'UNSPECIFIED');
      };
      CREATE REQUIRED PROPERTY SenseAgreement -> std::bool;
  };
};

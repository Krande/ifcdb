CREATE MIGRATION m1wcw7nwz6332236orfsbjfwtgfypjwmzhcq6ef3o7rfet73novixq
    ONTO m1maek5aazjdtcifilkcc6h3tgw2sw6mplejzmsgezl2ssta6ieqxa
{
  CREATE ABSTRACT TYPE default::IfcPresentationItem;
  CREATE TYPE default::IfcColourRgbList EXTENDING default::IfcPresentationItem {
      CREATE REQUIRED PROPERTY ColourList -> array<tuple<std::float64, std::float64, std::float64>>;
  };
  CREATE TYPE default::IfcPowerMeasure {
      CREATE REQUIRED PROPERTY IfcPowerMeasure -> std::float64;
  };
  CREATE TYPE default::IfcPressureMeasure {
      CREATE REQUIRED PROPERTY IfcPressureMeasure -> std::float64;
  };
  CREATE TYPE default::IfcRadioActivityMeasure {
      CREATE REQUIRED PROPERTY IfcRadioActivityMeasure -> std::float64;
  };
  CREATE TYPE default::IfcRotationalFrequencyMeasure {
      CREATE REQUIRED PROPERTY IfcRotationalFrequencyMeasure -> std::float64;
  };
  CREATE TYPE default::IfcRotationalMassMeasure {
      CREATE REQUIRED PROPERTY IfcRotationalMassMeasure -> std::float64;
  };
  CREATE TYPE default::IfcRotationalStiffnessMeasure {
      CREATE REQUIRED PROPERTY IfcRotationalStiffnessMeasure -> std::float64;
  };
  CREATE TYPE default::IfcSectionModulusMeasure {
      CREATE REQUIRED PROPERTY IfcSectionModulusMeasure -> std::float64;
  };
  CREATE TYPE default::IfcSectionalAreaIntegralMeasure {
      CREATE REQUIRED PROPERTY IfcSectionalAreaIntegralMeasure -> std::float64;
  };
  CREATE TYPE default::IfcShearModulusMeasure {
      CREATE REQUIRED PROPERTY IfcShearModulusMeasure -> std::float64;
  };
  CREATE TYPE default::IfcSoundPowerLevelMeasure {
      CREATE REQUIRED PROPERTY IfcSoundPowerLevelMeasure -> std::float64;
  };
  CREATE TYPE default::IfcSoundPowerMeasure {
      CREATE REQUIRED PROPERTY IfcSoundPowerMeasure -> std::float64;
  };
  CREATE TYPE default::IfcSoundPressureLevelMeasure {
      CREATE REQUIRED PROPERTY IfcSoundPressureLevelMeasure -> std::float64;
  };
  CREATE TYPE default::IfcSoundPressureMeasure {
      CREATE REQUIRED PROPERTY IfcSoundPressureMeasure -> std::float64;
  };
  CREATE TYPE default::IfcSpecificHeatCapacityMeasure {
      CREATE REQUIRED PROPERTY IfcSpecificHeatCapacityMeasure -> std::float64;
  };
  CREATE TYPE default::IfcTemperatureGradientMeasure {
      CREATE REQUIRED PROPERTY IfcTemperatureGradientMeasure -> std::float64;
  };
  CREATE TYPE default::IfcTemperatureRateOfChangeMeasure {
      CREATE REQUIRED PROPERTY IfcTemperatureRateOfChangeMeasure -> std::float64;
  };
  CREATE TYPE default::IfcThermalAdmittanceMeasure {
      CREATE REQUIRED PROPERTY IfcThermalAdmittanceMeasure -> std::float64;
  };
  CREATE TYPE default::IfcThermalConductivityMeasure {
      CREATE REQUIRED PROPERTY IfcThermalConductivityMeasure -> std::float64;
  };
  CREATE TYPE default::IfcThermalExpansionCoefficientMeasure {
      CREATE REQUIRED PROPERTY IfcThermalExpansionCoefficientMeasure -> std::float64;
  };
  CREATE TYPE default::IfcThermalResistanceMeasure {
      CREATE REQUIRED PROPERTY IfcThermalResistanceMeasure -> std::float64;
  };
  CREATE TYPE default::IfcThermalTransmittanceMeasure {
      CREATE REQUIRED PROPERTY IfcThermalTransmittanceMeasure -> std::float64;
  };
  CREATE TYPE default::IfcTorqueMeasure {
      CREATE REQUIRED PROPERTY IfcTorqueMeasure -> std::float64;
  };
  CREATE TYPE default::IfcVaporPermeabilityMeasure {
      CREATE REQUIRED PROPERTY IfcVaporPermeabilityMeasure -> std::float64;
  };
  CREATE TYPE default::IfcVolumetricFlowRateMeasure {
      CREATE REQUIRED PROPERTY IfcVolumetricFlowRateMeasure -> std::float64;
  };
  CREATE TYPE default::IfcWarpingConstantMeasure {
      CREATE REQUIRED PROPERTY IfcWarpingConstantMeasure -> std::float64;
  };
  CREATE TYPE default::IfcWarpingMomentMeasure {
      CREATE REQUIRED PROPERTY IfcWarpingMomentMeasure -> std::float64;
  };
  CREATE TYPE default::IfcDerivedMeasureValue {
      CREATE LINK IfcDerivedMeasureValue -> ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((default::IfcRotationalStiffnessMeasure | default::IfcPressureMeasure) | default::IfcElectricChargeMeasure) | default::IfcIntegerCountRateMeasure) | default::IfcSoundPowerMeasure) | default::IfcSpecificHeatCapacityMeasure) | default::IfcTemperatureRateOfChangeMeasure) | default::IfcAngularVelocityMeasure) | default::IfcElectricVoltageMeasure) | default::IfcVolumetricFlowRateMeasure) | default::IfcModulusOfRotationalSubgradeReactionMeasure) | default::IfcPlanarForceMeasure) | default::IfcElectricConductanceMeasure) | default::IfcPowerMeasure) | default::IfcSoundPowerLevelMeasure) | default::IfcSoundPressureLevelMeasure) | default::IfcMolecularWeightMeasure) | default::IfcElectricResistanceMeasure) | default::IfcKinematicViscosityMeasure) | default::IfcIlluminanceMeasure) | default::IfcMassPerLengthMeasure) | default::IfcIsothermalMoistureCapacityMeasure) | default::IfcEnergyMeasure) | default::IfcLuminousFluxMeasure) | default::IfcIonConcentrationMeasure) | default::IfcMomentOfInertiaMeasure) | default::IfcSoundPressureMeasure) | default::IfcAccelerationMeasure) | default::IfcAbsorbedDoseMeasure) | default::IfcAreaDensityMeasure) | default::IfcHeatingValueMeasure) | default::IfcLinearForceMeasure) | default::IfcModulusOfLinearSubgradeReactionMeasure) | default::IfcRotationalMassMeasure) | default::IfcShearModulusMeasure) | default::IfcLinearMomentMeasure) | default::IfcElectricCapacitanceMeasure) | default::IfcSectionModulusMeasure) | default::IfcModulusOfSubgradeReactionMeasure) | default::IfcPHMeasure) | default::IfcThermalResistanceMeasure) | default::IfcWarpingMomentMeasure) | default::IfcMassDensityMeasure) | default::IfcMoistureDiffusivityMeasure) | default::IfcFrequencyMeasure) | default::IfcTemperatureGradientMeasure) | default::IfcHeatFluxDensityMeasure) | default::IfcThermalExpansionCoefficientMeasure) | default::IfcThermalTransmittanceMeasure) | default::IfcRadioActivityMeasure) | default::IfcMonetaryMeasure) | default::IfcThermalConductivityMeasure) | default::IfcTorqueMeasure) | default::IfcCurvatureMeasure) | default::IfcWarpingConstantMeasure) | default::IfcLinearVelocityMeasure) | default::IfcMagneticFluxDensityMeasure) | default::IfcModulusOfElasticityMeasure) | default::IfcMagneticFluxMeasure) | default::IfcLuminousIntensityDistributionMeasure) | default::IfcThermalAdmittanceMeasure) | default::IfcLinearStiffnessMeasure) | default::IfcInductanceMeasure) | default::IfcSectionalAreaIntegralMeasure) | default::IfcForceMeasure) | default::IfcRotationalFrequencyMeasure) | default::IfcMassFlowRateMeasure) | default::IfcVaporPermeabilityMeasure) | default::IfcCompoundPlaneAngleMeasure) | default::IfcDynamicViscosityMeasure) | default::IfcDoseEquivalentMeasure);
  };
  CREATE TYPE default::IfcPositiveRatioMeasure {
      CREATE REQUIRED PROPERTY IfcPositiveRatioMeasure -> std::float64;
  };
  CREATE TYPE default::IfcRatioMeasure {
      CREATE REQUIRED PROPERTY IfcRatioMeasure -> std::float64;
  };
  CREATE TYPE default::IfcSolidAngleMeasure {
      CREATE REQUIRED PROPERTY IfcSolidAngleMeasure -> std::float64;
  };
  CREATE TYPE default::IfcThermodynamicTemperatureMeasure {
      CREATE REQUIRED PROPERTY IfcThermodynamicTemperatureMeasure -> std::float64;
  };
  CREATE TYPE default::IfcTimeMeasure {
      CREATE REQUIRED PROPERTY IfcTimeMeasure -> std::float64;
  };
  CREATE TYPE default::IfcVolumeMeasure {
      CREATE REQUIRED PROPERTY IfcVolumeMeasure -> std::float64;
  };
  CREATE TYPE default::IfcMeasureValue {
      CREATE LINK IfcMeasureValue -> ((((((((((((((((((((((default::IfcContextDependentMeasure | default::IfcPositiveRatioMeasure) | default::IfcAreaMeasure) | default::IfcLuminousIntensityMeasure) | default::IfcVolumeMeasure) | default::IfcThermodynamicTemperatureMeasure) | default::IfcRatioMeasure) | default::IfcNonNegativeLengthMeasure) | default::IfcDescriptiveMeasure) | default::IfcNumericMeasure) | default::IfcAmountOfSubstanceMeasure) | default::IfcParameterValue) | default::IfcPositivePlaneAngleMeasure) | default::IfcComplexNumber) | default::IfcNormalisedRatioMeasure) | default::IfcSolidAngleMeasure) | default::IfcElectricCurrentMeasure) | default::IfcTimeMeasure) | default::IfcPlaneAngleMeasure) | default::IfcPositiveLengthMeasure) | default::IfcMassMeasure) | default::IfcLengthMeasure) | default::IfcCountMeasure);
  };
  CREATE TYPE default::IfcReal {
      CREATE REQUIRED PROPERTY IfcReal -> std::float64;
  };
  CREATE TYPE default::IfcText {
      CREATE REQUIRED PROPERTY IfcText -> std::str;
  };
  CREATE TYPE default::IfcTime {
      CREATE REQUIRED PROPERTY IfcTime -> std::str;
  };
  CREATE TYPE default::IfcTimeStamp {
      CREATE REQUIRED PROPERTY IfcTimeStamp -> std::int64;
  };
  CREATE TYPE default::IfcSimpleValue {
      CREATE LINK IfcSimpleValue -> (((((((((((((default::IfcLabel | default::IfcDuration) | default::IfcPositiveInteger) | default::IfcText) | default::IfcIdentifier) | default::IfcDateTime) | default::IfcTime) | default::IfcTimeStamp) | default::IfcReal) | default::IfcBoolean) | default::IfcDate) | default::IfcLogical) | default::IfcInteger) | default::IfcBinary);
  };
  CREATE TYPE default::IfcModulusOfTranslationalSubgradeReactionSelect {
      CREATE LINK IfcModulusOfTranslationalSubgradeReactionSelect -> (default::IfcModulusOfLinearSubgradeReactionMeasure | default::IfcBoolean);
  };
  CREATE TYPE default::IfcModulusOfRotationalSubgradeReactionSelect {
      CREATE LINK IfcModulusOfRotationalSubgradeReactionSelect -> (default::IfcModulusOfRotationalSubgradeReactionMeasure | default::IfcBoolean);
  };
  CREATE TYPE default::IfcModulusOfSubgradeReactionSelect {
      CREATE LINK IfcModulusOfSubgradeReactionSelect -> (default::IfcModulusOfSubgradeReactionMeasure | default::IfcBoolean);
  };
  CREATE TYPE default::IfcRotationalStiffnessSelect {
      CREATE LINK IfcRotationalStiffnessSelect -> (default::IfcRotationalStiffnessMeasure | default::IfcBoolean);
  };
  CREATE TYPE default::IfcSizeSelect {
      CREATE LINK IfcSizeSelect -> (((((default::IfcRatioMeasure | default::IfcLengthMeasure) | default::IfcPositiveRatioMeasure) | default::IfcDescriptiveMeasure) | default::IfcPositiveLengthMeasure) | default::IfcNormalisedRatioMeasure);
  };
  CREATE TYPE default::IfcBendingParameterSelect {
      CREATE LINK IfcBendingParameterSelect -> (default::IfcPlaneAngleMeasure | default::IfcLengthMeasure);
  };
  CREATE TYPE default::IfcSpecularExponent {
      CREATE REQUIRED PROPERTY IfcSpecularExponent -> std::float64;
  };
  CREATE TYPE default::IfcSpecularRoughness {
      CREATE REQUIRED PROPERTY IfcSpecularRoughness -> std::float64;
  };
  CREATE TYPE default::IfcSpecularHighlightSelect {
      CREATE LINK IfcSpecularHighlightSelect -> (default::IfcSpecularRoughness | default::IfcSpecularExponent);
  };
  CREATE TYPE default::IfcActorRole {
      CREATE PROPERTY Description -> std::str;
      CREATE REQUIRED PROPERTY Role -> std::str {
          CREATE CONSTRAINT std::one_of('ARCHITECT', 'BUILDINGOPERATOR', 'BUILDINGOWNER', 'CIVILENGINEER', 'CLIENT', 'COMMISSIONINGENGINEER', 'CONSTRUCTIONMANAGER', 'CONSULTANT', 'CONTRACTOR', 'COSTENGINEER', 'ELECTRICALENGINEER', 'ENGINEER', 'FACILITIESMANAGER', 'FIELDCONSTRUCTIONMANAGER', 'MANUFACTURER', 'MECHANICALENGINEER', 'OWNER', 'PROJECTMANAGER', 'RESELLER', 'STRUCTURALENGINEER', 'SUBCONTRACTOR', 'SUPPLIER', 'USERDEFINED');
      };
      CREATE PROPERTY UserDefinedRole -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcAddress {
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Purpose -> std::str {
          CREATE CONSTRAINT std::one_of('DISTRIBUTIONPOINT', 'HOME', 'OFFICE', 'SITE', 'USERDEFINED');
      };
      CREATE PROPERTY UserDefinedPurpose -> std::str;
  };
  CREATE TYPE default::IfcArcIndex {
      CREATE REQUIRED PROPERTY IfcArcIndex -> tuple<std::int64, std::int64, std::int64>;
  };
  CREATE TYPE default::IfcClassification EXTENDING default::IfcExternalInformation {
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Edition -> std::str;
      CREATE PROPERTY EditionDate -> std::str;
      CREATE PROPERTY Location -> std::str;
      CREATE REQUIRED PROPERTY Name -> std::str;
      CREATE PROPERTY ReferenceTokens -> tuple<std::str>;
      CREATE PROPERTY Source -> std::str;
  };
  CREATE TYPE default::IfcClassificationReference EXTENDING default::IfcExternalReference {
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Sort -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcColourSpecification EXTENDING default::IfcPresentationItem {
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcCurveStyleFontPattern EXTENDING default::IfcPresentationItem {
      CREATE REQUIRED PROPERTY InvisibleSegmentLength -> std::float64;
      CREATE REQUIRED PROPERTY VisibleSegmentLength -> std::float64;
  };
  CREATE TYPE default::IfcExternallyDefinedHatchStyle EXTENDING default::IfcExternalReference;
  CREATE TYPE default::IfcExternallyDefinedSurfaceStyle EXTENDING default::IfcExternalReference;
  CREATE TYPE default::IfcExternallyDefinedTextFont EXTENDING default::IfcExternalReference;
  CREATE ABSTRACT TYPE default::IfcStructuralConnectionCondition {
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcFailureConnectionCondition EXTENDING default::IfcStructuralConnectionCondition {
      CREATE PROPERTY CompressionFailureX -> std::float64;
      CREATE PROPERTY CompressionFailureY -> std::float64;
      CREATE PROPERTY CompressionFailureZ -> std::float64;
      CREATE PROPERTY TensionFailureX -> std::float64;
      CREATE PROPERTY TensionFailureY -> std::float64;
      CREATE PROPERTY TensionFailureZ -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcRepresentationItem;
  CREATE ABSTRACT TYPE default::IfcGeometricRepresentationItem EXTENDING default::IfcRepresentationItem;
  CREATE TYPE default::IfcLightIntensityDistribution {
      CREATE REQUIRED MULTI LINK DistributionData -> default::IfcLightDistributionData;
      CREATE REQUIRED PROPERTY LightDistributionCurve -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'TYPE_A', 'TYPE_B', 'TYPE_C');
      };
  };
  CREATE TYPE default::IfcLineIndex {
      CREATE REQUIRED PROPERTY IfcLineIndex -> tuple<std::int64, std::int64>;
  };
  CREATE TYPE default::IfcMaterial EXTENDING default::IfcMaterialDefinition {
      CREATE PROPERTY Category -> std::str;
      CREATE PROPERTY Description -> std::str;
      CREATE REQUIRED PROPERTY Name -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcNamedUnit {
      CREATE LINK Dimensions -> default::IfcDimensionalExponents;
      CREATE REQUIRED PROPERTY UnitType -> std::str {
          CREATE CONSTRAINT std::one_of('ABSORBEDDOSEUNIT', 'AMOUNTOFSUBSTANCEUNIT', 'AREAUNIT', 'DOSEEQUIVALENTUNIT', 'ELECTRICCAPACITANCEUNIT', 'ELECTRICCHARGEUNIT', 'ELECTRICCONDUCTANCEUNIT', 'ELECTRICCURRENTUNIT', 'ELECTRICRESISTANCEUNIT', 'ELECTRICVOLTAGEUNIT', 'ENERGYUNIT', 'FORCEUNIT', 'FREQUENCYUNIT', 'ILLUMINANCEUNIT', 'INDUCTANCEUNIT', 'LENGTHUNIT', 'LUMINOUSFLUXUNIT', 'LUMINOUSINTENSITYUNIT', 'MAGNETICFLUXDENSITYUNIT', 'MAGNETICFLUXUNIT', 'MASSUNIT', 'PLANEANGLEUNIT', 'POWERUNIT', 'PRESSUREUNIT', 'RADIOACTIVITYUNIT', 'SOLIDANGLEUNIT', 'THERMODYNAMICTEMPERATUREUNIT', 'TIMEUNIT', 'USERDEFINED', 'VOLUMEUNIT');
      };
  };
  CREATE TYPE default::IfcPhysicalComplexQuantity EXTENDING default::IfcPhysicalQuantity {
      CREATE REQUIRED MULTI LINK HasQuantities -> default::IfcPhysicalQuantity;
      CREATE REQUIRED PROPERTY Discrimination -> std::str;
      CREATE PROPERTY Quality -> std::str;
      CREATE PROPERTY Usage -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcPreDefinedItem EXTENDING default::IfcPresentationItem {
      CREATE REQUIRED PROPERTY Name -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcPropertyAbstraction;
  CREATE ABSTRACT TYPE default::IfcPreDefinedProperties EXTENDING default::IfcPropertyAbstraction;
  CREATE TYPE default::IfcPresentableText {
      CREATE REQUIRED PROPERTY IfcPresentableText -> std::str;
  };
  CREATE TYPE default::IfcSurfaceStyleRefraction EXTENDING default::IfcPresentationItem {
      CREATE PROPERTY DispersionFactor -> std::float64;
      CREATE PROPERTY RefractionIndex -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcPresentationStyle {
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcProfileDef {
      CREATE PROPERTY ProfileName -> std::str;
      CREATE REQUIRED PROPERTY ProfileType -> std::str {
          CREATE CONSTRAINT std::one_of('AREA', 'CURVE');
      };
  };
  CREATE ABSTRACT TYPE default::IfcProperty EXTENDING default::IfcPropertyAbstraction {
      CREATE PROPERTY Description -> std::str;
      CREATE REQUIRED PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcTimePeriod {
      CREATE REQUIRED PROPERTY EndTime -> std::str;
      CREATE REQUIRED PROPERTY StartTime -> std::str;
  };
  CREATE TYPE default::IfcRecurrencePattern {
      CREATE MULTI LINK TimePeriods -> default::IfcTimePeriod;
      CREATE MULTI PROPERTY DayComponent -> std::int64;
      CREATE PROPERTY Interval -> std::int64;
      CREATE MULTI PROPERTY MonthComponent -> std::int64;
      CREATE PROPERTY Occurrences -> std::int64;
      CREATE PROPERTY Position -> std::int64;
      CREATE REQUIRED PROPERTY RecurrenceType -> std::str {
          CREATE CONSTRAINT std::one_of('BY_DAY_COUNT', 'BY_WEEKDAY_COUNT', 'DAILY', 'MONTHLY_BY_DAY_OF_MONTH', 'MONTHLY_BY_POSITION', 'WEEKLY', 'YEARLY_BY_DAY_OF_MONTH', 'YEARLY_BY_POSITION');
      };
      CREATE MULTI PROPERTY WeekdayComponent -> std::int64;
  };
  CREATE TYPE default::IfcReference {
      CREATE LINK InnerReference -> default::IfcReference;
      CREATE PROPERTY AttributeIdentifier -> std::str;
      CREATE PROPERTY InstanceName -> std::str;
      CREATE PROPERTY ListPositions -> tuple<std::int64>;
      CREATE PROPERTY TypeIdentifier -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcRepresentationContext {
      CREATE PROPERTY ContextIdentifier -> std::str;
      CREATE PROPERTY ContextType -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcRepresentation {
      CREATE REQUIRED LINK ContextOfItems -> default::IfcRepresentationContext;
      CREATE REQUIRED MULTI LINK Items -> default::IfcRepresentationItem;
      CREATE PROPERTY RepresentationIdentifier -> std::str;
      CREATE PROPERTY RepresentationType -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcResourceLevelRelationship {
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcSchedulingTime {
      CREATE PROPERTY DataOrigin -> std::str {
          CREATE CONSTRAINT std::one_of('MEASURED', 'NOTDEFINED', 'PREDICTED', 'SIMULATED', 'USERDEFINED');
      };
      CREATE PROPERTY Name -> std::str;
      CREATE PROPERTY UserDefinedDataOrigin -> std::str;
  };
  CREATE TYPE default::IfcSlippageConnectionCondition EXTENDING default::IfcStructuralConnectionCondition {
      CREATE PROPERTY SlippageX -> std::float64;
      CREATE PROPERTY SlippageY -> std::float64;
      CREATE PROPERTY SlippageZ -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcStructuralLoad {
      CREATE PROPERTY Name -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcStructuralLoadOrResult EXTENDING default::IfcStructuralLoad;
  CREATE TYPE default::IfcTextAlignment {
      CREATE REQUIRED PROPERTY IfcTextAlignment -> std::str;
  };
  CREATE TYPE default::IfcTextDecoration {
      CREATE REQUIRED PROPERTY IfcTextDecoration -> std::str;
  };
  CREATE TYPE default::IfcTextFontName {
      CREATE REQUIRED PROPERTY IfcTextFontName -> std::str;
  };
  CREATE TYPE default::IfcTextTransformation {
      CREATE REQUIRED PROPERTY IfcTextTransformation -> std::str;
  };
  CREATE TYPE default::IfcURIReference {
      CREATE REQUIRED PROPERTY IfcURIReference -> std::str;
  };
};

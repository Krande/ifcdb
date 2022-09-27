CREATE MIGRATION m1maek5aazjdtcifilkcc6h3tgw2sw6mplejzmsgezl2ssta6ieqxa
    ONTO initial
{
  CREATE TYPE default::IfcComplexNumber {
      CREATE REQUIRED PROPERTY IfcComplexNumber -> array<std::float64> {
          CREATE CONSTRAINT std::expression ON (((std::len(__subject__) = 1) OR (std::len(__subject__) = 2)));
      };
  };
  CREATE TYPE default::IfcCompoundPlaneAngleMeasure {
      CREATE REQUIRED PROPERTY IfcCompoundPlaneAngleMeasure -> array<std::int64> {
          CREATE CONSTRAINT std::expression ON (((std::len(__subject__) = 3) OR (std::len(__subject__) = 4)));
      };
  };
  CREATE TYPE default::IfcAbsorbedDoseMeasure {
      CREATE REQUIRED PROPERTY IfcAbsorbedDoseMeasure -> std::float64;
  };
  CREATE TYPE default::IfcAccelerationMeasure {
      CREATE REQUIRED PROPERTY IfcAccelerationMeasure -> std::float64;
  };
  CREATE TYPE default::IfcAmountOfSubstanceMeasure {
      CREATE REQUIRED PROPERTY IfcAmountOfSubstanceMeasure -> std::float64;
  };
  CREATE TYPE default::IfcAngularVelocityMeasure {
      CREATE REQUIRED PROPERTY IfcAngularVelocityMeasure -> std::float64;
  };
  CREATE TYPE default::IfcAreaDensityMeasure {
      CREATE REQUIRED PROPERTY IfcAreaDensityMeasure -> std::float64;
  };
  CREATE TYPE default::IfcAreaMeasure {
      CREATE REQUIRED PROPERTY IfcAreaMeasure -> std::float64;
  };
  CREATE TYPE default::IfcBinary {
      CREATE REQUIRED PROPERTY IfcBinary -> std::bytes;
  };
  CREATE TYPE default::IfcBoolean {
      CREATE REQUIRED PROPERTY IfcBoolean -> std::bool;
  };
  CREATE ABSTRACT TYPE default::IfcBoundaryCondition {
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcBoxAlignment {
      CREATE REQUIRED PROPERTY IfcBoxAlignment -> std::str;
  };
  CREATE TYPE default::IfcCardinalPointReference {
      CREATE REQUIRED PROPERTY IfcCardinalPointReference -> std::int64;
  };
  CREATE ABSTRACT TYPE default::IfcConnectionGeometry;
  CREATE TYPE default::IfcContextDependentMeasure {
      CREATE REQUIRED PROPERTY IfcContextDependentMeasure -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcCoordinateReferenceSystem {
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY GeodeticDatum -> std::str;
      CREATE REQUIRED PROPERTY Name -> std::str;
      CREATE PROPERTY VerticalDatum -> std::str;
  };
  CREATE TYPE default::IfcCountMeasure {
      CREATE REQUIRED PROPERTY IfcCountMeasure -> std::int64;
  };
  CREATE TYPE default::IfcCurvatureMeasure {
      CREATE REQUIRED PROPERTY IfcCurvatureMeasure -> std::float64;
  };
  CREATE TYPE default::IfcDate {
      CREATE REQUIRED PROPERTY IfcDate -> std::str;
  };
  CREATE TYPE default::IfcDateTime {
      CREATE REQUIRED PROPERTY IfcDateTime -> std::str;
  };
  CREATE TYPE default::IfcDayInMonthNumber {
      CREATE REQUIRED PROPERTY IfcDayInMonthNumber -> std::int64;
  };
  CREATE TYPE default::IfcDayInWeekNumber {
      CREATE REQUIRED PROPERTY IfcDayInWeekNumber -> std::int64;
  };
  CREATE TYPE default::IfcDescriptiveMeasure {
      CREATE REQUIRED PROPERTY IfcDescriptiveMeasure -> std::str;
  };
  CREATE TYPE default::IfcDimensionCount {
      CREATE REQUIRED PROPERTY IfcDimensionCount -> std::int64;
  };
  CREATE TYPE default::IfcDimensionalExponents {
      CREATE REQUIRED PROPERTY AmountOfSubstanceExponent -> std::int64;
      CREATE REQUIRED PROPERTY ElectricCurrentExponent -> std::int64;
      CREATE REQUIRED PROPERTY LengthExponent -> std::int64;
      CREATE REQUIRED PROPERTY LuminousIntensityExponent -> std::int64;
      CREATE REQUIRED PROPERTY MassExponent -> std::int64;
      CREATE REQUIRED PROPERTY ThermodynamicTemperatureExponent -> std::int64;
      CREATE REQUIRED PROPERTY TimeExponent -> std::int64;
  };
  CREATE TYPE default::IfcDoseEquivalentMeasure {
      CREATE REQUIRED PROPERTY IfcDoseEquivalentMeasure -> std::float64;
  };
  CREATE TYPE default::IfcDuration {
      CREATE REQUIRED PROPERTY IfcDuration -> std::str;
  };
  CREATE TYPE default::IfcDynamicViscosityMeasure {
      CREATE REQUIRED PROPERTY IfcDynamicViscosityMeasure -> std::float64;
  };
  CREATE TYPE default::IfcElectricCapacitanceMeasure {
      CREATE REQUIRED PROPERTY IfcElectricCapacitanceMeasure -> std::float64;
  };
  CREATE TYPE default::IfcElectricChargeMeasure {
      CREATE REQUIRED PROPERTY IfcElectricChargeMeasure -> std::float64;
  };
  CREATE TYPE default::IfcElectricConductanceMeasure {
      CREATE REQUIRED PROPERTY IfcElectricConductanceMeasure -> std::float64;
  };
  CREATE TYPE default::IfcElectricCurrentMeasure {
      CREATE REQUIRED PROPERTY IfcElectricCurrentMeasure -> std::float64;
  };
  CREATE TYPE default::IfcElectricResistanceMeasure {
      CREATE REQUIRED PROPERTY IfcElectricResistanceMeasure -> std::float64;
  };
  CREATE TYPE default::IfcElectricVoltageMeasure {
      CREATE REQUIRED PROPERTY IfcElectricVoltageMeasure -> std::float64;
  };
  CREATE TYPE default::IfcEnergyMeasure {
      CREATE REQUIRED PROPERTY IfcEnergyMeasure -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcExternalInformation;
  CREATE ABSTRACT TYPE default::IfcExternalReference {
      CREATE PROPERTY Identification -> std::str;
      CREATE PROPERTY Location -> std::str;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcFontStyle {
      CREATE REQUIRED PROPERTY IfcFontStyle -> std::str;
  };
  CREATE TYPE default::IfcFontVariant {
      CREATE REQUIRED PROPERTY IfcFontVariant -> std::str;
  };
  CREATE TYPE default::IfcFontWeight {
      CREATE REQUIRED PROPERTY IfcFontWeight -> std::str;
  };
  CREATE TYPE default::IfcForceMeasure {
      CREATE REQUIRED PROPERTY IfcForceMeasure -> std::float64;
  };
  CREATE TYPE default::IfcFrequencyMeasure {
      CREATE REQUIRED PROPERTY IfcFrequencyMeasure -> std::float64;
  };
  CREATE TYPE default::IfcGloballyUniqueId {
      CREATE REQUIRED PROPERTY IfcGloballyUniqueId -> std::str;
  };
  CREATE TYPE default::IfcHeatFluxDensityMeasure {
      CREATE REQUIRED PROPERTY IfcHeatFluxDensityMeasure -> std::float64;
  };
  CREATE TYPE default::IfcHeatingValueMeasure {
      CREATE REQUIRED PROPERTY IfcHeatingValueMeasure -> std::float64;
  };
  CREATE TYPE default::IfcIdentifier {
      CREATE REQUIRED PROPERTY IfcIdentifier -> std::str;
  };
  CREATE TYPE default::IfcIlluminanceMeasure {
      CREATE REQUIRED PROPERTY IfcIlluminanceMeasure -> std::float64;
  };
  CREATE TYPE default::IfcInductanceMeasure {
      CREATE REQUIRED PROPERTY IfcInductanceMeasure -> std::float64;
  };
  CREATE TYPE default::IfcInteger {
      CREATE REQUIRED PROPERTY IfcInteger -> std::int64;
  };
  CREATE TYPE default::IfcIntegerCountRateMeasure {
      CREATE REQUIRED PROPERTY IfcIntegerCountRateMeasure -> std::int64;
  };
  CREATE TYPE default::IfcIonConcentrationMeasure {
      CREATE REQUIRED PROPERTY IfcIonConcentrationMeasure -> std::float64;
  };
  CREATE TYPE default::IfcIsothermalMoistureCapacityMeasure {
      CREATE REQUIRED PROPERTY IfcIsothermalMoistureCapacityMeasure -> std::float64;
  };
  CREATE TYPE default::IfcKinematicViscosityMeasure {
      CREATE REQUIRED PROPERTY IfcKinematicViscosityMeasure -> std::float64;
  };
  CREATE TYPE default::IfcLabel {
      CREATE REQUIRED PROPERTY IfcLabel -> std::str;
  };
  CREATE TYPE default::IfcLanguageId {
      CREATE REQUIRED PROPERTY IfcLanguageId -> std::str;
  };
  CREATE TYPE default::IfcLengthMeasure {
      CREATE REQUIRED PROPERTY IfcLengthMeasure -> std::float64;
  };
  CREATE TYPE default::IfcLightDistributionData {
      CREATE REQUIRED PROPERTY LuminousIntensity -> tuple<std::float64>;
      CREATE REQUIRED PROPERTY MainPlaneAngle -> std::float64;
      CREATE REQUIRED PROPERTY SecondaryPlaneAngle -> tuple<std::float64>;
  };
  CREATE TYPE default::IfcLinearForceMeasure {
      CREATE REQUIRED PROPERTY IfcLinearForceMeasure -> std::float64;
  };
  CREATE TYPE default::IfcLinearMomentMeasure {
      CREATE REQUIRED PROPERTY IfcLinearMomentMeasure -> std::float64;
  };
  CREATE TYPE default::IfcLinearStiffnessMeasure {
      CREATE REQUIRED PROPERTY IfcLinearStiffnessMeasure -> std::float64;
  };
  CREATE TYPE default::IfcLinearVelocityMeasure {
      CREATE REQUIRED PROPERTY IfcLinearVelocityMeasure -> std::float64;
  };
  CREATE TYPE default::IfcLogical {
      CREATE REQUIRED PROPERTY IfcLogical -> std::bool;
  };
  CREATE TYPE default::IfcLuminousFluxMeasure {
      CREATE REQUIRED PROPERTY IfcLuminousFluxMeasure -> std::float64;
  };
  CREATE TYPE default::IfcLuminousIntensityDistributionMeasure {
      CREATE REQUIRED PROPERTY IfcLuminousIntensityDistributionMeasure -> std::float64;
  };
  CREATE TYPE default::IfcLuminousIntensityMeasure {
      CREATE REQUIRED PROPERTY IfcLuminousIntensityMeasure -> std::float64;
  };
  CREATE TYPE default::IfcMagneticFluxDensityMeasure {
      CREATE REQUIRED PROPERTY IfcMagneticFluxDensityMeasure -> std::float64;
  };
  CREATE TYPE default::IfcMagneticFluxMeasure {
      CREATE REQUIRED PROPERTY IfcMagneticFluxMeasure -> std::float64;
  };
  CREATE TYPE default::IfcMassDensityMeasure {
      CREATE REQUIRED PROPERTY IfcMassDensityMeasure -> std::float64;
  };
  CREATE TYPE default::IfcMassFlowRateMeasure {
      CREATE REQUIRED PROPERTY IfcMassFlowRateMeasure -> std::float64;
  };
  CREATE TYPE default::IfcMassMeasure {
      CREATE REQUIRED PROPERTY IfcMassMeasure -> std::float64;
  };
  CREATE TYPE default::IfcMassPerLengthMeasure {
      CREATE REQUIRED PROPERTY IfcMassPerLengthMeasure -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcMaterialDefinition;
  CREATE ABSTRACT TYPE default::IfcMaterialUsageDefinition;
  CREATE TYPE default::IfcModulusOfElasticityMeasure {
      CREATE REQUIRED PROPERTY IfcModulusOfElasticityMeasure -> std::float64;
  };
  CREATE TYPE default::IfcModulusOfLinearSubgradeReactionMeasure {
      CREATE REQUIRED PROPERTY IfcModulusOfLinearSubgradeReactionMeasure -> std::float64;
  };
  CREATE TYPE default::IfcModulusOfRotationalSubgradeReactionMeasure {
      CREATE REQUIRED PROPERTY IfcModulusOfRotationalSubgradeReactionMeasure -> std::float64;
  };
  CREATE TYPE default::IfcModulusOfSubgradeReactionMeasure {
      CREATE REQUIRED PROPERTY IfcModulusOfSubgradeReactionMeasure -> std::float64;
  };
  CREATE TYPE default::IfcMoistureDiffusivityMeasure {
      CREATE REQUIRED PROPERTY IfcMoistureDiffusivityMeasure -> std::float64;
  };
  CREATE TYPE default::IfcMolecularWeightMeasure {
      CREATE REQUIRED PROPERTY IfcMolecularWeightMeasure -> std::float64;
  };
  CREATE TYPE default::IfcMomentOfInertiaMeasure {
      CREATE REQUIRED PROPERTY IfcMomentOfInertiaMeasure -> std::float64;
  };
  CREATE TYPE default::IfcMonetaryMeasure {
      CREATE REQUIRED PROPERTY IfcMonetaryMeasure -> std::float64;
  };
  CREATE TYPE default::IfcMonetaryUnit {
      CREATE REQUIRED PROPERTY Currency -> std::str;
  };
  CREATE TYPE default::IfcMonthInYearNumber {
      CREATE REQUIRED PROPERTY IfcMonthInYearNumber -> std::int64;
  };
  CREATE TYPE default::IfcNonNegativeLengthMeasure {
      CREATE REQUIRED PROPERTY IfcNonNegativeLengthMeasure -> std::float64;
  };
  CREATE TYPE default::IfcNormalisedRatioMeasure {
      CREATE REQUIRED PROPERTY IfcNormalisedRatioMeasure -> std::float64;
  };
  CREATE TYPE default::IfcNullStyle {
      CREATE REQUIRED PROPERTY IfcNullStyle -> std::str {
          CREATE CONSTRAINT std::one_of('NULL');
      };
  };
  CREATE TYPE default::IfcNumericMeasure {
      CREATE REQUIRED PROPERTY IfcNumericMeasure -> std::int64;
  };
  CREATE ABSTRACT TYPE default::IfcObjectPlacement;
  CREATE TYPE default::IfcPHMeasure {
      CREATE REQUIRED PROPERTY IfcPHMeasure -> std::float64;
  };
  CREATE TYPE default::IfcParameterValue {
      CREATE REQUIRED PROPERTY IfcParameterValue -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcPhysicalQuantity {
      CREATE PROPERTY Description -> std::str;
      CREATE REQUIRED PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcPlanarForceMeasure {
      CREATE REQUIRED PROPERTY IfcPlanarForceMeasure -> std::float64;
  };
  CREATE TYPE default::IfcPlaneAngleMeasure {
      CREATE REQUIRED PROPERTY IfcPlaneAngleMeasure -> std::float64;
  };
  CREATE TYPE default::IfcPositiveInteger {
      CREATE REQUIRED PROPERTY IfcPositiveInteger -> std::int64;
  };
  CREATE TYPE default::IfcPositiveLengthMeasure {
      CREATE REQUIRED PROPERTY IfcPositiveLengthMeasure -> std::float64;
  };
  CREATE TYPE default::IfcPositivePlaneAngleMeasure {
      CREATE REQUIRED PROPERTY IfcPositivePlaneAngleMeasure -> std::float64;
  };
};

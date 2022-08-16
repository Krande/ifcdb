CREATE MIGRATION m1bbmpt5tepjpfwwpxfwrfag67nebqzqr3x7rcl3vzvu573jldeqba
    ONTO initial
{
  CREATE ABSTRACT TYPE default::IfcRepresentationItem;
  CREATE ABSTRACT TYPE default::IfcGeometricRepresentationItem EXTENDING default::IfcRepresentationItem;
  CREATE ABSTRACT TYPE default::IfcPoint EXTENDING default::IfcGeometricRepresentationItem;
  CREATE TYPE default::IfcCartesianPoint EXTENDING default::IfcPoint {
      CREATE REQUIRED PROPERTY Coordinates -> array<std::float64> {
          CREATE CONSTRAINT std::expression ON ((((std::len(__subject__) = 1) OR (std::len(__subject__) = 2)) OR (std::len(__subject__) = 3)));
      };
  };
  CREATE TYPE default::IfcDirection EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED PROPERTY DirectionRatios -> array<std::float64> {
          CREATE CONSTRAINT std::expression ON (((std::len(__subject__) = 2) OR (std::len(__subject__) = 3)));
      };
  };
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
  CREATE ABSTRACT TYPE default::IfcCartesianPointList EXTENDING default::IfcGeometricRepresentationItem;
  CREATE TYPE default::IfcCartesianPointList3D EXTENDING default::IfcCartesianPointList {
      CREATE REQUIRED PROPERTY CoordList -> array<tuple<std::float64, std::float64, std::float64>>;
      CREATE PROPERTY TagList -> tuple<std::str>;
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
  CREATE TYPE default::IfcContextDependentMeasure {
      CREATE REQUIRED PROPERTY IfcContextDependentMeasure -> std::float64;
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
  CREATE TYPE default::IfcDescriptiveMeasure {
      CREATE REQUIRED PROPERTY IfcDescriptiveMeasure -> std::str;
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
  CREATE TYPE default::IfcForceMeasure {
      CREATE REQUIRED PROPERTY IfcForceMeasure -> std::float64;
  };
  CREATE TYPE default::IfcFrequencyMeasure {
      CREATE REQUIRED PROPERTY IfcFrequencyMeasure -> std::float64;
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
  CREATE TYPE default::IfcLengthMeasure {
      CREATE REQUIRED PROPERTY IfcLengthMeasure -> std::float64;
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
  CREATE TYPE default::IfcNonNegativeLengthMeasure {
      CREATE REQUIRED PROPERTY IfcNonNegativeLengthMeasure -> std::float64;
  };
  CREATE TYPE default::IfcNormalisedRatioMeasure {
      CREATE REQUIRED PROPERTY IfcNormalisedRatioMeasure -> std::float64;
  };
  CREATE TYPE default::IfcNumericMeasure {
      CREATE REQUIRED PROPERTY IfcNumericMeasure -> std::int64;
  };
  CREATE TYPE default::IfcPHMeasure {
      CREATE REQUIRED PROPERTY IfcPHMeasure -> std::float64;
  };
  CREATE TYPE default::IfcParameterValue {
      CREATE REQUIRED PROPERTY IfcParameterValue -> std::float64;
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
  CREATE TYPE default::IfcPositiveRatioMeasure {
      CREATE REQUIRED PROPERTY IfcPositiveRatioMeasure -> std::float64;
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
  CREATE TYPE default::IfcRatioMeasure {
      CREATE REQUIRED PROPERTY IfcRatioMeasure -> std::float64;
  };
  CREATE TYPE default::IfcReal {
      CREATE REQUIRED PROPERTY IfcReal -> std::float64;
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
  CREATE TYPE default::IfcSolidAngleMeasure {
      CREATE REQUIRED PROPERTY IfcSolidAngleMeasure -> std::float64;
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
  CREATE TYPE default::IfcText {
      CREATE REQUIRED PROPERTY IfcText -> std::str;
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
  CREATE TYPE default::IfcThermodynamicTemperatureMeasure {
      CREATE REQUIRED PROPERTY IfcThermodynamicTemperatureMeasure -> std::float64;
  };
  CREATE TYPE default::IfcTime {
      CREATE REQUIRED PROPERTY IfcTime -> std::str;
  };
  CREATE TYPE default::IfcTimeMeasure {
      CREATE REQUIRED PROPERTY IfcTimeMeasure -> std::float64;
  };
  CREATE TYPE default::IfcTimeStamp {
      CREATE REQUIRED PROPERTY IfcTimeStamp -> std::int64;
  };
  CREATE TYPE default::IfcTorqueMeasure {
      CREATE REQUIRED PROPERTY IfcTorqueMeasure -> std::float64;
  };
  CREATE TYPE default::IfcVaporPermeabilityMeasure {
      CREATE REQUIRED PROPERTY IfcVaporPermeabilityMeasure -> std::float64;
  };
  CREATE TYPE default::IfcVolumeMeasure {
      CREATE REQUIRED PROPERTY IfcVolumeMeasure -> std::float64;
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
  CREATE TYPE default::IfcValue {
      CREATE LINK IfcValue -> (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((default::IfcRotationalStiffnessMeasure | default::IfcFrequencyMeasure) | default::IfcPlanarForceMeasure) | default::IfcLabel) | default::IfcMonetaryMeasure) | default::IfcCompoundPlaneAngleMeasure) | default::IfcThermalAdmittanceMeasure) | default::IfcAbsorbedDoseMeasure) | default::IfcAccelerationMeasure) | default::IfcMassFlowRateMeasure) | default::IfcReal) | default::IfcRotationalFrequencyMeasure) | default::IfcThermalConductivityMeasure) | default::IfcMassDensityMeasure) | default::IfcBoolean) | default::IfcCountMeasure) | default::IfcIsothermalMoistureCapacityMeasure) | default::IfcPHMeasure) | default::IfcRadioActivityMeasure) | default::IfcContextDependentMeasure) | default::IfcElectricVoltageMeasure) | default::IfcParameterValue) | default::IfcLuminousIntensityDistributionMeasure) | default::IfcLogical) | default::IfcPositiveInteger) | default::IfcHeatingValueMeasure) | default::IfcDuration) | default::IfcMomentOfInertiaMeasure) | default::IfcLinearStiffnessMeasure) | default::IfcAreaMeasure) | default::IfcSoundPowerMeasure) | default::IfcThermodynamicTemperatureMeasure) | default::IfcLinearForceMeasure) | default::IfcElectricCurrentMeasure) | default::IfcMagneticFluxDensityMeasure) | default::IfcDateTime) | default::IfcLinearVelocityMeasure) | default::IfcTimeStamp) | default::IfcVolumetricFlowRateMeasure) | default::IfcSpecificHeatCapacityMeasure) | default::IfcAreaDensityMeasure) | default::IfcModulusOfRotationalSubgradeReactionMeasure) | default::IfcAngularVelocityMeasure) | default::IfcCurvatureMeasure) | default::IfcEnergyMeasure) | default::IfcMoistureDiffusivityMeasure) | default::IfcIntegerCountRateMeasure) | default::IfcTemperatureRateOfChangeMeasure) | default::IfcMassPerLengthMeasure) | default::IfcWarpingMomentMeasure) | default::IfcVaporPermeabilityMeasure) | default::IfcNormalisedRatioMeasure) | default::IfcPositivePlaneAngleMeasure) | default::IfcSoundPowerLevelMeasure) | default::IfcNonNegativeLengthMeasure) | default::IfcDynamicViscosityMeasure) | default::IfcElectricCapacitanceMeasure) | default::IfcText) | default::IfcSoundPressureMeasure) | default::IfcIdentifier) | default::IfcSoundPressureLevelMeasure) | default::IfcTimeMeasure) | default::IfcBinary) | default::IfcIonConcentrationMeasure) | default::IfcMagneticFluxMeasure) | default::IfcKinematicViscosityMeasure) | default::IfcElectricConductanceMeasure) | default::IfcPressureMeasure) | default::IfcThermalTransmittanceMeasure) | default::IfcTime) | default::IfcDate) | default::IfcComplexNumber) | default::IfcSolidAngleMeasure) | default::IfcInductanceMeasure) | default::IfcVolumeMeasure) | default::IfcLengthMeasure) | default::IfcElectricChargeMeasure) | default::IfcNumericMeasure) | default::IfcForceMeasure) | default::IfcDoseEquivalentMeasure) | default::IfcTemperatureGradientMeasure) | default::IfcModulusOfSubgradeReactionMeasure) | default::IfcWarpingConstantMeasure) | default::IfcModulusOfElasticityMeasure) | default::IfcLuminousFluxMeasure) | default::IfcShearModulusMeasure) | default::IfcMassMeasure) | default::IfcIlluminanceMeasure) | default::IfcLuminousIntensityMeasure) | default::IfcDescriptiveMeasure) | default::IfcThermalExpansionCoefficientMeasure) | default::IfcPlaneAngleMeasure) | default::IfcPositiveLengthMeasure) | default::IfcSectionModulusMeasure) | default::IfcRotationalMassMeasure) | default::IfcSectionalAreaIntegralMeasure) | default::IfcThermalResistanceMeasure) | default::IfcTorqueMeasure) | default::IfcRatioMeasure) | default::IfcAmountOfSubstanceMeasure) | default::IfcLinearMomentMeasure) | default::IfcPowerMeasure) | default::IfcPositiveRatioMeasure) | default::IfcMolecularWeightMeasure) | default::IfcInteger) | default::IfcModulusOfLinearSubgradeReactionMeasure) | default::IfcElectricResistanceMeasure) | default::IfcHeatFluxDensityMeasure);
  };
  CREATE TYPE default::IfcDerivedMeasureValue {
      CREATE LINK IfcDerivedMeasureValue -> ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((default::IfcDynamicViscosityMeasure | default::IfcElectricVoltageMeasure) | default::IfcElectricCapacitanceMeasure) | default::IfcLuminousIntensityDistributionMeasure) | default::IfcHeatingValueMeasure) | default::IfcSoundPressureMeasure) | default::IfcRotationalStiffnessMeasure) | default::IfcLuminousFluxMeasure) | default::IfcMomentOfInertiaMeasure) | default::IfcFrequencyMeasure) | default::IfcShearModulusMeasure) | default::IfcIlluminanceMeasure) | default::IfcLinearStiffnessMeasure) | default::IfcSoundPressureLevelMeasure) | default::IfcSoundPowerMeasure) | default::IfcPlanarForceMeasure) | default::IfcIonConcentrationMeasure) | default::IfcMagneticFluxMeasure) | default::IfcKinematicViscosityMeasure) | default::IfcElectricConductanceMeasure) | default::IfcLinearForceMeasure) | default::IfcMonetaryMeasure) | default::IfcPressureMeasure) | default::IfcThermalTransmittanceMeasure) | default::IfcMagneticFluxDensityMeasure) | default::IfcThermalExpansionCoefficientMeasure) | default::IfcCompoundPlaneAngleMeasure) | default::IfcInductanceMeasure) | default::IfcLinearVelocityMeasure) | default::IfcThermalAdmittanceMeasure) | default::IfcAbsorbedDoseMeasure) | default::IfcAccelerationMeasure) | default::IfcMassFlowRateMeasure) | default::IfcElectricChargeMeasure) | default::IfcSectionModulusMeasure) | default::IfcVolumetricFlowRateMeasure) | default::IfcSpecificHeatCapacityMeasure) | default::IfcRotationalFrequencyMeasure) | default::IfcRotationalMassMeasure) | default::IfcAreaDensityMeasure) | default::IfcModulusOfRotationalSubgradeReactionMeasure) | default::IfcSectionalAreaIntegralMeasure) | default::IfcForceMeasure) | default::IfcAngularVelocityMeasure) | default::IfcCurvatureMeasure) | default::IfcEnergyMeasure) | default::IfcMoistureDiffusivityMeasure) | default::IfcDoseEquivalentMeasure) | default::IfcIntegerCountRateMeasure) | default::IfcTemperatureRateOfChangeMeasure) | default::IfcThermalConductivityMeasure) | default::IfcMassPerLengthMeasure) | default::IfcThermalResistanceMeasure) | default::IfcTemperatureGradientMeasure) | default::IfcMassDensityMeasure) | default::IfcVaporPermeabilityMeasure) | default::IfcLinearMomentMeasure) | default::IfcIsothermalMoistureCapacityMeasure) | default::IfcPowerMeasure) | default::IfcPHMeasure) | default::IfcWarpingMomentMeasure) | default::IfcModulusOfSubgradeReactionMeasure) | default::IfcMolecularWeightMeasure) | default::IfcWarpingConstantMeasure) | default::IfcTorqueMeasure) | default::IfcRadioActivityMeasure) | default::IfcSoundPowerLevelMeasure) | default::IfcModulusOfLinearSubgradeReactionMeasure) | default::IfcElectricResistanceMeasure) | default::IfcModulusOfElasticityMeasure) | default::IfcHeatFluxDensityMeasure);
  };
  CREATE TYPE default::IfcMeasureValue {
      CREATE LINK IfcMeasureValue -> ((((((((((((((((((((((default::IfcNonNegativeLengthMeasure | default::IfcContextDependentMeasure) | default::IfcParameterValue) | default::IfcMassMeasure) | default::IfcAreaMeasure) | default::IfcTimeMeasure) | default::IfcLuminousIntensityMeasure) | default::IfcThermodynamicTemperatureMeasure) | default::IfcDescriptiveMeasure) | default::IfcElectricCurrentMeasure) | default::IfcComplexNumber) | default::IfcSolidAngleMeasure) | default::IfcVolumeMeasure) | default::IfcPlaneAngleMeasure) | default::IfcLengthMeasure) | default::IfcPositiveLengthMeasure) | default::IfcNormalisedRatioMeasure) | default::IfcNumericMeasure) | default::IfcRatioMeasure) | default::IfcAmountOfSubstanceMeasure) | default::IfcCountMeasure) | default::IfcPositiveRatioMeasure) | default::IfcPositivePlaneAngleMeasure);
  };
  CREATE TYPE default::IfcArcIndex {
      CREATE REQUIRED PROPERTY IfcArcIndex -> tuple<std::int64, std::int64, std::int64>;
  };
  CREATE TYPE default::IfcLineIndex {
      CREATE REQUIRED PROPERTY IfcLineIndex -> tuple<std::int64, std::int64>;
  };
  CREATE TYPE default::IfcSegmentIndexSelect {
      CREATE LINK IfcSegmentIndexSelect -> (default::IfcArcIndex | default::IfcLineIndex);
  };
  CREATE ABSTRACT TYPE default::IfcPlacement EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED LINK Location -> default::IfcCartesianPoint;
  };
  CREATE TYPE default::IfcAxis2Placement2D EXTENDING default::IfcPlacement {
      CREATE LINK RefDirection -> default::IfcDirection;
  };
  CREATE TYPE default::IfcAxis2Placement3D EXTENDING default::IfcPlacement {
      CREATE LINK RefDirection -> default::IfcDirection;
      CREATE LINK Axis -> default::IfcDirection;
  };
  CREATE TYPE default::IfcAxis2Placement {
      CREATE LINK IfcAxis2Placement -> (default::IfcAxis2Placement3D | default::IfcAxis2Placement2D);
  };
  CREATE TYPE default::IfcSimpleValue {
      CREATE LINK IfcSimpleValue -> (((((((((((((default::IfcLabel | default::IfcTimeStamp) | default::IfcTime) | default::IfcLogical) | default::IfcBoolean) | default::IfcPositiveInteger) | default::IfcReal) | default::IfcText) | default::IfcDuration) | default::IfcDate) | default::IfcDateTime) | default::IfcIdentifier) | default::IfcInteger) | default::IfcBinary);
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
  CREATE ABSTRACT TYPE default::IfcNamedUnit {
      CREATE LINK Dimensions -> default::IfcDimensionalExponents;
      CREATE REQUIRED PROPERTY UnitType -> std::str {
          CREATE CONSTRAINT std::one_of('ABSORBEDDOSEUNIT', 'AMOUNTOFSUBSTANCEUNIT', 'AREAUNIT', 'DOSEEQUIVALENTUNIT', 'ELECTRICCAPACITANCEUNIT', 'ELECTRICCHARGEUNIT', 'ELECTRICCONDUCTANCEUNIT', 'ELECTRICCURRENTUNIT', 'ELECTRICRESISTANCEUNIT', 'ELECTRICVOLTAGEUNIT', 'ENERGYUNIT', 'FORCEUNIT', 'FREQUENCYUNIT', 'ILLUMINANCEUNIT', 'INDUCTANCEUNIT', 'LENGTHUNIT', 'LUMINOUSFLUXUNIT', 'LUMINOUSINTENSITYUNIT', 'MAGNETICFLUXDENSITYUNIT', 'MAGNETICFLUXUNIT', 'MASSUNIT', 'PLANEANGLEUNIT', 'POWERUNIT', 'PRESSUREUNIT', 'RADIOACTIVITYUNIT', 'SOLIDANGLEUNIT', 'THERMODYNAMICTEMPERATUREUNIT', 'TIMEUNIT', 'USERDEFINED', 'VOLUMEUNIT');
      };
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
  CREATE TYPE default::IfcMonetaryUnit {
      CREATE REQUIRED PROPERTY Currency -> std::str;
  };
  CREATE TYPE default::IfcUnit {
      CREATE LINK IfcUnit -> ((default::IfcNamedUnit | default::IfcMonetaryUnit) | default::IfcDerivedUnit);
  };
  CREATE ABSTRACT TYPE default::IfcMaterialDefinition;
  CREATE TYPE default::IfcMaterial EXTENDING default::IfcMaterialDefinition {
      CREATE PROPERTY Category -> std::str;
      CREATE PROPERTY Description -> std::str;
      CREATE REQUIRED PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcMaterialList {
      CREATE REQUIRED MULTI LINK Materials -> default::IfcMaterial;
  };
  CREATE ABSTRACT TYPE default::IfcMaterialUsageDefinition;
  CREATE TYPE default::IfcMaterialSelect {
      CREATE LINK IfcMaterialSelect -> ((default::IfcMaterialUsageDefinition | default::IfcMaterialDefinition) | default::IfcMaterialList);
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
  CREATE TYPE default::IfcOrganization {
      CREATE MULTI LINK Roles -> default::IfcActorRole;
      CREATE MULTI LINK Addresses -> default::IfcAddress;
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
  CREATE TYPE default::IfcPerson {
      CREATE MULTI LINK Roles -> default::IfcActorRole;
      CREATE MULTI LINK Addresses -> default::IfcAddress;
      CREATE PROPERTY FamilyName -> std::str;
      CREATE PROPERTY GivenName -> std::str;
      CREATE REQUIRED PROPERTY Identification -> std::str {
          CREATE CONSTRAINT std::exclusive;
      };
      CREATE PROPERTY MiddleNames -> tuple<std::str>;
      CREATE PROPERTY PrefixTitles -> tuple<std::str>;
      CREATE PROPERTY SuffixTitles -> tuple<std::str>;
  };
  CREATE TYPE default::IfcPersonAndOrganization {
      CREATE MULTI LINK Roles -> default::IfcActorRole;
      CREATE REQUIRED LINK TheOrganization -> default::IfcOrganization;
      CREATE REQUIRED LINK ThePerson -> default::IfcPerson;
  };
  CREATE TYPE default::IfcOwnerHistory {
      CREATE LINK LastModifyingApplication -> default::IfcApplication;
      CREATE REQUIRED LINK OwningApplication -> default::IfcApplication;
      CREATE LINK LastModifyingUser -> default::IfcPersonAndOrganization;
      CREATE REQUIRED LINK OwningUser -> default::IfcPersonAndOrganization;
      CREATE PROPERTY ChangeAction -> std::str {
          CREATE CONSTRAINT std::one_of('ADDED', 'DELETED', 'MODIFIED', 'NOCHANGE', 'NOTDEFINED');
      };
      CREATE REQUIRED PROPERTY CreationDate -> std::int64;
      CREATE PROPERTY LastModifiedDate -> std::int64;
      CREATE PROPERTY State -> std::str {
          CREATE CONSTRAINT std::one_of('LOCKED', 'READONLY', 'READONLYLOCKED', 'READWRITE', 'READWRITELOCKED');
      };
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
      CREATE LINK IfcDefinitionSelect -> (default::IfcPropertyDefinition | default::IfcObjectDefinition);
  };
  CREATE ABSTRACT TYPE default::IfcPropertySetDefinition EXTENDING default::IfcPropertyDefinition;
  CREATE TYPE default::IfcPropertySetDefinitionSet {
      CREATE REQUIRED MULTI LINK IfcPropertySetDefinitionSet -> default::IfcPropertySetDefinition;
  };
  CREATE TYPE default::IfcPropertySetDefinitionSelect {
      CREATE LINK IfcPropertySetDefinitionSelect -> (default::IfcPropertySetDefinitionSet | default::IfcPropertySetDefinition);
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
  CREATE ABSTRACT TYPE default::IfcCurve EXTENDING default::IfcGeometricRepresentationItem;
  CREATE TYPE default::IfcProfileDef {
      CREATE PROPERTY ProfileName -> std::str;
      CREATE REQUIRED PROPERTY ProfileType -> std::str {
          CREATE CONSTRAINT std::one_of('AREA', 'CURVE');
      };
  };
  CREATE TYPE default::IfcArbitraryClosedProfileDef EXTENDING default::IfcProfileDef {
      CREATE REQUIRED LINK OuterCurve -> default::IfcCurve;
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
  CREATE TYPE default::IfcRepresentationMap {
      CREATE REQUIRED LINK MappingOrigin -> default::IfcAxis2Placement;
      CREATE REQUIRED LINK MappedRepresentation -> default::IfcRepresentation;
  };
  CREATE ABSTRACT TYPE default::IfcObjectPlacement;
  CREATE TYPE default::IfcLocalPlacement EXTENDING default::IfcObjectPlacement {
      CREATE REQUIRED LINK RelativePlacement -> default::IfcAxis2Placement;
      CREATE LINK PlacementRelTo -> default::IfcObjectPlacement;
  };
  CREATE TYPE default::IfcGeometricRepresentationContext EXTENDING default::IfcRepresentationContext {
      CREATE LINK WorldCoordinateSystem -> default::IfcAxis2Placement;
      CREATE LINK TrueNorth -> default::IfcDirection;
      CREATE PROPERTY CoordinateSpaceDimension -> std::int64;
      CREATE PROPERTY Precision -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcParameterizedProfileDef EXTENDING default::IfcProfileDef {
      CREATE LINK Position -> default::IfcAxis2Placement2D;
  };
  CREATE TYPE default::IfcCircleProfileDef EXTENDING default::IfcParameterizedProfileDef {
      CREATE REQUIRED PROPERTY Radius -> std::float64;
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
  CREATE ABSTRACT TYPE default::IfcSolidModel EXTENDING default::IfcGeometricRepresentationItem;
  CREATE ABSTRACT TYPE default::IfcSweptAreaSolid EXTENDING default::IfcSolidModel {
      CREATE LINK Position -> default::IfcAxis2Placement3D;
      CREATE REQUIRED LINK SweptArea -> default::IfcProfileDef;
  };
  CREATE TYPE default::IfcExtrudedAreaSolid EXTENDING default::IfcSweptAreaSolid {
      CREATE REQUIRED LINK ExtrudedDirection -> default::IfcDirection;
      CREATE REQUIRED PROPERTY Depth -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcObject EXTENDING default::IfcObjectDefinition {
      CREATE PROPERTY ObjectType -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcProductRepresentation {
      CREATE REQUIRED MULTI LINK Representations -> default::IfcRepresentation;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcProduct EXTENDING default::IfcObject {
      CREATE LINK ObjectPlacement -> default::IfcObjectPlacement;
      CREATE LINK Representation -> default::IfcProductRepresentation;
  };
  CREATE ABSTRACT TYPE default::IfcElement EXTENDING default::IfcProduct {
      CREATE PROPERTY Tag -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcBuildingElement EXTENDING default::IfcElement;
  CREATE TYPE default::IfcBeam EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BEAM', 'HOLLOWCORE', 'JOIST', 'LINTEL', 'NOTDEFINED', 'SPANDREL', 'T_BEAM', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcTypeObject EXTENDING default::IfcObjectDefinition {
      CREATE MULTI LINK HasPropertySets -> default::IfcPropertySetDefinition;
      CREATE PROPERTY ApplicableOccurrence -> std::str;
  };
  CREATE TYPE default::IfcTypeProduct EXTENDING default::IfcTypeObject {
      CREATE MULTI LINK RepresentationMaps -> default::IfcRepresentationMap;
      CREATE PROPERTY Tag -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcElementType EXTENDING default::IfcTypeProduct {
      CREATE PROPERTY ElementType -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcBuildingElementType EXTENDING default::IfcElementType;
  CREATE TYPE default::IfcBeamType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BEAM', 'HOLLOWCORE', 'JOIST', 'LINTEL', 'NOTDEFINED', 'SPANDREL', 'T_BEAM', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcBoundedCurve EXTENDING default::IfcCurve;
  CREATE TYPE default::IfcIndexedPolyCurve EXTENDING default::IfcBoundedCurve {
      CREATE REQUIRED LINK Points -> default::IfcCartesianPointList;
      CREATE MULTI LINK Segments -> default::IfcSegmentIndexSelect;
      CREATE PROPERTY SelfIntersect -> std::bool;
  };
  CREATE TYPE default::IfcPolyline EXTENDING default::IfcBoundedCurve {
      CREATE REQUIRED MULTI LINK Points -> default::IfcCartesianPoint;
  };
  CREATE ABSTRACT TYPE default::IfcSpatialElement EXTENDING default::IfcProduct {
      CREATE PROPERTY LongName -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcSpatialStructureElement EXTENDING default::IfcSpatialElement {
      CREATE PROPERTY CompositionType -> std::str {
          CREATE CONSTRAINT std::one_of('COMPLEX', 'ELEMENT', 'PARTIAL');
      };
  };
  CREATE TYPE default::IfcBuildingStorey EXTENDING default::IfcSpatialStructureElement {
      CREATE PROPERTY Elevation -> std::float64;
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
  CREATE TYPE default::IfcProject EXTENDING default::IfcContext;
  CREATE TYPE default::IfcMeasureWithUnit {
      CREATE REQUIRED LINK UnitComponent -> default::IfcUnit;
      CREATE REQUIRED LINK ValueComponent -> default::IfcValue;
  };
  CREATE TYPE default::IfcConversionBasedUnit EXTENDING default::IfcNamedUnit {
      CREATE REQUIRED LINK ConversionFactor -> default::IfcMeasureWithUnit;
      CREATE REQUIRED PROPERTY Name -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcRelationship EXTENDING default::IfcRoot;
  CREATE ABSTRACT TYPE default::IfcRelAssociates EXTENDING default::IfcRelationship {
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcDefinitionSelect;
  };
  CREATE TYPE default::IfcRelAssociatesMaterial EXTENDING default::IfcRelAssociates {
      CREATE REQUIRED LINK RelatingMaterial -> default::IfcMaterialSelect;
  };
  CREATE TYPE default::IfcSIUnit EXTENDING default::IfcNamedUnit {
      CREATE REQUIRED PROPERTY Name -> std::str {
          CREATE CONSTRAINT std::one_of('AMPERE', 'BECQUEREL', 'CANDELA', 'COULOMB', 'CUBIC_METRE', 'DEGREE_CELSIUS', 'FARAD', 'GRAM', 'GRAY', 'HENRY', 'HERTZ', 'JOULE', 'KELVIN', 'LUMEN', 'LUX', 'METRE', 'MOLE', 'NEWTON', 'OHM', 'PASCAL', 'RADIAN', 'SECOND', 'SIEMENS', 'SIEVERT', 'SQUARE_METRE', 'STERADIAN', 'TESLA', 'VOLT', 'WATT', 'WEBER');
      };
      CREATE PROPERTY Prefix -> std::str {
          CREATE CONSTRAINT std::one_of('ATTO', 'CENTI', 'DECA', 'DECI', 'EXA', 'FEMTO', 'GIGA', 'HECTO', 'KILO', 'MEGA', 'MICRO', 'MILLI', 'NANO', 'PETA', 'PICO', 'TERA');
      };
  };
  CREATE ABSTRACT TYPE default::IfcFeatureElement EXTENDING default::IfcElement;
  CREATE ABSTRACT TYPE default::IfcFeatureElementSubtraction EXTENDING default::IfcFeatureElement;
  CREATE TYPE default::IfcOpeningElement EXTENDING default::IfcFeatureElementSubtraction {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'OPENING', 'RECESS', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcRelDecomposes EXTENDING default::IfcRelationship;
  CREATE TYPE default::IfcRelVoidsElement EXTENDING default::IfcRelDecomposes {
      CREATE REQUIRED LINK RelatingBuildingElement -> default::IfcElement;
      CREATE REQUIRED LINK RelatedOpeningElement -> default::IfcFeatureElementSubtraction;
  };
  CREATE ABSTRACT TYPE default::IfcPropertyAbstraction;
  CREATE ABSTRACT TYPE default::IfcProperty EXTENDING default::IfcPropertyAbstraction {
      CREATE PROPERTY Description -> std::str;
      CREATE REQUIRED PROPERTY Name -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcExtendedProperties EXTENDING default::IfcPropertyAbstraction {
      CREATE REQUIRED MULTI LINK Properties -> default::IfcProperty;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcMaterialProperties EXTENDING default::IfcExtendedProperties {
      CREATE REQUIRED LINK Material -> default::IfcMaterialDefinition;
  };
  CREATE TYPE default::IfcMaterialProfileSetUsage EXTENDING default::IfcMaterialUsageDefinition {
      CREATE REQUIRED LINK ForProfileSet -> default::IfcMaterialProfileSet;
      CREATE PROPERTY CardinalPoint -> std::int64;
      CREATE PROPERTY ReferenceExtent -> std::float64;
  };
  CREATE TYPE default::IfcSite EXTENDING default::IfcSpatialStructureElement {
      CREATE LINK SiteAddress -> default::IfcPostalAddress;
      CREATE PROPERTY LandTitleNumber -> std::str;
      CREATE PROPERTY RefElevation -> std::float64;
      CREATE PROPERTY RefLatitude -> std::int64;
      CREATE PROPERTY RefLongitude -> std::int64;
  };
  CREATE ABSTRACT TYPE default::IfcRelDefines EXTENDING default::IfcRelationship;
  CREATE TYPE default::IfcRelDefinesByType EXTENDING default::IfcRelDefines {
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcObject;
      CREATE REQUIRED LINK RelatingType -> default::IfcTypeObject;
  };
  CREATE TYPE default::IfcRelAggregates EXTENDING default::IfcRelDecomposes {
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcObjectDefinition;
      CREATE REQUIRED LINK RelatingObject -> default::IfcObjectDefinition;
  };
  CREATE TYPE default::IfcRelDefinesByProperties EXTENDING default::IfcRelDefines {
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcObjectDefinition;
      CREATE REQUIRED LINK RelatingPropertyDefinition -> default::IfcPropertySetDefinitionSelect;
  };
  CREATE TYPE default::IfcPropertySet EXTENDING default::IfcPropertySetDefinition {
      CREATE REQUIRED MULTI LINK HasProperties -> default::IfcProperty;
  };
  CREATE ABSTRACT TYPE default::IfcRelConnects EXTENDING default::IfcRelationship;
  CREATE TYPE default::IfcRelContainedInSpatialStructure EXTENDING default::IfcRelConnects {
      CREATE REQUIRED MULTI LINK RelatedElements -> default::IfcProduct;
      CREATE REQUIRED LINK RelatingStructure -> default::IfcSpatialElement;
  };
  CREATE TYPE default::IfcProductDefinitionShape EXTENDING default::IfcProductRepresentation;
  CREATE ABSTRACT TYPE default::IfcSimpleProperty EXTENDING default::IfcProperty;
  CREATE TYPE default::IfcPropertySingleValue EXTENDING default::IfcSimpleProperty {
      CREATE LINK NominalValue -> default::IfcValue;
      CREATE LINK Unit -> default::IfcUnit;
  };
  CREATE ABSTRACT TYPE default::IfcShapeModel EXTENDING default::IfcRepresentation;
  CREATE TYPE default::IfcShapeRepresentation EXTENDING default::IfcShapeModel;
};

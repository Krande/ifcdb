CREATE MIGRATION m1abjpm3qtvsqgce47rrxtubhwp6rcyb22ch5rdjrp2hh3dgd4kqwa
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
  CREATE TYPE default::IfcLineIndex {
      CREATE REQUIRED PROPERTY IfcLineIndex -> array<std::int64>;
  };
  CREATE TYPE default::IfcAbsorbedDoseMeasure {
      CREATE REQUIRED PROPERTY IfcAbsorbedDoseMeasure -> std::float64;
  };
  CREATE TYPE default::IfcAccelerationMeasure {
      CREATE REQUIRED PROPERTY IfcAccelerationMeasure -> std::float64;
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
  CREATE TYPE default::IfcAmountOfSubstanceMeasure {
      CREATE REQUIRED PROPERTY IfcAmountOfSubstanceMeasure -> std::float64;
  };
  CREATE TYPE default::IfcAngularVelocityMeasure {
      CREATE REQUIRED PROPERTY IfcAngularVelocityMeasure -> std::float64;
  };
  CREATE TYPE default::IfcArcIndex {
      CREATE REQUIRED PROPERTY IfcArcIndex -> tuple<std::int64, std::int64, std::int64>;
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
};

CREATE MIGRATION m1qcmri7z56hdbcrjdtacb3jwzb7jel4pdgtljsuwyaiaq3n5iei6a
    ONTO m1abjpm3qtvsqgce47rrxtubhwp6rcyb22ch5rdjrp2hh3dgd4kqwa
{
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
  CREATE TYPE default::IfcNonNegativeLengthMeasure {
      CREATE REQUIRED PROPERTY IfcNonNegativeLengthMeasure -> std::float64;
  };
  CREATE TYPE default::IfcNormalisedRatioMeasure {
      CREATE REQUIRED PROPERTY IfcNormalisedRatioMeasure -> std::float64;
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
  CREATE TYPE default::IfcProfileDef {
      CREATE PROPERTY ProfileName -> std::str;
      CREATE REQUIRED PROPERTY ProfileType -> std::str {
          CREATE CONSTRAINT std::one_of('AREA', 'CURVE');
      };
  };
  CREATE ABSTRACT TYPE default::IfcPropertyAbstraction;
  CREATE TYPE default::IfcRadioActivityMeasure {
      CREATE REQUIRED PROPERTY IfcRadioActivityMeasure -> std::float64;
  };
  CREATE TYPE default::IfcRatioMeasure {
      CREATE REQUIRED PROPERTY IfcRatioMeasure -> std::float64;
  };
  CREATE TYPE default::IfcReal {
      CREATE REQUIRED PROPERTY IfcReal -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcRepresentationContext {
      CREATE PROPERTY ContextIdentifier -> std::str;
      CREATE PROPERTY ContextType -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcRepresentationItem;
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
};

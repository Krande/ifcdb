CREATE MIGRATION m1us5wx72yww6nxr4sy43f5stydhbtufd5vwuaycwe3nnyjauggera
    ONTO m1qrqf5nwnblup7zfuc75y7ho4ttv5lb7vwoaixcqmiiqsy3mvflyq
{
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
      CREATE LINK IfcDerivedMeasureValue -> ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((default::IfcPlanarForceMeasure | default::IfcLinearForceMeasure) | default::IfcElectricResistanceMeasure) | default::IfcSoundPowerMeasure) | default::IfcEnergyMeasure) | default::IfcLuminousFluxMeasure) | default::IfcInductanceMeasure) | default::IfcElectricConductanceMeasure) | default::IfcSectionModulusMeasure) | default::IfcThermalResistanceMeasure) | default::IfcThermalTransmittanceMeasure) | default::IfcWarpingMomentMeasure) | default::IfcDynamicViscosityMeasure) | default::IfcIntegerCountRateMeasure) | default::IfcModulusOfRotationalSubgradeReactionMeasure) | default::IfcPowerMeasure) | default::IfcShearModulusMeasure) | default::IfcAngularVelocityMeasure) | default::IfcSoundPressureMeasure) | default::IfcSoundPowerLevelMeasure) | default::IfcRadioActivityMeasure) | default::IfcLinearMomentMeasure) | default::IfcWarpingConstantMeasure) | default::IfcDoseEquivalentMeasure) | default::IfcMoistureDiffusivityMeasure) | default::IfcPHMeasure) | default::IfcRotationalStiffnessMeasure) | default::IfcSectionalAreaIntegralMeasure) | default::IfcMomentOfInertiaMeasure) | default::IfcMassPerLengthMeasure) | default::IfcModulusOfLinearSubgradeReactionMeasure) | default::IfcLinearStiffnessMeasure) | default::IfcThermalAdmittanceMeasure) | default::IfcIlluminanceMeasure) | default::IfcMonetaryMeasure) | default::IfcTemperatureRateOfChangeMeasure) | default::IfcRotationalFrequencyMeasure) | default::IfcMagneticFluxMeasure) | default::IfcThermalConductivityMeasure) | default::IfcMagneticFluxDensityMeasure) | default::IfcKinematicViscosityMeasure) | default::IfcRotationalMassMeasure) | default::IfcForceMeasure) | default::IfcAbsorbedDoseMeasure) | default::IfcIonConcentrationMeasure) | default::IfcAccelerationMeasure) | default::IfcLuminousIntensityDistributionMeasure) | default::IfcSoundPressureLevelMeasure) | default::IfcCurvatureMeasure) | default::IfcThermalExpansionCoefficientMeasure) | default::IfcAreaDensityMeasure) | default::IfcTorqueMeasure) | default::IfcLinearVelocityMeasure) | default::IfcCompoundPlaneAngleMeasure) | default::IfcMassDensityMeasure) | default::IfcElectricChargeMeasure) | default::IfcMolecularWeightMeasure) | default::IfcElectricVoltageMeasure) | default::IfcPressureMeasure) | default::IfcFrequencyMeasure) | default::IfcHeatingValueMeasure) | default::IfcHeatFluxDensityMeasure) | default::IfcVolumetricFlowRateMeasure) | default::IfcModulusOfSubgradeReactionMeasure) | default::IfcTemperatureGradientMeasure) | default::IfcElectricCapacitanceMeasure) | default::IfcIsothermalMoistureCapacityMeasure) | default::IfcSpecificHeatCapacityMeasure) | default::IfcModulusOfElasticityMeasure) | default::IfcVaporPermeabilityMeasure) | default::IfcMassFlowRateMeasure);
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
      CREATE LINK IfcMeasureValue -> ((((((((((((((((((((((default::IfcPositiveRatioMeasure | default::IfcAreaMeasure) | default::IfcAmountOfSubstanceMeasure) | default::IfcCountMeasure) | default::IfcLuminousIntensityMeasure) | default::IfcSolidAngleMeasure) | default::IfcNonNegativeLengthMeasure) | default::IfcElectricCurrentMeasure) | default::IfcLengthMeasure) | default::IfcPlaneAngleMeasure) | default::IfcNormalisedRatioMeasure) | default::IfcContextDependentMeasure) | default::IfcMassMeasure) | default::IfcComplexNumber) | default::IfcNumericMeasure) | default::IfcVolumeMeasure) | default::IfcDescriptiveMeasure) | default::IfcPositivePlaneAngleMeasure) | default::IfcTimeMeasure) | default::IfcParameterValue) | default::IfcPositiveLengthMeasure) | default::IfcThermodynamicTemperatureMeasure) | default::IfcRatioMeasure);
  };
  CREATE TYPE default::IfcArcIndex {
      CREATE REQUIRED PROPERTY IfcArcIndex -> tuple<std::int64, std::int64, std::int64>;
  };
  CREATE TYPE default::IfcLineIndex {
      CREATE REQUIRED PROPERTY IfcLineIndex -> tuple<std::int64, std::int64>;
  };
  CREATE TYPE default::IfcSegmentIndexSelect {
      CREATE LINK IfcSegmentIndexSelect -> (default::IfcLineIndex | default::IfcArcIndex);
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
      CREATE LINK IfcSimpleValue -> (((((((((((((default::IfcDate | default::IfcTime) | default::IfcLogical) | default::IfcIdentifier) | default::IfcText) | default::IfcBoolean) | default::IfcDateTime) | default::IfcInteger) | default::IfcLabel) | default::IfcTimeStamp) | default::IfcPositiveInteger) | default::IfcBinary) | default::IfcDuration) | default::IfcReal);
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
  CREATE TYPE default::IfcPerson {
      CREATE MULTI LINK Roles -> default::IfcActorRole;
      CREATE MULTI LINK Addresses -> default::IfcAddress;
      CREATE PROPERTY FamilyName -> std::str;
      CREATE PROPERTY GivenName -> std::str;
      CREATE PROPERTY Identification -> std::str;
      CREATE PROPERTY MiddleNames -> tuple<std::str>;
      CREATE PROPERTY PrefixTitles -> tuple<std::str>;
      CREATE PROPERTY SuffixTitles -> tuple<std::str>;
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
  CREATE ABSTRACT TYPE default::IfcGeometricRepresentationItem EXTENDING default::IfcRepresentationItem;
  CREATE ABSTRACT TYPE default::IfcCartesianPointList EXTENDING default::IfcGeometricRepresentationItem;
  CREATE TYPE default::IfcProfileDef {
      CREATE PROPERTY ProfileName -> std::str;
      CREATE REQUIRED PROPERTY ProfileType -> std::str {
          CREATE CONSTRAINT std::one_of('AREA', 'CURVE');
      };
  };
  CREATE TYPE default::IfcCompositeProfileDef EXTENDING default::IfcProfileDef {
      CREATE REQUIRED MULTI LINK Profiles -> default::IfcProfileDef;
      CREATE PROPERTY Label -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcCurve EXTENDING default::IfcGeometricRepresentationItem;
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
  CREATE TYPE default::IfcDirection EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED PROPERTY DirectionRatios -> array<std::float64> {
          CREATE CONSTRAINT std::expression ON (((std::len(__subject__) = 2) OR (std::len(__subject__) = 3)));
      };
  };
  CREATE ABSTRACT TYPE default::IfcProperty EXTENDING default::IfcPropertyAbstraction {
      CREATE PROPERTY Description -> std::str;
      CREATE REQUIRED PROPERTY Name -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcExtendedProperties EXTENDING default::IfcPropertyAbstraction {
      CREATE REQUIRED MULTI LINK Properties -> default::IfcProperty;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcPoint EXTENDING default::IfcGeometricRepresentationItem;
  CREATE ABSTRACT TYPE default::IfcTopologicalRepresentationItem EXTENDING default::IfcRepresentationItem;
  CREATE TYPE default::IfcLoop EXTENDING default::IfcTopologicalRepresentationItem;
  CREATE TYPE default::IfcMaterial EXTENDING default::IfcMaterialDefinition {
      CREATE PROPERTY Category -> std::str;
      CREATE PROPERTY Description -> std::str;
      CREATE REQUIRED PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcMaterialProfile EXTENDING default::IfcMaterialDefinition {
      CREATE LINK Material -> default::IfcMaterial;
      CREATE REQUIRED LINK Profile -> default::IfcProfileDef;
      CREATE PROPERTY Category -> std::str;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Name -> std::str;
      CREATE PROPERTY Priority -> std::int64;
  };
  CREATE TYPE default::IfcMaterialList {
      CREATE REQUIRED MULTI LINK Materials -> default::IfcMaterial;
  };
  CREATE TYPE default::IfcSIUnit EXTENDING default::IfcNamedUnit {
      CREATE REQUIRED PROPERTY Name -> std::str {
          CREATE CONSTRAINT std::one_of('AMPERE', 'BECQUEREL', 'CANDELA', 'COULOMB', 'CUBIC_METRE', 'DEGREE_CELSIUS', 'FARAD', 'GRAM', 'GRAY', 'HENRY', 'HERTZ', 'JOULE', 'KELVIN', 'LUMEN', 'LUX', 'METRE', 'MOLE', 'NEWTON', 'OHM', 'PASCAL', 'RADIAN', 'SECOND', 'SIEMENS', 'SIEVERT', 'SQUARE_METRE', 'STERADIAN', 'TESLA', 'VOLT', 'WATT', 'WEBER');
      };
      CREATE PROPERTY Prefix -> std::str {
          CREATE CONSTRAINT std::one_of('ATTO', 'CENTI', 'DECA', 'DECI', 'EXA', 'FEMTO', 'GIGA', 'HECTO', 'KILO', 'MEGA', 'MICRO', 'MILLI', 'NANO', 'PETA', 'PICO', 'TERA');
      };
  };
  CREATE ABSTRACT TYPE default::IfcRepresentation {
      CREATE REQUIRED LINK ContextOfItems -> default::IfcRepresentationContext;
      CREATE REQUIRED MULTI LINK Items -> default::IfcRepresentationItem;
      CREATE PROPERTY RepresentationIdentifier -> std::str;
      CREATE PROPERTY RepresentationType -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcProductRepresentation {
      CREATE REQUIRED MULTI LINK Representations -> default::IfcRepresentation;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Name -> std::str;
  };
};

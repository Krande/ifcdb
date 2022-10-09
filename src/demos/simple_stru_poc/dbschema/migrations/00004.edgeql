CREATE MIGRATION m1epyhqgburlntfsxcq465coxnysxie3vh2wafu6lqb7ii3rbrszka
    ONTO m1lk7xseomfz5wszv4s24ri3nitw4hfu2qoxp73khzvsnrnspfgj7a
{
  CREATE TYPE default::IfcPropertyListValue EXTENDING default::IfcSimpleProperty {
      CREATE MULTI LINK ListValues -> (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((default::IfcPlanarForceMeasure | default::IfcDateTime) | default::IfcBinary) | default::IfcIsothermalMoistureCapacityMeasure) | default::IfcVaporPermeabilityMeasure) | default::IfcElectricVoltageMeasure) | default::IfcLinearMomentMeasure) | default::IfcDuration) | default::IfcTorqueMeasure) | default::IfcMoistureDiffusivityMeasure) | default::IfcAccelerationMeasure) | default::IfcSolidAngleMeasure) | default::IfcThermalAdmittanceMeasure) | default::IfcPowerMeasure) | default::IfcRotationalStiffnessMeasure) | default::IfcElectricResistanceMeasure) | default::IfcSpecificHeatCapacityMeasure) | default::IfcDate) | default::IfcTime) | default::IfcMagneticFluxDensityMeasure) | default::IfcIdentifier) | default::IfcMassPerLengthMeasure) | default::IfcElectricCurrentMeasure) | default::IfcLuminousIntensityDistributionMeasure) | default::IfcVolumetricFlowRateMeasure) | default::IfcForceMeasure) | default::IfcPositiveInteger) | default::IfcSoundPressureMeasure) | default::IfcModulusOfElasticityMeasure) | default::IfcLinearStiffnessMeasure) | default::IfcBoolean) | default::IfcComplexNumber) | default::IfcAreaMeasure) | default::IfcModulusOfLinearSubgradeReactionMeasure) | default::IfcSoundPowerLevelMeasure) | default::IfcTimeMeasure) | default::IfcLengthMeasure) | default::IfcThermalTransmittanceMeasure) | default::IfcWarpingMomentMeasure) | default::IfcLuminousIntensityMeasure) | default::IfcPositivePlaneAngleMeasure) | default::IfcMolecularWeightMeasure) | default::IfcElectricConductanceMeasure) | default::IfcElectricCapacitanceMeasure) | default::IfcPositiveRatioMeasure) | default::IfcPHMeasure) | default::IfcText) | default::IfcInductanceMeasure) | default::IfcThermalExpansionCoefficientMeasure) | default::IfcModulusOfSubgradeReactionMeasure) | default::IfcSectionalAreaIntegralMeasure) | default::IfcAbsorbedDoseMeasure) | default::IfcVolumeMeasure) | default::IfcIntegerCountRateMeasure) | default::IfcThermalConductivityMeasure) | default::IfcLuminousFluxMeasure) | default::IfcDynamicViscosityMeasure) | default::IfcCurvatureMeasure) | default::IfcSoundPressureLevelMeasure) | default::IfcHeatFluxDensityMeasure) | default::IfcRadioActivityMeasure) | default::IfcHeatingValueMeasure) | default::IfcIlluminanceMeasure) | default::IfcLogical) | default::IfcPlaneAngleMeasure) | default::IfcLabel) | default::IfcElectricChargeMeasure) | default::IfcAngularVelocityMeasure) | default::IfcFrequencyMeasure) | default::IfcKinematicViscosityMeasure) | default::IfcMagneticFluxMeasure) | default::IfcNumericMeasure) | default::IfcThermodynamicTemperatureMeasure) | default::IfcIonConcentrationMeasure) | default::IfcNonNegativeLengthMeasure) | default::IfcMonetaryMeasure) | default::IfcDoseEquivalentMeasure) | default::IfcRotationalFrequencyMeasure) | default::IfcWarpingConstantMeasure) | default::IfcParameterValue) | default::IfcDescriptiveMeasure) | default::IfcTemperatureRateOfChangeMeasure) | default::IfcAreaDensityMeasure) | default::IfcTemperatureGradientMeasure) | default::IfcSoundPowerMeasure) | default::IfcSectionModulusMeasure) | default::IfcReal) | default::IfcLinearForceMeasure) | default::IfcAmountOfSubstanceMeasure) | default::IfcContextDependentMeasure) | default::IfcRotationalMassMeasure) | default::IfcCountMeasure) | default::IfcMomentOfInertiaMeasure) | default::IfcInteger) | default::IfcPositiveLengthMeasure) | default::IfcEnergyMeasure) | default::IfcThermalResistanceMeasure) | default::IfcMassMeasure) | default::IfcShearModulusMeasure) | default::IfcModulusOfRotationalSubgradeReactionMeasure) | default::IfcRatioMeasure) | default::IfcNormalisedRatioMeasure) | default::IfcLinearVelocityMeasure) | default::IfcMassFlowRateMeasure) | default::IfcTimeStamp) | default::IfcMassDensityMeasure) | default::IfcCompoundPlaneAngleMeasure) | default::IfcPressureMeasure);
      CREATE LINK Unit -> ((default::IfcNamedUnit | default::IfcMonetaryUnit) | default::IfcDerivedUnit);
  };
  CREATE TYPE default::IfcPropertySingleValue EXTENDING default::IfcSimpleProperty {
      CREATE LINK NominalValue -> (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((default::IfcPlanarForceMeasure | default::IfcDateTime) | default::IfcBinary) | default::IfcIsothermalMoistureCapacityMeasure) | default::IfcVaporPermeabilityMeasure) | default::IfcElectricVoltageMeasure) | default::IfcLinearMomentMeasure) | default::IfcDuration) | default::IfcTorqueMeasure) | default::IfcMoistureDiffusivityMeasure) | default::IfcAccelerationMeasure) | default::IfcSolidAngleMeasure) | default::IfcThermalAdmittanceMeasure) | default::IfcPowerMeasure) | default::IfcRotationalStiffnessMeasure) | default::IfcElectricResistanceMeasure) | default::IfcSpecificHeatCapacityMeasure) | default::IfcDate) | default::IfcTime) | default::IfcMagneticFluxDensityMeasure) | default::IfcIdentifier) | default::IfcMassPerLengthMeasure) | default::IfcElectricCurrentMeasure) | default::IfcLuminousIntensityDistributionMeasure) | default::IfcVolumetricFlowRateMeasure) | default::IfcForceMeasure) | default::IfcPositiveInteger) | default::IfcSoundPressureMeasure) | default::IfcModulusOfElasticityMeasure) | default::IfcLinearStiffnessMeasure) | default::IfcBoolean) | default::IfcComplexNumber) | default::IfcAreaMeasure) | default::IfcModulusOfLinearSubgradeReactionMeasure) | default::IfcSoundPowerLevelMeasure) | default::IfcTimeMeasure) | default::IfcLengthMeasure) | default::IfcThermalTransmittanceMeasure) | default::IfcWarpingMomentMeasure) | default::IfcLuminousIntensityMeasure) | default::IfcPositivePlaneAngleMeasure) | default::IfcMolecularWeightMeasure) | default::IfcElectricConductanceMeasure) | default::IfcElectricCapacitanceMeasure) | default::IfcPositiveRatioMeasure) | default::IfcPHMeasure) | default::IfcText) | default::IfcInductanceMeasure) | default::IfcThermalExpansionCoefficientMeasure) | default::IfcModulusOfSubgradeReactionMeasure) | default::IfcSectionalAreaIntegralMeasure) | default::IfcAbsorbedDoseMeasure) | default::IfcVolumeMeasure) | default::IfcIntegerCountRateMeasure) | default::IfcThermalConductivityMeasure) | default::IfcLuminousFluxMeasure) | default::IfcDynamicViscosityMeasure) | default::IfcCurvatureMeasure) | default::IfcSoundPressureLevelMeasure) | default::IfcHeatFluxDensityMeasure) | default::IfcRadioActivityMeasure) | default::IfcHeatingValueMeasure) | default::IfcIlluminanceMeasure) | default::IfcLogical) | default::IfcPlaneAngleMeasure) | default::IfcLabel) | default::IfcElectricChargeMeasure) | default::IfcAngularVelocityMeasure) | default::IfcFrequencyMeasure) | default::IfcKinematicViscosityMeasure) | default::IfcMagneticFluxMeasure) | default::IfcNumericMeasure) | default::IfcThermodynamicTemperatureMeasure) | default::IfcIonConcentrationMeasure) | default::IfcNonNegativeLengthMeasure) | default::IfcMonetaryMeasure) | default::IfcDoseEquivalentMeasure) | default::IfcRotationalFrequencyMeasure) | default::IfcWarpingConstantMeasure) | default::IfcParameterValue) | default::IfcDescriptiveMeasure) | default::IfcTemperatureRateOfChangeMeasure) | default::IfcAreaDensityMeasure) | default::IfcTemperatureGradientMeasure) | default::IfcSoundPowerMeasure) | default::IfcSectionModulusMeasure) | default::IfcReal) | default::IfcLinearForceMeasure) | default::IfcAmountOfSubstanceMeasure) | default::IfcContextDependentMeasure) | default::IfcRotationalMassMeasure) | default::IfcCountMeasure) | default::IfcMomentOfInertiaMeasure) | default::IfcInteger) | default::IfcPositiveLengthMeasure) | default::IfcEnergyMeasure) | default::IfcThermalResistanceMeasure) | default::IfcMassMeasure) | default::IfcShearModulusMeasure) | default::IfcModulusOfRotationalSubgradeReactionMeasure) | default::IfcRatioMeasure) | default::IfcNormalisedRatioMeasure) | default::IfcLinearVelocityMeasure) | default::IfcMassFlowRateMeasure) | default::IfcTimeStamp) | default::IfcMassDensityMeasure) | default::IfcCompoundPlaneAngleMeasure) | default::IfcPressureMeasure);
      CREATE LINK Unit -> ((default::IfcNamedUnit | default::IfcMonetaryUnit) | default::IfcDerivedUnit);
  };
  CREATE TYPE default::IfcMeasureWithUnit {
      CREATE REQUIRED LINK ValueComponent -> (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((default::IfcPlanarForceMeasure | default::IfcDateTime) | default::IfcBinary) | default::IfcIsothermalMoistureCapacityMeasure) | default::IfcVaporPermeabilityMeasure) | default::IfcElectricVoltageMeasure) | default::IfcLinearMomentMeasure) | default::IfcDuration) | default::IfcTorqueMeasure) | default::IfcMoistureDiffusivityMeasure) | default::IfcAccelerationMeasure) | default::IfcSolidAngleMeasure) | default::IfcThermalAdmittanceMeasure) | default::IfcPowerMeasure) | default::IfcRotationalStiffnessMeasure) | default::IfcElectricResistanceMeasure) | default::IfcSpecificHeatCapacityMeasure) | default::IfcDate) | default::IfcTime) | default::IfcMagneticFluxDensityMeasure) | default::IfcIdentifier) | default::IfcMassPerLengthMeasure) | default::IfcElectricCurrentMeasure) | default::IfcLuminousIntensityDistributionMeasure) | default::IfcVolumetricFlowRateMeasure) | default::IfcForceMeasure) | default::IfcPositiveInteger) | default::IfcSoundPressureMeasure) | default::IfcModulusOfElasticityMeasure) | default::IfcLinearStiffnessMeasure) | default::IfcBoolean) | default::IfcComplexNumber) | default::IfcAreaMeasure) | default::IfcModulusOfLinearSubgradeReactionMeasure) | default::IfcSoundPowerLevelMeasure) | default::IfcTimeMeasure) | default::IfcLengthMeasure) | default::IfcThermalTransmittanceMeasure) | default::IfcWarpingMomentMeasure) | default::IfcLuminousIntensityMeasure) | default::IfcPositivePlaneAngleMeasure) | default::IfcMolecularWeightMeasure) | default::IfcElectricConductanceMeasure) | default::IfcElectricCapacitanceMeasure) | default::IfcPositiveRatioMeasure) | default::IfcPHMeasure) | default::IfcText) | default::IfcInductanceMeasure) | default::IfcThermalExpansionCoefficientMeasure) | default::IfcModulusOfSubgradeReactionMeasure) | default::IfcSectionalAreaIntegralMeasure) | default::IfcAbsorbedDoseMeasure) | default::IfcVolumeMeasure) | default::IfcIntegerCountRateMeasure) | default::IfcThermalConductivityMeasure) | default::IfcLuminousFluxMeasure) | default::IfcDynamicViscosityMeasure) | default::IfcCurvatureMeasure) | default::IfcSoundPressureLevelMeasure) | default::IfcHeatFluxDensityMeasure) | default::IfcRadioActivityMeasure) | default::IfcHeatingValueMeasure) | default::IfcIlluminanceMeasure) | default::IfcLogical) | default::IfcPlaneAngleMeasure) | default::IfcLabel) | default::IfcElectricChargeMeasure) | default::IfcAngularVelocityMeasure) | default::IfcFrequencyMeasure) | default::IfcKinematicViscosityMeasure) | default::IfcMagneticFluxMeasure) | default::IfcNumericMeasure) | default::IfcThermodynamicTemperatureMeasure) | default::IfcIonConcentrationMeasure) | default::IfcNonNegativeLengthMeasure) | default::IfcMonetaryMeasure) | default::IfcDoseEquivalentMeasure) | default::IfcRotationalFrequencyMeasure) | default::IfcWarpingConstantMeasure) | default::IfcParameterValue) | default::IfcDescriptiveMeasure) | default::IfcTemperatureRateOfChangeMeasure) | default::IfcAreaDensityMeasure) | default::IfcTemperatureGradientMeasure) | default::IfcSoundPowerMeasure) | default::IfcSectionModulusMeasure) | default::IfcReal) | default::IfcLinearForceMeasure) | default::IfcAmountOfSubstanceMeasure) | default::IfcContextDependentMeasure) | default::IfcRotationalMassMeasure) | default::IfcCountMeasure) | default::IfcMomentOfInertiaMeasure) | default::IfcInteger) | default::IfcPositiveLengthMeasure) | default::IfcEnergyMeasure) | default::IfcThermalResistanceMeasure) | default::IfcMassMeasure) | default::IfcShearModulusMeasure) | default::IfcModulusOfRotationalSubgradeReactionMeasure) | default::IfcRatioMeasure) | default::IfcNormalisedRatioMeasure) | default::IfcLinearVelocityMeasure) | default::IfcMassFlowRateMeasure) | default::IfcTimeStamp) | default::IfcMassDensityMeasure) | default::IfcCompoundPlaneAngleMeasure) | default::IfcPressureMeasure);
      CREATE REQUIRED LINK UnitComponent -> ((default::IfcNamedUnit | default::IfcMonetaryUnit) | default::IfcDerivedUnit);
  };
  CREATE TYPE default::IfcIndexedPolyCurve EXTENDING default::IfcBoundedCurve {
      CREATE MULTI LINK Segments -> (default::IfcLineIndex | default::IfcArcIndex);
      CREATE REQUIRED LINK Points -> default::IfcCartesianPointList;
      CREATE PROPERTY SelfIntersect -> std::bool;
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
  CREATE TYPE default::IfcRepresentationMap {
      CREATE REQUIRED LINK MappingOrigin -> (default::IfcAxis2Placement3D | default::IfcAxis2Placement2D);
      CREATE REQUIRED LINK MappedRepresentation -> default::IfcRepresentation;
  };
  CREATE TYPE default::IfcLocalPlacement EXTENDING default::IfcObjectPlacement {
      CREATE REQUIRED LINK RelativePlacement -> (default::IfcAxis2Placement3D | default::IfcAxis2Placement2D);
      CREATE LINK PlacementRelTo -> default::IfcObjectPlacement;
  };
  CREATE TYPE default::IfcGeometricRepresentationContext EXTENDING default::IfcRepresentationContext {
      CREATE LINK WorldCoordinateSystem -> (default::IfcAxis2Placement3D | default::IfcAxis2Placement2D);
      CREATE LINK TrueNorth -> default::IfcDirection;
      CREATE PROPERTY CoordinateSpaceDimension -> std::int64;
      CREATE PROPERTY Precision -> std::float64;
  };
  CREATE TYPE default::IfcUnitAssignment {
      CREATE REQUIRED MULTI LINK Units -> ((default::IfcNamedUnit | default::IfcMonetaryUnit) | default::IfcDerivedUnit);
  };
  CREATE TYPE default::IfcOwnerHistory {
      CREATE LINK LastModifyingApplication -> default::IfcApplication;
      CREATE LINK LastModifyingUser -> default::IfcPersonAndOrganization;
      CREATE REQUIRED LINK OwningApplication -> default::IfcApplication;
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
  CREATE ABSTRACT TYPE default::IfcRelationship EXTENDING default::IfcRoot;
  CREATE ABSTRACT TYPE default::IfcRelAssociates EXTENDING default::IfcRelationship {
      CREATE REQUIRED MULTI LINK RelatedObjects -> (default::IfcObjectDefinition | default::IfcPropertyDefinition);
  };
  CREATE TYPE default::IfcRelAssociatesMaterial EXTENDING default::IfcRelAssociates {
      CREATE REQUIRED LINK RelatingMaterial -> ((default::IfcMaterialDefinition | default::IfcMaterialUsageDefinition) | default::IfcMaterialList);
  };
  CREATE ABSTRACT TYPE default::IfcPropertySetDefinition EXTENDING default::IfcPropertyDefinition;
  CREATE TYPE default::IfcPropertySetDefinitionSet {
      CREATE REQUIRED MULTI LINK IfcPropertySetDefinitionSet -> default::IfcPropertySetDefinition;
  };
  CREATE ABSTRACT TYPE default::IfcRelDefines EXTENDING default::IfcRelationship;
  CREATE TYPE default::IfcRelDefinesByProperties EXTENDING default::IfcRelDefines {
      CREATE REQUIRED LINK RelatingPropertyDefinition -> (default::IfcPropertySetDefinition | default::IfcPropertySetDefinitionSet);
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcObjectDefinition;
  };
  CREATE TYPE default::IfcAxis1Placement EXTENDING default::IfcPlacement {
      CREATE LINK Axis -> default::IfcDirection;
  };
  CREATE ABSTRACT TYPE default::IfcSweptAreaSolid EXTENDING default::IfcSolidModel {
      CREATE LINK Position -> default::IfcAxis2Placement3D;
      CREATE REQUIRED LINK SweptArea -> default::IfcProfileDef;
  };
  CREATE TYPE default::IfcRevolvedAreaSolid EXTENDING default::IfcSweptAreaSolid {
      CREATE REQUIRED LINK Axis -> default::IfcAxis1Placement;
      CREATE REQUIRED PROPERTY Angle -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcParameterizedProfileDef EXTENDING default::IfcProfileDef {
      CREATE LINK Position -> default::IfcAxis2Placement2D;
  };
  CREATE TYPE default::IfcCircleProfileDef EXTENDING default::IfcParameterizedProfileDef {
      CREATE REQUIRED PROPERTY Radius -> std::float64;
  };
  CREATE TYPE default::IfcCircleHollowProfileDef EXTENDING default::IfcCircleProfileDef {
      CREATE REQUIRED PROPERTY WallThickness -> std::float64;
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
  CREATE TYPE default::IfcExtrudedAreaSolid EXTENDING default::IfcSweptAreaSolid {
      CREATE REQUIRED LINK ExtrudedDirection -> default::IfcDirection;
      CREATE REQUIRED PROPERTY Depth -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcContext EXTENDING default::IfcObjectDefinition {
      CREATE MULTI LINK RepresentationContexts -> default::IfcRepresentationContext;
      CREATE LINK UnitsInContext -> default::IfcUnitAssignment;
      CREATE PROPERTY LongName -> std::str;
      CREATE PROPERTY ObjectType -> std::str;
      CREATE PROPERTY Phase -> std::str;
  };
  CREATE TYPE default::IfcProject EXTENDING default::IfcContext;
  CREATE TYPE default::IfcConversionBasedUnit EXTENDING default::IfcNamedUnit {
      CREATE REQUIRED LINK ConversionFactor -> default::IfcMeasureWithUnit;
      CREATE REQUIRED PROPERTY Name -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcObject EXTENDING default::IfcObjectDefinition {
      CREATE PROPERTY ObjectType -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcProduct EXTENDING default::IfcObject {
      CREATE LINK ObjectPlacement -> default::IfcObjectPlacement;
      CREATE LINK Representation -> default::IfcProductRepresentation;
  };
  CREATE ABSTRACT TYPE default::IfcElement EXTENDING default::IfcProduct {
      CREATE PROPERTY Tag -> std::str;
  };
  CREATE TYPE default::IfcGroup EXTENDING default::IfcObject;
  CREATE ABSTRACT TYPE default::IfcRelAssigns EXTENDING default::IfcRelationship {
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcObjectDefinition;
      CREATE PROPERTY RelatedObjectsType -> std::str {
          CREATE CONSTRAINT std::one_of('ACTOR', 'CONTROL', 'GROUP', 'NOTDEFINED', 'PROCESS', 'PRODUCT', 'PROJECT', 'RESOURCE');
      };
  };
  CREATE TYPE default::IfcRelAssignsToGroup EXTENDING default::IfcRelAssigns {
      CREATE REQUIRED LINK RelatingGroup -> default::IfcGroup;
  };
  CREATE TYPE default::IfcMaterialProfileSet EXTENDING default::IfcMaterialDefinition {
      CREATE LINK CompositeProfile -> default::IfcCompositeProfileDef;
      CREATE REQUIRED MULTI LINK MaterialProfiles -> default::IfcMaterialProfile;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcMaterialProfileSetUsage EXTENDING default::IfcMaterialUsageDefinition {
      CREATE REQUIRED LINK ForProfileSet -> default::IfcMaterialProfileSet;
      CREATE PROPERTY CardinalPoint -> std::int64;
      CREATE PROPERTY ReferenceExtent -> std::float64;
  };
  CREATE TYPE default::IfcMaterialProperties EXTENDING default::IfcExtendedProperties {
      CREATE REQUIRED LINK Material -> default::IfcMaterialDefinition;
  };
  CREATE TYPE default::IfcTypeObject EXTENDING default::IfcObjectDefinition {
      CREATE MULTI LINK HasPropertySets -> default::IfcPropertySetDefinition;
      CREATE PROPERTY ApplicableOccurrence -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcRelDecomposes EXTENDING default::IfcRelationship;
  CREATE TYPE default::IfcRelAggregates EXTENDING default::IfcRelDecomposes {
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcObjectDefinition;
      CREATE REQUIRED LINK RelatingObject -> default::IfcObjectDefinition;
  };
  CREATE TYPE default::IfcPropertySet EXTENDING default::IfcPropertySetDefinition {
      CREATE REQUIRED MULTI LINK HasProperties -> default::IfcProperty;
  };
  CREATE ABSTRACT TYPE default::IfcRelConnects EXTENDING default::IfcRelationship;
  CREATE TYPE default::IfcPolyline EXTENDING default::IfcBoundedCurve {
      CREATE REQUIRED MULTI LINK Points -> default::IfcCartesianPoint;
  };
  CREATE TYPE default::IfcProductDefinitionShape EXTENDING default::IfcProductRepresentation;
  CREATE TYPE default::IfcShapeRepresentation EXTENDING default::IfcShapeModel;
};

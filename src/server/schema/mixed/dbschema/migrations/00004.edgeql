CREATE MIGRATION m177bp43lj5j3lsj4lskpsijqodbbb6rfszovqluakrevko5tbteya
    ONTO m1h2dhmlpcqaeso62rbfdwxltrisnmm4hxpwqenxpk3otaznmdrmxa
{
  CREATE TYPE default::IfcCartesianPointList3D EXTENDING default::IfcCartesianPointList {
      CREATE REQUIRED PROPERTY CoordList -> array<tuple<std::float64, std::float64, std::float64>>;
      CREATE PROPERTY TagList -> tuple<std::str>;
  };
  CREATE ABSTRACT TYPE default::IfcTessellatedItem EXTENDING default::IfcGeometricRepresentationItem;
  CREATE ABSTRACT TYPE default::IfcTessellatedFaceSet EXTENDING default::IfcTessellatedItem {
      CREATE REQUIRED LINK Coordinates -> default::IfcCartesianPointList3D;
  };
  CREATE TYPE default::IfcTriangulatedFaceSet EXTENDING default::IfcTessellatedFaceSet {
      CREATE PROPERTY Normals -> array<tuple<std::float64, std::float64, std::float64>>;
      CREATE REQUIRED PROPERTY CoordIndex -> array<tuple<std::int64, std::int64, std::int64>>;
      CREATE PROPERTY Closed -> std::bool;
      CREATE PROPERTY PnIndex -> tuple<std::int64>;
  };
  CREATE TYPE default::IfcValue {
      CREATE LINK IfcValue -> (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((default::IfcNormalisedRatioMeasure | default::IfcVolumeMeasure) | default::IfcElectricChargeMeasure) | default::IfcHeatingValueMeasure) | default::IfcMassDensityMeasure) | default::IfcForceMeasure) | default::IfcIdentifier) | default::IfcParameterValue) | default::IfcMagneticFluxMeasure) | default::IfcInteger) | default::IfcFrequencyMeasure) | default::IfcThermalTransmittanceMeasure) | default::IfcText) | default::IfcThermalExpansionCoefficientMeasure) | default::IfcLengthMeasure) | default::IfcLinearVelocityMeasure) | default::IfcContextDependentMeasure) | default::IfcTemperatureRateOfChangeMeasure) | default::IfcCurvatureMeasure) | default::IfcLabel) | default::IfcRadioActivityMeasure) | default::IfcMomentOfInertiaMeasure) | default::IfcDescriptiveMeasure) | default::IfcAbsorbedDoseMeasure) | default::IfcIsothermalMoistureCapacityMeasure) | default::IfcPHMeasure) | default::IfcEnergyMeasure) | default::IfcIonConcentrationMeasure) | default::IfcSoundPressureLevelMeasure) | default::IfcVolumetricFlowRateMeasure) | default::IfcMassMeasure) | default::IfcSectionalAreaIntegralMeasure) | default::IfcSoundPowerMeasure) | default::IfcRotationalFrequencyMeasure) | default::IfcLuminousFluxMeasure) | default::IfcModulusOfSubgradeReactionMeasure) | default::IfcPowerMeasure) | default::IfcIlluminanceMeasure) | default::IfcShearModulusMeasure) | default::IfcSoundPowerLevelMeasure) | default::IfcWarpingConstantMeasure) | default::IfcThermalResistanceMeasure) | default::IfcBoolean) | default::IfcCountMeasure) | default::IfcNonNegativeLengthMeasure) | default::IfcRotationalStiffnessMeasure) | default::IfcLogical) | default::IfcPositiveRatioMeasure) | default::IfcComplexNumber) | default::IfcSectionModulusMeasure) | default::IfcMagneticFluxDensityMeasure) | default::IfcThermalConductivityMeasure) | default::IfcSolidAngleMeasure) | default::IfcHeatFluxDensityMeasure) | default::IfcThermodynamicTemperatureMeasure) | default::IfcInductanceMeasure) | default::IfcMolecularWeightMeasure) | default::IfcAreaDensityMeasure) | default::IfcLinearStiffnessMeasure) | default::IfcBinary) | default::IfcLinearMomentMeasure) | default::IfcTemperatureGradientMeasure) | default::IfcTimeStamp) | default::IfcPressureMeasure) | default::IfcPositiveInteger) | default::IfcDateTime) | default::IfcKinematicViscosityMeasure) | default::IfcElectricVoltageMeasure) | default::IfcAmountOfSubstanceMeasure) | default::IfcModulusOfLinearSubgradeReactionMeasure) | default::IfcRatioMeasure) | default::IfcModulusOfElasticityMeasure) | default::IfcElectricConductanceMeasure) | default::IfcPositivePlaneAngleMeasure) | default::IfcTimeMeasure) | default::IfcRotationalMassMeasure) | default::IfcAccelerationMeasure) | default::IfcElectricResistanceMeasure) | default::IfcMassFlowRateMeasure) | default::IfcTime) | default::IfcLuminousIntensityDistributionMeasure) | default::IfcPositiveLengthMeasure) | default::IfcSoundPressureMeasure) | default::IfcDate) | default::IfcTorqueMeasure) | default::IfcElectricCapacitanceMeasure) | default::IfcLinearForceMeasure) | default::IfcSpecificHeatCapacityMeasure) | default::IfcDoseEquivalentMeasure) | default::IfcNumericMeasure) | default::IfcDynamicViscosityMeasure) | default::IfcWarpingMomentMeasure) | default::IfcReal) | default::IfcDuration) | default::IfcMassPerLengthMeasure) | default::IfcVaporPermeabilityMeasure) | default::IfcModulusOfRotationalSubgradeReactionMeasure) | default::IfcAngularVelocityMeasure) | default::IfcMonetaryMeasure) | default::IfcLuminousIntensityMeasure) | default::IfcMoistureDiffusivityMeasure) | default::IfcIntegerCountRateMeasure) | default::IfcThermalAdmittanceMeasure) | default::IfcCompoundPlaneAngleMeasure) | default::IfcAreaMeasure) | default::IfcPlaneAngleMeasure) | default::IfcPlanarForceMeasure) | default::IfcElectricCurrentMeasure);
  };
  CREATE TYPE default::IfcDerivedUnit {
      CREATE REQUIRED MULTI LINK Elements -> default::IfcDerivedUnitElement;
      CREATE REQUIRED PROPERTY UnitType -> std::str {
          CREATE CONSTRAINT std::one_of('ACCELERATIONUNIT', 'ANGULARVELOCITYUNIT', 'AREADENSITYUNIT', 'COMPOUNDPLANEANGLEUNIT', 'CURVATUREUNIT', 'DYNAMICVISCOSITYUNIT', 'HEATFLUXDENSITYUNIT', 'HEATINGVALUEUNIT', 'INTEGERCOUNTRATEUNIT', 'IONCONCENTRATIONUNIT', 'ISOTHERMALMOISTURECAPACITYUNIT', 'KINEMATICVISCOSITYUNIT', 'LINEARFORCEUNIT', 'LINEARMOMENTUNIT', 'LINEARSTIFFNESSUNIT', 'LINEARVELOCITYUNIT', 'LUMINOUSINTENSITYDISTRIBUTIONUNIT', 'MASSDENSITYUNIT', 'MASSFLOWRATEUNIT', 'MASSPERLENGTHUNIT', 'MODULUSOFELASTICITYUNIT', 'MODULUSOFLINEARSUBGRADEREACTIONUNIT', 'MODULUSOFROTATIONALSUBGRADEREACTIONUNIT', 'MODULUSOFSUBGRADEREACTIONUNIT', 'MOISTUREDIFFUSIVITYUNIT', 'MOLECULARWEIGHTUNIT', 'MOMENTOFINERTIAUNIT', 'PHUNIT', 'PLANARFORCEUNIT', 'ROTATIONALFREQUENCYUNIT', 'ROTATIONALMASSUNIT', 'ROTATIONALSTIFFNESSUNIT', 'SECTIONAREAINTEGRALUNIT', 'SECTIONMODULUSUNIT', 'SHEARMODULUSUNIT', 'SOUNDPOWERLEVELUNIT', 'SOUNDPOWERUNIT', 'SOUNDPRESSURELEVELUNIT', 'SOUNDPRESSUREUNIT', 'SPECIFICHEATCAPACITYUNIT', 'TEMPERATUREGRADIENTUNIT', 'TEMPERATURERATEOFCHANGEUNIT', 'THERMALADMITTANCEUNIT', 'THERMALCONDUCTANCEUNIT', 'THERMALEXPANSIONCOEFFICIENTUNIT', 'THERMALRESISTANCEUNIT', 'THERMALTRANSMITTANCEUNIT', 'TORQUEUNIT', 'USERDEFINED', 'VAPORPERMEABILITYUNIT', 'VOLUMETRICFLOWRATEUNIT', 'WARPINGCONSTANTUNIT', 'WARPINGMOMENTUNIT');
      };
      CREATE PROPERTY UserDefinedType -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcSimpleProperty EXTENDING default::IfcProperty;
  CREATE TYPE default::IfcPropertySingleValue EXTENDING default::IfcSimpleProperty {
      CREATE LINK NominalValue -> ((default::IfcDerivedMeasureValue | default::IfcMeasureValue) | default::IfcSimpleValue);
      CREATE LINK Unit -> ((default::IfcDerivedUnit | default::IfcMonetaryUnit) | default::IfcNamedUnit);
  };
  CREATE TYPE default::IfcMeasureWithUnit {
      CREATE REQUIRED LINK ValueComponent -> ((default::IfcDerivedMeasureValue | default::IfcMeasureValue) | default::IfcSimpleValue);
      CREATE REQUIRED LINK UnitComponent -> ((default::IfcDerivedUnit | default::IfcMonetaryUnit) | default::IfcNamedUnit);
  };
  CREATE TYPE default::IfcUnit {
      CREATE LINK IfcUnit -> ((default::IfcDerivedUnit | default::IfcMonetaryUnit) | default::IfcNamedUnit);
  };
  CREATE TYPE default::IfcMaterialSelect {
      CREATE LINK IfcMaterialSelect -> ((default::IfcMaterialList | default::IfcMaterialUsageDefinition) | default::IfcMaterialDefinition);
  };
  CREATE TYPE default::IfcFaceBound EXTENDING default::IfcTopologicalRepresentationItem {
      CREATE REQUIRED LINK Bound -> default::IfcLoop;
      CREATE REQUIRED PROPERTY Orientation -> std::bool;
  };
  CREATE TYPE default::IfcFace EXTENDING default::IfcTopologicalRepresentationItem {
      CREATE REQUIRED MULTI LINK Bounds -> default::IfcFaceBound;
  };
  CREATE ABSTRACT TYPE default::IfcSurface EXTENDING default::IfcGeometricRepresentationItem;
  CREATE TYPE default::IfcFaceSurface EXTENDING default::IfcFace {
      CREATE REQUIRED LINK FaceSurface -> default::IfcSurface;
      CREATE REQUIRED PROPERTY SameSense -> std::bool;
  };
  CREATE TYPE default::IfcAdvancedFace EXTENDING default::IfcFaceSurface;
  CREATE TYPE default::IfcApplication {
      CREATE REQUIRED LINK ApplicationDeveloper -> default::IfcOrganization;
      CREATE REQUIRED PROPERTY ApplicationFullName -> std::str;
      CREATE REQUIRED PROPERTY ApplicationIdentifier -> std::str;
      CREATE REQUIRED PROPERTY Version -> std::str;
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
  CREATE TYPE default::IfcArbitraryClosedProfileDef EXTENDING default::IfcProfileDef {
      CREATE REQUIRED LINK OuterCurve -> default::IfcCurve;
  };
  CREATE TYPE default::IfcCartesianPoint EXTENDING default::IfcPoint {
      CREATE REQUIRED PROPERTY Coordinates -> array<std::float64> {
          CREATE CONSTRAINT std::expression ON ((((std::len(__subject__) = 1) OR (std::len(__subject__) = 2)) OR (std::len(__subject__) = 3)));
      };
  };
  CREATE ABSTRACT TYPE default::IfcPlacement EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED LINK Location -> default::IfcCartesianPoint;
  };
  CREATE TYPE default::IfcAxis2Placement2D EXTENDING default::IfcPlacement {
      CREATE LINK RefDirection -> default::IfcDirection;
  };
  CREATE TYPE default::IfcAxis2Placement3D EXTENDING default::IfcPlacement {
      CREATE LINK Axis -> default::IfcDirection;
      CREATE LINK RefDirection -> default::IfcDirection;
  };
  CREATE ABSTRACT TYPE default::IfcBoundedSurface EXTENDING default::IfcSurface;
  CREATE TYPE default::List_of_IfcCartesianPoint {
      CREATE REQUIRED MULTI LINK IfcCartesianPoints -> default::IfcCartesianPoint;
  };
  CREATE ABSTRACT TYPE default::IfcBSplineSurface EXTENDING default::IfcBoundedSurface {
      CREATE REQUIRED MULTI LINK ControlPointsList -> default::List_of_IfcCartesianPoint;
      CREATE REQUIRED PROPERTY SelfIntersect -> std::bool;
      CREATE REQUIRED PROPERTY SurfaceForm -> std::str {
          CREATE CONSTRAINT std::one_of('CONICAL_SURF', 'CYLINDRICAL_SURF', 'GENERALISED_CONE', 'PLANE_SURF', 'QUADRIC_SURF', 'RULED_SURF', 'SPHERICAL_SURF', 'SURF_OF_LINEAR_EXTRUSION', 'SURF_OF_REVOLUTION', 'TOROIDAL_SURF', 'UNSPECIFIED');
      };
      CREATE REQUIRED PROPERTY UClosed -> std::bool;
      CREATE REQUIRED PROPERTY UDegree -> std::int64;
      CREATE REQUIRED PROPERTY VClosed -> std::bool;
      CREATE REQUIRED PROPERTY VDegree -> std::int64;
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
  CREATE TYPE default::IfcBoundingBox EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED LINK Corner -> default::IfcCartesianPoint;
      CREATE REQUIRED PROPERTY XDim -> std::float64;
      CREATE REQUIRED PROPERTY YDim -> std::float64;
      CREATE REQUIRED PROPERTY ZDim -> std::float64;
  };
  CREATE TYPE default::IfcConnectedFaceSet EXTENDING default::IfcTopologicalRepresentationItem {
      CREATE REQUIRED MULTI LINK CfsFaces -> default::IfcFace;
  };
  CREATE TYPE default::IfcVertex EXTENDING default::IfcTopologicalRepresentationItem;
  CREATE TYPE default::IfcEdge EXTENDING default::IfcTopologicalRepresentationItem {
      CREATE LINK EdgeEnd -> default::IfcVertex;
      CREATE LINK EdgeStart -> default::IfcVertex;
  };
  CREATE TYPE default::IfcEdgeCurve EXTENDING default::IfcEdge {
      CREATE REQUIRED LINK EdgeGeometry -> default::IfcCurve;
      CREATE REQUIRED PROPERTY SameSense -> std::bool;
  };
  CREATE TYPE default::IfcOrientedEdge EXTENDING default::IfcEdge {
      CREATE REQUIRED LINK EdgeElement -> default::IfcEdge;
      CREATE REQUIRED PROPERTY Orientation -> std::bool;
  };
  CREATE TYPE default::IfcEdgeLoop EXTENDING default::IfcLoop {
      CREATE REQUIRED MULTI LINK EdgeList -> default::IfcOrientedEdge;
  };
  CREATE TYPE default::IfcFaceOuterBound EXTENDING default::IfcFaceBound;
  CREATE TYPE default::IfcIndexedPolygonalFace EXTENDING default::IfcTessellatedItem {
      CREATE REQUIRED PROPERTY CoordIndex -> tuple<std::int64, std::int64, std::int64>;
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
  CREATE ABSTRACT TYPE default::IfcRoot {
      CREATE LINK OwnerHistory -> default::IfcOwnerHistory;
      CREATE PROPERTY Description -> std::str;
      CREATE REQUIRED PROPERTY GlobalId -> std::str;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcProductDefinitionShape EXTENDING default::IfcProductRepresentation;
  CREATE ABSTRACT TYPE default::IfcShapeModel EXTENDING default::IfcRepresentation;
  CREATE TYPE default::IfcShapeRepresentation EXTENDING default::IfcShapeModel;
  CREATE ABSTRACT TYPE default::IfcSolidModel EXTENDING default::IfcGeometricRepresentationItem;
  CREATE TYPE default::IfcTelecomAddress EXTENDING default::IfcAddress {
      CREATE PROPERTY ElectronicMailAddresses -> tuple<std::str>;
      CREATE PROPERTY FacsimileNumbers -> tuple<std::str>;
      CREATE PROPERTY MessagingIDs -> tuple<std::str>;
      CREATE PROPERTY PagerNumber -> std::str;
      CREATE PROPERTY TelephoneNumbers -> tuple<std::str>;
      CREATE PROPERTY WWWHomePageURL -> std::str;
  };
  CREATE TYPE default::IfcUnitAssignment {
      CREATE REQUIRED MULTI LINK Units -> default::IfcUnit;
  };
  CREATE TYPE default::IfcVertexPoint EXTENDING default::IfcVertex {
      CREATE REQUIRED LINK VertexGeometry -> default::IfcPoint;
  };
};

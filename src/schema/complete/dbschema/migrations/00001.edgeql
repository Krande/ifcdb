CREATE MIGRATION m17k7ipwz2bww2oifjkxb4cbj57vhsv74qlrmcr6aj7kjccr7vrx6a
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
  CREATE ABSTRACT TYPE default::IfcCurve EXTENDING default::IfcGeometricRepresentationItem;
  CREATE TYPE default::IfcGridAxis {
      CREATE REQUIRED LINK AxisCurve -> default::IfcCurve;
      CREATE PROPERTY AxisTag -> std::str;
      CREATE REQUIRED PROPERTY SameSense -> std::bool;
  };
  CREATE TYPE default::IfcVirtualGridIntersection {
      CREATE REQUIRED PROPERTY OffsetDistances -> array<std::float64> {
          CREATE CONSTRAINT std::expression ON (((std::len(__subject__) = 2) OR (std::len(__subject__) = 3)));
      };
      CREATE REQUIRED MULTI LINK IntersectingAxes -> default::IfcGridAxis;
  };
  CREATE ABSTRACT TYPE default::IfcStructuralLoad {
      CREATE PROPERTY Name -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcStructuralLoadOrResult EXTENDING default::IfcStructuralLoad;
  CREATE TYPE default::IfcSurfaceReinforcementArea EXTENDING default::IfcStructuralLoadOrResult {
      CREATE PROPERTY SurfaceReinforcement1 -> array<std::float64> {
          CREATE CONSTRAINT std::expression ON (((std::len(__subject__) = 2) OR (std::len(__subject__) = 3)));
      };
      CREATE PROPERTY SurfaceReinforcement2 -> array<std::float64> {
          CREATE CONSTRAINT std::expression ON (((std::len(__subject__) = 2) OR (std::len(__subject__) = 3)));
      };
      CREATE PROPERTY ShearReinforcement -> std::float64;
  };
  CREATE TYPE default::IfcCompoundPlaneAngleMeasure {
      CREATE REQUIRED PROPERTY IfcCompoundPlaneAngleMeasure -> array<std::int64> {
          CREATE CONSTRAINT std::expression ON (((std::len(__subject__) = 3) OR (std::len(__subject__) = 4)));
      };
  };
  CREATE ABSTRACT TYPE default::IfcPresentationItem;
  CREATE TYPE default::IfcColourRgbList EXTENDING default::IfcPresentationItem {
      CREATE REQUIRED PROPERTY ColourList -> array<tuple<std::float64, std::float64, std::float64>>;
  };
  CREATE ABSTRACT TYPE default::IfcCartesianPointList EXTENDING default::IfcGeometricRepresentationItem;
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
      CREATE PROPERTY Closed -> std::bool;
      CREATE REQUIRED PROPERTY CoordIndex -> array<tuple<std::int64, std::int64, std::int64>>;
      CREATE PROPERTY PnIndex -> tuple<std::int64>;
  };
  CREATE TYPE default::IfcTriangulatedIrregularNetwork EXTENDING default::IfcTriangulatedFaceSet {
      CREATE REQUIRED PROPERTY Flags -> tuple<std::int64>;
  };
  CREATE TYPE default::IfcCartesianPointList2D EXTENDING default::IfcCartesianPointList {
      CREATE REQUIRED PROPERTY CoordList -> array<tuple<std::float64, std::float64>>;
      CREATE PROPERTY TagList -> tuple<std::str>;
  };
  CREATE TYPE default::IfcStructuralLoadConfiguration EXTENDING default::IfcStructuralLoad {
      CREATE PROPERTY Locations -> array<tuple<std::float64, std::float64>>;
      CREATE REQUIRED MULTI LINK Values -> default::IfcStructuralLoadOrResult;
  };
  CREATE TYPE default::IfcTextureVertexList EXTENDING default::IfcPresentationItem {
      CREATE REQUIRED PROPERTY TexCoordsList -> array<tuple<std::float64, std::float64>>;
  };
  CREATE ABSTRACT TYPE default::IfcSurface EXTENDING default::IfcGeometricRepresentationItem;
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
  CREATE TYPE default::IfcBSplineSurfaceWithKnots EXTENDING default::IfcBSplineSurface {
      CREATE REQUIRED PROPERTY KnotSpec -> std::str {
          CREATE CONSTRAINT std::one_of('PIECEWISE_BEZIER_KNOTS', 'QUASI_UNIFORM_KNOTS', 'UNIFORM_KNOTS', 'UNSPECIFIED');
      };
      CREATE REQUIRED PROPERTY UKnots -> tuple<std::float64, std::float64>;
      CREATE REQUIRED PROPERTY UMultiplicities -> tuple<std::int64, std::int64>;
      CREATE REQUIRED PROPERTY VKnots -> tuple<std::float64, std::float64>;
      CREATE REQUIRED PROPERTY VMultiplicities -> tuple<std::int64, std::int64>;
  };
  CREATE TYPE default::IfcRationalBSplineSurfaceWithKnots EXTENDING default::IfcBSplineSurfaceWithKnots {
      CREATE REQUIRED PROPERTY WeightsData -> array<tuple<std::float64, std::float64>>;
  };
  CREATE TYPE default::IfcIndexedPolygonalFace EXTENDING default::IfcTessellatedItem {
      CREATE REQUIRED PROPERTY CoordIndex -> tuple<std::int64, std::int64, std::int64>;
  };
  CREATE TYPE default::IfcIndexedPolygonalFaceWithVoids EXTENDING default::IfcIndexedPolygonalFace {
      CREATE REQUIRED PROPERTY InnerCoordIndices -> array<tuple<std::int64, std::int64, std::int64>>;
  };
  CREATE ABSTRACT TYPE default::IfcCartesianTransformationOperator EXTENDING default::IfcGeometricRepresentationItem {
      CREATE LINK Axis1 -> default::IfcDirection;
      CREATE LINK Axis2 -> default::IfcDirection;
      CREATE REQUIRED LINK LocalOrigin -> default::IfcCartesianPoint;
      CREATE PROPERTY Scale -> std::float64;
  };
  CREATE TYPE default::IfcCartesianTransformationOperator2D EXTENDING default::IfcCartesianTransformationOperator;
  CREATE ABSTRACT TYPE default::IfcSurfaceTexture EXTENDING default::IfcPresentationItem {
      CREATE LINK TextureTransform -> default::IfcCartesianTransformationOperator2D;
      CREATE PROPERTY Mode -> std::str;
      CREATE PROPERTY Parameter -> tuple<std::str>;
      CREATE REQUIRED PROPERTY RepeatS -> std::bool;
      CREATE REQUIRED PROPERTY RepeatT -> std::bool;
  };
  CREATE ABSTRACT TYPE default::IfcTextureCoordinate EXTENDING default::IfcPresentationItem {
      CREATE REQUIRED MULTI LINK Maps -> default::IfcSurfaceTexture;
  };
  CREATE ABSTRACT TYPE default::IfcIndexedTextureMap EXTENDING default::IfcTextureCoordinate {
      CREATE REQUIRED LINK MappedTo -> default::IfcTessellatedFaceSet;
      CREATE REQUIRED LINK TexCoords -> default::IfcTextureVertexList;
  };
  CREATE TYPE default::IfcIndexedTriangleTextureMap EXTENDING default::IfcIndexedTextureMap {
      CREATE PROPERTY TexCoordIndex -> array<tuple<std::int64, std::int64, std::int64>>;
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
      CREATE LINK IfcValue -> (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((default::IfcMomentOfInertiaMeasure | default::IfcPositiveRatioMeasure) | default::IfcPlanarForceMeasure) | default::IfcIonConcentrationMeasure) | default::IfcMassFlowRateMeasure) | default::IfcNumericMeasure) | default::IfcIlluminanceMeasure) | default::IfcElectricCurrentMeasure) | default::IfcAreaMeasure) | default::IfcRadioActivityMeasure) | default::IfcHeatingValueMeasure) | default::IfcLinearStiffnessMeasure) | default::IfcInductanceMeasure) | default::IfcAreaDensityMeasure) | default::IfcMassDensityMeasure) | default::IfcVaporPermeabilityMeasure) | default::IfcLuminousIntensityMeasure) | default::IfcVolumeMeasure) | default::IfcThermodynamicTemperatureMeasure) | default::IfcShearModulusMeasure) | default::IfcBoolean) | default::IfcRatioMeasure) | default::IfcThermalExpansionCoefficientMeasure) | default::IfcIsothermalMoistureCapacityMeasure) | default::IfcLabel) | default::IfcLuminousIntensityDistributionMeasure) | default::IfcAmountOfSubstanceMeasure) | default::IfcThermalAdmittanceMeasure) | default::IfcSoundPowerLevelMeasure) | default::IfcTimeStamp) | default::IfcPressureMeasure) | default::IfcEnergyMeasure) | default::IfcSectionModulusMeasure) | default::IfcModulusOfSubgradeReactionMeasure) | default::IfcLuminousFluxMeasure) | default::IfcDate) | default::IfcRotationalFrequencyMeasure) | default::IfcSpecificHeatCapacityMeasure) | default::IfcWarpingMomentMeasure) | default::IfcCompoundPlaneAngleMeasure) | default::IfcDynamicViscosityMeasure) | default::IfcThermalResistanceMeasure) | default::IfcIntegerCountRateMeasure) | default::IfcInteger) | default::IfcIdentifier) | default::IfcKinematicViscosityMeasure) | default::IfcMagneticFluxDensityMeasure) | default::IfcFrequencyMeasure) | default::IfcTemperatureRateOfChangeMeasure) | default::IfcForceMeasure) | default::IfcDateTime) | default::IfcPositivePlaneAngleMeasure) | default::IfcLengthMeasure) | default::IfcLinearForceMeasure) | default::IfcParameterValue) | default::IfcText) | default::IfcDoseEquivalentMeasure) | default::IfcDescriptiveMeasure) | default::IfcVolumetricFlowRateMeasure) | default::IfcMassPerLengthMeasure) | default::IfcMonetaryMeasure) | default::IfcThermalConductivityMeasure) | default::IfcDuration) | default::IfcElectricConductanceMeasure) | default::IfcMagneticFluxMeasure) | default::IfcTime) | default::IfcRotationalStiffnessMeasure) | default::IfcHeatFluxDensityMeasure) | default::IfcMoistureDiffusivityMeasure) | default::IfcSolidAngleMeasure) | default::IfcLogical) | default::IfcElectricCapacitanceMeasure) | default::IfcSectionalAreaIntegralMeasure) | default::IfcModulusOfRotationalSubgradeReactionMeasure) | default::IfcSoundPressureMeasure) | default::IfcLinearMomentMeasure) | default::IfcAngularVelocityMeasure) | default::IfcPositiveInteger) | default::IfcCountMeasure) | default::IfcTorqueMeasure) | default::IfcBinary) | default::IfcElectricResistanceMeasure) | default::IfcNormalisedRatioMeasure) | default::IfcTimeMeasure) | default::IfcNonNegativeLengthMeasure) | default::IfcComplexNumber) | default::IfcSoundPressureLevelMeasure) | default::IfcPowerMeasure) | default::IfcAbsorbedDoseMeasure) | default::IfcRotationalMassMeasure) | default::IfcReal) | default::IfcElectricChargeMeasure) | default::IfcCurvatureMeasure) | default::IfcPositiveLengthMeasure) | default::IfcWarpingConstantMeasure) | default::IfcModulusOfLinearSubgradeReactionMeasure) | default::IfcThermalTransmittanceMeasure) | default::IfcTemperatureGradientMeasure) | default::IfcMassMeasure) | default::IfcMolecularWeightMeasure) | default::IfcSoundPowerMeasure) | default::IfcPHMeasure) | default::IfcContextDependentMeasure) | default::IfcElectricVoltageMeasure) | default::IfcAccelerationMeasure) | default::IfcPlaneAngleMeasure) | default::IfcLinearVelocityMeasure) | default::IfcModulusOfElasticityMeasure);
  };
  CREATE TYPE default::IfcMeasureWithUnit {
      CREATE REQUIRED LINK UnitComponent -> default::IfcUnit;
      CREATE REQUIRED LINK ValueComponent -> default::IfcValue;
  };
  CREATE TYPE default::IfcReference {
      CREATE LINK InnerReference -> default::IfcReference;
      CREATE PROPERTY AttributeIdentifier -> std::str;
      CREATE PROPERTY InstanceName -> std::str;
      CREATE PROPERTY ListPositions -> tuple<std::int64>;
      CREATE PROPERTY TypeIdentifier -> std::str;
  };
  CREATE TYPE default::IfcAppliedValueSelect {
      CREATE LINK IfcAppliedValueSelect -> (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((default::IfcMomentOfInertiaMeasure | default::IfcPositiveRatioMeasure) | default::IfcPlanarForceMeasure) | default::IfcIonConcentrationMeasure) | default::IfcMassFlowRateMeasure) | default::IfcNumericMeasure) | default::IfcIlluminanceMeasure) | default::IfcElectricCurrentMeasure) | default::IfcAreaMeasure) | default::IfcRadioActivityMeasure) | default::IfcHeatingValueMeasure) | default::IfcLinearStiffnessMeasure) | default::IfcInductanceMeasure) | default::IfcAreaDensityMeasure) | default::IfcMassDensityMeasure) | default::IfcVaporPermeabilityMeasure) | default::IfcLuminousIntensityMeasure) | default::IfcVolumeMeasure) | default::IfcThermodynamicTemperatureMeasure) | default::IfcShearModulusMeasure) | default::IfcBoolean) | default::IfcRatioMeasure) | default::IfcThermalExpansionCoefficientMeasure) | default::IfcIsothermalMoistureCapacityMeasure) | default::IfcLabel) | default::IfcLuminousIntensityDistributionMeasure) | default::IfcAmountOfSubstanceMeasure) | default::IfcThermalAdmittanceMeasure) | default::IfcReference) | default::IfcSoundPowerLevelMeasure) | default::IfcTimeStamp) | default::IfcPressureMeasure) | default::IfcEnergyMeasure) | default::IfcSectionModulusMeasure) | default::IfcModulusOfSubgradeReactionMeasure) | default::IfcLuminousFluxMeasure) | default::IfcDate) | default::IfcRotationalFrequencyMeasure) | default::IfcSpecificHeatCapacityMeasure) | default::IfcWarpingMomentMeasure) | default::IfcCompoundPlaneAngleMeasure) | default::IfcDynamicViscosityMeasure) | default::IfcThermalResistanceMeasure) | default::IfcIntegerCountRateMeasure) | default::IfcInteger) | default::IfcIdentifier) | default::IfcKinematicViscosityMeasure) | default::IfcMagneticFluxDensityMeasure) | default::IfcFrequencyMeasure) | default::IfcTemperatureRateOfChangeMeasure) | default::IfcForceMeasure) | default::IfcDateTime) | default::IfcPositivePlaneAngleMeasure) | default::IfcLengthMeasure) | default::IfcLinearForceMeasure) | default::IfcParameterValue) | default::IfcText) | default::IfcDoseEquivalentMeasure) | default::IfcDescriptiveMeasure) | default::IfcVolumetricFlowRateMeasure) | default::IfcMassPerLengthMeasure) | default::IfcMonetaryMeasure) | default::IfcThermalConductivityMeasure) | default::IfcDuration) | default::IfcElectricConductanceMeasure) | default::IfcMagneticFluxMeasure) | default::IfcTime) | default::IfcRotationalStiffnessMeasure) | default::IfcHeatFluxDensityMeasure) | default::IfcMoistureDiffusivityMeasure) | default::IfcSolidAngleMeasure) | default::IfcLogical) | default::IfcElectricCapacitanceMeasure) | default::IfcSectionalAreaIntegralMeasure) | default::IfcModulusOfRotationalSubgradeReactionMeasure) | default::IfcSoundPressureMeasure) | default::IfcLinearMomentMeasure) | default::IfcAngularVelocityMeasure) | default::IfcPositiveInteger) | default::IfcCountMeasure) | default::IfcTorqueMeasure) | default::IfcBinary) | default::IfcElectricResistanceMeasure) | default::IfcNormalisedRatioMeasure) | default::IfcTimeMeasure) | default::IfcNonNegativeLengthMeasure) | default::IfcComplexNumber) | default::IfcMeasureWithUnit) | default::IfcPowerMeasure) | default::IfcAbsorbedDoseMeasure) | default::IfcSoundPressureLevelMeasure) | default::IfcRotationalMassMeasure) | default::IfcReal) | default::IfcElectricChargeMeasure) | default::IfcCurvatureMeasure) | default::IfcPositiveLengthMeasure) | default::IfcWarpingConstantMeasure) | default::IfcModulusOfLinearSubgradeReactionMeasure) | default::IfcThermalTransmittanceMeasure) | default::IfcTemperatureGradientMeasure) | default::IfcMassMeasure) | default::IfcMolecularWeightMeasure) | default::IfcSoundPowerMeasure) | default::IfcPHMeasure) | default::IfcContextDependentMeasure) | default::IfcElectricVoltageMeasure) | default::IfcAccelerationMeasure) | default::IfcPlaneAngleMeasure) | default::IfcLinearVelocityMeasure) | default::IfcModulusOfElasticityMeasure);
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
  CREATE TYPE default::IfcTableColumn {
      CREATE LINK ReferencePath -> default::IfcReference;
      CREATE LINK Unit -> default::IfcUnit;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Identifier -> std::str;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcTableRow {
      CREATE MULTI LINK RowCells -> default::IfcValue;
      CREATE PROPERTY IsHeading -> std::bool;
  };
  CREATE TYPE default::IfcTable {
      CREATE MULTI LINK Columns -> default::IfcTableColumn;
      CREATE MULTI LINK Rows -> default::IfcTableRow;
      CREATE PROPERTY Name -> std::str;
  };
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
  CREATE TYPE default::IfcMetricValueSelect {
      CREATE LINK IfcMetricValueSelect -> ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((default::IfcMomentOfInertiaMeasure | default::IfcPositiveRatioMeasure) | default::IfcPlanarForceMeasure) | default::IfcIonConcentrationMeasure) | default::IfcMassFlowRateMeasure) | default::IfcNumericMeasure) | default::IfcIlluminanceMeasure) | default::IfcElectricCurrentMeasure) | default::IfcAreaMeasure) | default::IfcRadioActivityMeasure) | default::IfcHeatingValueMeasure) | default::IfcLinearStiffnessMeasure) | default::IfcInductanceMeasure) | default::IfcAreaDensityMeasure) | default::IfcMassDensityMeasure) | default::IfcVaporPermeabilityMeasure) | default::IfcLuminousIntensityMeasure) | default::IfcVolumeMeasure) | default::IfcThermodynamicTemperatureMeasure) | default::IfcShearModulusMeasure) | default::IfcBoolean) | default::IfcRatioMeasure) | default::IfcThermalExpansionCoefficientMeasure) | default::IfcIsothermalMoistureCapacityMeasure) | default::IfcLabel) | default::IfcLuminousIntensityDistributionMeasure) | default::IfcAmountOfSubstanceMeasure) | default::IfcAppliedValue) | default::IfcThermalAdmittanceMeasure) | default::IfcReference) | default::IfcSoundPowerLevelMeasure) | default::IfcTimeStamp) | default::IfcPressureMeasure) | default::IfcEnergyMeasure) | default::IfcSectionModulusMeasure) | default::IfcModulusOfSubgradeReactionMeasure) | default::IfcLuminousFluxMeasure) | default::IfcDate) | default::IfcRotationalFrequencyMeasure) | default::IfcSpecificHeatCapacityMeasure) | default::IfcWarpingMomentMeasure) | default::IfcCompoundPlaneAngleMeasure) | default::IfcDynamicViscosityMeasure) | default::IfcThermalResistanceMeasure) | default::IfcIntegerCountRateMeasure) | default::IfcInteger) | default::IfcIdentifier) | default::IfcKinematicViscosityMeasure) | default::IfcMagneticFluxDensityMeasure) | default::IfcFrequencyMeasure) | default::IfcTemperatureRateOfChangeMeasure) | default::IfcForceMeasure) | default::IfcDateTime) | default::IfcPositivePlaneAngleMeasure) | default::IfcLengthMeasure) | default::IfcLinearForceMeasure) | default::IfcParameterValue) | default::IfcText) | default::IfcTimeSeries) | default::IfcDoseEquivalentMeasure) | default::IfcDescriptiveMeasure) | default::IfcVolumetricFlowRateMeasure) | default::IfcMassPerLengthMeasure) | default::IfcMonetaryMeasure) | default::IfcThermalConductivityMeasure) | default::IfcDuration) | default::IfcElectricConductanceMeasure) | default::IfcMagneticFluxMeasure) | default::IfcTime) | default::IfcRotationalStiffnessMeasure) | default::IfcHeatFluxDensityMeasure) | default::IfcMoistureDiffusivityMeasure) | default::IfcSolidAngleMeasure) | default::IfcLogical) | default::IfcElectricCapacitanceMeasure) | default::IfcSectionalAreaIntegralMeasure) | default::IfcTable) | default::IfcModulusOfRotationalSubgradeReactionMeasure) | default::IfcSoundPressureMeasure) | default::IfcLinearMomentMeasure) | default::IfcAngularVelocityMeasure) | default::IfcPositiveInteger) | default::IfcCountMeasure) | default::IfcTorqueMeasure) | default::IfcBinary) | default::IfcElectricResistanceMeasure) | default::IfcNormalisedRatioMeasure) | default::IfcTimeMeasure) | default::IfcNonNegativeLengthMeasure) | default::IfcComplexNumber) | default::IfcMeasureWithUnit) | default::IfcPowerMeasure) | default::IfcAbsorbedDoseMeasure) | default::IfcSoundPressureLevelMeasure) | default::IfcRotationalMassMeasure) | default::IfcReal) | default::IfcElectricChargeMeasure) | default::IfcCurvatureMeasure) | default::IfcPositiveLengthMeasure) | default::IfcWarpingConstantMeasure) | default::IfcModulusOfLinearSubgradeReactionMeasure) | default::IfcThermalTransmittanceMeasure) | default::IfcTemperatureGradientMeasure) | default::IfcMassMeasure) | default::IfcMolecularWeightMeasure) | default::IfcSoundPowerMeasure) | default::IfcPHMeasure) | default::IfcContextDependentMeasure) | default::IfcElectricVoltageMeasure) | default::IfcAccelerationMeasure) | default::IfcPlaneAngleMeasure) | default::IfcLinearVelocityMeasure) | default::IfcModulusOfElasticityMeasure);
  };
  CREATE TYPE default::IfcDerivedMeasureValue {
      CREATE LINK IfcDerivedMeasureValue -> ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((default::IfcMomentOfInertiaMeasure | default::IfcSoundPowerLevelMeasure) | default::IfcVolumetricFlowRateMeasure) | default::IfcMassPerLengthMeasure) | default::IfcMonetaryMeasure) | default::IfcThermalConductivityMeasure) | default::IfcElectricConductanceMeasure) | default::IfcMagneticFluxMeasure) | default::IfcPlanarForceMeasure) | default::IfcPowerMeasure) | default::IfcAbsorbedDoseMeasure) | default::IfcIonConcentrationMeasure) | default::IfcMassFlowRateMeasure) | default::IfcPressureMeasure) | default::IfcRotationalMassMeasure) | default::IfcSoundPressureLevelMeasure) | default::IfcRotationalStiffnessMeasure) | default::IfcHeatFluxDensityMeasure) | default::IfcMoistureDiffusivityMeasure) | default::IfcIlluminanceMeasure) | default::IfcEnergyMeasure) | default::IfcElectricChargeMeasure) | default::IfcCurvatureMeasure) | default::IfcRadioActivityMeasure) | default::IfcSectionModulusMeasure) | default::IfcHeatingValueMeasure) | default::IfcElectricCapacitanceMeasure) | default::IfcModulusOfSubgradeReactionMeasure) | default::IfcModulusOfLinearSubgradeReactionMeasure) | default::IfcLinearStiffnessMeasure) | default::IfcInductanceMeasure) | default::IfcSectionalAreaIntegralMeasure) | default::IfcLuminousFluxMeasure) | default::IfcAreaDensityMeasure) | default::IfcMassDensityMeasure) | default::IfcTemperatureGradientMeasure) | default::IfcRotationalFrequencyMeasure) | default::IfcThermalTransmittanceMeasure) | default::IfcModulusOfRotationalSubgradeReactionMeasure) | default::IfcSpecificHeatCapacityMeasure) | default::IfcVaporPermeabilityMeasure) | default::IfcWarpingMomentMeasure) | default::IfcMolecularWeightMeasure) | default::IfcCompoundPlaneAngleMeasure) | default::IfcDynamicViscosityMeasure) | default::IfcSoundPressureMeasure) | default::IfcLinearMomentMeasure) | default::IfcAngularVelocityMeasure) | default::IfcShearModulusMeasure) | default::IfcThermalResistanceMeasure) | default::IfcSoundPowerMeasure) | default::IfcPHMeasure) | default::IfcIntegerCountRateMeasure) | default::IfcKinematicViscosityMeasure) | default::IfcMagneticFluxDensityMeasure) | default::IfcThermalExpansionCoefficientMeasure) | default::IfcFrequencyMeasure) | default::IfcTemperatureRateOfChangeMeasure) | default::IfcElectricVoltageMeasure) | default::IfcForceMeasure) | default::IfcIsothermalMoistureCapacityMeasure) | default::IfcTorqueMeasure) | default::IfcAccelerationMeasure) | default::IfcLuminousIntensityDistributionMeasure) | default::IfcLinearVelocityMeasure) | default::IfcModulusOfElasticityMeasure) | default::IfcWarpingConstantMeasure) | default::IfcElectricResistanceMeasure) | default::IfcThermalAdmittanceMeasure) | default::IfcLinearForceMeasure) | default::IfcDoseEquivalentMeasure);
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
  CREATE TYPE default::IfcPersonAndOrganization {
      CREATE MULTI LINK Roles -> default::IfcActorRole;
      CREATE REQUIRED LINK TheOrganization -> default::IfcOrganization;
      CREATE REQUIRED LINK ThePerson -> default::IfcPerson;
  };
  CREATE TYPE default::IfcActorSelect {
      CREATE LINK IfcActorSelect -> ((default::IfcPersonAndOrganization | default::IfcOrganization) | default::IfcPerson);
  };
  CREATE TYPE default::IfcApproval {
      CREATE LINK GivingApproval -> default::IfcActorSelect;
      CREATE LINK RequestingApproval -> default::IfcActorSelect;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Identifier -> std::str;
      CREATE PROPERTY Level -> std::str;
      CREATE PROPERTY Name -> std::str;
      CREATE PROPERTY Qualifier -> std::str;
      CREATE PROPERTY Status -> std::str;
      CREATE PROPERTY TimeOfApproval -> std::str;
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
  CREATE TYPE default::IfcContextDependentUnit EXTENDING default::IfcNamedUnit {
      CREATE REQUIRED PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcConversionBasedUnit EXTENDING default::IfcNamedUnit {
      CREATE REQUIRED LINK ConversionFactor -> default::IfcMeasureWithUnit;
      CREATE REQUIRED PROPERTY Name -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcExternalInformation;
  CREATE ABSTRACT TYPE default::IfcExternalReference {
      CREATE PROPERTY Identification -> std::str;
      CREATE PROPERTY Location -> std::str;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcMaterialDefinition;
  CREATE ABSTRACT TYPE default::IfcPhysicalQuantity {
      CREATE PROPERTY Description -> std::str;
      CREATE REQUIRED PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcProfileDef {
      CREATE PROPERTY ProfileName -> std::str;
      CREATE REQUIRED PROPERTY ProfileType -> std::str {
          CREATE CONSTRAINT std::one_of('AREA', 'CURVE');
      };
  };
  CREATE ABSTRACT TYPE default::IfcPropertyAbstraction;
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
  CREATE ABSTRACT TYPE default::IfcProductRepresentation {
      CREATE REQUIRED MULTI LINK Representations -> default::IfcRepresentation;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcProductDefinitionShape EXTENDING default::IfcProductRepresentation;
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
  CREATE TYPE default::IfcRepresentationMap {
      CREATE REQUIRED LINK MappingOrigin -> default::IfcAxis2Placement;
      CREATE REQUIRED LINK MappedRepresentation -> default::IfcRepresentation;
  };
  CREATE TYPE default::IfcProductRepresentationSelect {
      CREATE LINK IfcProductRepresentationSelect -> (default::IfcProductDefinitionShape | default::IfcRepresentationMap);
  };
  CREATE ABSTRACT TYPE default::IfcShapeModel EXTENDING default::IfcRepresentation;
  CREATE TYPE default::IfcShapeAspect {
      CREATE LINK PartOfProductDefinitionShape -> default::IfcProductRepresentationSelect;
      CREATE REQUIRED MULTI LINK ShapeRepresentations -> default::IfcShapeModel;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Name -> std::str;
      CREATE REQUIRED PROPERTY ProductDefinitional -> std::bool;
  };
  CREATE TYPE default::IfcResourceObjectSelect {
      CREATE LINK IfcResourceObjectSelect -> ((((((((((((((((default::IfcTimeSeries | default::IfcConstraint) | default::IfcPerson) | default::IfcOrganization) | default::IfcPhysicalQuantity) | default::IfcExternalInformation) | default::IfcShapeAspect) | default::IfcProfileDef) | default::IfcConversionBasedUnit) | default::IfcAppliedValue) | default::IfcApproval) | default::IfcActorRole) | default::IfcPersonAndOrganization) | default::IfcPropertyAbstraction) | default::IfcMaterialDefinition) | default::IfcExternalReference) | default::IfcContextDependentUnit);
  };
  CREATE TYPE default::IfcObjectReferenceSelect {
      CREATE LINK IfcObjectReferenceSelect -> ((((((((default::IfcTimeSeries | default::IfcPerson) | default::IfcTable) | default::IfcOrganization) | default::IfcAppliedValue) | default::IfcAddress) | default::IfcPersonAndOrganization) | default::IfcMaterialDefinition) | default::IfcExternalReference);
  };
  CREATE TYPE default::IfcMeasureValue {
      CREATE LINK IfcMeasureValue -> ((((((((((((((((((((((default::IfcDescriptiveMeasure | default::IfcPositiveRatioMeasure) | default::IfcNormalisedRatioMeasure) | default::IfcTimeMeasure) | default::IfcNonNegativeLengthMeasure) | default::IfcComplexNumber) | default::IfcNumericMeasure) | default::IfcElectricCurrentMeasure) | default::IfcAreaMeasure) | default::IfcSolidAngleMeasure) | default::IfcPositiveLengthMeasure) | default::IfcMassMeasure) | default::IfcLuminousIntensityMeasure) | default::IfcVolumeMeasure) | default::IfcThermodynamicTemperatureMeasure) | default::IfcRatioMeasure) | default::IfcContextDependentMeasure) | default::IfcCountMeasure) | default::IfcPlaneAngleMeasure) | default::IfcAmountOfSubstanceMeasure) | default::IfcPositivePlaneAngleMeasure) | default::IfcLengthMeasure) | default::IfcParameterValue);
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
  CREATE TYPE default::IfcSimpleValue {
      CREATE LINK IfcSimpleValue -> (((((((((((((default::IfcTimeStamp | default::IfcDateTime) | default::IfcLabel) | default::IfcLogical) | default::IfcBoolean) | default::IfcDuration) | default::IfcPositiveInteger) | default::IfcBinary) | default::IfcDate) | default::IfcInteger) | default::IfcIdentifier) | default::IfcTime) | default::IfcText) | default::IfcReal);
  };
  CREATE TYPE default::IfcTranslationalStiffnessSelect {
      CREATE LINK IfcTranslationalStiffnessSelect -> (default::IfcBoolean | default::IfcLinearStiffnessMeasure);
  };
  CREATE TYPE default::IfcModulusOfTranslationalSubgradeReactionSelect {
      CREATE LINK IfcModulusOfTranslationalSubgradeReactionSelect -> (default::IfcBoolean | default::IfcModulusOfLinearSubgradeReactionMeasure);
  };
  CREATE TYPE default::IfcModulusOfRotationalSubgradeReactionSelect {
      CREATE LINK IfcModulusOfRotationalSubgradeReactionSelect -> (default::IfcBoolean | default::IfcModulusOfRotationalSubgradeReactionMeasure);
  };
  CREATE TYPE default::IfcModulusOfSubgradeReactionSelect {
      CREATE LINK IfcModulusOfSubgradeReactionSelect -> (default::IfcModulusOfSubgradeReactionMeasure | default::IfcBoolean);
  };
  CREATE TYPE default::IfcRotationalStiffnessSelect {
      CREATE LINK IfcRotationalStiffnessSelect -> (default::IfcRotationalStiffnessMeasure | default::IfcBoolean);
  };
  CREATE TYPE default::IfcWarpingStiffnessSelect {
      CREATE LINK IfcWarpingStiffnessSelect -> (default::IfcBoolean | default::IfcWarpingMomentMeasure);
  };
  CREATE TYPE default::IfcBooleanResult EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED PROPERTY Operator -> std::str {
          CREATE CONSTRAINT std::one_of('DIFFERENCE', 'INTERSECTION', 'UNION');
      };
  };
  CREATE ABSTRACT TYPE default::IfcCsgPrimitive3D EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED LINK Position -> default::IfcAxis2Placement3D;
  };
  CREATE TYPE default::IfcHalfSpaceSolid EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED LINK BaseSurface -> default::IfcSurface;
      CREATE REQUIRED PROPERTY AgreementFlag -> std::bool;
  };
  CREATE ABSTRACT TYPE default::IfcSolidModel EXTENDING default::IfcGeometricRepresentationItem;
  CREATE TYPE default::IfcBooleanOperand {
      CREATE LINK IfcBooleanOperand -> ((((default::IfcBooleanResult | default::IfcHalfSpaceSolid) | default::IfcTessellatedFaceSet) | default::IfcSolidModel) | default::IfcCsgPrimitive3D);
  };
  CREATE TYPE default::IfcCsgSelect {
      CREATE LINK IfcCsgSelect -> (default::IfcBooleanResult | default::IfcCsgPrimitive3D);
  };
  CREATE ABSTRACT TYPE default::IfcBoundedCurve EXTENDING default::IfcCurve;
  CREATE ABSTRACT TYPE default::IfcTopologicalRepresentationItem EXTENDING default::IfcRepresentationItem;
  CREATE TYPE default::IfcVertex EXTENDING default::IfcTopologicalRepresentationItem;
  CREATE TYPE default::IfcEdge EXTENDING default::IfcTopologicalRepresentationItem {
      CREATE LINK EdgeEnd -> default::IfcVertex;
      CREATE LINK EdgeStart -> default::IfcVertex;
  };
  CREATE TYPE default::IfcEdgeCurve EXTENDING default::IfcEdge {
      CREATE REQUIRED LINK EdgeGeometry -> default::IfcCurve;
      CREATE REQUIRED PROPERTY SameSense -> std::bool;
  };
  CREATE TYPE default::IfcCurveOrEdgeCurve {
      CREATE LINK IfcCurveOrEdgeCurve -> (default::IfcEdgeCurve | default::IfcBoundedCurve);
  };
  CREATE TYPE default::IfcTrimmingSelect {
      CREATE LINK IfcTrimmingSelect -> (default::IfcCartesianPoint | default::IfcParameterValue);
  };
  CREATE TYPE default::IfcClassification EXTENDING default::IfcExternalInformation {
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Location -> std::str;
      CREATE REQUIRED PROPERTY Name -> std::str;
      CREATE PROPERTY Edition -> std::str;
      CREATE PROPERTY EditionDate -> std::str;
      CREATE PROPERTY ReferenceTokens -> tuple<std::str>;
      CREATE PROPERTY Source -> std::str;
  };
  CREATE TYPE default::IfcClassificationReference EXTENDING default::IfcExternalReference {
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Sort -> std::str;
  };
  CREATE TYPE default::IfcClassificationReferenceSelect {
      CREATE LINK IfcClassificationReferenceSelect -> (default::IfcClassification | default::IfcClassificationReference);
  };
  CREATE TYPE default::IfcClassificationSelect {
      CREATE LINK IfcClassificationSelect -> (default::IfcClassification | default::IfcClassificationReference);
  };
  CREATE TYPE default::IfcLoop EXTENDING default::IfcTopologicalRepresentationItem;
  CREATE TYPE default::IfcFaceBound EXTENDING default::IfcTopologicalRepresentationItem {
      CREATE REQUIRED LINK Bound -> default::IfcLoop;
      CREATE REQUIRED PROPERTY Orientation -> std::bool;
  };
  CREATE TYPE default::IfcFace EXTENDING default::IfcTopologicalRepresentationItem {
      CREATE REQUIRED MULTI LINK Bounds -> default::IfcFaceBound;
  };
  CREATE TYPE default::IfcConnectedFaceSet EXTENDING default::IfcTopologicalRepresentationItem {
      CREATE REQUIRED MULTI LINK CfsFaces -> default::IfcFace;
  };
  CREATE TYPE default::IfcClosedShell EXTENDING default::IfcConnectedFaceSet;
  CREATE TYPE default::IfcOpenShell EXTENDING default::IfcConnectedFaceSet;
  CREATE TYPE default::IfcShell {
      CREATE LINK IfcShell -> (default::IfcClosedShell | default::IfcOpenShell);
  };
  CREATE TYPE default::IfcSolidOrShell {
      CREATE LINK IfcSolidOrShell -> (default::IfcClosedShell | default::IfcSolidModel);
  };
  CREATE ABSTRACT TYPE default::IfcColourSpecification EXTENDING default::IfcPresentationItem {
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcColourRgb EXTENDING default::IfcColourSpecification {
      CREATE REQUIRED PROPERTY Blue -> std::float64;
      CREATE REQUIRED PROPERTY Green -> std::float64;
      CREATE REQUIRED PROPERTY Red -> std::float64;
  };
  CREATE TYPE default::IfcColourOrFactor {
      CREATE LINK IfcColourOrFactor -> (default::IfcNormalisedRatioMeasure | default::IfcColourRgb);
  };
  CREATE TYPE default::IfcExternallyDefinedHatchStyle EXTENDING default::IfcExternalReference;
  CREATE ABSTRACT TYPE default::IfcPreDefinedItem EXTENDING default::IfcPresentationItem {
      CREATE REQUIRED PROPERTY Name -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcPreDefinedColour EXTENDING default::IfcPreDefinedItem;
  CREATE TYPE default::IfcColour {
      CREATE LINK IfcColour -> (default::IfcColourSpecification | default::IfcPreDefinedColour);
  };
  CREATE TYPE default::IfcCurveStyleFontPattern EXTENDING default::IfcPresentationItem {
      CREATE REQUIRED PROPERTY InvisibleSegmentLength -> std::float64;
      CREATE REQUIRED PROPERTY VisibleSegmentLength -> std::float64;
  };
  CREATE TYPE default::IfcCurveStyleFont EXTENDING default::IfcPresentationItem {
      CREATE PROPERTY Name -> std::str;
      CREATE REQUIRED MULTI LINK PatternList -> default::IfcCurveStyleFontPattern;
  };
  CREATE ABSTRACT TYPE default::IfcPreDefinedCurveFont EXTENDING default::IfcPreDefinedItem;
  CREATE TYPE default::IfcCurveStyleFontSelect {
      CREATE LINK IfcCurveStyleFontSelect -> (default::IfcPreDefinedCurveFont | default::IfcCurveStyleFont);
  };
  CREATE TYPE default::IfcCurveStyleFontAndScaling EXTENDING default::IfcPresentationItem {
      CREATE PROPERTY Name -> std::str;
      CREATE REQUIRED LINK CurveFont -> default::IfcCurveStyleFontSelect;
      CREATE REQUIRED PROPERTY CurveFontScaling -> std::float64;
  };
  CREATE TYPE default::IfcCurveFontOrScaledCurveFontSelect {
      CREATE LINK IfcCurveFontOrScaledCurveFontSelect -> ((default::IfcPreDefinedCurveFont | default::IfcCurveStyleFont) | default::IfcCurveStyleFontAndScaling);
  };
  CREATE ABSTRACT TYPE default::IfcPresentationStyle {
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcSizeSelect {
      CREATE LINK IfcSizeSelect -> (((((default::IfcDescriptiveMeasure | default::IfcPositiveRatioMeasure) | default::IfcPositiveLengthMeasure) | default::IfcNormalisedRatioMeasure) | default::IfcRatioMeasure) | default::IfcLengthMeasure);
  };
  CREATE TYPE default::IfcCurveStyle EXTENDING default::IfcPresentationStyle {
      CREATE LINK CurveColour -> default::IfcColour;
      CREATE LINK CurveFont -> default::IfcCurveFontOrScaledCurveFontSelect;
      CREATE LINK CurveWidth -> default::IfcSizeSelect;
      CREATE PROPERTY ModelOrDraughting -> std::bool;
  };
  CREATE TYPE default::IfcVector EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED LINK Orientation -> default::IfcDirection;
      CREATE REQUIRED PROPERTY Magnitude -> std::float64;
  };
  CREATE TYPE default::IfcHatchLineDistanceSelect {
      CREATE LINK IfcHatchLineDistanceSelect -> (default::IfcVector | default::IfcPositiveLengthMeasure);
  };
  CREATE TYPE default::IfcFillAreaStyleHatching EXTENDING default::IfcGeometricRepresentationItem {
      CREATE LINK PatternStart -> default::IfcCartesianPoint;
      CREATE LINK PointOfReferenceHatchLine -> default::IfcCartesianPoint;
      CREATE REQUIRED LINK HatchLineAppearance -> default::IfcCurveStyle;
      CREATE REQUIRED LINK StartOfNextHatchLine -> default::IfcHatchLineDistanceSelect;
      CREATE REQUIRED PROPERTY HatchLineAngle -> std::float64;
  };
  CREATE TYPE default::IfcFillAreaStyleTiles EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED MULTI LINK TilingPattern -> default::IfcVector;
      CREATE REQUIRED PROPERTY TilingScale -> std::float64;
  };
  CREATE TYPE default::IfcFillStyleSelect {
      CREATE LINK IfcFillStyleSelect -> ((((default::IfcExternallyDefinedHatchStyle | default::IfcFillAreaStyleTiles) | default::IfcFillAreaStyleHatching) | default::IfcColourSpecification) | default::IfcPreDefinedColour);
  };
  CREATE TYPE default::IfcCompositeCurveSegment EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED LINK ParentCurve -> default::IfcCurve;
      CREATE REQUIRED PROPERTY SameSense -> std::bool;
      CREATE REQUIRED PROPERTY Transition -> std::str {
          CREATE CONSTRAINT std::one_of('CONTINUOUS', 'CONTSAMEGRADIENT', 'CONTSAMEGRADIENTSAMECURVATURE', 'DISCONTINUOUS');
      };
  };
  CREATE TYPE default::IfcCompositeCurve EXTENDING default::IfcBoundedCurve {
      CREATE REQUIRED MULTI LINK Segments -> default::IfcCompositeCurveSegment;
      CREATE REQUIRED PROPERTY SelfIntersect -> std::bool;
  };
  CREATE TYPE default::IfcCompositeCurveOnSurface EXTENDING default::IfcCompositeCurve;
  CREATE TYPE default::IfcPcurve EXTENDING default::IfcCurve {
      CREATE REQUIRED LINK ReferenceCurve -> default::IfcCurve;
      CREATE REQUIRED LINK BasisSurface -> default::IfcSurface;
  };
  CREATE TYPE default::IfcSurfaceCurve EXTENDING default::IfcCurve {
      CREATE REQUIRED MULTI LINK AssociatedGeometry -> default::IfcPcurve;
      CREATE REQUIRED LINK Curve3D -> default::IfcCurve;
      CREATE REQUIRED PROPERTY MasterRepresentation -> std::str {
          CREATE CONSTRAINT std::one_of('CURVE3D', 'PCURVE_S1', 'PCURVE_S2');
      };
  };
  CREATE TYPE default::IfcCurveOnSurface {
      CREATE LINK IfcCurveOnSurface -> ((default::IfcPcurve | default::IfcSurfaceCurve) | default::IfcCompositeCurveOnSurface);
  };
  CREATE ABSTRACT TYPE default::IfcCoordinateReferenceSystem {
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY GeodeticDatum -> std::str;
      CREATE REQUIRED PROPERTY Name -> std::str;
      CREATE PROPERTY VerticalDatum -> std::str;
  };
  CREATE TYPE default::IfcGeometricRepresentationContext EXTENDING default::IfcRepresentationContext {
      CREATE LINK WorldCoordinateSystem -> default::IfcAxis2Placement;
      CREATE LINK TrueNorth -> default::IfcDirection;
      CREATE PROPERTY CoordinateSpaceDimension -> std::int64;
      CREATE PROPERTY Precision -> std::float64;
  };
  CREATE TYPE default::IfcCoordinateReferenceSystemSelect {
      CREATE LINK IfcCoordinateReferenceSystemSelect -> (default::IfcCoordinateReferenceSystem | default::IfcGeometricRepresentationContext);
  };
  CREATE TYPE default::IfcGeometricSetSelect {
      CREATE LINK IfcGeometricSetSelect -> ((default::IfcSurface | default::IfcCurve) | default::IfcPoint);
  };
  CREATE TYPE default::IfcFillAreaStyle EXTENDING default::IfcPresentationStyle {
      CREATE REQUIRED MULTI LINK FillStyles -> default::IfcFillStyleSelect;
      CREATE PROPERTY ModelorDraughting -> std::bool;
  };
  CREATE TYPE default::IfcNullStyle {
      CREATE REQUIRED PROPERTY IfcNullStyle -> std::str {
          CREATE CONSTRAINT std::one_of('NULL');
      };
  };
  CREATE TYPE default::IfcExternallyDefinedSurfaceStyle EXTENDING default::IfcExternalReference;
  CREATE TYPE default::IfcSurfaceStyleLighting EXTENDING default::IfcPresentationItem {
      CREATE REQUIRED LINK DiffuseReflectionColour -> default::IfcColourRgb;
      CREATE REQUIRED LINK DiffuseTransmissionColour -> default::IfcColourRgb;
      CREATE REQUIRED LINK ReflectanceColour -> default::IfcColourRgb;
      CREATE REQUIRED LINK TransmissionColour -> default::IfcColourRgb;
  };
  CREATE TYPE default::IfcSurfaceStyleRefraction EXTENDING default::IfcPresentationItem {
      CREATE PROPERTY DispersionFactor -> std::float64;
      CREATE PROPERTY RefractionIndex -> std::float64;
  };
  CREATE TYPE default::IfcSurfaceStyleShading EXTENDING default::IfcPresentationItem {
      CREATE REQUIRED LINK SurfaceColour -> default::IfcColourRgb;
      CREATE PROPERTY Transparency -> std::float64;
  };
  CREATE TYPE default::IfcSurfaceStyleWithTextures EXTENDING default::IfcPresentationItem {
      CREATE REQUIRED MULTI LINK Textures -> default::IfcSurfaceTexture;
  };
  CREATE TYPE default::IfcSurfaceStyleElementSelect {
      CREATE LINK IfcSurfaceStyleElementSelect -> ((((default::IfcSurfaceStyleLighting | default::IfcExternallyDefinedSurfaceStyle) | default::IfcSurfaceStyleWithTextures) | default::IfcSurfaceStyleShading) | default::IfcSurfaceStyleRefraction);
  };
  CREATE TYPE default::IfcSurfaceStyle EXTENDING default::IfcPresentationStyle {
      CREATE REQUIRED MULTI LINK Styles -> default::IfcSurfaceStyleElementSelect;
      CREATE REQUIRED PROPERTY Side -> std::str {
          CREATE CONSTRAINT std::one_of('BOTH', 'NEGATIVE', 'POSITIVE');
      };
  };
  CREATE TYPE default::IfcExternallyDefinedTextFont EXTENDING default::IfcExternalReference;
  CREATE ABSTRACT TYPE default::IfcPreDefinedTextFont EXTENDING default::IfcPreDefinedItem;
  CREATE TYPE default::IfcTextFontSelect {
      CREATE LINK IfcTextFontSelect -> (default::IfcPreDefinedTextFont | default::IfcExternallyDefinedTextFont);
  };
  CREATE TYPE default::IfcTextStyleForDefinedFont EXTENDING default::IfcPresentationItem {
      CREATE LINK BackgroundColour -> default::IfcColour;
      CREATE REQUIRED LINK Colour -> default::IfcColour;
  };
  CREATE TYPE default::IfcTextStyleTextModel EXTENDING default::IfcPresentationItem {
      CREATE LINK LetterSpacing -> default::IfcSizeSelect;
      CREATE LINK LineHeight -> default::IfcSizeSelect;
      CREATE LINK TextIndent -> default::IfcSizeSelect;
      CREATE LINK WordSpacing -> default::IfcSizeSelect;
      CREATE PROPERTY TextAlign -> std::str;
      CREATE PROPERTY TextDecoration -> std::str;
      CREATE PROPERTY TextTransform -> std::str;
  };
  CREATE TYPE default::IfcTextStyle EXTENDING default::IfcPresentationStyle {
      CREATE REQUIRED LINK TextFontStyle -> default::IfcTextFontSelect;
      CREATE LINK TextCharacterAppearance -> default::IfcTextStyleForDefinedFont;
      CREATE LINK TextStyle -> default::IfcTextStyleTextModel;
      CREATE PROPERTY ModelOrDraughting -> std::bool;
  };
  CREATE TYPE default::IfcPresentationStyleSelect {
      CREATE LINK IfcPresentationStyleSelect -> ((((default::IfcFillAreaStyle | default::IfcSurfaceStyle) | default::IfcNullStyle) | default::IfcCurveStyle) | default::IfcTextStyle);
  };
  CREATE TYPE default::IfcVectorOrDirection {
      CREATE LINK IfcVectorOrDirection -> (default::IfcVector | default::IfcDirection);
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
  CREATE TYPE default::IfcTimeOrRatioSelect {
      CREATE LINK IfcTimeOrRatioSelect -> (default::IfcDuration | default::IfcRatioMeasure);
  };
  CREATE TYPE default::IfcApplication {
      CREATE REQUIRED LINK ApplicationDeveloper -> default::IfcOrganization;
      CREATE REQUIRED PROPERTY ApplicationFullName -> std::str;
      CREATE REQUIRED PROPERTY ApplicationIdentifier -> std::str;
      CREATE REQUIRED PROPERTY Version -> std::str;
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
  CREATE ABSTRACT TYPE default::IfcObject EXTENDING default::IfcObjectDefinition {
      CREATE PROPERTY ObjectType -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcObjectPlacement;
  CREATE ABSTRACT TYPE default::IfcProduct EXTENDING default::IfcObject {
      CREATE LINK ObjectPlacement -> default::IfcObjectPlacement;
      CREATE LINK Representation -> default::IfcProductRepresentation;
  };
  CREATE ABSTRACT TYPE default::IfcElement EXTENDING default::IfcProduct {
      CREATE PROPERTY Tag -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcStructuralItem EXTENDING default::IfcProduct;
  CREATE TYPE default::IfcStructuralActivityAssignmentSelect {
      CREATE LINK IfcStructuralActivityAssignmentSelect -> (default::IfcElement | default::IfcStructuralItem);
  };
  CREATE TYPE default::IfcLightDistributionData {
      CREATE REQUIRED PROPERTY LuminousIntensity -> tuple<std::float64>;
      CREATE REQUIRED PROPERTY MainPlaneAngle -> std::float64;
      CREATE REQUIRED PROPERTY SecondaryPlaneAngle -> tuple<std::float64>;
  };
  CREATE TYPE default::IfcLightIntensityDistribution {
      CREATE REQUIRED MULTI LINK DistributionData -> default::IfcLightDistributionData;
      CREATE REQUIRED PROPERTY LightDistributionCurve -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'TYPE_A', 'TYPE_B', 'TYPE_C');
      };
  };
  CREATE TYPE default::IfcLightDistributionDataSourceSelect {
      CREATE LINK IfcLightDistributionDataSourceSelect -> (default::IfcLightIntensityDistribution | default::IfcExternalReference);
  };
  CREATE ABSTRACT TYPE default::IfcSpatialElement EXTENDING default::IfcProduct {
      CREATE PROPERTY LongName -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcExternalSpatialStructureElement EXTENDING default::IfcSpatialElement;
  CREATE TYPE default::IfcExternalSpatialElement EXTENDING default::IfcExternalSpatialStructureElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('EXTERNAL', 'EXTERNAL_EARTH', 'EXTERNAL_FIRE', 'EXTERNAL_WATER', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcSpatialStructureElement EXTENDING default::IfcSpatialElement {
      CREATE PROPERTY CompositionType -> std::str {
          CREATE CONSTRAINT std::one_of('COMPLEX', 'ELEMENT', 'PARTIAL');
      };
  };
  CREATE TYPE default::IfcSpace EXTENDING default::IfcSpatialStructureElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('EXTERNAL', 'GFA', 'INTERNAL', 'NOTDEFINED', 'PARKING', 'SPACE', 'USERDEFINED');
      };
      CREATE PROPERTY ElevationWithFlooring -> std::float64;
  };
  CREATE TYPE default::IfcSpaceBoundarySelect {
      CREATE LINK IfcSpaceBoundarySelect -> (default::IfcExternalSpatialElement | default::IfcSpace);
  };
  CREATE TYPE default::IfcFaceBasedSurfaceModel EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED MULTI LINK FbsmFaces -> default::IfcConnectedFaceSet;
  };
  CREATE TYPE default::IfcFaceSurface EXTENDING default::IfcFace {
      CREATE REQUIRED LINK FaceSurface -> default::IfcSurface;
      CREATE REQUIRED PROPERTY SameSense -> std::bool;
  };
  CREATE TYPE default::IfcSurfaceOrFaceSurface {
      CREATE LINK IfcSurfaceOrFaceSurface -> ((default::IfcFaceSurface | default::IfcSurface) | default::IfcFaceBasedSurfaceModel);
  };
  CREATE TYPE default::IfcBendingParameterSelect {
      CREATE LINK IfcBendingParameterSelect -> (default::IfcLengthMeasure | default::IfcPlaneAngleMeasure);
  };
  CREATE TYPE default::IfcLibraryInformation EXTENDING default::IfcExternalInformation {
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Location -> std::str;
      CREATE REQUIRED PROPERTY Name -> std::str;
      CREATE LINK Publisher -> default::IfcActorSelect;
      CREATE PROPERTY Version -> std::str;
      CREATE PROPERTY VersionDate -> std::str;
  };
  CREATE TYPE default::IfcLibraryReference EXTENDING default::IfcExternalReference {
      CREATE PROPERTY Description -> std::str;
      CREATE LINK ReferencedLibrary -> default::IfcLibraryInformation;
      CREATE PROPERTY Language -> std::str;
  };
  CREATE TYPE default::IfcLibrarySelect {
      CREATE LINK IfcLibrarySelect -> (default::IfcLibraryInformation | default::IfcLibraryReference);
  };
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
      CREATE LINK IfcMaterialSelect -> ((default::IfcMaterialUsageDefinition | default::IfcMaterialList) | default::IfcMaterialDefinition);
  };
  CREATE ABSTRACT TYPE default::IfcPropertyDefinition EXTENDING default::IfcRoot;
  CREATE TYPE default::IfcDefinitionSelect {
      CREATE LINK IfcDefinitionSelect -> (default::IfcObjectDefinition | default::IfcPropertyDefinition);
  };
  CREATE TYPE default::IfcVertexPoint EXTENDING default::IfcVertex {
      CREATE REQUIRED LINK VertexGeometry -> default::IfcPoint;
  };
  CREATE TYPE default::IfcPointOrVertexPoint {
      CREATE LINK IfcPointOrVertexPoint -> (default::IfcPoint | default::IfcVertexPoint);
  };
  CREATE TYPE default::IfcPresentationStyleAssignment {
      CREATE REQUIRED MULTI LINK Styles -> default::IfcPresentationStyleSelect;
  };
  CREATE TYPE default::IfcStyleAssignmentSelect {
      CREATE LINK IfcStyleAssignmentSelect -> (default::IfcPresentationStyle | default::IfcPresentationStyleAssignment);
  };
  CREATE ABSTRACT TYPE default::IfcProcess EXTENDING default::IfcObject {
      CREATE PROPERTY Identification -> std::str;
      CREATE PROPERTY LongDescription -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcPropertySetDefinition EXTENDING default::IfcPropertyDefinition;
  CREATE TYPE default::IfcTypeObject EXTENDING default::IfcObjectDefinition {
      CREATE MULTI LINK HasPropertySets -> default::IfcPropertySetDefinition;
      CREATE PROPERTY ApplicableOccurrence -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcTypeProcess EXTENDING default::IfcTypeObject {
      CREATE PROPERTY Identification -> std::str;
      CREATE PROPERTY LongDescription -> std::str;
      CREATE PROPERTY ProcessType -> std::str;
  };
  CREATE TYPE default::IfcProcessSelect {
      CREATE LINK IfcProcessSelect -> (default::IfcTypeProcess | default::IfcProcess);
  };
  CREATE TYPE default::IfcTypeProduct EXTENDING default::IfcTypeObject {
      CREATE MULTI LINK RepresentationMaps -> default::IfcRepresentationMap;
      CREATE PROPERTY Tag -> std::str;
  };
  CREATE TYPE default::IfcProductSelect {
      CREATE LINK IfcProductSelect -> (default::IfcProduct | default::IfcTypeProduct);
  };
  CREATE TYPE default::IfcPropertySetDefinitionSet {
      CREATE REQUIRED MULTI LINK IfcPropertySetDefinitionSet -> default::IfcPropertySetDefinition;
  };
  CREATE TYPE default::IfcPropertySetDefinitionSelect {
      CREATE LINK IfcPropertySetDefinitionSelect -> (default::IfcPropertySetDefinitionSet | default::IfcPropertySetDefinition);
  };
  CREATE TYPE default::IfcLayeredItem {
      CREATE LINK IfcLayeredItem -> (default::IfcRepresentationItem | default::IfcRepresentation);
  };
  CREATE ABSTRACT TYPE default::IfcResource EXTENDING default::IfcObject {
      CREATE PROPERTY Identification -> std::str;
      CREATE PROPERTY LongDescription -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcTypeResource EXTENDING default::IfcTypeObject {
      CREATE PROPERTY Identification -> std::str;
      CREATE PROPERTY LongDescription -> std::str;
      CREATE PROPERTY ResourceType -> std::str;
  };
  CREATE TYPE default::IfcResourceSelect {
      CREATE LINK IfcResourceSelect -> (default::IfcTypeResource | default::IfcResource);
  };
  CREATE TYPE default::IfcSpecularExponent {
      CREATE REQUIRED PROPERTY IfcSpecularExponent -> std::float64;
  };
  CREATE TYPE default::IfcSpecularRoughness {
      CREATE REQUIRED PROPERTY IfcSpecularRoughness -> std::float64;
  };
  CREATE TYPE default::IfcSpecularHighlightSelect {
      CREATE LINK IfcSpecularHighlightSelect -> (default::IfcSpecularExponent | default::IfcSpecularRoughness);
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
  CREATE TYPE default::IfcOccupant EXTENDING default::IfcActor {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ASSIGNEE', 'ASSIGNOR', 'LESSEE', 'LESSOR', 'LETTINGAGENT', 'NOTDEFINED', 'OWNER', 'TENANT', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcRelationship EXTENDING default::IfcRoot;
  CREATE ABSTRACT TYPE default::IfcRelAssigns EXTENDING default::IfcRelationship {
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcObjectDefinition;
      CREATE PROPERTY RelatedObjectsType -> std::str {
          CREATE CONSTRAINT std::one_of('ACTOR', 'CONTROL', 'GROUP', 'NOTDEFINED', 'PROCESS', 'PRODUCT', 'PROJECT', 'RESOURCE');
      };
  };
  CREATE TYPE default::IfcRelAssignsToActor EXTENDING default::IfcRelAssigns {
      CREATE REQUIRED LINK RelatingActor -> default::IfcActor;
      CREATE LINK ActingRole -> default::IfcActorRole;
  };
  CREATE TYPE default::IfcMetric EXTENDING default::IfcConstraint {
      CREATE LINK DataValue -> default::IfcMetricValueSelect;
      CREATE LINK ReferencePath -> default::IfcReference;
      CREATE REQUIRED PROPERTY Benchmark -> std::str {
          CREATE CONSTRAINT std::one_of('EQUALTO', 'GREATERTHAN', 'GREATERTHANOREQUALTO', 'INCLUDEDIN', 'INCLUDES', 'LESSTHAN', 'LESSTHANOREQUALTO', 'NOTEQUALTO', 'NOTINCLUDEDIN', 'NOTINCLUDES');
      };
      CREATE PROPERTY ValueSource -> std::str;
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
  CREATE TYPE default::IfcCostValue EXTENDING default::IfcAppliedValue;
  CREATE TYPE default::IfcGroup EXTENDING default::IfcObject;
  CREATE TYPE default::IfcInventory EXTENDING default::IfcGroup {
      CREATE LINK Jurisdiction -> default::IfcActorSelect;
      CREATE LINK CurrentValue -> default::IfcCostValue;
      CREATE LINK OriginalValue -> default::IfcCostValue;
      CREATE MULTI LINK ResponsiblePersons -> default::IfcPerson;
      CREATE PROPERTY LastUpdateDate -> std::str;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ASSETINVENTORY', 'FURNITUREINVENTORY', 'NOTDEFINED', 'SPACEINVENTORY', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcAsset EXTENDING default::IfcGroup {
      CREATE LINK Owner -> default::IfcActorSelect;
      CREATE LINK User -> default::IfcActorSelect;
      CREATE LINK CurrentValue -> default::IfcCostValue;
      CREATE LINK DepreciatedValue -> default::IfcCostValue;
      CREATE LINK OriginalValue -> default::IfcCostValue;
      CREATE LINK ResponsiblePerson -> default::IfcPerson;
      CREATE LINK TotalReplacementCost -> default::IfcCostValue;
      CREATE PROPERTY Identification -> std::str;
      CREATE PROPERTY IncorporationDate -> std::str;
  };
  CREATE TYPE default::IfcDistributionElement EXTENDING default::IfcElement;
  CREATE TYPE default::IfcDistributionControlElement EXTENDING default::IfcDistributionElement;
  CREATE TYPE default::IfcActuator EXTENDING default::IfcDistributionControlElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ELECTRICACTUATOR', 'HANDOPERATEDACTUATOR', 'HYDRAULICACTUATOR', 'NOTDEFINED', 'PNEUMATICACTUATOR', 'THERMOSTATICACTUATOR', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcElementType EXTENDING default::IfcTypeProduct {
      CREATE PROPERTY ElementType -> std::str;
  };
  CREATE TYPE default::IfcDistributionElementType EXTENDING default::IfcElementType;
  CREATE ABSTRACT TYPE default::IfcDistributionControlElementType EXTENDING default::IfcDistributionElementType;
  CREATE TYPE default::IfcActuatorType EXTENDING default::IfcDistributionControlElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ELECTRICACTUATOR', 'HANDOPERATEDACTUATOR', 'HYDRAULICACTUATOR', 'NOTDEFINED', 'PNEUMATICACTUATOR', 'THERMOSTATICACTUATOR', 'USERDEFINED');
      };
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
  CREATE TYPE default::IfcTelecomAddress EXTENDING default::IfcAddress {
      CREATE PROPERTY ElectronicMailAddresses -> tuple<std::str>;
      CREATE PROPERTY FacsimileNumbers -> tuple<std::str>;
      CREATE PROPERTY MessagingIDs -> tuple<std::str>;
      CREATE PROPERTY PagerNumber -> std::str;
      CREATE PROPERTY TelephoneNumbers -> tuple<std::str>;
      CREATE PROPERTY WWWHomePageURL -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcManifoldSolidBrep EXTENDING default::IfcSolidModel {
      CREATE REQUIRED LINK Outer -> default::IfcClosedShell;
  };
  CREATE TYPE default::IfcAdvancedBrep EXTENDING default::IfcManifoldSolidBrep;
  CREATE TYPE default::IfcAdvancedBrepWithVoids EXTENDING default::IfcAdvancedBrep {
      CREATE REQUIRED MULTI LINK Voids -> default::IfcClosedShell;
  };
  CREATE TYPE default::IfcAdvancedFace EXTENDING default::IfcFaceSurface;
  CREATE TYPE default::IfcDistributionFlowElement EXTENDING default::IfcDistributionElement;
  CREATE TYPE default::IfcFlowTerminal EXTENDING default::IfcDistributionFlowElement;
  CREATE TYPE default::IfcAirTerminal EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DIFFUSER', 'GRILLE', 'LOUVRE', 'NOTDEFINED', 'REGISTER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcFlowController EXTENDING default::IfcDistributionFlowElement;
  CREATE TYPE default::IfcAirTerminalBox EXTENDING default::IfcFlowController {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONSTANTFLOW', 'NOTDEFINED', 'USERDEFINED', 'VARIABLEFLOWPRESSUREDEPENDANT', 'VARIABLEFLOWPRESSUREINDEPENDANT');
      };
  };
  CREATE ABSTRACT TYPE default::IfcDistributionFlowElementType EXTENDING default::IfcDistributionElementType;
  CREATE ABSTRACT TYPE default::IfcFlowControllerType EXTENDING default::IfcDistributionFlowElementType;
  CREATE TYPE default::IfcAirTerminalBoxType EXTENDING default::IfcFlowControllerType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONSTANTFLOW', 'NOTDEFINED', 'USERDEFINED', 'VARIABLEFLOWPRESSUREDEPENDANT', 'VARIABLEFLOWPRESSUREINDEPENDANT');
      };
  };
  CREATE ABSTRACT TYPE default::IfcFlowTerminalType EXTENDING default::IfcDistributionFlowElementType;
  CREATE TYPE default::IfcAirTerminalType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DIFFUSER', 'GRILLE', 'LOUVRE', 'NOTDEFINED', 'REGISTER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcEnergyConversionDevice EXTENDING default::IfcDistributionFlowElement;
  CREATE TYPE default::IfcAirToAirHeatRecovery EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FIXEDPLATECOUNTERFLOWEXCHANGER', 'FIXEDPLATECROSSFLOWEXCHANGER', 'FIXEDPLATEPARALLELFLOWEXCHANGER', 'HEATPIPE', 'NOTDEFINED', 'ROTARYWHEEL', 'RUNAROUNDCOILLOOP', 'THERMOSIPHONCOILTYPEHEATEXCHANGERS', 'THERMOSIPHONSEALEDTUBEHEATEXCHANGERS', 'TWINTOWERENTHALPYRECOVERYLOOPS', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcEnergyConversionDeviceType EXTENDING default::IfcDistributionFlowElementType;
  CREATE TYPE default::IfcAirToAirHeatRecoveryType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FIXEDPLATECOUNTERFLOWEXCHANGER', 'FIXEDPLATECROSSFLOWEXCHANGER', 'FIXEDPLATEPARALLELFLOWEXCHANGER', 'HEATPIPE', 'NOTDEFINED', 'ROTARYWHEEL', 'RUNAROUNDCOILLOOP', 'THERMOSIPHONCOILTYPEHEATEXCHANGERS', 'THERMOSIPHONSEALEDTUBEHEATEXCHANGERS', 'TWINTOWERENTHALPYRECOVERYLOOPS', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcAlarm EXTENDING default::IfcDistributionControlElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BELL', 'BREAKGLASSBUTTON', 'LIGHT', 'MANUALPULLBOX', 'NOTDEFINED', 'SIREN', 'USERDEFINED', 'WHISTLE');
      };
  };
  CREATE TYPE default::IfcAlarmType EXTENDING default::IfcDistributionControlElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BELL', 'BREAKGLASSBUTTON', 'LIGHT', 'MANUALPULLBOX', 'NOTDEFINED', 'SIREN', 'USERDEFINED', 'WHISTLE');
      };
  };
  CREATE ABSTRACT TYPE default::IfcPositioningElement EXTENDING default::IfcProduct;
  CREATE ABSTRACT TYPE default::IfcLinearPositioningElement EXTENDING default::IfcPositioningElement {
      CREATE REQUIRED LINK Axis -> default::IfcCurve;
  };
  CREATE TYPE default::IfcAlignment EXTENDING default::IfcLinearPositioningElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcAlignment2DSegment EXTENDING default::IfcGeometricRepresentationItem {
      CREATE PROPERTY EndTag -> std::str;
      CREATE PROPERTY StartTag -> std::str;
      CREATE PROPERTY TangentialContinuity -> std::bool;
  };
  CREATE ABSTRACT TYPE default::IfcCurveSegment2D EXTENDING default::IfcBoundedCurve {
      CREATE REQUIRED LINK StartPoint -> default::IfcCartesianPoint;
      CREATE REQUIRED PROPERTY SegmentLength -> std::float64;
      CREATE REQUIRED PROPERTY StartDirection -> std::float64;
  };
  CREATE TYPE default::IfcAlignment2DHorizontalSegment EXTENDING default::IfcAlignment2DSegment {
      CREATE REQUIRED LINK CurveGeometry -> default::IfcCurveSegment2D;
  };
  CREATE TYPE default::IfcAlignment2DHorizontal EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED MULTI LINK Segments -> default::IfcAlignment2DHorizontalSegment;
      CREATE PROPERTY StartDistAlong -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcAlignment2DVerticalSegment EXTENDING default::IfcAlignment2DSegment {
      CREATE REQUIRED PROPERTY HorizontalLength -> std::float64;
      CREATE REQUIRED PROPERTY StartDistAlong -> std::float64;
      CREATE REQUIRED PROPERTY StartGradient -> std::float64;
      CREATE REQUIRED PROPERTY StartHeight -> std::float64;
  };
  CREATE TYPE default::IfcAlignment2DVertical EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED MULTI LINK Segments -> default::IfcAlignment2DVerticalSegment;
  };
  CREATE TYPE default::IfcAlignmentCurve EXTENDING default::IfcBoundedCurve {
      CREATE REQUIRED LINK Horizontal -> default::IfcAlignment2DHorizontal;
      CREATE LINK Vertical -> default::IfcAlignment2DVertical;
      CREATE PROPERTY Tag -> std::str;
  };
  CREATE TYPE default::IfcAlignment2DVerSegCircularArc EXTENDING default::IfcAlignment2DVerticalSegment {
      CREATE REQUIRED PROPERTY IsConvex -> std::bool;
      CREATE REQUIRED PROPERTY Radius -> std::float64;
  };
  CREATE TYPE default::IfcAlignment2DVerSegLine EXTENDING default::IfcAlignment2DVerticalSegment;
  CREATE TYPE default::IfcAlignment2DVerSegParabolicArc EXTENDING default::IfcAlignment2DVerticalSegment {
      CREATE REQUIRED PROPERTY IsConvex -> std::bool;
      CREATE REQUIRED PROPERTY ParabolaConstant -> std::float64;
  };
  CREATE TYPE default::IfcAnnotation EXTENDING default::IfcProduct;
  CREATE TYPE default::IfcAnnotationFillArea EXTENDING default::IfcGeometricRepresentationItem {
      CREATE MULTI LINK InnerBoundaries -> default::IfcCurve;
      CREATE REQUIRED LINK OuterBoundary -> default::IfcCurve;
  };
  CREATE ABSTRACT TYPE default::IfcSchedulingTime {
      CREATE PROPERTY DataOrigin -> std::str {
          CREATE CONSTRAINT std::one_of('MEASURED', 'NOTDEFINED', 'PREDICTED', 'SIMULATED', 'USERDEFINED');
      };
      CREATE PROPERTY Name -> std::str;
      CREATE PROPERTY UserDefinedDataOrigin -> std::str;
  };
  CREATE TYPE default::IfcResourceTime EXTENDING default::IfcSchedulingTime {
      CREATE PROPERTY ActualFinish -> std::str;
      CREATE PROPERTY ActualStart -> std::str;
      CREATE PROPERTY ActualUsage -> std::float64;
      CREATE PROPERTY ActualWork -> std::str;
      CREATE PROPERTY Completion -> std::float64;
      CREATE PROPERTY IsOverAllocated -> std::bool;
      CREATE PROPERTY LevelingDelay -> std::str;
      CREATE PROPERTY RemainingUsage -> std::float64;
      CREATE PROPERTY RemainingWork -> std::str;
      CREATE PROPERTY ScheduleContour -> std::str;
      CREATE PROPERTY ScheduleFinish -> std::str;
      CREATE PROPERTY ScheduleStart -> std::str;
      CREATE PROPERTY ScheduleUsage -> std::float64;
      CREATE PROPERTY ScheduleWork -> std::str;
      CREATE PROPERTY StatusTime -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcConstructionResource EXTENDING default::IfcResource {
      CREATE MULTI LINK BaseCosts -> default::IfcAppliedValue;
      CREATE LINK BaseQuantity -> default::IfcPhysicalQuantity;
      CREATE LINK Usage -> default::IfcResourceTime;
  };
  CREATE TYPE default::IfcConstructionEquipmentResource EXTENDING default::IfcConstructionResource {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DEMOLISHING', 'EARTHMOVING', 'ERECTING', 'HEATING', 'LIGHTING', 'NOTDEFINED', 'PAVING', 'PUMPING', 'TRANSPORTING', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcConstructionResourceType EXTENDING default::IfcTypeResource {
      CREATE MULTI LINK BaseCosts -> default::IfcAppliedValue;
      CREATE LINK BaseQuantity -> default::IfcPhysicalQuantity;
  };
  CREATE TYPE default::IfcConstructionEquipmentResourceType EXTENDING default::IfcConstructionResourceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DEMOLISHING', 'EARTHMOVING', 'ERECTING', 'HEATING', 'LIGHTING', 'NOTDEFINED', 'PAVING', 'PUMPING', 'TRANSPORTING', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcConstructionMaterialResource EXTENDING default::IfcConstructionResource {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AGGREGATES', 'CONCRETE', 'DRYWALL', 'FUEL', 'GYPSUM', 'MASONRY', 'METAL', 'NOTDEFINED', 'PLASTIC', 'USERDEFINED', 'WOOD');
      };
  };
  CREATE TYPE default::IfcConstructionMaterialResourceType EXTENDING default::IfcConstructionResourceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AGGREGATES', 'CONCRETE', 'DRYWALL', 'FUEL', 'GYPSUM', 'MASONRY', 'METAL', 'NOTDEFINED', 'PLASTIC', 'USERDEFINED', 'WOOD');
      };
  };
  CREATE TYPE default::IfcConstructionProductResource EXTENDING default::IfcConstructionResource {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ASSEMBLY', 'FORMWORK', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcConstructionProductResourceType EXTENDING default::IfcConstructionResourceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ASSEMBLY', 'FORMWORK', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSubContractResource EXTENDING default::IfcConstructionResource {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'PURCHASE', 'USERDEFINED', 'WORK');
      };
  };
  CREATE TYPE default::IfcLaborResource EXTENDING default::IfcConstructionResource {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ADMINISTRATION', 'CARPENTRY', 'CLEANING', 'CONCRETE', 'DRYWALL', 'ELECTRIC', 'FINISHING', 'FLOORING', 'GENERAL', 'HVAC', 'LANDSCAPING', 'MASONRY', 'NOTDEFINED', 'PAINTING', 'PAVING', 'PLUMBING', 'ROOFING', 'SITEGRADING', 'STEELWORK', 'SURVEYING', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCrewResource EXTENDING default::IfcConstructionResource {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'OFFICE', 'SITE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCrewResourceType EXTENDING default::IfcConstructionResourceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'OFFICE', 'SITE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSubContractResourceType EXTENDING default::IfcConstructionResourceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'PURCHASE', 'USERDEFINED', 'WORK');
      };
  };
  CREATE TYPE default::IfcLaborResourceType EXTENDING default::IfcConstructionResourceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ADMINISTRATION', 'CARPENTRY', 'CLEANING', 'CONCRETE', 'DRYWALL', 'ELECTRIC', 'FINISHING', 'FLOORING', 'GENERAL', 'HVAC', 'LANDSCAPING', 'MASONRY', 'NOTDEFINED', 'PAINTING', 'PAVING', 'PLUMBING', 'ROOFING', 'SITEGRADING', 'STEELWORK', 'SURVEYING', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcResourceLevelRelationship {
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcApprovalRelationship EXTENDING default::IfcResourceLevelRelationship {
      CREATE REQUIRED MULTI LINK RelatedApprovals -> default::IfcApproval;
      CREATE REQUIRED LINK RelatingApproval -> default::IfcApproval;
  };
  CREATE ABSTRACT TYPE default::IfcRelAssociates EXTENDING default::IfcRelationship {
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcDefinitionSelect;
  };
  CREATE TYPE default::IfcRelAssociatesApproval EXTENDING default::IfcRelAssociates {
      CREATE REQUIRED LINK RelatingApproval -> default::IfcApproval;
  };
  CREATE TYPE default::IfcResourceApprovalRelationship EXTENDING default::IfcResourceLevelRelationship {
      CREATE REQUIRED LINK RelatingApproval -> default::IfcApproval;
      CREATE REQUIRED MULTI LINK RelatedResourceObjects -> default::IfcResourceObjectSelect;
  };
  CREATE TYPE default::IfcArbitraryClosedProfileDef EXTENDING default::IfcProfileDef {
      CREATE REQUIRED LINK OuterCurve -> default::IfcCurve;
  };
  CREATE TYPE default::IfcArbitraryProfileDefWithVoids EXTENDING default::IfcArbitraryClosedProfileDef {
      CREATE REQUIRED MULTI LINK InnerCurves -> default::IfcCurve;
  };
  CREATE TYPE default::IfcArbitraryOpenProfileDef EXTENDING default::IfcProfileDef {
      CREATE REQUIRED LINK Curve -> default::IfcBoundedCurve;
  };
  CREATE TYPE default::IfcCenterLineProfileDef EXTENDING default::IfcArbitraryOpenProfileDef {
      CREATE REQUIRED PROPERTY Thickness -> std::float64;
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
  CREATE TYPE default::IfcAudioVisualAppliance EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AMPLIFIER', 'CAMERA', 'DISPLAY', 'MICROPHONE', 'NOTDEFINED', 'PLAYER', 'PROJECTOR', 'RECEIVER', 'SPEAKER', 'SWITCHER', 'TELEPHONE', 'TUNER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcAudioVisualApplianceType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AMPLIFIER', 'CAMERA', 'DISPLAY', 'MICROPHONE', 'NOTDEFINED', 'PLAYER', 'PROJECTOR', 'RECEIVER', 'SPEAKER', 'SWITCHER', 'TELEPHONE', 'TUNER', 'USERDEFINED');
      };
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
  CREATE TYPE default::IfcRevolvedAreaSolidTapered EXTENDING default::IfcRevolvedAreaSolid {
      CREATE REQUIRED LINK EndSweptArea -> default::IfcProfileDef;
  };
  CREATE ABSTRACT TYPE default::IfcSweptSurface EXTENDING default::IfcSurface {
      CREATE LINK Position -> default::IfcAxis2Placement3D;
      CREATE REQUIRED LINK SweptCurve -> default::IfcProfileDef;
  };
  CREATE TYPE default::IfcSurfaceOfRevolution EXTENDING default::IfcSweptSurface {
      CREATE REQUIRED LINK AxisPosition -> default::IfcAxis1Placement;
  };
  CREATE TYPE default::IfcPlanarExtent EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED PROPERTY SizeInX -> std::float64;
      CREATE REQUIRED PROPERTY SizeInY -> std::float64;
  };
  CREATE TYPE default::IfcPlanarBox EXTENDING default::IfcPlanarExtent {
      CREATE REQUIRED LINK Placement -> default::IfcAxis2Placement;
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
  CREATE ABSTRACT TYPE default::IfcConic EXTENDING default::IfcCurve {
      CREATE REQUIRED LINK Position -> default::IfcAxis2Placement;
  };
  CREATE TYPE default::IfcCircle EXTENDING default::IfcConic {
      CREATE REQUIRED PROPERTY Radius -> std::float64;
  };
  CREATE TYPE default::IfcEllipse EXTENDING default::IfcConic {
      CREATE REQUIRED PROPERTY SemiAxis1 -> std::float64;
      CREATE REQUIRED PROPERTY SemiAxis2 -> std::float64;
  };
  CREATE TYPE default::IfcLocalPlacement EXTENDING default::IfcObjectPlacement {
      CREATE REQUIRED LINK RelativePlacement -> default::IfcAxis2Placement;
      CREATE LINK PlacementRelTo -> default::IfcObjectPlacement;
  };
  CREATE TYPE default::IfcGeometricRepresentationSubContext EXTENDING default::IfcGeometricRepresentationContext {
      CREATE REQUIRED LINK ParentContext -> default::IfcGeometricRepresentationContext;
      CREATE PROPERTY TargetScale -> std::float64;
      CREATE REQUIRED PROPERTY TargetView -> std::str {
          CREATE CONSTRAINT std::one_of('ELEVATION_VIEW', 'GRAPH_VIEW', 'MODEL_VIEW', 'NOTDEFINED', 'PLAN_VIEW', 'REFLECTED_PLAN_VIEW', 'SECTION_VIEW', 'SKETCH_VIEW', 'USERDEFINED');
      };
      CREATE PROPERTY UserDefinedTargetView -> std::str;
  };
  CREATE TYPE default::IfcCShapeProfileDef EXTENDING default::IfcParameterizedProfileDef {
      CREATE REQUIRED PROPERTY Depth -> std::float64;
      CREATE REQUIRED PROPERTY Girth -> std::float64;
      CREATE PROPERTY InternalFilletRadius -> std::float64;
      CREATE REQUIRED PROPERTY WallThickness -> std::float64;
      CREATE REQUIRED PROPERTY Width -> std::float64;
  };
  CREATE TYPE default::IfcCircleProfileDef EXTENDING default::IfcParameterizedProfileDef {
      CREATE REQUIRED PROPERTY Radius -> std::float64;
  };
  CREATE TYPE default::IfcCircleHollowProfileDef EXTENDING default::IfcCircleProfileDef {
      CREATE REQUIRED PROPERTY WallThickness -> std::float64;
  };
  CREATE TYPE default::IfcEllipseProfileDef EXTENDING default::IfcParameterizedProfileDef {
      CREATE REQUIRED PROPERTY SemiAxis1 -> std::float64;
      CREATE REQUIRED PROPERTY SemiAxis2 -> std::float64;
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
  CREATE TYPE default::IfcLShapeProfileDef EXTENDING default::IfcParameterizedProfileDef {
      CREATE REQUIRED PROPERTY Depth -> std::float64;
      CREATE PROPERTY EdgeRadius -> std::float64;
      CREATE PROPERTY FilletRadius -> std::float64;
      CREATE PROPERTY LegSlope -> std::float64;
      CREATE REQUIRED PROPERTY Thickness -> std::float64;
      CREATE PROPERTY Width -> std::float64;
  };
  CREATE TYPE default::IfcTrapeziumProfileDef EXTENDING default::IfcParameterizedProfileDef {
      CREATE REQUIRED PROPERTY BottomXDim -> std::float64;
      CREATE REQUIRED PROPERTY TopXDim -> std::float64;
      CREATE REQUIRED PROPERTY TopXOffset -> std::float64;
      CREATE REQUIRED PROPERTY YDim -> std::float64;
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
  CREATE TYPE default::IfcUShapeProfileDef EXTENDING default::IfcParameterizedProfileDef {
      CREATE REQUIRED PROPERTY Depth -> std::float64;
      CREATE PROPERTY EdgeRadius -> std::float64;
      CREATE PROPERTY FilletRadius -> std::float64;
      CREATE PROPERTY FlangeSlope -> std::float64;
      CREATE REQUIRED PROPERTY FlangeThickness -> std::float64;
      CREATE REQUIRED PROPERTY FlangeWidth -> std::float64;
      CREATE REQUIRED PROPERTY WebThickness -> std::float64;
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
  CREATE TYPE default::IfcZShapeProfileDef EXTENDING default::IfcParameterizedProfileDef {
      CREATE REQUIRED PROPERTY Depth -> std::float64;
      CREATE PROPERTY EdgeRadius -> std::float64;
      CREATE PROPERTY FilletRadius -> std::float64;
      CREATE REQUIRED PROPERTY FlangeThickness -> std::float64;
      CREATE REQUIRED PROPERTY FlangeWidth -> std::float64;
      CREATE REQUIRED PROPERTY WebThickness -> std::float64;
  };
  CREATE TYPE default::IfcDistanceExpression EXTENDING default::IfcGeometricRepresentationItem {
      CREATE PROPERTY AlongHorizontal -> std::bool;
      CREATE REQUIRED PROPERTY DistanceAlong -> std::float64;
      CREATE PROPERTY OffsetLateral -> std::float64;
      CREATE PROPERTY OffsetLongitudinal -> std::float64;
      CREATE PROPERTY OffsetVertical -> std::float64;
  };
  CREATE TYPE default::IfcOrientationExpression EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED LINK LateralAxisDirection -> default::IfcDirection;
      CREATE REQUIRED LINK VerticalAxisDirection -> default::IfcDirection;
  };
  CREATE TYPE default::IfcLinearPlacement EXTENDING default::IfcObjectPlacement {
      CREATE LINK CartesianPosition -> default::IfcAxis2Placement3D;
      CREATE REQUIRED LINK PlacementRelTo -> default::IfcCurve;
      CREATE REQUIRED LINK Distance -> default::IfcDistanceExpression;
      CREATE LINK Orientation -> default::IfcOrientationExpression;
  };
  CREATE ABSTRACT TYPE default::IfcBoundaryCondition {
      CREATE PROPERTY Name -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcRelConnects EXTENDING default::IfcRelationship;
  CREATE ABSTRACT TYPE default::IfcStructuralConnection EXTENDING default::IfcStructuralItem {
      CREATE LINK AppliedCondition -> default::IfcBoundaryCondition;
  };
  CREATE ABSTRACT TYPE default::IfcStructuralConnectionCondition {
      CREATE PROPERTY Name -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcStructuralMember EXTENDING default::IfcStructuralItem;
  CREATE TYPE default::IfcRelConnectsStructuralMember EXTENDING default::IfcRelConnects {
      CREATE LINK ConditionCoordinateSystem -> default::IfcAxis2Placement3D;
      CREATE LINK AdditionalConditions -> default::IfcStructuralConnectionCondition;
      CREATE LINK AppliedCondition -> default::IfcBoundaryCondition;
      CREATE REQUIRED LINK RelatedStructuralConnection -> default::IfcStructuralConnection;
      CREATE REQUIRED LINK RelatingStructuralMember -> default::IfcStructuralMember;
      CREATE PROPERTY SupportedLength -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcConnectionGeometry;
  CREATE TYPE default::IfcRelConnectsWithEccentricity EXTENDING default::IfcRelConnectsStructuralMember {
      CREATE REQUIRED LINK ConnectionConstraint -> default::IfcConnectionGeometry;
  };
  CREATE TYPE default::IfcStructuralPointConnection EXTENDING default::IfcStructuralConnection {
      CREATE LINK ConditionCoordinateSystem -> default::IfcAxis2Placement3D;
  };
  CREATE TYPE default::IfcSectionedSpine EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED MULTI LINK CrossSectionPositions -> default::IfcAxis2Placement3D;
      CREATE REQUIRED LINK SpineCurve -> default::IfcCompositeCurve;
      CREATE REQUIRED MULTI LINK CrossSections -> default::IfcProfileDef;
  };
  CREATE TYPE default::IfcStructuralLoadGroup EXTENDING default::IfcGroup {
      CREATE REQUIRED PROPERTY ActionSource -> std::str {
          CREATE CONSTRAINT std::one_of('BRAKES', 'BUOYANCY', 'COMPLETION_G1', 'CREEP', 'CURRENT', 'DEAD_LOAD_G', 'EARTHQUAKE_E', 'ERECTION', 'FIRE', 'ICE', 'IMPACT', 'IMPULSE', 'LACK_OF_FIT', 'LIVE_LOAD_Q', 'NOTDEFINED', 'PRESTRESSING_P', 'PROPPING', 'RAIN', 'SETTLEMENT_U', 'SHRINKAGE', 'SNOW_S', 'SYSTEM_IMPERFECTION', 'TEMPERATURE_T', 'TRANSPORT', 'USERDEFINED', 'WAVE', 'WIND_W');
      };
      CREATE REQUIRED PROPERTY ActionType -> std::str {
          CREATE CONSTRAINT std::one_of('EXTRAORDINARY_A', 'NOTDEFINED', 'PERMANENT_G', 'USERDEFINED', 'VARIABLE_Q');
      };
      CREATE PROPERTY Coefficient -> std::float64;
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('LOAD_CASE', 'LOAD_COMBINATION', 'LOAD_GROUP', 'NOTDEFINED', 'USERDEFINED');
      };
      CREATE PROPERTY Purpose -> std::str;
  };
  CREATE TYPE default::IfcStructuralResultGroup EXTENDING default::IfcGroup {
      CREATE LINK ResultForLoadGroup -> default::IfcStructuralLoadGroup;
      CREATE REQUIRED PROPERTY IsLinear -> std::bool;
      CREATE REQUIRED PROPERTY TheoryType -> std::str {
          CREATE CONSTRAINT std::one_of('FIRST_ORDER_THEORY', 'FULL_NONLINEAR_THEORY', 'NOTDEFINED', 'SECOND_ORDER_THEORY', 'THIRD_ORDER_THEORY', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSystem EXTENDING default::IfcGroup;
  CREATE TYPE default::IfcStructuralAnalysisModel EXTENDING default::IfcSystem {
      CREATE LINK OrientationOf2DPlane -> default::IfcAxis2Placement3D;
      CREATE LINK SharedPlacement -> default::IfcObjectPlacement;
      CREATE MULTI LINK HasResults -> default::IfcStructuralResultGroup;
      CREATE MULTI LINK LoadedBy -> default::IfcStructuralLoadGroup;
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('IN_PLANE_LOADING_2D', 'LOADING_3D', 'NOTDEFINED', 'OUT_PLANE_LOADING_2D', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcBlock EXTENDING default::IfcCsgPrimitive3D {
      CREATE REQUIRED PROPERTY XLength -> std::float64;
      CREATE REQUIRED PROPERTY YLength -> std::float64;
      CREATE REQUIRED PROPERTY ZLength -> std::float64;
  };
  CREATE TYPE default::IfcSphere EXTENDING default::IfcCsgPrimitive3D {
      CREATE REQUIRED PROPERTY Radius -> std::float64;
  };
  CREATE TYPE default::IfcRectangularPyramid EXTENDING default::IfcCsgPrimitive3D {
      CREATE REQUIRED PROPERTY Height -> std::float64;
      CREATE REQUIRED PROPERTY XLength -> std::float64;
      CREATE REQUIRED PROPERTY YLength -> std::float64;
  };
  CREATE TYPE default::IfcRightCircularCylinder EXTENDING default::IfcCsgPrimitive3D {
      CREATE REQUIRED PROPERTY Height -> std::float64;
      CREATE REQUIRED PROPERTY Radius -> std::float64;
  };
  CREATE TYPE default::IfcRightCircularCone EXTENDING default::IfcCsgPrimitive3D {
      CREATE REQUIRED PROPERTY BottomRadius -> std::float64;
      CREATE REQUIRED PROPERTY Height -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcElementarySurface EXTENDING default::IfcSurface {
      CREATE REQUIRED LINK Position -> default::IfcAxis2Placement3D;
  };
  CREATE TYPE default::IfcCylindricalSurface EXTENDING default::IfcElementarySurface {
      CREATE REQUIRED PROPERTY Radius -> std::float64;
  };
  CREATE TYPE default::IfcToroidalSurface EXTENDING default::IfcElementarySurface {
      CREATE REQUIRED PROPERTY MajorRadius -> std::float64;
      CREATE REQUIRED PROPERTY MinorRadius -> std::float64;
  };
  CREATE TYPE default::IfcSphericalSurface EXTENDING default::IfcElementarySurface {
      CREATE REQUIRED PROPERTY Radius -> std::float64;
  };
  CREATE TYPE default::IfcPlane EXTENDING default::IfcElementarySurface;
  CREATE TYPE default::IfcExtrudedAreaSolid EXTENDING default::IfcSweptAreaSolid {
      CREATE REQUIRED LINK ExtrudedDirection -> default::IfcDirection;
      CREATE REQUIRED PROPERTY Depth -> std::float64;
  };
  CREATE TYPE default::IfcExtrudedAreaSolidTapered EXTENDING default::IfcExtrudedAreaSolid {
      CREATE REQUIRED LINK EndSweptArea -> default::IfcProfileDef;
  };
  CREATE TYPE default::IfcFixedReferenceSweptAreaSolid EXTENDING default::IfcSweptAreaSolid {
      CREATE REQUIRED LINK Directrix -> default::IfcCurve;
      CREATE REQUIRED LINK FixedReference -> default::IfcDirection;
      CREATE PROPERTY EndParam -> std::float64;
      CREATE PROPERTY StartParam -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcLightSource EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED LINK LightColour -> default::IfcColourRgb;
      CREATE PROPERTY AmbientIntensity -> std::float64;
      CREATE PROPERTY Intensity -> std::float64;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcLightSourceGoniometric EXTENDING default::IfcLightSource {
      CREATE REQUIRED LINK Position -> default::IfcAxis2Placement3D;
      CREATE LINK ColourAppearance -> default::IfcColourRgb;
      CREATE REQUIRED LINK LightDistributionDataSource -> default::IfcLightDistributionDataSourceSelect;
      CREATE REQUIRED PROPERTY ColourTemperature -> std::float64;
      CREATE REQUIRED PROPERTY LightEmissionSource -> std::str {
          CREATE CONSTRAINT std::one_of('COMPACTFLUORESCENT', 'FLUORESCENT', 'HIGHPRESSUREMERCURY', 'HIGHPRESSURESODIUM', 'LIGHTEMITTINGDIODE', 'LOWPRESSURESODIUM', 'LOWVOLTAGEHALOGEN', 'MAINVOLTAGEHALOGEN', 'METALHALIDE', 'NOTDEFINED', 'TUNGSTENFILAMENT');
      };
      CREATE REQUIRED PROPERTY LuminousFlux -> std::float64;
  };
  CREATE TYPE default::IfcPolygonalBoundedHalfSpace EXTENDING default::IfcHalfSpaceSolid {
      CREATE REQUIRED LINK Position -> default::IfcAxis2Placement3D;
      CREATE REQUIRED LINK PolygonalBoundary -> default::IfcBoundedCurve;
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
  CREATE ABSTRACT TYPE default::IfcBSplineCurve EXTENDING default::IfcBoundedCurve {
      CREATE REQUIRED MULTI LINK ControlPointsList -> default::IfcCartesianPoint;
      CREATE REQUIRED PROPERTY ClosedCurve -> std::bool;
      CREATE REQUIRED PROPERTY CurveForm -> std::str {
          CREATE CONSTRAINT std::one_of('CIRCULAR_ARC', 'ELLIPTIC_ARC', 'HYPERBOLIC_ARC', 'PARABOLIC_ARC', 'POLYLINE_FORM', 'UNSPECIFIED');
      };
      CREATE REQUIRED PROPERTY Degree -> std::int64;
      CREATE REQUIRED PROPERTY SelfIntersect -> std::bool;
  };
  CREATE TYPE default::IfcBSplineCurveWithKnots EXTENDING default::IfcBSplineCurve {
      CREATE REQUIRED PROPERTY KnotMultiplicities -> tuple<std::int64, std::int64>;
      CREATE REQUIRED PROPERTY KnotSpec -> std::str {
          CREATE CONSTRAINT std::one_of('PIECEWISE_BEZIER_KNOTS', 'QUASI_UNIFORM_KNOTS', 'UNIFORM_KNOTS', 'UNSPECIFIED');
      };
      CREATE REQUIRED PROPERTY Knots -> tuple<std::float64, std::float64>;
  };
  CREATE TYPE default::IfcRationalBSplineCurveWithKnots EXTENDING default::IfcBSplineCurveWithKnots {
      CREATE REQUIRED PROPERTY WeightsData -> tuple<std::float64, std::float64>;
  };
  CREATE ABSTRACT TYPE default::IfcBuildingElement EXTENDING default::IfcElement;
  CREATE TYPE default::IfcBeam EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BEAM', 'HOLLOWCORE', 'JOIST', 'LINTEL', 'NOTDEFINED', 'SPANDREL', 'T_BEAM', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcBeamStandardCase EXTENDING default::IfcBeam;
  CREATE ABSTRACT TYPE default::IfcBuildingElementType EXTENDING default::IfcElementType;
  CREATE TYPE default::IfcBeamType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BEAM', 'HOLLOWCORE', 'JOIST', 'LINTEL', 'NOTDEFINED', 'SPANDREL', 'T_BEAM', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcElementComponentType EXTENDING default::IfcElementType;
  CREATE ABSTRACT TYPE default::IfcReinforcingElementType EXTENDING default::IfcElementComponentType;
  CREATE TYPE default::IfcReinforcingBarType EXTENDING default::IfcReinforcingElementType {
      CREATE MULTI LINK BendingParameters -> default::IfcBendingParameterSelect;
      CREATE PROPERTY BarLength -> std::float64;
      CREATE PROPERTY BarSurface -> std::str {
          CREATE CONSTRAINT std::one_of('PLAIN', 'TEXTURED');
      };
      CREATE PROPERTY BendingShapeCode -> std::str;
      CREATE PROPERTY CrossSectionArea -> std::float64;
      CREATE PROPERTY NominalDiameter -> std::float64;
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ANCHORING', 'EDGE', 'LIGATURE', 'MAIN', 'NOTDEFINED', 'PUNCHING', 'RING', 'SHEAR', 'STUD', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcReinforcingMeshType EXTENDING default::IfcReinforcingElementType {
      CREATE MULTI LINK BendingParameters -> default::IfcBendingParameterSelect;
      CREATE PROPERTY BendingShapeCode -> std::str;
      CREATE PROPERTY LongitudinalBarCrossSectionArea -> std::float64;
      CREATE PROPERTY LongitudinalBarNominalDiameter -> std::float64;
      CREATE PROPERTY LongitudinalBarSpacing -> std::float64;
      CREATE PROPERTY MeshLength -> std::float64;
      CREATE PROPERTY MeshWidth -> std::float64;
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'USERDEFINED');
      };
      CREATE PROPERTY TransverseBarCrossSectionArea -> std::float64;
      CREATE PROPERTY TransverseBarNominalDiameter -> std::float64;
      CREATE PROPERTY TransverseBarSpacing -> std::float64;
  };
  CREATE TYPE default::IfcBlobTexture EXTENDING default::IfcSurfaceTexture {
      CREATE REQUIRED PROPERTY RasterCode -> std::bytes;
      CREATE REQUIRED PROPERTY RasterFormat -> std::str;
  };
  CREATE TYPE default::IfcBoiler EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'STEAM', 'USERDEFINED', 'WATER');
      };
  };
  CREATE TYPE default::IfcBoilerType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'STEAM', 'USERDEFINED', 'WATER');
      };
  };
  ALTER TYPE default::IfcBooleanResult {
      CREATE REQUIRED LINK FirstOperand -> default::IfcBooleanOperand;
      CREATE REQUIRED LINK SecondOperand -> default::IfcBooleanOperand;
  };
  CREATE TYPE default::IfcBooleanClippingResult EXTENDING default::IfcBooleanResult;
  CREATE TYPE default::IfcBoundaryEdgeCondition EXTENDING default::IfcBoundaryCondition {
      CREATE LINK RotationalStiffnessByLengthX -> default::IfcModulusOfRotationalSubgradeReactionSelect;
      CREATE LINK RotationalStiffnessByLengthY -> default::IfcModulusOfRotationalSubgradeReactionSelect;
      CREATE LINK RotationalStiffnessByLengthZ -> default::IfcModulusOfRotationalSubgradeReactionSelect;
      CREATE LINK TranslationalStiffnessByLengthX -> default::IfcModulusOfTranslationalSubgradeReactionSelect;
      CREATE LINK TranslationalStiffnessByLengthY -> default::IfcModulusOfTranslationalSubgradeReactionSelect;
      CREATE LINK TranslationalStiffnessByLengthZ -> default::IfcModulusOfTranslationalSubgradeReactionSelect;
  };
  CREATE TYPE default::IfcBoundaryFaceCondition EXTENDING default::IfcBoundaryCondition {
      CREATE LINK TranslationalStiffnessByAreaX -> default::IfcModulusOfSubgradeReactionSelect;
      CREATE LINK TranslationalStiffnessByAreaY -> default::IfcModulusOfSubgradeReactionSelect;
      CREATE LINK TranslationalStiffnessByAreaZ -> default::IfcModulusOfSubgradeReactionSelect;
  };
  CREATE TYPE default::IfcBoundaryNodeCondition EXTENDING default::IfcBoundaryCondition {
      CREATE LINK RotationalStiffnessX -> default::IfcRotationalStiffnessSelect;
      CREATE LINK RotationalStiffnessY -> default::IfcRotationalStiffnessSelect;
      CREATE LINK RotationalStiffnessZ -> default::IfcRotationalStiffnessSelect;
      CREATE LINK TranslationalStiffnessX -> default::IfcTranslationalStiffnessSelect;
      CREATE LINK TranslationalStiffnessY -> default::IfcTranslationalStiffnessSelect;
      CREATE LINK TranslationalStiffnessZ -> default::IfcTranslationalStiffnessSelect;
  };
  CREATE TYPE default::IfcBoundaryNodeConditionWarping EXTENDING default::IfcBoundaryNodeCondition {
      CREATE LINK WarpingStiffness -> default::IfcWarpingStiffnessSelect;
  };
  CREATE TYPE default::IfcStructuralSurfaceConnection EXTENDING default::IfcStructuralConnection;
  CREATE TYPE default::IfcStructuralCurveConnection EXTENDING default::IfcStructuralConnection {
      CREATE REQUIRED LINK Axis -> default::IfcDirection;
  };
  CREATE TYPE default::IfcBoundaryCurve EXTENDING default::IfcCompositeCurveOnSurface;
  CREATE TYPE default::IfcOuterBoundaryCurve EXTENDING default::IfcBoundaryCurve;
  CREATE TYPE default::IfcCurveBoundedSurface EXTENDING default::IfcBoundedSurface {
      CREATE REQUIRED MULTI LINK Boundaries -> default::IfcBoundaryCurve;
      CREATE REQUIRED LINK BasisSurface -> default::IfcSurface;
      CREATE REQUIRED PROPERTY ImplicitOuter -> std::bool;
  };
  CREATE TYPE default::IfcCircularArcSegment2D EXTENDING default::IfcCurveSegment2D {
      CREATE REQUIRED PROPERTY IsCCW -> std::bool;
      CREATE REQUIRED PROPERTY Radius -> std::float64;
  };
  CREATE TYPE default::IfcLineSegment2D EXTENDING default::IfcCurveSegment2D;
  CREATE TYPE default::IfcTransitionCurveSegment2D EXTENDING default::IfcCurveSegment2D {
      CREATE PROPERTY EndRadius -> std::float64;
      CREATE REQUIRED PROPERTY IsEndRadiusCCW -> std::bool;
      CREATE REQUIRED PROPERTY IsStartRadiusCCW -> std::bool;
      CREATE PROPERTY StartRadius -> std::float64;
      CREATE REQUIRED PROPERTY TransitionCurveType -> std::str {
          CREATE CONSTRAINT std::one_of('BIQUADRATICPARABOLA', 'BLOSSCURVE', 'CLOTHOIDCURVE', 'COSINECURVE', 'CUBICPARABOLA', 'SINECURVE');
      };
  };
  CREATE TYPE default::IfcIndexedPolyCurve EXTENDING default::IfcBoundedCurve {
      CREATE REQUIRED LINK Points -> default::IfcCartesianPointList;
      CREATE MULTI LINK Segments -> default::IfcSegmentIndexSelect;
      CREATE PROPERTY SelfIntersect -> std::bool;
  };
  CREATE TYPE default::IfcPolyline EXTENDING default::IfcBoundedCurve {
      CREATE REQUIRED MULTI LINK Points -> default::IfcCartesianPoint;
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
  CREATE TYPE default::IfcCurveBoundedPlane EXTENDING default::IfcBoundedSurface {
      CREATE REQUIRED MULTI LINK InnerBoundaries -> default::IfcCurve;
      CREATE REQUIRED LINK OuterBoundary -> default::IfcCurve;
      CREATE REQUIRED LINK BasisSurface -> default::IfcPlane;
  };
  CREATE TYPE default::IfcRectangularTrimmedSurface EXTENDING default::IfcBoundedSurface {
      CREATE REQUIRED LINK BasisSurface -> default::IfcSurface;
      CREATE REQUIRED PROPERTY U1 -> std::float64;
      CREATE REQUIRED PROPERTY U2 -> std::float64;
      CREATE REQUIRED PROPERTY Usense -> std::bool;
      CREATE REQUIRED PROPERTY V1 -> std::float64;
      CREATE REQUIRED PROPERTY V2 -> std::float64;
      CREATE REQUIRED PROPERTY Vsense -> std::bool;
  };
  CREATE TYPE default::IfcBoundingBox EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED LINK Corner -> default::IfcCartesianPoint;
      CREATE REQUIRED PROPERTY XDim -> std::float64;
      CREATE REQUIRED PROPERTY YDim -> std::float64;
      CREATE REQUIRED PROPERTY ZDim -> std::float64;
  };
  CREATE TYPE default::IfcBoxedHalfSpace EXTENDING default::IfcHalfSpaceSolid {
      CREATE REQUIRED LINK Enclosure -> default::IfcBoundingBox;
  };
  CREATE TYPE default::IfcBoxAlignment {
      CREATE REQUIRED PROPERTY IfcBoxAlignment -> std::str;
  };
  CREATE TYPE default::IfcBuilding EXTENDING default::IfcSpatialStructureElement {
      CREATE LINK BuildingAddress -> default::IfcPostalAddress;
      CREATE PROPERTY ElevationOfRefHeight -> std::float64;
      CREATE PROPERTY ElevationOfTerrain -> std::float64;
  };
  CREATE TYPE default::IfcBuildingElementProxy EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('COMPLEX', 'ELEMENT', 'NOTDEFINED', 'PARTIAL', 'PROVISIONFORSPACE', 'PROVISIONFORVOID', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcChimney EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcColumn EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('COLUMN', 'NOTDEFINED', 'PILASTER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcColumnStandardCase EXTENDING default::IfcColumn;
  CREATE TYPE default::IfcCovering EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CEILING', 'CLADDING', 'FLOORING', 'INSULATION', 'MEMBRANE', 'MOLDING', 'NOTDEFINED', 'ROOFING', 'SKIRTINGBOARD', 'SLEEVING', 'USERDEFINED', 'WRAPPING');
      };
  };
  CREATE TYPE default::IfcCurtainWall EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcDoor EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY OperationType -> std::str {
          CREATE CONSTRAINT std::one_of('DOUBLE_DOOR_DOUBLE_SWING', 'DOUBLE_DOOR_FOLDING', 'DOUBLE_DOOR_SINGLE_SWING', 'DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_LEFT', 'DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_RIGHT', 'DOUBLE_DOOR_SLIDING', 'DOUBLE_SWING_LEFT', 'DOUBLE_SWING_RIGHT', 'FOLDING_TO_LEFT', 'FOLDING_TO_RIGHT', 'NOTDEFINED', 'REVOLVING', 'ROLLINGUP', 'SINGLE_SWING_LEFT', 'SINGLE_SWING_RIGHT', 'SLIDING_TO_LEFT', 'SLIDING_TO_RIGHT', 'SWING_FIXED_LEFT', 'SWING_FIXED_RIGHT', 'USERDEFINED');
      };
      CREATE PROPERTY OverallHeight -> std::float64;
      CREATE PROPERTY OverallWidth -> std::float64;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DOOR', 'GATE', 'NOTDEFINED', 'TRAPDOOR', 'USERDEFINED');
      };
      CREATE PROPERTY UserDefinedOperationType -> std::str;
  };
  CREATE TYPE default::IfcDoorStandardCase EXTENDING default::IfcDoor;
  CREATE TYPE default::IfcFooting EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CAISSON_FOUNDATION', 'FOOTING_BEAM', 'NOTDEFINED', 'PAD_FOOTING', 'PILE_CAP', 'STRIP_FOOTING', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcMember EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BRACE', 'CHORD', 'COLLAR', 'MEMBER', 'MULLION', 'NOTDEFINED', 'PLATE', 'POST', 'PURLIN', 'RAFTER', 'STRINGER', 'STRUT', 'STUD', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcMemberStandardCase EXTENDING default::IfcMember;
  CREATE TYPE default::IfcPile EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY ConstructionType -> std::str {
          CREATE CONSTRAINT std::one_of('CAST_IN_PLACE', 'COMPOSITE', 'NOTDEFINED', 'PRECAST_CONCRETE', 'PREFAB_STEEL', 'USERDEFINED');
      };
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BORED', 'COHESION', 'DRIVEN', 'FRICTION', 'JETGROUTING', 'NOTDEFINED', 'SUPPORT', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcPlate EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CURTAIN_PANEL', 'NOTDEFINED', 'SHEET', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcPlateStandardCase EXTENDING default::IfcPlate;
  CREATE TYPE default::IfcRailing EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BALUSTRADE', 'GUARDRAIL', 'HANDRAIL', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcRamp EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('HALF_TURN_RAMP', 'NOTDEFINED', 'QUARTER_TURN_RAMP', 'SPIRAL_RAMP', 'STRAIGHT_RUN_RAMP', 'TWO_QUARTER_TURN_RAMP', 'TWO_STRAIGHT_RUN_RAMP', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcRampFlight EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'SPIRAL', 'STRAIGHT', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcRoof EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BARREL_ROOF', 'BUTTERFLY_ROOF', 'DOME_ROOF', 'FLAT_ROOF', 'FREEFORM', 'GABLE_ROOF', 'GAMBREL_ROOF', 'HIPPED_GABLE_ROOF', 'HIP_ROOF', 'MANSARD_ROOF', 'NOTDEFINED', 'PAVILION_ROOF', 'RAINBOW_ROOF', 'SHED_ROOF', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcShadingDevice EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AWNING', 'JALOUSIE', 'NOTDEFINED', 'SHUTTER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSlab EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BASESLAB', 'FLOOR', 'LANDING', 'NOTDEFINED', 'ROOF', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSlabElementedCase EXTENDING default::IfcSlab;
  CREATE TYPE default::IfcSlabStandardCase EXTENDING default::IfcSlab;
  CREATE TYPE default::IfcStair EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CURVED_RUN_STAIR', 'DOUBLE_RETURN_STAIR', 'HALF_TURN_STAIR', 'HALF_WINDING_STAIR', 'NOTDEFINED', 'QUARTER_TURN_STAIR', 'QUARTER_WINDING_STAIR', 'SPIRAL_STAIR', 'STRAIGHT_RUN_STAIR', 'THREE_QUARTER_TURN_STAIR', 'THREE_QUARTER_WINDING_STAIR', 'TWO_CURVED_RUN_STAIR', 'TWO_QUARTER_TURN_STAIR', 'TWO_QUARTER_WINDING_STAIR', 'TWO_STRAIGHT_RUN_STAIR', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcStairFlight EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY NumberOfRisers -> std::int64;
      CREATE PROPERTY NumberOfTreads -> std::int64;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CURVED', 'FREEFORM', 'NOTDEFINED', 'SPIRAL', 'STRAIGHT', 'USERDEFINED', 'WINDER');
      };
      CREATE PROPERTY RiserHeight -> std::float64;
      CREATE PROPERTY TreadLength -> std::float64;
  };
  CREATE TYPE default::IfcWall EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ELEMENTEDWALL', 'MOVABLE', 'NOTDEFINED', 'PARAPET', 'PARTITIONING', 'PLUMBINGWALL', 'POLYGONAL', 'SHEAR', 'SOLIDWALL', 'STANDARD', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcWallElementedCase EXTENDING default::IfcWall;
  CREATE TYPE default::IfcWallStandardCase EXTENDING default::IfcWall;
  CREATE TYPE default::IfcWindow EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY OverallHeight -> std::float64;
      CREATE PROPERTY OverallWidth -> std::float64;
      CREATE PROPERTY PartitioningType -> std::str {
          CREATE CONSTRAINT std::one_of('DOUBLE_PANEL_HORIZONTAL', 'DOUBLE_PANEL_VERTICAL', 'NOTDEFINED', 'SINGLE_PANEL', 'TRIPLE_PANEL_BOTTOM', 'TRIPLE_PANEL_HORIZONTAL', 'TRIPLE_PANEL_LEFT', 'TRIPLE_PANEL_RIGHT', 'TRIPLE_PANEL_TOP', 'TRIPLE_PANEL_VERTICAL', 'USERDEFINED');
      };
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('LIGHTDOME', 'NOTDEFINED', 'SKYLIGHT', 'USERDEFINED', 'WINDOW');
      };
      CREATE PROPERTY UserDefinedPartitioningType -> std::str;
  };
  CREATE TYPE default::IfcWindowStandardCase EXTENDING default::IfcWindow;
  CREATE ABSTRACT TYPE default::IfcElementComponent EXTENDING default::IfcElement;
  CREATE TYPE default::IfcBuildingElementPart EXTENDING default::IfcElementComponent {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('INSULATION', 'NOTDEFINED', 'PRECASTPANEL', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcBuildingElementPartType EXTENDING default::IfcElementComponentType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('INSULATION', 'NOTDEFINED', 'PRECASTPANEL', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcBuildingElementProxyType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('COMPLEX', 'ELEMENT', 'NOTDEFINED', 'PARTIAL', 'PROVISIONFORSPACE', 'PROVISIONFORVOID', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcChimneyType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcColumnType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('COLUMN', 'NOTDEFINED', 'PILASTER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCoveringType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CEILING', 'CLADDING', 'FLOORING', 'INSULATION', 'MEMBRANE', 'MOLDING', 'NOTDEFINED', 'ROOFING', 'SKIRTINGBOARD', 'SLEEVING', 'USERDEFINED', 'WRAPPING');
      };
  };
  CREATE TYPE default::IfcCurtainWallType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcDoorType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY OperationType -> std::str {
          CREATE CONSTRAINT std::one_of('DOUBLE_DOOR_DOUBLE_SWING', 'DOUBLE_DOOR_FOLDING', 'DOUBLE_DOOR_SINGLE_SWING', 'DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_LEFT', 'DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_RIGHT', 'DOUBLE_DOOR_SLIDING', 'DOUBLE_SWING_LEFT', 'DOUBLE_SWING_RIGHT', 'FOLDING_TO_LEFT', 'FOLDING_TO_RIGHT', 'NOTDEFINED', 'REVOLVING', 'ROLLINGUP', 'SINGLE_SWING_LEFT', 'SINGLE_SWING_RIGHT', 'SLIDING_TO_LEFT', 'SLIDING_TO_RIGHT', 'SWING_FIXED_LEFT', 'SWING_FIXED_RIGHT', 'USERDEFINED');
      };
      CREATE PROPERTY ParameterTakesPrecedence -> std::bool;
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DOOR', 'GATE', 'NOTDEFINED', 'TRAPDOOR', 'USERDEFINED');
      };
      CREATE PROPERTY UserDefinedOperationType -> std::str;
  };
  CREATE TYPE default::IfcFootingType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CAISSON_FOUNDATION', 'FOOTING_BEAM', 'NOTDEFINED', 'PAD_FOOTING', 'PILE_CAP', 'STRIP_FOOTING', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcMemberType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BRACE', 'CHORD', 'COLLAR', 'MEMBER', 'MULLION', 'NOTDEFINED', 'PLATE', 'POST', 'PURLIN', 'RAFTER', 'STRINGER', 'STRUT', 'STUD', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcPileType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BORED', 'COHESION', 'DRIVEN', 'FRICTION', 'JETGROUTING', 'NOTDEFINED', 'SUPPORT', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcPlateType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CURTAIN_PANEL', 'NOTDEFINED', 'SHEET', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcRailingType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BALUSTRADE', 'GUARDRAIL', 'HANDRAIL', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcRampFlightType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'SPIRAL', 'STRAIGHT', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcRampType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('HALF_TURN_RAMP', 'NOTDEFINED', 'QUARTER_TURN_RAMP', 'SPIRAL_RAMP', 'STRAIGHT_RUN_RAMP', 'TWO_QUARTER_TURN_RAMP', 'TWO_STRAIGHT_RUN_RAMP', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcRoofType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BARREL_ROOF', 'BUTTERFLY_ROOF', 'DOME_ROOF', 'FLAT_ROOF', 'FREEFORM', 'GABLE_ROOF', 'GAMBREL_ROOF', 'HIPPED_GABLE_ROOF', 'HIP_ROOF', 'MANSARD_ROOF', 'NOTDEFINED', 'PAVILION_ROOF', 'RAINBOW_ROOF', 'SHED_ROOF', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcShadingDeviceType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AWNING', 'JALOUSIE', 'NOTDEFINED', 'SHUTTER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSlabType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BASESLAB', 'FLOOR', 'LANDING', 'NOTDEFINED', 'ROOF', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcStairFlightType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CURVED', 'FREEFORM', 'NOTDEFINED', 'SPIRAL', 'STRAIGHT', 'USERDEFINED', 'WINDER');
      };
  };
  CREATE TYPE default::IfcStairType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CURVED_RUN_STAIR', 'DOUBLE_RETURN_STAIR', 'HALF_TURN_STAIR', 'HALF_WINDING_STAIR', 'NOTDEFINED', 'QUARTER_TURN_STAIR', 'QUARTER_WINDING_STAIR', 'SPIRAL_STAIR', 'STRAIGHT_RUN_STAIR', 'THREE_QUARTER_TURN_STAIR', 'THREE_QUARTER_WINDING_STAIR', 'TWO_CURVED_RUN_STAIR', 'TWO_QUARTER_TURN_STAIR', 'TWO_QUARTER_WINDING_STAIR', 'TWO_STRAIGHT_RUN_STAIR', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcWallType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ELEMENTEDWALL', 'MOVABLE', 'NOTDEFINED', 'PARAPET', 'PARTITIONING', 'PLUMBINGWALL', 'POLYGONAL', 'SHEAR', 'SOLIDWALL', 'STANDARD', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcWindowType EXTENDING default::IfcBuildingElementType {
      CREATE PROPERTY ParameterTakesPrecedence -> std::bool;
      CREATE REQUIRED PROPERTY PartitioningType -> std::str {
          CREATE CONSTRAINT std::one_of('DOUBLE_PANEL_HORIZONTAL', 'DOUBLE_PANEL_VERTICAL', 'NOTDEFINED', 'SINGLE_PANEL', 'TRIPLE_PANEL_BOTTOM', 'TRIPLE_PANEL_HORIZONTAL', 'TRIPLE_PANEL_LEFT', 'TRIPLE_PANEL_RIGHT', 'TRIPLE_PANEL_TOP', 'TRIPLE_PANEL_VERTICAL', 'USERDEFINED');
      };
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('LIGHTDOME', 'NOTDEFINED', 'SKYLIGHT', 'USERDEFINED', 'WINDOW');
      };
      CREATE PROPERTY UserDefinedPartitioningType -> std::str;
  };
  CREATE TYPE default::IfcBuildingStorey EXTENDING default::IfcSpatialStructureElement {
      CREATE PROPERTY Elevation -> std::float64;
  };
  CREATE TYPE default::IfcBuildingSystem EXTENDING default::IfcSystem {
      CREATE PROPERTY LongName -> std::str;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FENESTRATION', 'FOUNDATION', 'LOADBEARING', 'NOTDEFINED', 'OUTERSHELL', 'SHADING', 'TRANSPORT', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcBurner EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcBurnerType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcFlowFitting EXTENDING default::IfcDistributionFlowElement;
  CREATE TYPE default::IfcCableCarrierFitting EXTENDING default::IfcFlowFitting {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BEND', 'CROSS', 'NOTDEFINED', 'REDUCER', 'TEE', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcFlowFittingType EXTENDING default::IfcDistributionFlowElementType;
  CREATE TYPE default::IfcCableCarrierFittingType EXTENDING default::IfcFlowFittingType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BEND', 'CROSS', 'NOTDEFINED', 'REDUCER', 'TEE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcFlowSegment EXTENDING default::IfcDistributionFlowElement;
  CREATE TYPE default::IfcCableCarrierSegment EXTENDING default::IfcFlowSegment {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CABLELADDERSEGMENT', 'CABLETRAYSEGMENT', 'CABLETRUNKINGSEGMENT', 'CONDUITSEGMENT', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcFlowSegmentType EXTENDING default::IfcDistributionFlowElementType;
  CREATE TYPE default::IfcCableCarrierSegmentType EXTENDING default::IfcFlowSegmentType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CABLELADDERSEGMENT', 'CABLETRAYSEGMENT', 'CABLETRUNKINGSEGMENT', 'CONDUITSEGMENT', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCableFitting EXTENDING default::IfcFlowFitting {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONNECTOR', 'ENTRY', 'EXIT', 'JUNCTION', 'NOTDEFINED', 'TRANSITION', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCableFittingType EXTENDING default::IfcFlowFittingType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONNECTOR', 'ENTRY', 'EXIT', 'JUNCTION', 'NOTDEFINED', 'TRANSITION', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCableSegment EXTENDING default::IfcFlowSegment {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BUSBARSEGMENT', 'CABLESEGMENT', 'CONDUCTORSEGMENT', 'CORESEGMENT', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCableSegmentType EXTENDING default::IfcFlowSegmentType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BUSBARSEGMENT', 'CABLESEGMENT', 'CONDUCTORSEGMENT', 'CORESEGMENT', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCardinalPointReference {
      CREATE REQUIRED PROPERTY IfcCardinalPointReference -> std::int64;
  };
  CREATE TYPE default::IfcCartesianTransformationOperator3D EXTENDING default::IfcCartesianTransformationOperator {
      CREATE LINK Axis3 -> default::IfcDirection;
  };
  CREATE TYPE default::IfcCartesianTransformationOperator3DnonUniform EXTENDING default::IfcCartesianTransformationOperator3D {
      CREATE PROPERTY Scale2 -> std::float64;
      CREATE PROPERTY Scale3 -> std::float64;
  };
  CREATE TYPE default::IfcCartesianTransformationOperator2DnonUniform EXTENDING default::IfcCartesianTransformationOperator2D {
      CREATE PROPERTY Scale2 -> std::float64;
  };
  CREATE TYPE default::IfcLine EXTENDING default::IfcCurve {
      CREATE REQUIRED LINK Pnt -> default::IfcCartesianPoint;
      CREATE REQUIRED LINK Dir -> default::IfcVector;
  };
  CREATE TYPE default::IfcPolyLoop EXTENDING default::IfcLoop {
      CREATE REQUIRED MULTI LINK Polygon -> default::IfcCartesianPoint;
  };
  CREATE TYPE default::IfcLightSourcePositional EXTENDING default::IfcLightSource {
      CREATE REQUIRED LINK Position -> default::IfcCartesianPoint;
      CREATE REQUIRED PROPERTY ConstantAttenuation -> std::float64;
      CREATE REQUIRED PROPERTY DistanceAttenuation -> std::float64;
      CREATE REQUIRED PROPERTY QuadricAttenuation -> std::float64;
      CREATE REQUIRED PROPERTY Radius -> std::float64;
  };
  CREATE TYPE default::IfcLightSourceSpot EXTENDING default::IfcLightSourcePositional {
      CREATE REQUIRED LINK Orientation -> default::IfcDirection;
      CREATE REQUIRED PROPERTY BeamWidthAngle -> std::float64;
      CREATE PROPERTY ConcentrationExponent -> std::float64;
      CREATE REQUIRED PROPERTY SpreadAngle -> std::float64;
  };
  CREATE TYPE default::IfcPolygonalFaceSet EXTENDING default::IfcTessellatedFaceSet {
      CREATE REQUIRED MULTI LINK Faces -> default::IfcIndexedPolygonalFace;
      CREATE PROPERTY Closed -> std::bool;
      CREATE PROPERTY PnIndex -> tuple<std::int64>;
  };
  CREATE TYPE default::IfcMappedItem EXTENDING default::IfcRepresentationItem {
      CREATE REQUIRED LINK MappingTarget -> default::IfcCartesianTransformationOperator;
      CREATE REQUIRED LINK MappingSource -> default::IfcRepresentationMap;
  };
  CREATE TYPE default::IfcDerivedProfileDef EXTENDING default::IfcProfileDef {
      CREATE LINK Operator -> default::IfcCartesianTransformationOperator2D;
      CREATE REQUIRED LINK ParentProfile -> default::IfcProfileDef;
      CREATE PROPERTY Label -> std::str;
  };
  CREATE TYPE default::IfcMirroredProfileDef EXTENDING default::IfcDerivedProfileDef;
  CREATE TYPE default::IfcImageTexture EXTENDING default::IfcSurfaceTexture {
      CREATE REQUIRED PROPERTY URLReference -> std::str;
  };
  CREATE TYPE default::IfcPixelTexture EXTENDING default::IfcSurfaceTexture {
      CREATE REQUIRED PROPERTY ColourComponents -> std::int64;
      CREATE REQUIRED PROPERTY Height -> std::int64;
      CREATE REQUIRED PROPERTY Pixel -> tuple<std::bytes>;
      CREATE REQUIRED PROPERTY Width -> std::int64;
  };
  CREATE TYPE default::IfcChiller EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRCOOLED', 'HEATRECOVERY', 'NOTDEFINED', 'USERDEFINED', 'WATERCOOLED');
      };
  };
  CREATE TYPE default::IfcChillerType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRCOOLED', 'HEATRECOVERY', 'NOTDEFINED', 'USERDEFINED', 'WATERCOOLED');
      };
  };
  CREATE TYPE default::IfcCivilElement EXTENDING default::IfcElement;
  CREATE TYPE default::IfcCivilElementType EXTENDING default::IfcElementType;
  ALTER TYPE default::IfcClassificationReference {
      CREATE LINK ReferencedSource -> default::IfcClassificationReferenceSelect;
  };
  CREATE TYPE default::IfcMaterialClassificationRelationship {
      CREATE REQUIRED MULTI LINK MaterialClassifications -> default::IfcClassificationSelect;
      CREATE REQUIRED LINK ClassifiedMaterial -> default::IfcMaterial;
  };
  CREATE TYPE default::IfcRelAssociatesClassification EXTENDING default::IfcRelAssociates {
      CREATE REQUIRED LINK RelatingClassification -> default::IfcClassificationSelect;
  };
  CREATE TYPE default::IfcFacetedBrep EXTENDING default::IfcManifoldSolidBrep;
  CREATE TYPE default::IfcFacetedBrepWithVoids EXTENDING default::IfcFacetedBrep {
      CREATE REQUIRED MULTI LINK Voids -> default::IfcClosedShell;
  };
  CREATE TYPE default::IfcCoil EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DXCOOLINGCOIL', 'ELECTRICHEATINGCOIL', 'GASHEATINGCOIL', 'HYDRONICCOIL', 'NOTDEFINED', 'STEAMHEATINGCOIL', 'USERDEFINED', 'WATERCOOLINGCOIL', 'WATERHEATINGCOIL');
      };
  };
  CREATE TYPE default::IfcCoilType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DXCOOLINGCOIL', 'ELECTRICHEATINGCOIL', 'GASHEATINGCOIL', 'HYDRONICCOIL', 'NOTDEFINED', 'STEAMHEATINGCOIL', 'USERDEFINED', 'WATERCOOLINGCOIL', 'WATERHEATINGCOIL');
      };
  };
  CREATE TYPE default::IfcSurfaceStyleRendering EXTENDING default::IfcSurfaceStyleShading {
      CREATE LINK DiffuseColour -> default::IfcColourOrFactor;
      CREATE LINK DiffuseTransmissionColour -> default::IfcColourOrFactor;
      CREATE LINK ReflectionColour -> default::IfcColourOrFactor;
      CREATE LINK SpecularColour -> default::IfcColourOrFactor;
      CREATE LINK TransmissionColour -> default::IfcColourOrFactor;
      CREATE LINK SpecularHighlight -> default::IfcSpecularHighlightSelect;
      CREATE REQUIRED PROPERTY ReflectanceMethod -> std::str {
          CREATE CONSTRAINT std::one_of('BLINN', 'FLAT', 'GLASS', 'MATT', 'METAL', 'MIRROR', 'NOTDEFINED', 'PHONG', 'PLASTIC', 'STRAUSS');
      };
  };
  CREATE TYPE default::IfcLightSourceDirectional EXTENDING default::IfcLightSource {
      CREATE REQUIRED LINK Orientation -> default::IfcDirection;
  };
  CREATE TYPE default::IfcLightSourceAmbient EXTENDING default::IfcLightSource;
  CREATE TYPE default::IfcIndexedColourMap EXTENDING default::IfcPresentationItem {
      CREATE REQUIRED LINK Colours -> default::IfcColourRgbList;
      CREATE REQUIRED LINK MappedTo -> default::IfcTessellatedFaceSet;
      CREATE REQUIRED PROPERTY ColourIndex -> tuple<std::int64>;
      CREATE PROPERTY Opacity -> std::float64;
  };
  CREATE TYPE default::IfcCommunicationsAppliance EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ANTENNA', 'COMPUTER', 'FAX', 'GATEWAY', 'MODEM', 'NETWORKAPPLIANCE', 'NETWORKBRIDGE', 'NETWORKHUB', 'NOTDEFINED', 'PRINTER', 'REPEATER', 'ROUTER', 'SCANNER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCommunicationsApplianceType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ANTENNA', 'COMPUTER', 'FAX', 'GATEWAY', 'MODEM', 'NETWORKAPPLIANCE', 'NETWORKBRIDGE', 'NETWORKHUB', 'NOTDEFINED', 'PRINTER', 'REPEATER', 'ROUTER', 'SCANNER', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcProperty EXTENDING default::IfcPropertyAbstraction {
      CREATE PROPERTY Description -> std::str;
      CREATE REQUIRED PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcComplexProperty EXTENDING default::IfcProperty {
      CREATE REQUIRED MULTI LINK HasProperties -> default::IfcProperty;
      CREATE REQUIRED PROPERTY UsageName -> std::str;
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
  CREATE TYPE default::IfcReparametrisedCompositeCurveSegment EXTENDING default::IfcCompositeCurveSegment {
      CREATE REQUIRED PROPERTY ParamLength -> std::float64;
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
  CREATE TYPE default::IfcFlowMovingDevice EXTENDING default::IfcDistributionFlowElement;
  CREATE TYPE default::IfcCompressor EXTENDING default::IfcFlowMovingDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BOOSTER', 'DYNAMIC', 'HERMETIC', 'NOTDEFINED', 'OPENTYPE', 'RECIPROCATING', 'ROLLINGPISTON', 'ROTARY', 'ROTARYVANE', 'SCROLL', 'SEMIHERMETIC', 'SINGLESCREW', 'SINGLESTAGE', 'TROCHOIDAL', 'TWINSCREW', 'USERDEFINED', 'WELDEDSHELLHERMETIC');
      };
  };
  CREATE ABSTRACT TYPE default::IfcFlowMovingDeviceType EXTENDING default::IfcDistributionFlowElementType;
  CREATE TYPE default::IfcCompressorType EXTENDING default::IfcFlowMovingDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BOOSTER', 'DYNAMIC', 'HERMETIC', 'NOTDEFINED', 'OPENTYPE', 'RECIPROCATING', 'ROLLINGPISTON', 'ROTARY', 'ROTARYVANE', 'SCROLL', 'SEMIHERMETIC', 'SINGLESCREW', 'SINGLESTAGE', 'TROCHOIDAL', 'TWINSCREW', 'USERDEFINED', 'WELDEDSHELLHERMETIC');
      };
  };
  CREATE TYPE default::IfcCondenser EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRCOOLED', 'EVAPORATIVECOOLED', 'NOTDEFINED', 'USERDEFINED', 'WATERCOOLED', 'WATERCOOLEDBRAZEDPLATE', 'WATERCOOLEDSHELLCOIL', 'WATERCOOLEDSHELLTUBE', 'WATERCOOLEDTUBEINTUBE');
      };
  };
  CREATE TYPE default::IfcCondenserType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRCOOLED', 'EVAPORATIVECOOLED', 'NOTDEFINED', 'USERDEFINED', 'WATERCOOLED', 'WATERCOOLEDBRAZEDPLATE', 'WATERCOOLEDSHELLCOIL', 'WATERCOOLEDSHELLTUBE', 'WATERCOOLEDTUBEINTUBE');
      };
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
  CREATE TYPE default::IfcConnectionSurfaceGeometry EXTENDING default::IfcConnectionGeometry {
      CREATE LINK SurfaceOnRelatedElement -> default::IfcSurfaceOrFaceSurface;
      CREATE REQUIRED LINK SurfaceOnRelatingElement -> default::IfcSurfaceOrFaceSurface;
  };
  CREATE TYPE default::IfcConnectionVolumeGeometry EXTENDING default::IfcConnectionGeometry {
      CREATE LINK VolumeOnRelatedElement -> default::IfcSolidOrShell;
      CREATE REQUIRED LINK VolumeOnRelatingElement -> default::IfcSolidOrShell;
  };
  CREATE TYPE default::IfcRelConnectsElements EXTENDING default::IfcRelConnects {
      CREATE LINK ConnectionGeometry -> default::IfcConnectionGeometry;
      CREATE REQUIRED LINK RelatedElement -> default::IfcElement;
      CREATE REQUIRED LINK RelatingElement -> default::IfcElement;
  };
  CREATE TYPE default::IfcRelConnectsPathElements EXTENDING default::IfcRelConnectsElements {
      CREATE REQUIRED PROPERTY RelatedConnectionType -> std::str {
          CREATE CONSTRAINT std::one_of('ATEND', 'ATPATH', 'ATSTART', 'NOTDEFINED');
      };
      CREATE REQUIRED PROPERTY RelatedPriorities -> tuple<std::int64>;
      CREATE REQUIRED PROPERTY RelatingConnectionType -> std::str {
          CREATE CONSTRAINT std::one_of('ATEND', 'ATPATH', 'ATSTART', 'NOTDEFINED');
      };
      CREATE REQUIRED PROPERTY RelatingPriorities -> tuple<std::int64>;
  };
  CREATE TYPE default::IfcRelConnectsWithRealizingElements EXTENDING default::IfcRelConnectsElements {
      CREATE REQUIRED MULTI LINK RealizingElements -> default::IfcElement;
      CREATE PROPERTY ConnectionType -> std::str;
  };
  CREATE TYPE default::IfcRelSpaceBoundary EXTENDING default::IfcRelConnects {
      CREATE LINK ConnectionGeometry -> default::IfcConnectionGeometry;
      CREATE REQUIRED LINK RelatedBuildingElement -> default::IfcElement;
      CREATE REQUIRED LINK RelatingSpace -> default::IfcSpaceBoundarySelect;
      CREATE REQUIRED PROPERTY InternalOrExternalBoundary -> std::str {
          CREATE CONSTRAINT std::one_of('EXTERNAL', 'EXTERNAL_EARTH', 'EXTERNAL_FIRE', 'EXTERNAL_WATER', 'INTERNAL', 'NOTDEFINED');
      };
      CREATE REQUIRED PROPERTY PhysicalOrVirtualBoundary -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'PHYSICAL', 'VIRTUAL');
      };
  };
  CREATE TYPE default::IfcRelSpaceBoundary1stLevel EXTENDING default::IfcRelSpaceBoundary {
      CREATE LINK ParentBoundary -> default::IfcRelSpaceBoundary1stLevel;
  };
  CREATE TYPE default::IfcRelSpaceBoundary2ndLevel EXTENDING default::IfcRelSpaceBoundary1stLevel {
      CREATE LINK CorrespondingBoundary -> default::IfcRelSpaceBoundary2ndLevel;
  };
  CREATE TYPE default::IfcRelInterferesElements EXTENDING default::IfcRelConnects {
      CREATE LINK InterferenceGeometry -> default::IfcConnectionGeometry;
      CREATE REQUIRED LINK RelatedElement -> default::IfcElement;
      CREATE REQUIRED LINK RelatingElement -> default::IfcElement;
      CREATE REQUIRED PROPERTY ImpliedOrder -> std::bool;
      CREATE PROPERTY InterferenceType -> std::str;
  };
  CREATE TYPE default::IfcRelAssociatesConstraint EXTENDING default::IfcRelAssociates {
      CREATE REQUIRED LINK RelatingConstraint -> default::IfcConstraint;
      CREATE PROPERTY Intent -> std::str;
  };
  CREATE TYPE default::IfcResourceConstraintRelationship EXTENDING default::IfcResourceLevelRelationship {
      CREATE REQUIRED LINK RelatingConstraint -> default::IfcConstraint;
      CREATE REQUIRED MULTI LINK RelatedResourceObjects -> default::IfcResourceObjectSelect;
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
  CREATE TYPE default::IfcProjectLibrary EXTENDING default::IfcContext;
  CREATE TYPE default::IfcRelDeclares EXTENDING default::IfcRelationship {
      CREATE REQUIRED LINK RelatingContext -> default::IfcContext;
      CREATE REQUIRED MULTI LINK RelatedDefinitions -> default::IfcDefinitionSelect;
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
  CREATE TYPE default::IfcPerformanceHistory EXTENDING default::IfcControl {
      CREATE REQUIRED PROPERTY LifeCyclePhase -> std::str;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcPermit EXTENDING default::IfcControl {
      CREATE PROPERTY LongDescription -> std::str;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ACCESS', 'BUILDING', 'NOTDEFINED', 'USERDEFINED', 'WORK');
      };
      CREATE PROPERTY Status -> std::str;
  };
  CREATE TYPE default::IfcProjectOrder EXTENDING default::IfcControl {
      CREATE PROPERTY LongDescription -> std::str;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CHANGEORDER', 'MAINTENANCEWORKORDER', 'MOVEORDER', 'NOTDEFINED', 'PURCHASEORDER', 'USERDEFINED', 'WORKORDER');
      };
      CREATE PROPERTY Status -> std::str;
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
  CREATE TYPE default::IfcWorkTime EXTENDING default::IfcSchedulingTime {
      CREATE LINK RecurrencePattern -> default::IfcRecurrencePattern;
      CREATE PROPERTY Finish -> std::str;
      CREATE PROPERTY `Start` -> std::str;
  };
  CREATE TYPE default::IfcWorkCalendar EXTENDING default::IfcControl {
      CREATE MULTI LINK ExceptionTimes -> default::IfcWorkTime;
      CREATE MULTI LINK WorkingTimes -> default::IfcWorkTime;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FIRSTSHIFT', 'NOTDEFINED', 'SECONDSHIFT', 'THIRDSHIFT', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcWorkControl EXTENDING default::IfcControl {
      CREATE MULTI LINK Creators -> default::IfcPerson;
      CREATE REQUIRED PROPERTY CreationDate -> std::str;
      CREATE PROPERTY Duration -> std::str;
      CREATE PROPERTY FinishTime -> std::str;
      CREATE PROPERTY Purpose -> std::str;
      CREATE REQUIRED PROPERTY StartTime -> std::str;
      CREATE PROPERTY TotalFloat -> std::str;
  };
  CREATE TYPE default::IfcWorkPlan EXTENDING default::IfcWorkControl {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ACTUAL', 'BASELINE', 'NOTDEFINED', 'PLANNED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcWorkSchedule EXTENDING default::IfcWorkControl {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ACTUAL', 'BASELINE', 'NOTDEFINED', 'PLANNED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcRelAssignsToControl EXTENDING default::IfcRelAssigns {
      CREATE REQUIRED LINK RelatingControl -> default::IfcControl;
  };
  CREATE TYPE default::IfcController EXTENDING default::IfcDistributionControlElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FLOATING', 'MULTIPOSITION', 'NOTDEFINED', 'PROGRAMMABLE', 'PROPORTIONAL', 'TWOPOSITION', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcControllerType EXTENDING default::IfcDistributionControlElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FLOATING', 'MULTIPOSITION', 'NOTDEFINED', 'PROGRAMMABLE', 'PROPORTIONAL', 'TWOPOSITION', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcConversionBasedUnitWithOffset EXTENDING default::IfcConversionBasedUnit {
      CREATE REQUIRED PROPERTY ConversionOffset -> std::float64;
  };
  CREATE TYPE default::IfcCooledBeam EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ACTIVE', 'NOTDEFINED', 'PASSIVE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCooledBeamType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ACTIVE', 'NOTDEFINED', 'PASSIVE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCoolingTower EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('MECHANICALFORCEDDRAFT', 'MECHANICALINDUCEDDRAFT', 'NATURALDRAFT', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCoolingTowerType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('MECHANICALFORCEDDRAFT', 'MECHANICALINDUCEDDRAFT', 'NATURALDRAFT', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcCoordinateOperation {
      CREATE REQUIRED LINK SourceCRS -> default::IfcCoordinateReferenceSystemSelect;
      CREATE REQUIRED LINK TargetCRS -> default::IfcCoordinateReferenceSystem;
  };
  CREATE TYPE default::IfcMapConversion EXTENDING default::IfcCoordinateOperation {
      CREATE REQUIRED PROPERTY Eastings -> std::float64;
      CREATE REQUIRED PROPERTY Northings -> std::float64;
      CREATE REQUIRED PROPERTY OrthogonalHeight -> std::float64;
      CREATE PROPERTY Scale -> std::float64;
      CREATE PROPERTY XAxisAbscissa -> std::float64;
      CREATE PROPERTY XAxisOrdinate -> std::float64;
  };
  CREATE TYPE default::IfcProjectedCRS EXTENDING default::IfcCoordinateReferenceSystem {
      CREATE LINK MapUnit -> default::IfcNamedUnit;
      CREATE PROPERTY MapProjection -> std::str;
      CREATE PROPERTY MapZone -> std::str;
  };
  CREATE TYPE default::IfcRelCoversBldgElements EXTENDING default::IfcRelConnects {
      CREATE REQUIRED MULTI LINK RelatedCoverings -> default::IfcCovering;
      CREATE REQUIRED LINK RelatingBuildingElement -> default::IfcElement;
  };
  CREATE TYPE default::IfcRelCoversSpaces EXTENDING default::IfcRelConnects {
      CREATE REQUIRED MULTI LINK RelatedCoverings -> default::IfcCovering;
      CREATE REQUIRED LINK RelatingSpace -> default::IfcSpace;
  };
  CREATE TYPE default::IfcCsgSolid EXTENDING default::IfcSolidModel {
      CREATE REQUIRED LINK TreeRootExpression -> default::IfcCsgSelect;
  };
  CREATE TYPE default::IfcCurrencyRelationship EXTENDING default::IfcResourceLevelRelationship {
      CREATE LINK RateSource -> default::IfcLibraryInformation;
      CREATE REQUIRED LINK RelatedMonetaryUnit -> default::IfcMonetaryUnit;
      CREATE REQUIRED LINK RelatingMonetaryUnit -> default::IfcMonetaryUnit;
      CREATE REQUIRED PROPERTY ExchangeRate -> std::float64;
      CREATE PROPERTY RateDateTime -> std::str;
  };
  CREATE TYPE default::IfcIntersectionCurve EXTENDING default::IfcSurfaceCurve;
  CREATE ABSTRACT TYPE default::IfcOffsetCurve EXTENDING default::IfcCurve {
      CREATE REQUIRED LINK BasisCurve -> default::IfcCurve;
  };
  CREATE TYPE default::IfcOffsetCurve3D EXTENDING default::IfcOffsetCurve {
      CREATE REQUIRED LINK RefDirection -> default::IfcDirection;
      CREATE REQUIRED PROPERTY Distance -> std::float64;
      CREATE REQUIRED PROPERTY SelfIntersect -> std::bool;
  };
  CREATE TYPE default::IfcOffsetCurveByDistances EXTENDING default::IfcOffsetCurve {
      CREATE REQUIRED MULTI LINK OffsetValues -> default::IfcDistanceExpression;
      CREATE PROPERTY Tag -> std::str;
  };
  CREATE TYPE default::IfcOffsetCurve2D EXTENDING default::IfcOffsetCurve {
      CREATE REQUIRED PROPERTY Distance -> std::float64;
      CREATE REQUIRED PROPERTY SelfIntersect -> std::bool;
  };
  CREATE TYPE default::IfcSeamCurve EXTENDING default::IfcSurfaceCurve;
  CREATE TYPE default::IfcPointOnCurve EXTENDING default::IfcPoint {
      CREATE REQUIRED LINK BasisCurve -> default::IfcCurve;
      CREATE REQUIRED PROPERTY PointParameter -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcSectionedSolid EXTENDING default::IfcSolidModel {
      CREATE REQUIRED LINK Directrix -> default::IfcCurve;
      CREATE REQUIRED MULTI LINK CrossSections -> default::IfcProfileDef;
  };
  CREATE TYPE default::IfcSectionedSolidHorizontal EXTENDING default::IfcSectionedSolid {
      CREATE REQUIRED MULTI LINK CrossSectionPositions -> default::IfcDistanceExpression;
      CREATE REQUIRED PROPERTY FixedAxisVertical -> std::bool;
  };
  CREATE TYPE default::IfcSweptDiskSolid EXTENDING default::IfcSolidModel {
      CREATE REQUIRED LINK Directrix -> default::IfcCurve;
      CREATE PROPERTY EndParam -> std::float64;
      CREATE PROPERTY InnerRadius -> std::float64;
      CREATE REQUIRED PROPERTY Radius -> std::float64;
      CREATE PROPERTY StartParam -> std::float64;
  };
  CREATE TYPE default::IfcSweptDiskSolidPolygonal EXTENDING default::IfcSweptDiskSolid {
      CREATE PROPERTY FilletRadius -> std::float64;
  };
  CREATE TYPE default::IfcDamper EXTENDING default::IfcFlowController {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BACKDRAFTDAMPER', 'BALANCINGDAMPER', 'BLASTDAMPER', 'CONTROLDAMPER', 'FIREDAMPER', 'FIRESMOKEDAMPER', 'FUMEHOODEXHAUST', 'GRAVITYDAMPER', 'GRAVITYRELIEFDAMPER', 'NOTDEFINED', 'RELIEFDAMPER', 'SMOKEDAMPER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcDamperType EXTENDING default::IfcFlowControllerType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BACKDRAFTDAMPER', 'BALANCINGDAMPER', 'BLASTDAMPER', 'CONTROLDAMPER', 'FIREDAMPER', 'FIRESMOKEDAMPER', 'FUMEHOODEXHAUST', 'GRAVITYDAMPER', 'GRAVITYRELIEFDAMPER', 'NOTDEFINED', 'RELIEFDAMPER', 'SMOKEDAMPER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcDayInMonthNumber {
      CREATE REQUIRED PROPERTY IfcDayInMonthNumber -> std::int64;
  };
  CREATE TYPE default::IfcDayInWeekNumber {
      CREATE REQUIRED PROPERTY IfcDayInWeekNumber -> std::int64;
  };
  CREATE TYPE default::IfcRelAssociatesDocument EXTENDING default::IfcRelAssociates {
      CREATE REQUIRED LINK RelatingDocument -> default::IfcDocumentSelect;
  };
  CREATE TYPE default::IfcRelAssociatesMaterial EXTENDING default::IfcRelAssociates {
      CREATE REQUIRED LINK RelatingMaterial -> default::IfcMaterialSelect;
  };
  CREATE TYPE default::IfcRelAssociatesLibrary EXTENDING default::IfcRelAssociates {
      CREATE REQUIRED LINK RelatingLibrary -> default::IfcLibrarySelect;
  };
  CREATE TYPE default::IfcDimensionCount {
      CREATE REQUIRED PROPERTY IfcDimensionCount -> std::int64;
  };
  CREATE TYPE default::IfcSIUnit EXTENDING default::IfcNamedUnit {
      CREATE REQUIRED PROPERTY Name -> std::str {
          CREATE CONSTRAINT std::one_of('AMPERE', 'BECQUEREL', 'CANDELA', 'COULOMB', 'CUBIC_METRE', 'DEGREE_CELSIUS', 'FARAD', 'GRAM', 'GRAY', 'HENRY', 'HERTZ', 'JOULE', 'KELVIN', 'LUMEN', 'LUX', 'METRE', 'MOLE', 'NEWTON', 'OHM', 'PASCAL', 'RADIAN', 'SECOND', 'SIEMENS', 'SIEVERT', 'SQUARE_METRE', 'STERADIAN', 'TESLA', 'VOLT', 'WATT', 'WEBER');
      };
      CREATE PROPERTY Prefix -> std::str {
          CREATE CONSTRAINT std::one_of('ATTO', 'CENTI', 'DECA', 'DECI', 'EXA', 'FEMTO', 'GIGA', 'HECTO', 'KILO', 'MEGA', 'MICRO', 'MILLI', 'NANO', 'PETA', 'PICO', 'TERA');
      };
  };
  CREATE TYPE default::IfcStructuralCurveMember EXTENDING default::IfcStructuralMember {
      CREATE REQUIRED LINK Axis -> default::IfcDirection;
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CABLE', 'COMPRESSION_MEMBER', 'NOTDEFINED', 'PIN_JOINED_MEMBER', 'RIGID_JOINED_MEMBER', 'TENSION_MEMBER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcStructuralCurveMemberVarying EXTENDING default::IfcStructuralCurveMember;
  CREATE TYPE default::IfcDiscreteAccessory EXTENDING default::IfcElementComponent {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ANCHORPLATE', 'BRACKET', 'NOTDEFINED', 'SHOE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcDiscreteAccessoryType EXTENDING default::IfcElementComponentType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ANCHORPLATE', 'BRACKET', 'NOTDEFINED', 'SHOE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcDistributionChamberElement EXTENDING default::IfcDistributionFlowElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FORMEDDUCT', 'INSPECTIONCHAMBER', 'INSPECTIONPIT', 'MANHOLE', 'METERCHAMBER', 'NOTDEFINED', 'SUMP', 'TRENCH', 'USERDEFINED', 'VALVECHAMBER');
      };
  };
  CREATE TYPE default::IfcDistributionChamberElementType EXTENDING default::IfcDistributionFlowElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FORMEDDUCT', 'INSPECTIONCHAMBER', 'INSPECTIONPIT', 'MANHOLE', 'METERCHAMBER', 'NOTDEFINED', 'SUMP', 'TRENCH', 'USERDEFINED', 'VALVECHAMBER');
      };
  };
  CREATE TYPE default::IfcDistributionSystem EXTENDING default::IfcSystem {
      CREATE PROPERTY LongName -> std::str;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRCONDITIONING', 'AUDIOVISUAL', 'CHEMICAL', 'CHILLEDWATER', 'COMMUNICATION', 'COMPRESSEDAIR', 'CONDENSERWATER', 'CONTROL', 'CONVEYING', 'DATA', 'DISPOSAL', 'DOMESTICCOLDWATER', 'DOMESTICHOTWATER', 'DRAINAGE', 'EARTHING', 'ELECTRICAL', 'ELECTROACOUSTIC', 'EXHAUST', 'FIREPROTECTION', 'FUEL', 'GAS', 'HAZARDOUS', 'HEATING', 'LIGHTING', 'LIGHTNINGPROTECTION', 'MUNICIPALSOLIDWASTE', 'NOTDEFINED', 'OIL', 'OPERATIONAL', 'POWERGENERATION', 'RAINWATER', 'REFRIGERATION', 'SECURITY', 'SEWAGE', 'SIGNAL', 'STORMWATER', 'TELEPHONE', 'TV', 'USERDEFINED', 'VACUUM', 'VENT', 'VENTILATION', 'WASTEWATER', 'WATERSUPPLY');
      };
  };
  CREATE TYPE default::IfcDistributionCircuit EXTENDING default::IfcDistributionSystem;
  CREATE TYPE default::IfcFlowInstrument EXTENDING default::IfcDistributionControlElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AMMETER', 'FREQUENCYMETER', 'NOTDEFINED', 'PHASEANGLEMETER', 'POWERFACTORMETER', 'PRESSUREGAUGE', 'THERMOMETER', 'USERDEFINED', 'VOLTMETER_PEAK', 'VOLTMETER_RMS');
      };
  };
  CREATE TYPE default::IfcProtectiveDeviceTrippingUnit EXTENDING default::IfcDistributionControlElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ELECTROMAGNETIC', 'ELECTRONIC', 'NOTDEFINED', 'RESIDUALCURRENT', 'THERMAL', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSensor EXTENDING default::IfcDistributionControlElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CO2SENSOR', 'CONDUCTANCESENSOR', 'CONTACTSENSOR', 'COSENSOR', 'FIRESENSOR', 'FLOWSENSOR', 'FROSTSENSOR', 'GASSENSOR', 'HEATSENSOR', 'HUMIDITYSENSOR', 'IDENTIFIERSENSOR', 'IONCONCENTRATIONSENSOR', 'LEVELSENSOR', 'LIGHTSENSOR', 'MOISTURESENSOR', 'MOVEMENTSENSOR', 'NOTDEFINED', 'PHSENSOR', 'PRESSURESENSOR', 'RADIATIONSENSOR', 'RADIOACTIVITYSENSOR', 'SMOKESENSOR', 'SOUNDSENSOR', 'TEMPERATURESENSOR', 'USERDEFINED', 'WINDSENSOR');
      };
  };
  CREATE TYPE default::IfcUnitaryControlElement EXTENDING default::IfcDistributionControlElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ALARMPANEL', 'CONTROLPANEL', 'GASDETECTIONPANEL', 'HUMIDISTAT', 'INDICATORPANEL', 'MIMICPANEL', 'NOTDEFINED', 'THERMOSTAT', 'USERDEFINED', 'WEATHERSTATION');
      };
  };
  CREATE TYPE default::IfcRelFlowControlElements EXTENDING default::IfcRelConnects {
      CREATE REQUIRED MULTI LINK RelatedControlElements -> default::IfcDistributionControlElement;
      CREATE REQUIRED LINK RelatingFlowElement -> default::IfcDistributionFlowElement;
  };
  CREATE TYPE default::IfcFlowInstrumentType EXTENDING default::IfcDistributionControlElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AMMETER', 'FREQUENCYMETER', 'NOTDEFINED', 'PHASEANGLEMETER', 'POWERFACTORMETER', 'PRESSUREGAUGE', 'THERMOMETER', 'USERDEFINED', 'VOLTMETER_PEAK', 'VOLTMETER_RMS');
      };
  };
  CREATE TYPE default::IfcProtectiveDeviceTrippingUnitType EXTENDING default::IfcDistributionControlElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ELECTROMAGNETIC', 'ELECTRONIC', 'NOTDEFINED', 'RESIDUALCURRENT', 'THERMAL', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSensorType EXTENDING default::IfcDistributionControlElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CO2SENSOR', 'CONDUCTANCESENSOR', 'CONTACTSENSOR', 'COSENSOR', 'FIRESENSOR', 'FLOWSENSOR', 'FROSTSENSOR', 'GASSENSOR', 'HEATSENSOR', 'HUMIDITYSENSOR', 'IDENTIFIERSENSOR', 'IONCONCENTRATIONSENSOR', 'LEVELSENSOR', 'LIGHTSENSOR', 'MOISTURESENSOR', 'MOVEMENTSENSOR', 'NOTDEFINED', 'PHSENSOR', 'PRESSURESENSOR', 'RADIATIONSENSOR', 'RADIOACTIVITYSENSOR', 'SMOKESENSOR', 'SOUNDSENSOR', 'TEMPERATURESENSOR', 'USERDEFINED', 'WINDSENSOR');
      };
  };
  CREATE TYPE default::IfcUnitaryControlElementType EXTENDING default::IfcDistributionControlElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ALARMPANEL', 'CONTROLPANEL', 'GASDETECTIONPANEL', 'HUMIDISTAT', 'INDICATORPANEL', 'MIMICPANEL', 'NOTDEFINED', 'THERMOSTAT', 'USERDEFINED', 'WEATHERSTATION');
      };
  };
  CREATE TYPE default::IfcPipeFitting EXTENDING default::IfcFlowFitting {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BEND', 'CONNECTOR', 'ENTRY', 'EXIT', 'JUNCTION', 'NOTDEFINED', 'OBSTRUCTION', 'TRANSITION', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcFlowStorageDevice EXTENDING default::IfcDistributionFlowElement;
  CREATE TYPE default::IfcElectricFlowStorageDevice EXTENDING default::IfcFlowStorageDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BATTERY', 'CAPACITORBANK', 'HARMONICFILTER', 'INDUCTORBANK', 'NOTDEFINED', 'UPS', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcJunctionBox EXTENDING default::IfcFlowFitting {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DATA', 'NOTDEFINED', 'POWER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcFlowTreatmentDevice EXTENDING default::IfcDistributionFlowElement;
  CREATE TYPE default::IfcDuctSilencer EXTENDING default::IfcFlowTreatmentDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FLATOVAL', 'NOTDEFINED', 'RECTANGULAR', 'ROUND', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcDuctFitting EXTENDING default::IfcFlowFitting {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BEND', 'CONNECTOR', 'ENTRY', 'EXIT', 'JUNCTION', 'NOTDEFINED', 'OBSTRUCTION', 'TRANSITION', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcOutlet EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AUDIOVISUALOUTLET', 'COMMUNICATIONSOUTLET', 'DATAOUTLET', 'NOTDEFINED', 'POWEROUTLET', 'TELEPHONEOUTLET', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcElectricDistributionBoard EXTENDING default::IfcFlowController {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONSUMERUNIT', 'DISTRIBUTIONBOARD', 'MOTORCONTROLCENTRE', 'NOTDEFINED', 'SWITCHBOARD', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcHeatExchanger EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'PLATE', 'SHELLANDTUBE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcHumidifier EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ADIABATICAIRWASHER', 'ADIABATICATOMIZING', 'ADIABATICCOMPRESSEDAIRNOZZLE', 'ADIABATICPAN', 'ADIABATICRIGIDMEDIA', 'ADIABATICULTRASONIC', 'ADIABATICWETTEDELEMENT', 'ASSISTEDBUTANE', 'ASSISTEDELECTRIC', 'ASSISTEDNATURALGAS', 'ASSISTEDPROPANE', 'ASSISTEDSTEAM', 'NOTDEFINED', 'STEAMINJECTION', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcLamp EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('COMPACTFLUORESCENT', 'FLUORESCENT', 'HALOGEN', 'HIGHPRESSUREMERCURY', 'HIGHPRESSURESODIUM', 'LED', 'METALHALIDE', 'NOTDEFINED', 'OLED', 'TUNGSTENFILAMENT', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcFilter EXTENDING default::IfcFlowTreatmentDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRPARTICLEFILTER', 'COMPRESSEDAIRFILTER', 'NOTDEFINED', 'ODORFILTER', 'OILFILTER', 'STRAINER', 'USERDEFINED', 'WATERFILTER');
      };
  };
  CREATE TYPE default::IfcProtectiveDevice EXTENDING default::IfcFlowController {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CIRCUITBREAKER', 'EARTHINGSWITCH', 'EARTHLEAKAGECIRCUITBREAKER', 'FUSEDISCONNECTOR', 'NOTDEFINED', 'RESIDUALCURRENTCIRCUITBREAKER', 'RESIDUALCURRENTSWITCH', 'USERDEFINED', 'VARISTOR');
      };
  };
  CREATE TYPE default::IfcElectricGenerator EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CHP', 'ENGINEGENERATOR', 'NOTDEFINED', 'STANDALONE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcElectricTimeControl EXTENDING default::IfcFlowController {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'RELAY', 'TIMECLOCK', 'TIMEDELAY', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcMotorConnection EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BELTDRIVE', 'COUPLING', 'DIRECTDRIVE', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcFireSuppressionTerminal EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BREECHINGINLET', 'FIREHYDRANT', 'HOSEREEL', 'NOTDEFINED', 'SPRINKLER', 'SPRINKLERDEFLECTOR', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcEvaporativeCooler EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DIRECTEVAPORATIVEAIRWASHER', 'DIRECTEVAPORATIVEPACKAGEDROTARYAIRCOOLER', 'DIRECTEVAPORATIVERANDOMMEDIAAIRCOOLER', 'DIRECTEVAPORATIVERIGIDMEDIAAIRCOOLER', 'DIRECTEVAPORATIVESLINGERSPACKAGEDAIRCOOLER', 'INDIRECTDIRECTCOMBINATION', 'INDIRECTEVAPORATIVECOOLINGTOWERORCOILCOOLER', 'INDIRECTEVAPORATIVEPACKAGEAIRCOOLER', 'INDIRECTEVAPORATIVEWETCOIL', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcElectricAppliance EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DISHWASHER', 'ELECTRICCOOKER', 'FREESTANDINGELECTRICHEATER', 'FREESTANDINGFAN', 'FREESTANDINGWATERCOOLER', 'FREESTANDINGWATERHEATER', 'FREEZER', 'FRIDGE_FREEZER', 'HANDDRYER', 'KITCHENMACHINE', 'MICROWAVE', 'NOTDEFINED', 'PHOTOCOPIER', 'REFRIGERATOR', 'TUMBLEDRYER', 'USERDEFINED', 'VENDINGMACHINE', 'WASHINGMACHINE');
      };
  };
  CREATE TYPE default::IfcFlowMeter EXTENDING default::IfcFlowController {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ENERGYMETER', 'GASMETER', 'NOTDEFINED', 'OILMETER', 'USERDEFINED', 'WATERMETER');
      };
  };
  CREATE TYPE default::IfcTubeBundle EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FINNED', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcWasteTerminal EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FLOORTRAP', 'FLOORWASTE', 'GULLYSUMP', 'GULLYTRAP', 'NOTDEFINED', 'ROOFDRAIN', 'USERDEFINED', 'WASTEDISPOSALUNIT', 'WASTETRAP');
      };
  };
  CREATE TYPE default::IfcStackTerminal EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BIRDCAGE', 'COWL', 'NOTDEFINED', 'RAINWATERHOPPER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcUnitaryEquipment EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRCONDITIONINGUNIT', 'AIRHANDLER', 'DEHUMIDIFIER', 'NOTDEFINED', 'ROOFTOPUNIT', 'SPLITSYSTEM', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSolarDevice EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'SOLARCOLLECTOR', 'SOLARPANEL', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcEngine EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('EXTERNALCOMBUSTION', 'INTERNALCOMBUSTION', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcPump EXTENDING default::IfcFlowMovingDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CIRCULATOR', 'ENDSUCTION', 'NOTDEFINED', 'SPLITCASE', 'SUBMERSIBLEPUMP', 'SUMPPUMP', 'USERDEFINED', 'VERTICALINLINE', 'VERTICALTURBINE');
      };
  };
  CREATE TYPE default::IfcMedicalDevice EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRSTATION', 'FEEDAIRUNIT', 'NOTDEFINED', 'OXYGENGENERATOR', 'OXYGENPLANT', 'USERDEFINED', 'VACUUMSTATION');
      };
  };
  CREATE TYPE default::IfcTank EXTENDING default::IfcFlowStorageDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BASIN', 'BREAKPRESSURE', 'EXPANSION', 'FEEDANDEXPANSION', 'NOTDEFINED', 'PRESSUREVESSEL', 'STORAGE', 'USERDEFINED', 'VESSEL');
      };
  };
  CREATE TYPE default::IfcFan EXTENDING default::IfcFlowMovingDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CENTRIFUGALAIRFOIL', 'CENTRIFUGALBACKWARDINCLINEDCURVED', 'CENTRIFUGALFORWARDCURVED', 'CENTRIFUGALRADIAL', 'NOTDEFINED', 'PROPELLORAXIAL', 'TUBEAXIAL', 'USERDEFINED', 'VANEAXIAL');
      };
  };
  CREATE TYPE default::IfcDuctSegment EXTENDING default::IfcFlowSegment {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FLEXIBLESEGMENT', 'NOTDEFINED', 'RIGIDSEGMENT', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSanitaryTerminal EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BATH', 'BIDET', 'CISTERN', 'NOTDEFINED', 'SANITARYFOUNTAIN', 'SHOWER', 'SINK', 'TOILETPAN', 'URINAL', 'USERDEFINED', 'WASHHANDBASIN', 'WCSEAT');
      };
  };
  CREATE TYPE default::IfcTransformer EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CURRENT', 'FREQUENCY', 'INVERTER', 'NOTDEFINED', 'RECTIFIER', 'USERDEFINED', 'VOLTAGE');
      };
  };
  CREATE TYPE default::IfcSwitchingDevice EXTENDING default::IfcFlowController {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONTACTOR', 'DIMMERSWITCH', 'EMERGENCYSTOP', 'KEYPAD', 'MOMENTARYSWITCH', 'NOTDEFINED', 'SELECTORSWITCH', 'STARTER', 'SWITCHDISCONNECTOR', 'TOGGLESWITCH', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcLightFixture EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DIRECTIONSOURCE', 'NOTDEFINED', 'POINTSOURCE', 'SECURITYLIGHTING', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcInterceptor EXTENDING default::IfcFlowTreatmentDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CYCLONIC', 'GREASE', 'NOTDEFINED', 'OIL', 'PETROL', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcValve EXTENDING default::IfcFlowController {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRRELEASE', 'ANTIVACUUM', 'CHANGEOVER', 'CHECK', 'COMMISSIONING', 'DIVERTING', 'DOUBLECHECK', 'DOUBLEREGULATING', 'DRAWOFFCOCK', 'FAUCET', 'FLUSHING', 'GASCOCK', 'GASTAP', 'ISOLATING', 'MIXING', 'NOTDEFINED', 'PRESSUREREDUCING', 'PRESSURERELIEF', 'REGULATING', 'SAFETYCUTOFF', 'STEAMTRAP', 'STOPCOCK', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSpaceHeater EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONVECTOR', 'NOTDEFINED', 'RADIATOR', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcEvaporator EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DIRECTEXPANSION', 'DIRECTEXPANSIONBRAZEDPLATE', 'DIRECTEXPANSIONSHELLANDTUBE', 'DIRECTEXPANSIONTUBEINTUBE', 'FLOODEDSHELLANDTUBE', 'NOTDEFINED', 'SHELLANDCOIL', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcPipeSegment EXTENDING default::IfcFlowSegment {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CULVERT', 'FLEXIBLESEGMENT', 'GUTTER', 'NOTDEFINED', 'RIGIDSEGMENT', 'SPOOL', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcElectricMotor EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DC', 'INDUCTION', 'NOTDEFINED', 'POLYPHASE', 'RELUCTANCESYNCHRONOUS', 'SYNCHRONOUS', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcPort EXTENDING default::IfcProduct;
  CREATE TYPE default::IfcRelConnectsPortToElement EXTENDING default::IfcRelConnects {
      CREATE REQUIRED LINK RelatedElement -> default::IfcDistributionElement;
      CREATE REQUIRED LINK RelatingPort -> default::IfcPort;
  };
  CREATE TYPE default::IfcFlowMeterType EXTENDING default::IfcFlowControllerType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ENERGYMETER', 'GASMETER', 'NOTDEFINED', 'OILMETER', 'USERDEFINED', 'WATERMETER');
      };
  };
  CREATE TYPE default::IfcEvaporatorType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DIRECTEXPANSION', 'DIRECTEXPANSIONBRAZEDPLATE', 'DIRECTEXPANSIONSHELLANDTUBE', 'DIRECTEXPANSIONTUBEINTUBE', 'FLOODEDSHELLANDTUBE', 'NOTDEFINED', 'SHELLANDCOIL', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcWasteTerminalType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FLOORTRAP', 'FLOORWASTE', 'GULLYSUMP', 'GULLYTRAP', 'NOTDEFINED', 'ROOFDRAIN', 'USERDEFINED', 'WASTEDISPOSALUNIT', 'WASTETRAP');
      };
  };
  CREATE TYPE default::IfcElectricDistributionBoardType EXTENDING default::IfcFlowControllerType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONSUMERUNIT', 'DISTRIBUTIONBOARD', 'MOTORCONTROLCENTRE', 'NOTDEFINED', 'SWITCHBOARD', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcFlowTreatmentDeviceType EXTENDING default::IfcDistributionFlowElementType;
  CREATE TYPE default::IfcDuctSilencerType EXTENDING default::IfcFlowTreatmentDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FLATOVAL', 'NOTDEFINED', 'RECTANGULAR', 'ROUND', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSanitaryTerminalType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BATH', 'BIDET', 'CISTERN', 'NOTDEFINED', 'SANITARYFOUNTAIN', 'SHOWER', 'SINK', 'TOILETPAN', 'URINAL', 'USERDEFINED', 'WASHHANDBASIN', 'WCSEAT');
      };
  };
  CREATE ABSTRACT TYPE default::IfcFlowStorageDeviceType EXTENDING default::IfcDistributionFlowElementType;
  CREATE TYPE default::IfcElectricFlowStorageDeviceType EXTENDING default::IfcFlowStorageDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BATTERY', 'CAPACITORBANK', 'HARMONICFILTER', 'INDUCTORBANK', 'NOTDEFINED', 'UPS', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcElectricGeneratorType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CHP', 'ENGINEGENERATOR', 'NOTDEFINED', 'STANDALONE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSwitchingDeviceType EXTENDING default::IfcFlowControllerType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONTACTOR', 'DIMMERSWITCH', 'EMERGENCYSTOP', 'KEYPAD', 'MOMENTARYSWITCH', 'NOTDEFINED', 'SELECTORSWITCH', 'STARTER', 'SWITCHDISCONNECTOR', 'TOGGLESWITCH', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcPumpType EXTENDING default::IfcFlowMovingDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CIRCULATOR', 'ENDSUCTION', 'NOTDEFINED', 'SPLITCASE', 'SUBMERSIBLEPUMP', 'SUMPPUMP', 'USERDEFINED', 'VERTICALINLINE', 'VERTICALTURBINE');
      };
  };
  CREATE TYPE default::IfcHumidifierType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ADIABATICAIRWASHER', 'ADIABATICATOMIZING', 'ADIABATICCOMPRESSEDAIRNOZZLE', 'ADIABATICPAN', 'ADIABATICRIGIDMEDIA', 'ADIABATICULTRASONIC', 'ADIABATICWETTEDELEMENT', 'ASSISTEDBUTANE', 'ASSISTEDELECTRIC', 'ASSISTEDNATURALGAS', 'ASSISTEDPROPANE', 'ASSISTEDSTEAM', 'NOTDEFINED', 'STEAMINJECTION', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcEngineType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('EXTERNALCOMBUSTION', 'INTERNALCOMBUSTION', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcTransformerType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CURRENT', 'FREQUENCY', 'INVERTER', 'NOTDEFINED', 'RECTIFIER', 'USERDEFINED', 'VOLTAGE');
      };
  };
  CREATE TYPE default::IfcElectricMotorType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DC', 'INDUCTION', 'NOTDEFINED', 'POLYPHASE', 'RELUCTANCESYNCHRONOUS', 'SYNCHRONOUS', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcMotorConnectionType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BELTDRIVE', 'COUPLING', 'DIRECTDRIVE', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcElectricApplianceType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DISHWASHER', 'ELECTRICCOOKER', 'FREESTANDINGELECTRICHEATER', 'FREESTANDINGFAN', 'FREESTANDINGWATERCOOLER', 'FREESTANDINGWATERHEATER', 'FREEZER', 'FRIDGE_FREEZER', 'HANDDRYER', 'KITCHENMACHINE', 'MICROWAVE', 'NOTDEFINED', 'PHOTOCOPIER', 'REFRIGERATOR', 'TUMBLEDRYER', 'USERDEFINED', 'VENDINGMACHINE', 'WASHINGMACHINE');
      };
  };
  CREATE TYPE default::IfcTubeBundleType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FINNED', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcPipeFittingType EXTENDING default::IfcFlowFittingType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BEND', 'CONNECTOR', 'ENTRY', 'EXIT', 'JUNCTION', 'NOTDEFINED', 'OBSTRUCTION', 'TRANSITION', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcMedicalDeviceType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRSTATION', 'FEEDAIRUNIT', 'NOTDEFINED', 'OXYGENGENERATOR', 'OXYGENPLANT', 'USERDEFINED', 'VACUUMSTATION');
      };
  };
  CREATE TYPE default::IfcUnitaryEquipmentType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRCONDITIONINGUNIT', 'AIRHANDLER', 'DEHUMIDIFIER', 'NOTDEFINED', 'ROOFTOPUNIT', 'SPLITSYSTEM', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcInterceptorType EXTENDING default::IfcFlowTreatmentDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CYCLONIC', 'GREASE', 'NOTDEFINED', 'OIL', 'PETROL', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcFireSuppressionTerminalType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BREECHINGINLET', 'FIREHYDRANT', 'HOSEREEL', 'NOTDEFINED', 'SPRINKLER', 'SPRINKLERDEFLECTOR', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcDuctSegmentType EXTENDING default::IfcFlowSegmentType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FLEXIBLESEGMENT', 'NOTDEFINED', 'RIGIDSEGMENT', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcStackTerminalType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BIRDCAGE', 'COWL', 'NOTDEFINED', 'RAINWATERHOPPER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcLampType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('COMPACTFLUORESCENT', 'FLUORESCENT', 'HALOGEN', 'HIGHPRESSUREMERCURY', 'HIGHPRESSURESODIUM', 'LED', 'METALHALIDE', 'NOTDEFINED', 'OLED', 'TUNGSTENFILAMENT', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcDuctFittingType EXTENDING default::IfcFlowFittingType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BEND', 'CONNECTOR', 'ENTRY', 'EXIT', 'JUNCTION', 'NOTDEFINED', 'OBSTRUCTION', 'TRANSITION', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcOutletType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AUDIOVISUALOUTLET', 'COMMUNICATIONSOUTLET', 'DATAOUTLET', 'NOTDEFINED', 'POWEROUTLET', 'TELEPHONEOUTLET', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcLightFixtureType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DIRECTIONSOURCE', 'NOTDEFINED', 'POINTSOURCE', 'SECURITYLIGHTING', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcJunctionBoxType EXTENDING default::IfcFlowFittingType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DATA', 'NOTDEFINED', 'POWER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcFanType EXTENDING default::IfcFlowMovingDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CENTRIFUGALAIRFOIL', 'CENTRIFUGALBACKWARDINCLINEDCURVED', 'CENTRIFUGALFORWARDCURVED', 'CENTRIFUGALRADIAL', 'NOTDEFINED', 'PROPELLORAXIAL', 'TUBEAXIAL', 'USERDEFINED', 'VANEAXIAL');
      };
  };
  CREATE TYPE default::IfcProtectiveDeviceType EXTENDING default::IfcFlowControllerType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CIRCUITBREAKER', 'EARTHINGSWITCH', 'EARTHLEAKAGECIRCUITBREAKER', 'FUSEDISCONNECTOR', 'NOTDEFINED', 'RESIDUALCURRENTCIRCUITBREAKER', 'RESIDUALCURRENTSWITCH', 'USERDEFINED', 'VARISTOR');
      };
  };
  CREATE TYPE default::IfcValveType EXTENDING default::IfcFlowControllerType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRRELEASE', 'ANTIVACUUM', 'CHANGEOVER', 'CHECK', 'COMMISSIONING', 'DIVERTING', 'DOUBLECHECK', 'DOUBLEREGULATING', 'DRAWOFFCOCK', 'FAUCET', 'FLUSHING', 'GASCOCK', 'GASTAP', 'ISOLATING', 'MIXING', 'NOTDEFINED', 'PRESSUREREDUCING', 'PRESSURERELIEF', 'REGULATING', 'SAFETYCUTOFF', 'STEAMTRAP', 'STOPCOCK', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSpaceHeaterType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONVECTOR', 'NOTDEFINED', 'RADIATOR', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcEvaporativeCoolerType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DIRECTEVAPORATIVEAIRWASHER', 'DIRECTEVAPORATIVEPACKAGEDROTARYAIRCOOLER', 'DIRECTEVAPORATIVERANDOMMEDIAAIRCOOLER', 'DIRECTEVAPORATIVERIGIDMEDIAAIRCOOLER', 'DIRECTEVAPORATIVESLINGERSPACKAGEDAIRCOOLER', 'INDIRECTDIRECTCOMBINATION', 'INDIRECTEVAPORATIVECOOLINGTOWERORCOILCOOLER', 'INDIRECTEVAPORATIVEPACKAGEAIRCOOLER', 'INDIRECTEVAPORATIVEWETCOIL', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcHeatExchangerType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'PLATE', 'SHELLANDTUBE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcTankType EXTENDING default::IfcFlowStorageDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BASIN', 'BREAKPRESSURE', 'EXPANSION', 'FEEDANDEXPANSION', 'NOTDEFINED', 'PRESSUREVESSEL', 'STORAGE', 'USERDEFINED', 'VESSEL');
      };
  };
  CREATE TYPE default::IfcSolarDeviceType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'SOLARCOLLECTOR', 'SOLARPANEL', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcElectricTimeControlType EXTENDING default::IfcFlowControllerType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'RELAY', 'TIMECLOCK', 'TIMEDELAY', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcFilterType EXTENDING default::IfcFlowTreatmentDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRPARTICLEFILTER', 'COMPRESSEDAIRFILTER', 'NOTDEFINED', 'ODORFILTER', 'OILFILTER', 'STRAINER', 'USERDEFINED', 'WATERFILTER');
      };
  };
  CREATE TYPE default::IfcPipeSegmentType EXTENDING default::IfcFlowSegmentType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CULVERT', 'FLEXIBLESEGMENT', 'GUTTER', 'NOTDEFINED', 'RIGIDSEGMENT', 'SPOOL', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcDistributionPort EXTENDING default::IfcPort {
      CREATE PROPERTY FlowDirection -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'SINK', 'SOURCE', 'SOURCEANDSINK');
      };
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CABLE', 'CABLECARRIER', 'DUCT', 'NOTDEFINED', 'PIPE', 'USERDEFINED');
      };
      CREATE PROPERTY SystemType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRCONDITIONING', 'AUDIOVISUAL', 'CHEMICAL', 'CHILLEDWATER', 'COMMUNICATION', 'COMPRESSEDAIR', 'CONDENSERWATER', 'CONTROL', 'CONVEYING', 'DATA', 'DISPOSAL', 'DOMESTICCOLDWATER', 'DOMESTICHOTWATER', 'DRAINAGE', 'EARTHING', 'ELECTRICAL', 'ELECTROACOUSTIC', 'EXHAUST', 'FIREPROTECTION', 'FUEL', 'GAS', 'HAZARDOUS', 'HEATING', 'LIGHTING', 'LIGHTNINGPROTECTION', 'MUNICIPALSOLIDWASTE', 'NOTDEFINED', 'OIL', 'OPERATIONAL', 'POWERGENERATION', 'RAINWATER', 'REFRIGERATION', 'SECURITY', 'SEWAGE', 'SIGNAL', 'STORMWATER', 'TELEPHONE', 'TV', 'USERDEFINED', 'VACUUM', 'VENT', 'VENTILATION', 'WASTEWATER', 'WATERSUPPLY');
      };
  };
  CREATE TYPE default::IfcDocumentInformationRelationship EXTENDING default::IfcResourceLevelRelationship {
      CREATE REQUIRED MULTI LINK RelatedDocuments -> default::IfcDocumentInformation;
      CREATE REQUIRED LINK RelatingDocument -> default::IfcDocumentInformation;
      CREATE PROPERTY RelationshipType -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcPreDefinedPropertySet EXTENDING default::IfcPropertySetDefinition;
  CREATE TYPE default::IfcDoorLiningProperties EXTENDING default::IfcPreDefinedPropertySet {
      CREATE LINK ShapeAspectStyle -> default::IfcShapeAspect;
      CREATE PROPERTY CasingDepth -> std::float64;
      CREATE PROPERTY CasingThickness -> std::float64;
      CREATE PROPERTY LiningDepth -> std::float64;
      CREATE PROPERTY LiningOffset -> std::float64;
      CREATE PROPERTY LiningThickness -> std::float64;
      CREATE PROPERTY LiningToPanelOffsetX -> std::float64;
      CREATE PROPERTY LiningToPanelOffsetY -> std::float64;
      CREATE PROPERTY ThresholdDepth -> std::float64;
      CREATE PROPERTY ThresholdOffset -> std::float64;
      CREATE PROPERTY ThresholdThickness -> std::float64;
      CREATE PROPERTY TransomOffset -> std::float64;
      CREATE PROPERTY TransomThickness -> std::float64;
  };
  CREATE TYPE default::IfcDoorPanelProperties EXTENDING default::IfcPreDefinedPropertySet {
      CREATE LINK ShapeAspectStyle -> default::IfcShapeAspect;
      CREATE PROPERTY PanelDepth -> std::float64;
      CREATE REQUIRED PROPERTY PanelOperation -> std::str {
          CREATE CONSTRAINT std::one_of('DOUBLE_ACTING', 'FIXEDPANEL', 'FOLDING', 'NOTDEFINED', 'REVOLVING', 'ROLLINGUP', 'SLIDING', 'SWINGING', 'USERDEFINED');
      };
      CREATE REQUIRED PROPERTY PanelPosition -> std::str {
          CREATE CONSTRAINT std::one_of('LEFT', 'MIDDLE', 'NOTDEFINED', 'RIGHT');
      };
      CREATE PROPERTY PanelWidth -> std::float64;
  };
  CREATE TYPE default::IfcDoorStyle EXTENDING default::IfcTypeProduct {
      CREATE REQUIRED PROPERTY ConstructionType -> std::str {
          CREATE CONSTRAINT std::one_of('ALUMINIUM', 'ALUMINIUM_PLASTIC', 'ALUMINIUM_WOOD', 'HIGH_GRADE_STEEL', 'NOTDEFINED', 'PLASTIC', 'STEEL', 'USERDEFINED', 'WOOD');
      };
      CREATE REQUIRED PROPERTY OperationType -> std::str {
          CREATE CONSTRAINT std::one_of('DOUBLE_DOOR_DOUBLE_SWING', 'DOUBLE_DOOR_FOLDING', 'DOUBLE_DOOR_SINGLE_SWING', 'DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_LEFT', 'DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_RIGHT', 'DOUBLE_DOOR_SLIDING', 'DOUBLE_SWING_LEFT', 'DOUBLE_SWING_RIGHT', 'FOLDING_TO_LEFT', 'FOLDING_TO_RIGHT', 'NOTDEFINED', 'REVOLVING', 'ROLLINGUP', 'SINGLE_SWING_LEFT', 'SINGLE_SWING_RIGHT', 'SLIDING_TO_LEFT', 'SLIDING_TO_RIGHT', 'USERDEFINED');
      };
      CREATE REQUIRED PROPERTY ParameterTakesPrecedence -> std::bool;
      CREATE REQUIRED PROPERTY Sizeable -> std::bool;
  };
  CREATE TYPE default::IfcDraughtingPreDefinedColour EXTENDING default::IfcPreDefinedColour;
  CREATE TYPE default::IfcDraughtingPreDefinedCurveFont EXTENDING default::IfcPreDefinedCurveFont;
  CREATE TYPE default::IfcOrientedEdge EXTENDING default::IfcEdge {
      CREATE REQUIRED LINK EdgeElement -> default::IfcEdge;
      CREATE REQUIRED PROPERTY Orientation -> std::bool;
  };
  CREATE TYPE default::IfcSubedge EXTENDING default::IfcEdge {
      CREATE REQUIRED LINK ParentEdge -> default::IfcEdge;
  };
  CREATE TYPE default::IfcEdgeLoop EXTENDING default::IfcLoop {
      CREATE REQUIRED MULTI LINK EdgeList -> default::IfcOrientedEdge;
  };
  CREATE TYPE default::IfcElementAssembly EXTENDING default::IfcElement {
      CREATE PROPERTY AssemblyPlace -> std::str {
          CREATE CONSTRAINT std::one_of('FACTORY', 'NOTDEFINED', 'SITE');
      };
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ACCESSORY_ASSEMBLY', 'ARCH', 'BEAM_GRID', 'BRACED_FRAME', 'GIRDER', 'NOTDEFINED', 'REINFORCEMENT_UNIT', 'RIGID_FRAME', 'SLAB_FIELD', 'TRUSS', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcReinforcingElement EXTENDING default::IfcElementComponent {
      CREATE PROPERTY SteelGrade -> std::str;
  };
  CREATE TYPE default::IfcReinforcingMesh EXTENDING default::IfcReinforcingElement {
      CREATE PROPERTY LongitudinalBarCrossSectionArea -> std::float64;
      CREATE PROPERTY LongitudinalBarNominalDiameter -> std::float64;
      CREATE PROPERTY LongitudinalBarSpacing -> std::float64;
      CREATE PROPERTY MeshLength -> std::float64;
      CREATE PROPERTY MeshWidth -> std::float64;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'USERDEFINED');
      };
      CREATE PROPERTY TransverseBarCrossSectionArea -> std::float64;
      CREATE PROPERTY TransverseBarNominalDiameter -> std::float64;
      CREATE PROPERTY TransverseBarSpacing -> std::float64;
  };
  CREATE TYPE default::IfcTendon EXTENDING default::IfcReinforcingElement {
      CREATE PROPERTY AnchorageSlip -> std::float64;
      CREATE PROPERTY CrossSectionArea -> std::float64;
      CREATE PROPERTY FrictionCoefficient -> std::float64;
      CREATE PROPERTY MinCurvatureRadius -> std::float64;
      CREATE PROPERTY NominalDiameter -> std::float64;
      CREATE PROPERTY PreStress -> std::float64;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BAR', 'COATED', 'NOTDEFINED', 'STRAND', 'USERDEFINED', 'WIRE');
      };
      CREATE PROPERTY TensionForce -> std::float64;
  };
  CREATE TYPE default::IfcFastener EXTENDING default::IfcElementComponent {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('GLUE', 'MORTAR', 'NOTDEFINED', 'USERDEFINED', 'WELD');
      };
  };
  CREATE TYPE default::IfcTendonAnchor EXTENDING default::IfcReinforcingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('COUPLER', 'FIXED_END', 'NOTDEFINED', 'TENSIONING_END', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcReinforcingBar EXTENDING default::IfcReinforcingElement {
      CREATE PROPERTY BarLength -> std::float64;
      CREATE PROPERTY BarSurface -> std::str {
          CREATE CONSTRAINT std::one_of('PLAIN', 'TEXTURED');
      };
      CREATE PROPERTY CrossSectionArea -> std::float64;
      CREATE PROPERTY NominalDiameter -> std::float64;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ANCHORING', 'EDGE', 'LIGATURE', 'MAIN', 'NOTDEFINED', 'PUNCHING', 'RING', 'SHEAR', 'STUD', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcVibrationIsolator EXTENDING default::IfcElementComponent {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('COMPRESSION', 'NOTDEFINED', 'SPRING', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcMechanicalFastener EXTENDING default::IfcElementComponent {
      CREATE PROPERTY NominalDiameter -> std::float64;
      CREATE PROPERTY NominalLength -> std::float64;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ANCHORBOLT', 'BOLT', 'DOWEL', 'NAIL', 'NAILPLATE', 'NOTDEFINED', 'RIVET', 'SCREW', 'SHEARCONNECTOR', 'STAPLE', 'STUDSHEARCONNECTOR', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcFeatureElement EXTENDING default::IfcElement;
  CREATE ABSTRACT TYPE default::IfcFeatureElementSubtraction EXTENDING default::IfcFeatureElement;
  CREATE TYPE default::IfcVoidingFeature EXTENDING default::IfcFeatureElementSubtraction {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CHAMFER', 'CUTOUT', 'EDGE', 'HOLE', 'MITER', 'NOTCH', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcFeatureElementAddition EXTENDING default::IfcFeatureElement;
  CREATE TYPE default::IfcOpeningElement EXTENDING default::IfcFeatureElementSubtraction {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'OPENING', 'RECESS', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSurfaceFeature EXTENDING default::IfcFeatureElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('MARK', 'NOTDEFINED', 'TAG', 'TREATMENT', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcProjectionElement EXTENDING default::IfcFeatureElementAddition {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcOpeningStandardCase EXTENDING default::IfcOpeningElement;
  CREATE TYPE default::IfcFurnishingElement EXTENDING default::IfcElement;
  CREATE TYPE default::IfcSystemFurnitureElement EXTENDING default::IfcFurnishingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'PANEL', 'USERDEFINED', 'WORKSURFACE');
      };
  };
  CREATE TYPE default::IfcFurniture EXTENDING default::IfcFurnishingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BED', 'CHAIR', 'DESK', 'FILECABINET', 'NOTDEFINED', 'SHELF', 'SOFA', 'TABLE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcGeographicElement EXTENDING default::IfcElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'TERRAIN', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcTransportElement EXTENDING default::IfcElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CRANEWAY', 'ELEVATOR', 'ESCALATOR', 'LIFTINGGEAR', 'MOVINGWALKWAY', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcVirtualElement EXTENDING default::IfcElement;
  CREATE TYPE default::IfcRelConnectsPorts EXTENDING default::IfcRelConnects {
      CREATE LINK RealizingElement -> default::IfcElement;
      CREATE REQUIRED LINK RelatedPort -> default::IfcPort;
      CREATE REQUIRED LINK RelatingPort -> default::IfcPort;
  };
  CREATE TYPE default::IfcRelFillsElement EXTENDING default::IfcRelConnects {
      CREATE REQUIRED LINK RelatedBuildingElement -> default::IfcElement;
      CREATE REQUIRED LINK RelatingOpeningElement -> default::IfcOpeningElement;
  };
  CREATE ABSTRACT TYPE default::IfcRelDecomposes EXTENDING default::IfcRelationship;
  CREATE TYPE default::IfcRelVoidsElement EXTENDING default::IfcRelDecomposes {
      CREATE REQUIRED LINK RelatingBuildingElement -> default::IfcElement;
      CREATE REQUIRED LINK RelatedOpeningElement -> default::IfcFeatureElementSubtraction;
  };
  CREATE TYPE default::IfcRelProjectsElement EXTENDING default::IfcRelDecomposes {
      CREATE REQUIRED LINK RelatingElement -> default::IfcElement;
      CREATE REQUIRED LINK RelatedFeatureElement -> default::IfcFeatureElementAddition;
  };
  CREATE TYPE default::IfcElementAssemblyType EXTENDING default::IfcElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ACCESSORY_ASSEMBLY', 'ARCH', 'BEAM_GRID', 'BRACED_FRAME', 'GIRDER', 'NOTDEFINED', 'REINFORCEMENT_UNIT', 'RIGID_FRAME', 'SLAB_FIELD', 'TRUSS', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcFastenerType EXTENDING default::IfcElementComponentType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('GLUE', 'MORTAR', 'NOTDEFINED', 'USERDEFINED', 'WELD');
      };
  };
  CREATE TYPE default::IfcMechanicalFastenerType EXTENDING default::IfcElementComponentType {
      CREATE PROPERTY NominalDiameter -> std::float64;
      CREATE PROPERTY NominalLength -> std::float64;
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ANCHORBOLT', 'BOLT', 'DOWEL', 'NAIL', 'NAILPLATE', 'NOTDEFINED', 'RIVET', 'SCREW', 'SHEARCONNECTOR', 'STAPLE', 'STUDSHEARCONNECTOR', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcTendonAnchorType EXTENDING default::IfcReinforcingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('COUPLER', 'FIXED_END', 'NOTDEFINED', 'TENSIONING_END', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcTendonType EXTENDING default::IfcReinforcingElementType {
      CREATE PROPERTY CrossSectionArea -> std::float64;
      CREATE PROPERTY NominalDiameter -> std::float64;
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BAR', 'COATED', 'NOTDEFINED', 'STRAND', 'USERDEFINED', 'WIRE');
      };
      CREATE PROPERTY SheathDiameter -> std::float64;
  };
  CREATE TYPE default::IfcVibrationIsolatorType EXTENDING default::IfcElementComponentType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('COMPRESSION', 'NOTDEFINED', 'SPRING', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcQuantitySet EXTENDING default::IfcPropertySetDefinition;
  CREATE TYPE default::IfcElementQuantity EXTENDING default::IfcQuantitySet {
      CREATE REQUIRED MULTI LINK Quantities -> default::IfcPhysicalQuantity;
      CREATE PROPERTY MethodOfMeasurement -> std::str;
  };
  CREATE TYPE default::IfcFurnishingElementType EXTENDING default::IfcElementType;
  CREATE TYPE default::IfcFurnitureType EXTENDING default::IfcFurnishingElementType {
      CREATE REQUIRED PROPERTY AssemblyPlace -> std::str {
          CREATE CONSTRAINT std::one_of('FACTORY', 'NOTDEFINED', 'SITE');
      };
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BED', 'CHAIR', 'DESK', 'FILECABINET', 'NOTDEFINED', 'SHELF', 'SOFA', 'TABLE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSystemFurnitureElementType EXTENDING default::IfcFurnishingElementType {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'PANEL', 'USERDEFINED', 'WORKSURFACE');
      };
  };
  CREATE TYPE default::IfcGeographicElementType EXTENDING default::IfcElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'TERRAIN', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcTransportElementType EXTENDING default::IfcElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CRANEWAY', 'ELEVATOR', 'ESCALATOR', 'LIFTINGGEAR', 'MOVINGWALKWAY', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcEventTime EXTENDING default::IfcSchedulingTime {
      CREATE PROPERTY ActualDate -> std::str;
      CREATE PROPERTY EarlyDate -> std::str;
      CREATE PROPERTY LateDate -> std::str;
      CREATE PROPERTY ScheduleDate -> std::str;
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
  CREATE TYPE default::IfcEventType EXTENDING default::IfcTypeProcess {
      CREATE REQUIRED PROPERTY EventTriggerType -> std::str {
          CREATE CONSTRAINT std::one_of('EVENTCOMPLEX', 'EVENTMESSAGE', 'EVENTRULE', 'EVENTTIME', 'NOTDEFINED', 'USERDEFINED');
      };
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ENDEVENT', 'INTERMEDIATEEVENT', 'NOTDEFINED', 'STARTEVENT', 'USERDEFINED');
      };
      CREATE PROPERTY UserDefinedEventTriggerType -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcExtendedProperties EXTENDING default::IfcPropertyAbstraction {
      CREATE REQUIRED MULTI LINK Properties -> default::IfcProperty;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcMaterialProperties EXTENDING default::IfcExtendedProperties {
      CREATE REQUIRED LINK Material -> default::IfcMaterialDefinition;
  };
  CREATE TYPE default::IfcProfileProperties EXTENDING default::IfcExtendedProperties {
      CREATE REQUIRED LINK ProfileDefinition -> default::IfcProfileDef;
  };
  CREATE TYPE default::IfcExternalReferenceRelationship EXTENDING default::IfcResourceLevelRelationship {
      CREATE REQUIRED LINK RelatingReference -> default::IfcExternalReference;
      CREATE REQUIRED MULTI LINK RelatedResourceObjects -> default::IfcResourceObjectSelect;
  };
  CREATE TYPE default::IfcTextureVertex EXTENDING default::IfcPresentationItem {
      CREATE REQUIRED PROPERTY Coordinates -> tuple<std::float64, std::float64>;
  };
  CREATE TYPE default::IfcTextureMap EXTENDING default::IfcTextureCoordinate {
      CREATE REQUIRED LINK MappedTo -> default::IfcFace;
      CREATE REQUIRED MULTI LINK Vertices -> default::IfcTextureVertex;
  };
  CREATE TYPE default::IfcFaceOuterBound EXTENDING default::IfcFaceBound;
  CREATE TYPE default::IfcFailureConnectionCondition EXTENDING default::IfcStructuralConnectionCondition {
      CREATE PROPERTY CompressionFailureX -> std::float64;
      CREATE PROPERTY CompressionFailureY -> std::float64;
      CREATE PROPERTY CompressionFailureZ -> std::float64;
      CREATE PROPERTY TensionFailureX -> std::float64;
      CREATE PROPERTY TensionFailureY -> std::float64;
      CREATE PROPERTY TensionFailureZ -> std::float64;
  };
  CREATE TYPE default::IfcStyledItem EXTENDING default::IfcRepresentationItem {
      CREATE LINK Item -> default::IfcRepresentationItem;
      CREATE REQUIRED MULTI LINK Styles -> default::IfcStyleAssignmentSelect;
      CREATE PROPERTY Name -> std::str;
  };
  ALTER TYPE default::IfcFillAreaStyleTiles {
      CREATE REQUIRED MULTI LINK Tiles -> default::IfcStyledItem;
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
  CREATE TYPE default::IfcGeometricSet EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED MULTI LINK Elements -> default::IfcGeometricSetSelect;
  };
  CREATE TYPE default::IfcGeometricCurveSet EXTENDING default::IfcGeometricSet;
  CREATE TYPE default::IfcPointOnSurface EXTENDING default::IfcPoint {
      CREATE REQUIRED LINK BasisSurface -> default::IfcSurface;
      CREATE REQUIRED PROPERTY PointParameterU -> std::float64;
      CREATE REQUIRED PROPERTY PointParameterV -> std::float64;
  };
  CREATE TYPE default::IfcShellBasedSurfaceModel EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED MULTI LINK SbsmBoundary -> default::IfcShell;
  };
  CREATE TYPE default::IfcGloballyUniqueId {
      CREATE REQUIRED PROPERTY IfcGloballyUniqueId -> std::str;
  };
  CREATE TYPE default::IfcGrid EXTENDING default::IfcPositioningElement {
      CREATE REQUIRED MULTI LINK UAxes -> default::IfcGridAxis;
      CREATE REQUIRED MULTI LINK VAxes -> default::IfcGridAxis;
      CREATE MULTI LINK WAxes -> default::IfcGridAxis;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('IRREGULAR', 'NOTDEFINED', 'RADIAL', 'RECTANGULAR', 'TRIANGULAR', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcGridPlacement EXTENDING default::IfcObjectPlacement {
      CREATE REQUIRED LINK PlacementLocation -> default::IfcVirtualGridIntersection;
      CREATE LINK PlacementRefDirection -> default::IfcGridPlacementDirectionSelect;
  };
  CREATE TYPE default::IfcStructuralLoadCase EXTENDING default::IfcStructuralLoadGroup {
      CREATE PROPERTY SelfWeightCoefficients -> tuple<std::float64, std::float64, std::float64>;
  };
  CREATE TYPE default::IfcZone EXTENDING default::IfcSystem {
      CREATE PROPERTY LongName -> std::str;
  };
  CREATE TYPE default::IfcRelAssignsToGroup EXTENDING default::IfcRelAssigns {
      CREATE REQUIRED LINK RelatingGroup -> default::IfcGroup;
  };
  CREATE TYPE default::IfcRelAssignsToGroupByFactor EXTENDING default::IfcRelAssignsToGroup {
      CREATE REQUIRED PROPERTY Factor -> std::float64;
  };
  CREATE TYPE default::IfcIrregularTimeSeriesValue {
      CREATE REQUIRED MULTI LINK ListValues -> default::IfcValue;
      CREATE REQUIRED PROPERTY TimeStamp -> std::str;
  };
  CREATE TYPE default::IfcIrregularTimeSeries EXTENDING default::IfcTimeSeries {
      CREATE REQUIRED MULTI LINK Values -> default::IfcIrregularTimeSeriesValue;
  };
  CREATE TYPE default::IfcLagTime EXTENDING default::IfcSchedulingTime {
      CREATE REQUIRED LINK LagValue -> default::IfcTimeOrRatioSelect;
      CREATE REQUIRED PROPERTY DurationType -> std::str {
          CREATE CONSTRAINT std::one_of('ELAPSEDTIME', 'NOTDEFINED', 'WORKTIME');
      };
  };
  CREATE TYPE default::IfcRelSequence EXTENDING default::IfcRelConnects {
      CREATE LINK TimeLag -> default::IfcLagTime;
      CREATE REQUIRED LINK RelatedProcess -> default::IfcProcess;
      CREATE REQUIRED LINK RelatingProcess -> default::IfcProcess;
      CREATE PROPERTY SequenceType -> std::str {
          CREATE CONSTRAINT std::one_of('FINISH_FINISH', 'FINISH_START', 'NOTDEFINED', 'START_FINISH', 'START_START', 'USERDEFINED');
      };
      CREATE PROPERTY UserDefinedSequenceType -> std::str;
  };
  CREATE TYPE default::IfcLanguageId {
      CREATE REQUIRED PROPERTY IfcLanguageId -> std::str;
  };
  CREATE TYPE default::IfcPresentationLayerAssignment {
      CREATE REQUIRED MULTI LINK AssignedItems -> default::IfcLayeredItem;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Identifier -> std::str;
      CREATE REQUIRED PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcPresentationLayerWithStyle EXTENDING default::IfcPresentationLayerAssignment {
      CREATE REQUIRED MULTI LINK LayerStyles -> default::IfcPresentationStyle;
      CREATE REQUIRED PROPERTY LayerBlocked -> std::bool;
      CREATE REQUIRED PROPERTY LayerFrozen -> std::bool;
      CREATE REQUIRED PROPERTY LayerOn -> std::bool;
  };
  CREATE TYPE default::IfcVertexLoop EXTENDING default::IfcLoop {
      CREATE REQUIRED LINK LoopVertex -> default::IfcVertex;
  };
  CREATE TYPE default::IfcMaterialConstituent EXTENDING default::IfcMaterialDefinition {
      CREATE REQUIRED LINK Material -> default::IfcMaterial;
      CREATE PROPERTY Category -> std::str;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Fraction -> std::float64;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcMaterialLayer EXTENDING default::IfcMaterialDefinition {
      CREATE LINK Material -> default::IfcMaterial;
      CREATE PROPERTY Category -> std::str;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY IsVentilated -> std::bool;
      CREATE REQUIRED PROPERTY LayerThickness -> std::float64;
      CREATE PROPERTY Name -> std::str;
      CREATE PROPERTY Priority -> std::int64;
  };
  CREATE TYPE default::IfcMaterialLayerWithOffsets EXTENDING default::IfcMaterialLayer {
      CREATE REQUIRED PROPERTY OffsetDirection -> std::str {
          CREATE CONSTRAINT std::one_of('AXIS1', 'AXIS2', 'AXIS3');
      };
      CREATE REQUIRED MULTI PROPERTY OffsetValues -> std::float64;
  };
  CREATE TYPE default::IfcMaterialProfileWithOffsets EXTENDING default::IfcMaterialProfile {
      CREATE REQUIRED MULTI PROPERTY OffsetValues -> std::float64;
  };
  CREATE TYPE default::IfcMaterialRelationship EXTENDING default::IfcResourceLevelRelationship {
      CREATE REQUIRED MULTI LINK RelatedMaterials -> default::IfcMaterial;
      CREATE REQUIRED LINK RelatingMaterial -> default::IfcMaterial;
      CREATE PROPERTY Expression -> std::str;
  };
  CREATE TYPE default::IfcMaterialDefinitionRepresentation EXTENDING default::IfcProductRepresentation {
      CREATE REQUIRED LINK RepresentedMaterial -> default::IfcMaterial;
  };
  CREATE TYPE default::IfcMaterialConstituentSet EXTENDING default::IfcMaterialDefinition {
      CREATE MULTI LINK MaterialConstituents -> default::IfcMaterialConstituent;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcMaterialLayerSet EXTENDING default::IfcMaterialDefinition {
      CREATE REQUIRED MULTI LINK MaterialLayers -> default::IfcMaterialLayer;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY LayerSetName -> std::str;
  };
  CREATE TYPE default::IfcMaterialLayerSetUsage EXTENDING default::IfcMaterialUsageDefinition {
      CREATE REQUIRED LINK ForLayerSet -> default::IfcMaterialLayerSet;
      CREATE REQUIRED PROPERTY DirectionSense -> std::str {
          CREATE CONSTRAINT std::one_of('NEGATIVE', 'POSITIVE');
      };
      CREATE REQUIRED PROPERTY LayerSetDirection -> std::str {
          CREATE CONSTRAINT std::one_of('AXIS1', 'AXIS2', 'AXIS3');
      };
      CREATE REQUIRED PROPERTY OffsetFromReferenceLine -> std::float64;
      CREATE PROPERTY ReferenceExtent -> std::float64;
  };
  CREATE TYPE default::IfcMaterialProfileSetUsage EXTENDING default::IfcMaterialUsageDefinition {
      CREATE REQUIRED LINK ForProfileSet -> default::IfcMaterialProfileSet;
      CREATE PROPERTY CardinalPoint -> std::int64;
      CREATE PROPERTY ReferenceExtent -> std::float64;
  };
  CREATE TYPE default::IfcMaterialProfileSetUsageTapering EXTENDING default::IfcMaterialProfileSetUsage {
      CREATE REQUIRED LINK ForProfileEndSet -> default::IfcMaterialProfileSet;
      CREATE PROPERTY CardinalEndPoint -> std::int64;
  };
  CREATE TYPE default::IfcRelAssignsToProcess EXTENDING default::IfcRelAssigns {
      CREATE LINK QuantityInProcess -> default::IfcMeasureWithUnit;
      CREATE REQUIRED LINK RelatingProcess -> default::IfcProcessSelect;
  };
  CREATE TYPE default::IfcMonthInYearNumber {
      CREATE REQUIRED PROPERTY IfcMonthInYearNumber -> std::int64;
  };
  CREATE ABSTRACT TYPE default::IfcPhysicalSimpleQuantity EXTENDING default::IfcPhysicalQuantity {
      CREATE LINK Unit -> default::IfcNamedUnit;
  };
  CREATE TYPE default::IfcQuantityLength EXTENDING default::IfcPhysicalSimpleQuantity {
      CREATE PROPERTY Formula -> std::str;
      CREATE REQUIRED PROPERTY LengthValue -> std::float64;
  };
  CREATE TYPE default::IfcQuantityCount EXTENDING default::IfcPhysicalSimpleQuantity {
      CREATE REQUIRED PROPERTY CountValue -> std::int64;
      CREATE PROPERTY Formula -> std::str;
  };
  CREATE TYPE default::IfcQuantityWeight EXTENDING default::IfcPhysicalSimpleQuantity {
      CREATE PROPERTY Formula -> std::str;
      CREATE REQUIRED PROPERTY WeightValue -> std::float64;
  };
  CREATE TYPE default::IfcQuantityVolume EXTENDING default::IfcPhysicalSimpleQuantity {
      CREATE PROPERTY Formula -> std::str;
      CREATE REQUIRED PROPERTY VolumeValue -> std::float64;
  };
  CREATE TYPE default::IfcQuantityArea EXTENDING default::IfcPhysicalSimpleQuantity {
      CREATE REQUIRED PROPERTY AreaValue -> std::float64;
      CREATE PROPERTY Formula -> std::str;
  };
  CREATE TYPE default::IfcQuantityTime EXTENDING default::IfcPhysicalSimpleQuantity {
      CREATE PROPERTY Formula -> std::str;
      CREATE REQUIRED PROPERTY TimeValue -> std::float64;
  };
  CREATE TYPE default::IfcReferent EXTENDING default::IfcPositioningElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('KILOPOINT', 'MILEPOINT', 'NOTDEFINED', 'STATION', 'USERDEFINED');
      };
      CREATE PROPERTY RestartDistance -> std::float64;
  };
  CREATE TYPE default::IfcProcedure EXTENDING default::IfcProcess {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ADVICE_CAUTION', 'ADVICE_NOTE', 'ADVICE_WARNING', 'CALIBRATION', 'DIAGNOSTIC', 'NOTDEFINED', 'SHUTDOWN', 'STARTUP', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcTaskTime EXTENDING default::IfcSchedulingTime {
      CREATE PROPERTY ActualDuration -> std::str;
      CREATE PROPERTY ActualFinish -> std::str;
      CREATE PROPERTY ActualStart -> std::str;
      CREATE PROPERTY Completion -> std::float64;
      CREATE PROPERTY DurationType -> std::str {
          CREATE CONSTRAINT std::one_of('ELAPSEDTIME', 'NOTDEFINED', 'WORKTIME');
      };
      CREATE PROPERTY EarlyFinish -> std::str;
      CREATE PROPERTY EarlyStart -> std::str;
      CREATE PROPERTY FreeFloat -> std::str;
      CREATE PROPERTY IsCritical -> std::bool;
      CREATE PROPERTY LateFinish -> std::str;
      CREATE PROPERTY LateStart -> std::str;
      CREATE PROPERTY RemainingTime -> std::str;
      CREATE PROPERTY ScheduleDuration -> std::str;
      CREATE PROPERTY ScheduleFinish -> std::str;
      CREATE PROPERTY ScheduleStart -> std::str;
      CREATE PROPERTY StatusTime -> std::str;
      CREATE PROPERTY TotalFloat -> std::str;
  };
  CREATE TYPE default::IfcTask EXTENDING default::IfcProcess {
      CREATE LINK TaskTime -> default::IfcTaskTime;
      CREATE REQUIRED PROPERTY IsMilestone -> std::bool;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ATTENDANCE', 'CONSTRUCTION', 'DEMOLITION', 'DISMANTLE', 'DISPOSAL', 'INSTALLATION', 'LOGISTIC', 'MAINTENANCE', 'MOVE', 'NOTDEFINED', 'OPERATION', 'REMOVAL', 'RENOVATION', 'USERDEFINED');
      };
      CREATE PROPERTY Priority -> std::int64;
      CREATE PROPERTY Status -> std::str;
      CREATE PROPERTY WorkMethod -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcStructuralActivity EXTENDING default::IfcProduct {
      CREATE REQUIRED LINK AppliedLoad -> default::IfcStructuralLoad;
      CREATE REQUIRED PROPERTY GlobalOrLocal -> std::str {
          CREATE CONSTRAINT std::one_of('GLOBAL_COORDS', 'LOCAL_COORDS');
      };
  };
  CREATE ABSTRACT TYPE default::IfcStructuralAction EXTENDING default::IfcStructuralActivity {
      CREATE PROPERTY DestabilizingLoad -> std::bool;
  };
  CREATE TYPE default::IfcStructuralCurveAction EXTENDING default::IfcStructuralAction {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONST', 'DISCRETE', 'EQUIDISTANT', 'LINEAR', 'NOTDEFINED', 'PARABOLA', 'POLYGONAL', 'SINUS', 'USERDEFINED');
      };
      CREATE PROPERTY ProjectedOrTrue -> std::str {
          CREATE CONSTRAINT std::one_of('PROJECTED_LENGTH', 'TRUE_LENGTH');
      };
  };
  CREATE TYPE default::IfcStructuralLinearAction EXTENDING default::IfcStructuralCurveAction;
  CREATE ABSTRACT TYPE default::IfcStructuralReaction EXTENDING default::IfcStructuralActivity;
  CREATE TYPE default::IfcStructuralSurfaceReaction EXTENDING default::IfcStructuralReaction {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BILINEAR', 'CONST', 'DISCRETE', 'ISOCONTOUR', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcStructuralSurfaceAction EXTENDING default::IfcStructuralAction {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BILINEAR', 'CONST', 'DISCRETE', 'ISOCONTOUR', 'NOTDEFINED', 'USERDEFINED');
      };
      CREATE PROPERTY ProjectedOrTrue -> std::str {
          CREATE CONSTRAINT std::one_of('PROJECTED_LENGTH', 'TRUE_LENGTH');
      };
  };
  CREATE TYPE default::IfcProxy EXTENDING default::IfcProduct {
      CREATE REQUIRED PROPERTY ProxyType -> std::str {
          CREATE CONSTRAINT std::one_of('ACTOR', 'CONTROL', 'GROUP', 'NOTDEFINED', 'PROCESS', 'PRODUCT', 'PROJECT', 'RESOURCE');
      };
      CREATE PROPERTY Tag -> std::str;
  };
  CREATE TYPE default::IfcStructuralPointReaction EXTENDING default::IfcStructuralReaction;
  CREATE TYPE default::IfcStructuralPointAction EXTENDING default::IfcStructuralAction;
  CREATE TYPE default::IfcStructuralCurveReaction EXTENDING default::IfcStructuralReaction {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONST', 'DISCRETE', 'EQUIDISTANT', 'LINEAR', 'NOTDEFINED', 'PARABOLA', 'POLYGONAL', 'SINUS', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcStructuralSurfaceMember EXTENDING default::IfcStructuralMember {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BENDING_ELEMENT', 'MEMBRANE_ELEMENT', 'NOTDEFINED', 'SHELL', 'USERDEFINED');
      };
      CREATE PROPERTY Thickness -> std::float64;
  };
  CREATE TYPE default::IfcSpatialZone EXTENDING default::IfcSpatialElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONSTRUCTION', 'FIRESAFETY', 'LIGHTING', 'NOTDEFINED', 'OCCUPANCY', 'SECURITY', 'THERMAL', 'TRANSPORT', 'USERDEFINED', 'VENTILATION');
      };
  };
  CREATE TYPE default::IfcStructuralSurfaceMemberVarying EXTENDING default::IfcStructuralSurfaceMember;
  CREATE TYPE default::IfcSite EXTENDING default::IfcSpatialStructureElement {
      CREATE LINK SiteAddress -> default::IfcPostalAddress;
      CREATE PROPERTY LandTitleNumber -> std::str;
      CREATE PROPERTY RefElevation -> std::float64;
      CREATE PROPERTY RefLatitude -> std::int64;
      CREATE PROPERTY RefLongitude -> std::int64;
  };
  CREATE TYPE default::IfcStructuralPlanarAction EXTENDING default::IfcStructuralSurfaceAction;
  CREATE ABSTRACT TYPE default::IfcRelDefines EXTENDING default::IfcRelationship;
  CREATE TYPE default::IfcRelDefinesByObject EXTENDING default::IfcRelDefines {
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcObject;
      CREATE REQUIRED LINK RelatingObject -> default::IfcObject;
  };
  CREATE TYPE default::IfcRelDefinesByType EXTENDING default::IfcRelDefines {
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcObject;
      CREATE REQUIRED LINK RelatingType -> default::IfcTypeObject;
  };
  CREATE TYPE default::IfcProcedureType EXTENDING default::IfcTypeProcess {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ADVICE_CAUTION', 'ADVICE_NOTE', 'ADVICE_WARNING', 'CALIBRATION', 'DIAGNOSTIC', 'NOTDEFINED', 'SHUTDOWN', 'STARTUP', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcSpatialElementType EXTENDING default::IfcTypeProduct {
      CREATE PROPERTY ElementType -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcSpatialStructureElementType EXTENDING default::IfcSpatialElementType;
  CREATE TYPE default::IfcSpaceType EXTENDING default::IfcSpatialStructureElementType {
      CREATE PROPERTY LongName -> std::str;
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('EXTERNAL', 'GFA', 'INTERNAL', 'NOTDEFINED', 'PARKING', 'SPACE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSpatialZoneType EXTENDING default::IfcSpatialElementType {
      CREATE PROPERTY LongName -> std::str;
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONSTRUCTION', 'FIRESAFETY', 'LIGHTING', 'NOTDEFINED', 'OCCUPANCY', 'SECURITY', 'THERMAL', 'TRANSPORT', 'USERDEFINED', 'VENTILATION');
      };
  };
  CREATE TYPE default::IfcTaskType EXTENDING default::IfcTypeProcess {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ATTENDANCE', 'CONSTRUCTION', 'DEMOLITION', 'DISMANTLE', 'DISPOSAL', 'INSTALLATION', 'LOGISTIC', 'MAINTENANCE', 'MOVE', 'NOTDEFINED', 'OPERATION', 'REMOVAL', 'RENOVATION', 'USERDEFINED');
      };
      CREATE PROPERTY WorkMethod -> std::str;
  };
  CREATE TYPE default::IfcWindowStyle EXTENDING default::IfcTypeProduct {
      CREATE REQUIRED PROPERTY ConstructionType -> std::str {
          CREATE CONSTRAINT std::one_of('ALUMINIUM', 'ALUMINIUM_WOOD', 'HIGH_GRADE_STEEL', 'NOTDEFINED', 'OTHER_CONSTRUCTION', 'PLASTIC', 'STEEL', 'WOOD');
      };
      CREATE REQUIRED PROPERTY OperationType -> std::str {
          CREATE CONSTRAINT std::one_of('DOUBLE_PANEL_HORIZONTAL', 'DOUBLE_PANEL_VERTICAL', 'NOTDEFINED', 'SINGLE_PANEL', 'TRIPLE_PANEL_BOTTOM', 'TRIPLE_PANEL_HORIZONTAL', 'TRIPLE_PANEL_LEFT', 'TRIPLE_PANEL_RIGHT', 'TRIPLE_PANEL_TOP', 'TRIPLE_PANEL_VERTICAL', 'USERDEFINED');
      };
      CREATE REQUIRED PROPERTY ParameterTakesPrecedence -> std::bool;
      CREATE REQUIRED PROPERTY Sizeable -> std::bool;
  };
  CREATE TYPE default::IfcRelAggregates EXTENDING default::IfcRelDecomposes {
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcObjectDefinition;
      CREATE REQUIRED LINK RelatingObject -> default::IfcObjectDefinition;
  };
  CREATE TYPE default::IfcRelAssignsToProduct EXTENDING default::IfcRelAssigns {
      CREATE REQUIRED LINK RelatingProduct -> default::IfcProductSelect;
  };
  CREATE TYPE default::IfcRelAssignsToResource EXTENDING default::IfcRelAssigns {
      CREATE REQUIRED LINK RelatingResource -> default::IfcResourceSelect;
  };
  CREATE TYPE default::IfcRelDefinesByProperties EXTENDING default::IfcRelDefines {
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcObjectDefinition;
      CREATE REQUIRED LINK RelatingPropertyDefinition -> default::IfcPropertySetDefinitionSelect;
  };
  CREATE TYPE default::IfcRelNests EXTENDING default::IfcRelDecomposes {
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcObjectDefinition;
      CREATE REQUIRED LINK RelatingObject -> default::IfcObjectDefinition;
  };
  CREATE ABSTRACT TYPE default::IfcSimpleProperty EXTENDING default::IfcProperty;
  CREATE TYPE default::IfcPropertyReferenceValue EXTENDING default::IfcSimpleProperty {
      CREATE LINK PropertyReference -> default::IfcObjectReferenceSelect;
      CREATE PROPERTY UsageName -> std::str;
  };
  CREATE TYPE default::IfcOrganizationRelationship EXTENDING default::IfcResourceLevelRelationship {
      CREATE REQUIRED MULTI LINK RelatedOrganizations -> default::IfcOrganization;
      CREATE REQUIRED LINK RelatingOrganization -> default::IfcOrganization;
  };
  CREATE TYPE default::IfcPath EXTENDING default::IfcTopologicalRepresentationItem {
      CREATE REQUIRED MULTI LINK EdgeList -> default::IfcOrientedEdge;
  };
  CREATE TYPE default::IfcPermeableCoveringProperties EXTENDING default::IfcPreDefinedPropertySet {
      CREATE LINK ShapeAspectStyle -> default::IfcShapeAspect;
      CREATE PROPERTY FrameDepth -> std::float64;
      CREATE PROPERTY FrameThickness -> std::float64;
      CREATE REQUIRED PROPERTY OperationType -> std::str {
          CREATE CONSTRAINT std::one_of('GRILL', 'LOUVER', 'NOTDEFINED', 'SCREEN', 'USERDEFINED');
      };
      CREATE REQUIRED PROPERTY PanelPosition -> std::str {
          CREATE CONSTRAINT std::one_of('BOTTOM', 'LEFT', 'MIDDLE', 'NOTDEFINED', 'RIGHT', 'TOP');
      };
  };
  CREATE TYPE default::IfcWindowPanelProperties EXTENDING default::IfcPreDefinedPropertySet {
      CREATE LINK ShapeAspectStyle -> default::IfcShapeAspect;
      CREATE PROPERTY FrameDepth -> std::float64;
      CREATE PROPERTY FrameThickness -> std::float64;
      CREATE REQUIRED PROPERTY OperationType -> std::str {
          CREATE CONSTRAINT std::one_of('BOTTOMHUNG', 'FIXEDCASEMENT', 'NOTDEFINED', 'OTHEROPERATION', 'PIVOTHORIZONTAL', 'PIVOTVERTICAL', 'REMOVABLECASEMENT', 'SIDEHUNGLEFTHAND', 'SIDEHUNGRIGHTHAND', 'SLIDINGHORIZONTAL', 'SLIDINGVERTICAL', 'TILTANDTURNLEFTHAND', 'TILTANDTURNRIGHTHAND', 'TOPHUNG');
      };
      CREATE REQUIRED PROPERTY PanelPosition -> std::str {
          CREATE CONSTRAINT std::one_of('BOTTOM', 'LEFT', 'MIDDLE', 'NOTDEFINED', 'RIGHT', 'TOP');
      };
  };
  CREATE ABSTRACT TYPE default::IfcPreDefinedProperties EXTENDING default::IfcPropertyAbstraction;
  CREATE TYPE default::IfcReinforcementBarProperties EXTENDING default::IfcPreDefinedProperties {
      CREATE PROPERTY BarCount -> std::int64;
      CREATE PROPERTY BarSurface -> std::str {
          CREATE CONSTRAINT std::one_of('PLAIN', 'TEXTURED');
      };
      CREATE PROPERTY EffectiveDepth -> std::float64;
      CREATE PROPERTY NominalBarDiameter -> std::float64;
      CREATE REQUIRED PROPERTY SteelGrade -> std::str;
      CREATE REQUIRED PROPERTY TotalCrossSectionArea -> std::float64;
  };
  CREATE TYPE default::IfcSectionProperties EXTENDING default::IfcPreDefinedProperties {
      CREATE LINK EndProfile -> default::IfcProfileDef;
      CREATE REQUIRED LINK StartProfile -> default::IfcProfileDef;
      CREATE REQUIRED PROPERTY SectionType -> std::str {
          CREATE CONSTRAINT std::one_of('TAPERED', 'UNIFORM');
      };
  };
  CREATE TYPE default::IfcSectionReinforcementProperties EXTENDING default::IfcPreDefinedProperties {
      CREATE REQUIRED MULTI LINK CrossSectionReinforcementDefinitions -> default::IfcReinforcementBarProperties;
      CREATE REQUIRED LINK SectionDefinition -> default::IfcSectionProperties;
      CREATE REQUIRED PROPERTY LongitudinalEndPosition -> std::float64;
      CREATE REQUIRED PROPERTY LongitudinalStartPosition -> std::float64;
      CREATE REQUIRED PROPERTY ReinforcementRole -> std::str {
          CREATE CONSTRAINT std::one_of('ANCHORING', 'EDGE', 'LIGATURE', 'MAIN', 'NOTDEFINED', 'PUNCHING', 'RING', 'SHEAR', 'STUD', 'USERDEFINED');
      };
      CREATE PROPERTY TransversePosition -> std::float64;
  };
  CREATE TYPE default::IfcReinforcementDefinitionProperties EXTENDING default::IfcPreDefinedPropertySet {
      CREATE REQUIRED MULTI LINK ReinforcementSectionDefinitions -> default::IfcSectionReinforcementProperties;
      CREATE PROPERTY DefinitionType -> std::str;
  };
  CREATE TYPE default::IfcWindowLiningProperties EXTENDING default::IfcPreDefinedPropertySet {
      CREATE LINK ShapeAspectStyle -> default::IfcShapeAspect;
      CREATE PROPERTY FirstMullionOffset -> std::float64;
      CREATE PROPERTY FirstTransomOffset -> std::float64;
      CREATE PROPERTY LiningDepth -> std::float64;
      CREATE PROPERTY LiningOffset -> std::float64;
      CREATE PROPERTY LiningThickness -> std::float64;
      CREATE PROPERTY LiningToPanelOffsetX -> std::float64;
      CREATE PROPERTY LiningToPanelOffsetY -> std::float64;
      CREATE PROPERTY MullionThickness -> std::float64;
      CREATE PROPERTY SecondMullionOffset -> std::float64;
      CREATE PROPERTY SecondTransomOffset -> std::float64;
      CREATE PROPERTY TransomThickness -> std::float64;
  };
  CREATE TYPE default::IfcPropertySet EXTENDING default::IfcPropertySetDefinition {
      CREATE REQUIRED MULTI LINK HasProperties -> default::IfcProperty;
  };
  CREATE TYPE default::IfcPropertyEnumeration EXTENDING default::IfcPropertyAbstraction {
      CREATE REQUIRED MULTI LINK EnumerationValues -> default::IfcValue;
      CREATE LINK Unit -> default::IfcUnit;
      CREATE REQUIRED PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcSimplePropertyTemplate EXTENDING default::IfcPropertyTemplate {
      CREATE LINK Enumerators -> default::IfcPropertyEnumeration;
      CREATE LINK PrimaryUnit -> default::IfcUnit;
      CREATE LINK SecondaryUnit -> default::IfcUnit;
      CREATE PROPERTY AccessState -> std::str {
          CREATE CONSTRAINT std::one_of('LOCKED', 'READONLY', 'READONLYLOCKED', 'READWRITE', 'READWRITELOCKED');
      };
      CREATE PROPERTY Expression -> std::str;
      CREATE PROPERTY PrimaryMeasureType -> std::str;
      CREATE PROPERTY SecondaryMeasureType -> std::str;
      CREATE PROPERTY TemplateType -> std::str {
          CREATE CONSTRAINT std::one_of('P_BOUNDEDVALUE', 'P_ENUMERATEDVALUE', 'P_LISTVALUE', 'P_REFERENCEVALUE', 'P_SINGLEVALUE', 'P_TABLEVALUE', 'Q_AREA', 'Q_COUNT', 'Q_LENGTH', 'Q_TIME', 'Q_VOLUME', 'Q_WEIGHT');
      };
  };
  CREATE TYPE default::IfcPropertySetTemplate EXTENDING default::IfcPropertyTemplateDefinition {
      CREATE REQUIRED MULTI LINK HasPropertyTemplates -> default::IfcPropertyTemplate;
      CREATE PROPERTY ApplicableEntity -> std::str;
      CREATE PROPERTY TemplateType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'PSET_OCCURRENCEDRIVEN', 'PSET_PERFORMANCEDRIVEN', 'PSET_TYPEDRIVENONLY', 'PSET_TYPEDRIVENOVERRIDE', 'QTO_OCCURRENCEDRIVEN', 'QTO_TYPEDRIVENONLY', 'QTO_TYPEDRIVENOVERRIDE');
      };
  };
  CREATE TYPE default::IfcRelServicesBuildings EXTENDING default::IfcRelConnects {
      CREATE REQUIRED MULTI LINK RelatedBuildings -> default::IfcSpatialElement;
      CREATE REQUIRED LINK RelatingSystem -> default::IfcSystem;
  };
  CREATE TYPE default::IfcRelContainedInSpatialStructure EXTENDING default::IfcRelConnects {
      CREATE REQUIRED MULTI LINK RelatedElements -> default::IfcProduct;
      CREATE REQUIRED LINK RelatingStructure -> default::IfcSpatialElement;
  };
  CREATE TYPE default::IfcRelConnectsStructuralActivity EXTENDING default::IfcRelConnects {
      CREATE REQUIRED LINK RelatedStructuralActivity -> default::IfcStructuralActivity;
      CREATE REQUIRED LINK RelatingElement -> default::IfcStructuralActivityAssignmentSelect;
  };
  CREATE TYPE default::IfcRelReferencedInSpatialStructure EXTENDING default::IfcRelConnects {
      CREATE REQUIRED MULTI LINK RelatedElements -> default::IfcProduct;
      CREATE REQUIRED LINK RelatingStructure -> default::IfcSpatialElement;
  };
  CREATE TYPE default::IfcRelDefinesByTemplate EXTENDING default::IfcRelDefines {
      CREATE REQUIRED MULTI LINK RelatedPropertySets -> default::IfcPropertySetDefinition;
      CREATE REQUIRED LINK RelatingTemplate -> default::IfcPropertySetTemplate;
  };
  CREATE TYPE default::IfcPhysicalComplexQuantity EXTENDING default::IfcPhysicalQuantity {
      CREATE REQUIRED MULTI LINK HasQuantities -> default::IfcPhysicalQuantity;
      CREATE REQUIRED PROPERTY Discrimination -> std::str;
      CREATE PROPERTY Quality -> std::str;
      CREATE PROPERTY Usage -> std::str;
  };
  CREATE TYPE default::IfcTextStyleFontModel EXTENDING default::IfcPreDefinedTextFont {
      CREATE REQUIRED LINK FontSize -> default::IfcSizeSelect;
      CREATE REQUIRED PROPERTY FontFamily -> tuple<std::str>;
      CREATE PROPERTY FontStyle -> std::str;
      CREATE PROPERTY FontVariant -> std::str;
      CREATE PROPERTY FontWeight -> std::str;
  };
  CREATE TYPE default::IfcPresentableText {
      CREATE REQUIRED PROPERTY IfcPresentableText -> std::str;
  };
  CREATE TYPE default::IfcTextureCoordinateGenerator EXTENDING default::IfcTextureCoordinate {
      CREATE REQUIRED PROPERTY Mode -> std::str;
      CREATE PROPERTY Parameter -> tuple<std::float64>;
  };
  CREATE TYPE default::IfcPropertyBoundedValue EXTENDING default::IfcSimpleProperty {
      CREATE LINK LowerBoundValue -> default::IfcValue;
      CREATE LINK SetPointValue -> default::IfcValue;
      CREATE LINK Unit -> default::IfcUnit;
      CREATE LINK UpperBoundValue -> default::IfcValue;
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
  CREATE TYPE default::IfcPropertyDependencyRelationship EXTENDING default::IfcResourceLevelRelationship {
      CREATE REQUIRED LINK DependantProperty -> default::IfcProperty;
      CREATE REQUIRED LINK DependingProperty -> default::IfcProperty;
      CREATE PROPERTY Expression -> std::str;
  };
  CREATE TYPE default::IfcTaskTimeRecurring EXTENDING default::IfcTaskTime {
      CREATE REQUIRED LINK Recurrence -> default::IfcRecurrencePattern;
  };
  CREATE TYPE default::IfcTimeSeriesValue {
      CREATE REQUIRED MULTI LINK ListValues -> default::IfcValue;
  };
  CREATE TYPE default::IfcRegularTimeSeries EXTENDING default::IfcTimeSeries {
      CREATE REQUIRED MULTI LINK Values -> default::IfcTimeSeriesValue;
      CREATE REQUIRED PROPERTY TimeStep -> std::float64;
  };
  CREATE TYPE default::IfcTopologyRepresentation EXTENDING default::IfcShapeModel;
  CREATE TYPE default::IfcShapeRepresentation EXTENDING default::IfcShapeModel;
  CREATE ABSTRACT TYPE default::IfcStyleModel EXTENDING default::IfcRepresentation;
  CREATE TYPE default::IfcStyledRepresentation EXTENDING default::IfcStyleModel;
  CREATE TYPE default::IfcSlippageConnectionCondition EXTENDING default::IfcStructuralConnectionCondition {
      CREATE PROPERTY SlippageX -> std::float64;
      CREATE PROPERTY SlippageY -> std::float64;
      CREATE PROPERTY SlippageZ -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcStructuralLoadStatic EXTENDING default::IfcStructuralLoadOrResult;
  CREATE TYPE default::IfcStructuralLoadLinearForce EXTENDING default::IfcStructuralLoadStatic {
      CREATE PROPERTY LinearForceX -> std::float64;
      CREATE PROPERTY LinearForceY -> std::float64;
      CREATE PROPERTY LinearForceZ -> std::float64;
      CREATE PROPERTY LinearMomentX -> std::float64;
      CREATE PROPERTY LinearMomentY -> std::float64;
      CREATE PROPERTY LinearMomentZ -> std::float64;
  };
  CREATE TYPE default::IfcStructuralLoadSingleDisplacement EXTENDING default::IfcStructuralLoadStatic {
      CREATE PROPERTY DisplacementX -> std::float64;
      CREATE PROPERTY DisplacementY -> std::float64;
      CREATE PROPERTY DisplacementZ -> std::float64;
      CREATE PROPERTY RotationalDisplacementRX -> std::float64;
      CREATE PROPERTY RotationalDisplacementRY -> std::float64;
      CREATE PROPERTY RotationalDisplacementRZ -> std::float64;
  };
  CREATE TYPE default::IfcStructuralLoadSingleDisplacementDistortion EXTENDING default::IfcStructuralLoadSingleDisplacement {
      CREATE PROPERTY Distortion -> std::float64;
  };
  CREATE TYPE default::IfcStructuralLoadSingleForce EXTENDING default::IfcStructuralLoadStatic {
      CREATE PROPERTY ForceX -> std::float64;
      CREATE PROPERTY ForceY -> std::float64;
      CREATE PROPERTY ForceZ -> std::float64;
      CREATE PROPERTY MomentX -> std::float64;
      CREATE PROPERTY MomentY -> std::float64;
      CREATE PROPERTY MomentZ -> std::float64;
  };
  CREATE TYPE default::IfcStructuralLoadTemperature EXTENDING default::IfcStructuralLoadStatic {
      CREATE PROPERTY DeltaTConstant -> std::float64;
      CREATE PROPERTY DeltaTY -> std::float64;
      CREATE PROPERTY DeltaTZ -> std::float64;
  };
  CREATE TYPE default::IfcStructuralLoadPlanarForce EXTENDING default::IfcStructuralLoadStatic {
      CREATE PROPERTY PlanarForceX -> std::float64;
      CREATE PROPERTY PlanarForceY -> std::float64;
      CREATE PROPERTY PlanarForceZ -> std::float64;
  };
  CREATE TYPE default::IfcStructuralLoadSingleForceWarping EXTENDING default::IfcStructuralLoadSingleForce {
      CREATE PROPERTY WarpingMoment -> std::float64;
  };
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

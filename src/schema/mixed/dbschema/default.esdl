module default {

    type IfcAbsorbedDoseMeasure {
        required property `IfcAbsorbedDoseMeasure` -> float64;
    }

    type IfcAccelerationMeasure {
        required property `IfcAccelerationMeasure` -> float64;
    }

    type IfcAddressTypeEnum {
        required property `IfcAddressTypeEnum` -> str {
            constraint one_of ('DISTRIBUTIONPOINT','HOME','OFFICE','SITE','USERDEFINED');
        };
    }

    type IfcAmountOfSubstanceMeasure {
        required property `IfcAmountOfSubstanceMeasure` -> float64;
    }

    type IfcAngularVelocityMeasure {
        required property `IfcAngularVelocityMeasure` -> float64;
    }

    type IfcAreaDensityMeasure {
        required property `IfcAreaDensityMeasure` -> float64;
    }

    type IfcAreaMeasure {
        required property `IfcAreaMeasure` -> float64;
    }

    type IfcAssemblyPlaceEnum {
        required property `IfcAssemblyPlaceEnum` -> str {
            constraint one_of ('FACTORY','NOTDEFINED','SITE');
        };
    }

    type IfcBSplineSurfaceForm {
        required property `IfcBSplineSurfaceForm` -> str {
            constraint one_of ('CONICAL_SURF','CYLINDRICAL_SURF','GENERALISED_CONE','PLANE_SURF','QUADRIC_SURF','RULED_SURF','SPHERICAL_SURF','SURF_OF_LINEAR_EXTRUSION','SURF_OF_REVOLUTION','TOROIDAL_SURF','UNSPECIFIED');
        };
    }

    type IfcBeamTypeEnum {
        required property `IfcBeamTypeEnum` -> str {
            constraint one_of ('BEAM','HOLLOWCORE','JOIST','LINTEL','NOTDEFINED','SPANDREL','T_BEAM','USERDEFINED');
        };
    }

    type IfcBinary {
        required property `IfcBinary` -> bytes;
    }

    type IfcBoolean {
        required property `IfcBoolean` -> bool;
    }

    type IfcBuildingElementProxyTypeEnum {
        required property `IfcBuildingElementProxyTypeEnum` -> str {
            constraint one_of ('COMPLEX','ELEMENT','NOTDEFINED','PARTIAL','PROVISIONFORSPACE','PROVISIONFORVOID','USERDEFINED');
        };
    }

    type IfcChangeActionEnum {
        required property `IfcChangeActionEnum` -> str {
            constraint one_of ('ADDED','DELETED','MODIFIED','NOCHANGE','NOTDEFINED');
        };
    }

    type IfcColumnTypeEnum {
        required property `IfcColumnTypeEnum` -> str {
            constraint one_of ('COLUMN','NOTDEFINED','PILASTER','USERDEFINED');
        };
    }

    type IfcComplexNumber {
        required property `IfcComplexNumber` -> array<float64>{
            constraint expression on (len(__subject__) = 1 or len(__subject__) = 2)
        };
    }

    type IfcCompoundPlaneAngleMeasure {
        required property `IfcCompoundPlaneAngleMeasure` -> array<int64>{
            constraint expression on (len(__subject__) = 3 or len(__subject__) = 4)
        };
    }

    type IfcContextDependentMeasure {
        required property `IfcContextDependentMeasure` -> float64;
    }

    type IfcCountMeasure {
        required property `IfcCountMeasure` -> int64;
    }

    type IfcCoveringTypeEnum {
        required property `IfcCoveringTypeEnum` -> str {
            constraint one_of ('CEILING','CLADDING','FLOORING','INSULATION','MEMBRANE','MOLDING','NOTDEFINED','ROOFING','SKIRTINGBOARD','SLEEVING','USERDEFINED','WRAPPING');
        };
    }

    type IfcCurvatureMeasure {
        required property `IfcCurvatureMeasure` -> float64;
    }

    type IfcDate {
        required property `IfcDate` -> str;
    }

    type IfcDateTime {
        required property `IfcDateTime` -> str;
    }

    type IfcDerivedUnitEnum {
        required property `IfcDerivedUnitEnum` -> str {
            constraint one_of ('ACCELERATIONUNIT','ANGULARVELOCITYUNIT','AREADENSITYUNIT','COMPOUNDPLANEANGLEUNIT','CURVATUREUNIT','DYNAMICVISCOSITYUNIT','HEATFLUXDENSITYUNIT','HEATINGVALUEUNIT','INTEGERCOUNTRATEUNIT','IONCONCENTRATIONUNIT','ISOTHERMALMOISTURECAPACITYUNIT','KINEMATICVISCOSITYUNIT','LINEARFORCEUNIT','LINEARMOMENTUNIT','LINEARSTIFFNESSUNIT','LINEARVELOCITYUNIT','LUMINOUSINTENSITYDISTRIBUTIONUNIT','MASSDENSITYUNIT','MASSFLOWRATEUNIT','MASSPERLENGTHUNIT','MODULUSOFELASTICITYUNIT','MODULUSOFLINEARSUBGRADEREACTIONUNIT','MODULUSOFROTATIONALSUBGRADEREACTIONUNIT','MODULUSOFSUBGRADEREACTIONUNIT','MOISTUREDIFFUSIVITYUNIT','MOLECULARWEIGHTUNIT','MOMENTOFINERTIAUNIT','PHUNIT','PLANARFORCEUNIT','ROTATIONALFREQUENCYUNIT','ROTATIONALMASSUNIT','ROTATIONALSTIFFNESSUNIT','SECTIONAREAINTEGRALUNIT','SECTIONMODULUSUNIT','SHEARMODULUSUNIT','SOUNDPOWERLEVELUNIT','SOUNDPOWERUNIT','SOUNDPRESSURELEVELUNIT','SOUNDPRESSUREUNIT','SPECIFICHEATCAPACITYUNIT','TEMPERATUREGRADIENTUNIT','TEMPERATURERATEOFCHANGEUNIT','THERMALADMITTANCEUNIT','THERMALCONDUCTANCEUNIT','THERMALEXPANSIONCOEFFICIENTUNIT','THERMALRESISTANCEUNIT','THERMALTRANSMITTANCEUNIT','TORQUEUNIT','USERDEFINED','VAPORPERMEABILITYUNIT','VOLUMETRICFLOWRATEUNIT','WARPINGCONSTANTUNIT','WARPINGMOMENTUNIT');
        };
    }

    type IfcDescriptiveMeasure {
        required property `IfcDescriptiveMeasure` -> str;
    }

    type IfcDimensionalExponents {
        required property LengthExponent -> int64;
        required property MassExponent -> int64;
        required property TimeExponent -> int64;
        required property ElectricCurrentExponent -> int64;
        required property ThermodynamicTemperatureExponent -> int64;
        required property AmountOfSubstanceExponent -> int64;
        required property LuminousIntensityExponent -> int64;
    }

    type IfcDoorTypeEnum {
        required property `IfcDoorTypeEnum` -> str {
            constraint one_of ('DOOR','GATE','NOTDEFINED','TRAPDOOR','USERDEFINED');
        };
    }

    type IfcDoorTypeOperationEnum {
        required property `IfcDoorTypeOperationEnum` -> str {
            constraint one_of ('DOUBLE_DOOR_DOUBLE_SWING','DOUBLE_DOOR_FOLDING','DOUBLE_DOOR_SINGLE_SWING','DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_LEFT','DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_RIGHT','DOUBLE_DOOR_SLIDING','DOUBLE_SWING_LEFT','DOUBLE_SWING_RIGHT','FOLDING_TO_LEFT','FOLDING_TO_RIGHT','NOTDEFINED','REVOLVING','ROLLINGUP','SINGLE_SWING_LEFT','SINGLE_SWING_RIGHT','SLIDING_TO_LEFT','SLIDING_TO_RIGHT','SWING_FIXED_LEFT','SWING_FIXED_RIGHT','USERDEFINED');
        };
    }

    type IfcDoseEquivalentMeasure {
        required property `IfcDoseEquivalentMeasure` -> float64;
    }

    type IfcDuration {
        required property `IfcDuration` -> str;
    }

    type IfcDynamicViscosityMeasure {
        required property `IfcDynamicViscosityMeasure` -> float64;
    }

    type IfcElectricCapacitanceMeasure {
        required property `IfcElectricCapacitanceMeasure` -> float64;
    }

    type IfcElectricChargeMeasure {
        required property `IfcElectricChargeMeasure` -> float64;
    }

    type IfcElectricConductanceMeasure {
        required property `IfcElectricConductanceMeasure` -> float64;
    }

    type IfcElectricCurrentMeasure {
        required property `IfcElectricCurrentMeasure` -> float64;
    }

    type IfcElectricResistanceMeasure {
        required property `IfcElectricResistanceMeasure` -> float64;
    }

    type IfcElectricVoltageMeasure {
        required property `IfcElectricVoltageMeasure` -> float64;
    }

    type IfcElementCompositionEnum {
        required property `IfcElementCompositionEnum` -> str {
            constraint one_of ('COMPLEX','ELEMENT','PARTIAL');
        };
    }

    type IfcEnergyMeasure {
        required property `IfcEnergyMeasure` -> float64;
    }

    abstract type IfcExternalReference {
        property Location -> str;
        property Identification -> str;
        property Name -> str;
    }

    type IfcForceMeasure {
        required property `IfcForceMeasure` -> float64;
    }

    type IfcFrequencyMeasure {
        required property `IfcFrequencyMeasure` -> float64;
    }

    type IfcFurnitureTypeEnum {
        required property `IfcFurnitureTypeEnum` -> str {
            constraint one_of ('BED','CHAIR','DESK','FILECABINET','NOTDEFINED','SHELF','SOFA','TABLE','USERDEFINED');
        };
    }

    type IfcGeometricProjectionEnum {
        required property `IfcGeometricProjectionEnum` -> str {
            constraint one_of ('ELEVATION_VIEW','GRAPH_VIEW','MODEL_VIEW','NOTDEFINED','PLAN_VIEW','REFLECTED_PLAN_VIEW','SECTION_VIEW','SKETCH_VIEW','USERDEFINED');
        };
    }

    type IfcHeatFluxDensityMeasure {
        required property `IfcHeatFluxDensityMeasure` -> float64;
    }

    type IfcHeatingValueMeasure {
        required property `IfcHeatingValueMeasure` -> float64;
    }

    type IfcIdentifier {
        required property `IfcIdentifier` -> str;
    }

    type IfcIlluminanceMeasure {
        required property `IfcIlluminanceMeasure` -> float64;
    }

    type IfcInductanceMeasure {
        required property `IfcInductanceMeasure` -> float64;
    }

    type IfcInteger {
        required property `IfcInteger` -> int64;
    }

    type IfcIntegerCountRateMeasure {
        required property `IfcIntegerCountRateMeasure` -> int64;
    }

    type IfcIonConcentrationMeasure {
        required property `IfcIonConcentrationMeasure` -> float64;
    }

    type IfcIsothermalMoistureCapacityMeasure {
        required property `IfcIsothermalMoistureCapacityMeasure` -> float64;
    }

    type IfcKinematicViscosityMeasure {
        required property `IfcKinematicViscosityMeasure` -> float64;
    }

    type IfcKnotType {
        required property `IfcKnotType` -> str {
            constraint one_of ('PIECEWISE_BEZIER_KNOTS','QUASI_UNIFORM_KNOTS','UNIFORM_KNOTS','UNSPECIFIED');
        };
    }

    type IfcLabel {
        required property `IfcLabel` -> str;
    }

    type IfcLengthMeasure {
        required property `IfcLengthMeasure` -> float64;
    }

    type IfcLinearForceMeasure {
        required property `IfcLinearForceMeasure` -> float64;
    }

    type IfcLinearMomentMeasure {
        required property `IfcLinearMomentMeasure` -> float64;
    }

    type IfcLinearStiffnessMeasure {
        required property `IfcLinearStiffnessMeasure` -> float64;
    }

    type IfcLinearVelocityMeasure {
        required property `IfcLinearVelocityMeasure` -> float64;
    }

    type IfcLogical {
        required property `IfcLogical` -> bool;
    }

    type IfcLuminousFluxMeasure {
        required property `IfcLuminousFluxMeasure` -> float64;
    }

    type IfcLuminousIntensityDistributionMeasure {
        required property `IfcLuminousIntensityDistributionMeasure` -> float64;
    }

    type IfcLuminousIntensityMeasure {
        required property `IfcLuminousIntensityMeasure` -> float64;
    }

    type IfcMagneticFluxDensityMeasure {
        required property `IfcMagneticFluxDensityMeasure` -> float64;
    }

    type IfcMagneticFluxMeasure {
        required property `IfcMagneticFluxMeasure` -> float64;
    }

    type IfcMassDensityMeasure {
        required property `IfcMassDensityMeasure` -> float64;
    }

    type IfcMassFlowRateMeasure {
        required property `IfcMassFlowRateMeasure` -> float64;
    }

    type IfcMassMeasure {
        required property `IfcMassMeasure` -> float64;
    }

    type IfcMassPerLengthMeasure {
        required property `IfcMassPerLengthMeasure` -> float64;
    }

    abstract type IfcMaterialDefinition {
    }

    abstract type IfcMaterialUsageDefinition {
    }

    type IfcMemberTypeEnum {
        required property `IfcMemberTypeEnum` -> str {
            constraint one_of ('BRACE','CHORD','COLLAR','MEMBER','MULLION','NOTDEFINED','PLATE','POST','PURLIN','RAFTER','STRINGER','STRUT','STUD','USERDEFINED');
        };
    }

    type IfcModulusOfElasticityMeasure {
        required property `IfcModulusOfElasticityMeasure` -> float64;
    }

    type IfcModulusOfLinearSubgradeReactionMeasure {
        required property `IfcModulusOfLinearSubgradeReactionMeasure` -> float64;
    }

    type IfcModulusOfRotationalSubgradeReactionMeasure {
        required property `IfcModulusOfRotationalSubgradeReactionMeasure` -> float64;
    }

    type IfcModulusOfSubgradeReactionMeasure {
        required property `IfcModulusOfSubgradeReactionMeasure` -> float64;
    }

    type IfcMoistureDiffusivityMeasure {
        required property `IfcMoistureDiffusivityMeasure` -> float64;
    }

    type IfcMolecularWeightMeasure {
        required property `IfcMolecularWeightMeasure` -> float64;
    }

    type IfcMomentOfInertiaMeasure {
        required property `IfcMomentOfInertiaMeasure` -> float64;
    }

    type IfcMonetaryMeasure {
        required property `IfcMonetaryMeasure` -> float64;
    }

    type IfcMonetaryUnit {
        required property Currency -> str;
    }

    type IfcNonNegativeLengthMeasure {
        required property `IfcNonNegativeLengthMeasure` -> float64;
    }

    type IfcNormalisedRatioMeasure {
        required property `IfcNormalisedRatioMeasure` -> float64;
    }

    type IfcNullStyle {
        required property `IfcNullStyle` -> str {
            constraint one_of ('NULL');
        };
    }

    type IfcNumericMeasure {
        required property `IfcNumericMeasure` -> int64;
    }

    abstract type IfcObjectPlacement {
    }

    type IfcOpeningElementTypeEnum {
        required property `IfcOpeningElementTypeEnum` -> str {
            constraint one_of ('NOTDEFINED','OPENING','RECESS','USERDEFINED');
        };
    }

    type IfcPHMeasure {
        required property `IfcPHMeasure` -> float64;
    }

    type IfcParameterValue {
        required property `IfcParameterValue` -> float64;
    }

    type IfcPileTypeEnum {
        required property `IfcPileTypeEnum` -> str {
            constraint one_of ('BORED','COHESION','DRIVEN','FRICTION','JETGROUTING','NOTDEFINED','SUPPORT','USERDEFINED');
        };
    }

    type IfcPlanarForceMeasure {
        required property `IfcPlanarForceMeasure` -> float64;
    }

    type IfcPlaneAngleMeasure {
        required property `IfcPlaneAngleMeasure` -> float64;
    }

    type IfcPositiveInteger {
        required property `IfcPositiveInteger` -> int64;
    }

    type IfcPositiveLengthMeasure {
        required property `IfcPositiveLengthMeasure` -> float64;
    }

    type IfcPositivePlaneAngleMeasure {
        required property `IfcPositivePlaneAngleMeasure` -> float64;
    }

    type IfcPositiveRatioMeasure {
        required property `IfcPositiveRatioMeasure` -> float64;
    }

    type IfcPowerMeasure {
        required property `IfcPowerMeasure` -> float64;
    }

    abstract type IfcPresentationItem {
    }

    abstract type IfcPresentationStyle {
        property Name -> str;
    }

    type IfcPressureMeasure {
        required property `IfcPressureMeasure` -> float64;
    }

    type IfcProfileTypeEnum {
        required property `IfcProfileTypeEnum` -> str {
            constraint one_of ('AREA','CURVE');
        };
    }

    abstract type IfcPropertyAbstraction {
    }

    type IfcRadioActivityMeasure {
        required property `IfcRadioActivityMeasure` -> float64;
    }

    type IfcRampTypeEnum {
        required property `IfcRampTypeEnum` -> str {
            constraint one_of ('HALF_TURN_RAMP','NOTDEFINED','QUARTER_TURN_RAMP','SPIRAL_RAMP','STRAIGHT_RUN_RAMP','TWO_QUARTER_TURN_RAMP','TWO_STRAIGHT_RUN_RAMP','USERDEFINED');
        };
    }

    type IfcRatioMeasure {
        required property `IfcRatioMeasure` -> float64;
    }

    type IfcReal {
        required property `IfcReal` -> float64;
    }

    abstract type IfcRepresentationContext {
        property ContextIdentifier -> str;
        property ContextType -> str;
    }

    abstract type IfcRepresentationItem {
    }

    type IfcRoleEnum {
        required property `IfcRoleEnum` -> str {
            constraint one_of ('ARCHITECT','BUILDINGOPERATOR','BUILDINGOWNER','CIVILENGINEER','CLIENT','COMMISSIONINGENGINEER','CONSTRUCTIONMANAGER','CONSULTANT','CONTRACTOR','COSTENGINEER','ELECTRICALENGINEER','ENGINEER','FACILITIESMANAGER','FIELDCONSTRUCTIONMANAGER','MANUFACTURER','MECHANICALENGINEER','OWNER','PROJECTMANAGER','RESELLER','STRUCTURALENGINEER','SUBCONTRACTOR','SUPPLIER','USERDEFINED');
        };
    }

    type IfcRotationalFrequencyMeasure {
        required property `IfcRotationalFrequencyMeasure` -> float64;
    }

    type IfcRotationalMassMeasure {
        required property `IfcRotationalMassMeasure` -> float64;
    }

    type IfcRotationalStiffnessMeasure {
        required property `IfcRotationalStiffnessMeasure` -> float64;
    }

    type IfcSIPrefix {
        required property `IfcSIPrefix` -> str {
            constraint one_of ('ATTO','CENTI','DECA','DECI','EXA','FEMTO','GIGA','HECTO','KILO','MEGA','MICRO','MILLI','NANO','PETA','PICO','TERA');
        };
    }

    type IfcSIUnitName {
        required property `IfcSIUnitName` -> str {
            constraint one_of ('AMPERE','BECQUEREL','CANDELA','COULOMB','CUBIC_METRE','DEGREE_CELSIUS','FARAD','GRAM','GRAY','HENRY','HERTZ','JOULE','KELVIN','LUMEN','LUX','METRE','MOLE','NEWTON','OHM','PASCAL','RADIAN','SECOND','SIEMENS','SIEVERT','SQUARE_METRE','STERADIAN','TESLA','VOLT','WATT','WEBER');
        };
    }

    type IfcSectionModulusMeasure {
        required property `IfcSectionModulusMeasure` -> float64;
    }

    type IfcSectionalAreaIntegralMeasure {
        required property `IfcSectionalAreaIntegralMeasure` -> float64;
    }

    type IfcShearModulusMeasure {
        required property `IfcShearModulusMeasure` -> float64;
    }

    type IfcSlabTypeEnum {
        required property `IfcSlabTypeEnum` -> str {
            constraint one_of ('BASESLAB','FLOOR','LANDING','NOTDEFINED','ROOF','USERDEFINED');
        };
    }

    type IfcSolidAngleMeasure {
        required property `IfcSolidAngleMeasure` -> float64;
    }

    type IfcSoundPowerLevelMeasure {
        required property `IfcSoundPowerLevelMeasure` -> float64;
    }

    type IfcSoundPowerMeasure {
        required property `IfcSoundPowerMeasure` -> float64;
    }

    type IfcSoundPressureLevelMeasure {
        required property `IfcSoundPressureLevelMeasure` -> float64;
    }

    type IfcSoundPressureMeasure {
        required property `IfcSoundPressureMeasure` -> float64;
    }

    type IfcSpecificHeatCapacityMeasure {
        required property `IfcSpecificHeatCapacityMeasure` -> float64;
    }

    type IfcStateEnum {
        required property `IfcStateEnum` -> str {
            constraint one_of ('LOCKED','READONLY','READONLYLOCKED','READWRITE','READWRITELOCKED');
        };
    }

    type IfcSurfaceSide {
        required property `IfcSurfaceSide` -> str {
            constraint one_of ('BOTH','NEGATIVE','POSITIVE');
        };
    }

    type IfcTemperatureGradientMeasure {
        required property `IfcTemperatureGradientMeasure` -> float64;
    }

    type IfcTemperatureRateOfChangeMeasure {
        required property `IfcTemperatureRateOfChangeMeasure` -> float64;
    }

    type IfcText {
        required property `IfcText` -> str;
    }

    type IfcThermalAdmittanceMeasure {
        required property `IfcThermalAdmittanceMeasure` -> float64;
    }

    type IfcThermalConductivityMeasure {
        required property `IfcThermalConductivityMeasure` -> float64;
    }

    type IfcThermalExpansionCoefficientMeasure {
        required property `IfcThermalExpansionCoefficientMeasure` -> float64;
    }

    type IfcThermalResistanceMeasure {
        required property `IfcThermalResistanceMeasure` -> float64;
    }

    type IfcThermalTransmittanceMeasure {
        required property `IfcThermalTransmittanceMeasure` -> float64;
    }

    type IfcThermodynamicTemperatureMeasure {
        required property `IfcThermodynamicTemperatureMeasure` -> float64;
    }

    type IfcTime {
        required property `IfcTime` -> str;
    }

    type IfcTimeMeasure {
        required property `IfcTimeMeasure` -> float64;
    }

    type IfcTimeStamp {
        required property `IfcTimeStamp` -> int64;
    }

    type IfcTorqueMeasure {
        required property `IfcTorqueMeasure` -> float64;
    }

    type IfcUnitEnum {
        required property `IfcUnitEnum` -> str {
            constraint one_of ('ABSORBEDDOSEUNIT','AMOUNTOFSUBSTANCEUNIT','AREAUNIT','DOSEEQUIVALENTUNIT','ELECTRICCAPACITANCEUNIT','ELECTRICCHARGEUNIT','ELECTRICCONDUCTANCEUNIT','ELECTRICCURRENTUNIT','ELECTRICRESISTANCEUNIT','ELECTRICVOLTAGEUNIT','ENERGYUNIT','FORCEUNIT','FREQUENCYUNIT','ILLUMINANCEUNIT','INDUCTANCEUNIT','LENGTHUNIT','LUMINOUSFLUXUNIT','LUMINOUSINTENSITYUNIT','MAGNETICFLUXDENSITYUNIT','MAGNETICFLUXUNIT','MASSUNIT','PLANEANGLEUNIT','POWERUNIT','PRESSUREUNIT','RADIOACTIVITYUNIT','SOLIDANGLEUNIT','THERMODYNAMICTEMPERATUREUNIT','TIMEUNIT','USERDEFINED','VOLUMEUNIT');
        };
    }

    type IfcVaporPermeabilityMeasure {
        required property `IfcVaporPermeabilityMeasure` -> float64;
    }

    type IfcVolumeMeasure {
        required property `IfcVolumeMeasure` -> float64;
    }

    type IfcVolumetricFlowRateMeasure {
        required property `IfcVolumetricFlowRateMeasure` -> float64;
    }

    type IfcWallTypeEnum {
        required property `IfcWallTypeEnum` -> str {
            constraint one_of ('ELEMENTEDWALL','MOVABLE','NOTDEFINED','PARAPET','PARTITIONING','PLUMBINGWALL','POLYGONAL','SHEAR','SOLIDWALL','STANDARD','USERDEFINED');
        };
    }

    type IfcWarpingConstantMeasure {
        required property `IfcWarpingConstantMeasure` -> float64;
    }

    type IfcWarpingMomentMeasure {
        required property `IfcWarpingMomentMeasure` -> float64;
    }

    type IfcWindowTypeEnum {
        required property `IfcWindowTypeEnum` -> str {
            constraint one_of ('LIGHTDOME','NOTDEFINED','SKYLIGHT','USERDEFINED','WINDOW');
        };
    }

    type IfcWindowTypePartitioningEnum {
        required property `IfcWindowTypePartitioningEnum` -> str {
            constraint one_of ('DOUBLE_PANEL_HORIZONTAL','DOUBLE_PANEL_VERTICAL','NOTDEFINED','SINGLE_PANEL','TRIPLE_PANEL_BOTTOM','TRIPLE_PANEL_HORIZONTAL','TRIPLE_PANEL_LEFT','TRIPLE_PANEL_RIGHT','TRIPLE_PANEL_TOP','TRIPLE_PANEL_VERTICAL','USERDEFINED');
        };
    }

    type IfcActorRole {
        property UserDefinedRole -> str;
        property Description -> str;
        required link Role -> IfcRoleEnum;
    }

    abstract type IfcAddress {
        property Description -> str;
        property UserDefinedPurpose -> str;
        link Purpose -> IfcAddressTypeEnum;
    }

    type IfcArcIndex {
        required property `IfcArcIndex` -> tuple<int64,int64,int64>;
    }

    abstract type IfcColourSpecification extending IfcPresentationItem {
        property Name -> str;
    }

    type IfcCurveStyleFontPattern extending IfcPresentationItem {
        required property VisibleSegmentLength -> float64;
        required property InvisibleSegmentLength -> float64;
    }

    type IfcDerivedMeasureValue {
        required link IfcDerivedMeasureValue -> IfcAbsorbedDoseMeasure | IfcAccelerationMeasure | IfcAngularVelocityMeasure | IfcAreaDensityMeasure | IfcCompoundPlaneAngleMeasure | IfcCurvatureMeasure | IfcDoseEquivalentMeasure | IfcDynamicViscosityMeasure | IfcElectricCapacitanceMeasure | IfcElectricChargeMeasure | IfcElectricConductanceMeasure | IfcElectricResistanceMeasure | IfcElectricVoltageMeasure | IfcEnergyMeasure | IfcForceMeasure | IfcFrequencyMeasure | IfcHeatFluxDensityMeasure | IfcHeatingValueMeasure | IfcIlluminanceMeasure | IfcInductanceMeasure | IfcIntegerCountRateMeasure | IfcIonConcentrationMeasure | IfcIsothermalMoistureCapacityMeasure | IfcKinematicViscosityMeasure | IfcLinearForceMeasure | IfcLinearMomentMeasure | IfcLinearStiffnessMeasure | IfcLinearVelocityMeasure | IfcLuminousFluxMeasure | IfcLuminousIntensityDistributionMeasure | IfcMagneticFluxDensityMeasure | IfcMagneticFluxMeasure | IfcMassDensityMeasure | IfcMassFlowRateMeasure | IfcMassPerLengthMeasure | IfcModulusOfElasticityMeasure | IfcModulusOfLinearSubgradeReactionMeasure | IfcModulusOfRotationalSubgradeReactionMeasure | IfcModulusOfSubgradeReactionMeasure | IfcMoistureDiffusivityMeasure | IfcMolecularWeightMeasure | IfcMomentOfInertiaMeasure | IfcMonetaryMeasure | IfcPHMeasure | IfcPlanarForceMeasure | IfcPowerMeasure | IfcPressureMeasure | IfcRadioActivityMeasure | IfcRotationalFrequencyMeasure | IfcRotationalMassMeasure | IfcRotationalStiffnessMeasure | IfcSectionModulusMeasure | IfcSectionalAreaIntegralMeasure | IfcShearModulusMeasure | IfcSoundPowerLevelMeasure | IfcSoundPowerMeasure | IfcSoundPressureLevelMeasure | IfcSoundPressureMeasure | IfcSpecificHeatCapacityMeasure | IfcTemperatureGradientMeasure | IfcTemperatureRateOfChangeMeasure | IfcThermalAdmittanceMeasure | IfcThermalConductivityMeasure | IfcThermalExpansionCoefficientMeasure | IfcThermalResistanceMeasure | IfcThermalTransmittanceMeasure | IfcTorqueMeasure | IfcVaporPermeabilityMeasure | IfcVolumetricFlowRateMeasure | IfcWarpingConstantMeasure | IfcWarpingMomentMeasure;
    }

    type IfcExternallyDefinedHatchStyle extending IfcExternalReference {
    }

    type IfcExternallyDefinedSurfaceStyle extending IfcExternalReference {
    }

    type IfcExternallyDefinedTextFont extending IfcExternalReference {
    }

    abstract type IfcGeometricRepresentationItem extending IfcRepresentationItem {
    }

    type IfcLineIndex {
        required property `IfcLineIndex` -> tuple<int64>;
    }

    type IfcMaterial extending IfcMaterialDefinition {
        required property Name -> str;
        property Description -> str;
        property Category -> str;
    }

    type IfcMeasureValue {
        required link IfcMeasureValue -> IfcAmountOfSubstanceMeasure | IfcAreaMeasure | IfcComplexNumber | IfcContextDependentMeasure | IfcCountMeasure | IfcDescriptiveMeasure | IfcElectricCurrentMeasure | IfcLengthMeasure | IfcLuminousIntensityMeasure | IfcMassMeasure | IfcNonNegativeLengthMeasure | IfcNormalisedRatioMeasure | IfcNumericMeasure | IfcParameterValue | IfcPlaneAngleMeasure | IfcPositiveLengthMeasure | IfcPositivePlaneAngleMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure | IfcSolidAngleMeasure | IfcThermodynamicTemperatureMeasure | IfcTimeMeasure | IfcVolumeMeasure;
    }

    abstract type IfcNamedUnit {
        link Dimensions -> IfcDimensionalExponents;
        required link UnitType -> IfcUnitEnum;
    }

    abstract type IfcPreDefinedItem extending IfcPresentationItem {
        required property Name -> str;
    }

    type IfcProfileDef {
        property ProfileName -> str;
        required link ProfileType -> IfcProfileTypeEnum;
    }

    abstract type IfcProperty extending IfcPropertyAbstraction {
        required property Name -> str;
        property Description -> str;
    }

    abstract type IfcRepresentation {
        property RepresentationIdentifier -> str;
        property RepresentationType -> str;
        required link ContextOfItems -> IfcRepresentationContext;
        required multi link Items -> IfcRepresentationItem;
    }

    type IfcSimpleValue {
        required link IfcSimpleValue -> IfcBinary | IfcBoolean | IfcDate | IfcDateTime | IfcDuration | IfcIdentifier | IfcInteger | IfcLabel | IfcLogical | IfcPositiveInteger | IfcReal | IfcText | IfcTime | IfcTimeStamp;
    }

    type IfcSizeSelect {
        required link IfcSizeSelect -> IfcDescriptiveMeasure | IfcLengthMeasure | IfcNormalisedRatioMeasure | IfcPositiveLengthMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure;
    }

    type IfcSurfaceStyleRefraction extending IfcPresentationItem {
        property RefractionIndex -> float64;
        property DispersionFactor -> float64;
    }

    abstract type IfcTopologicalRepresentationItem extending IfcRepresentationItem {
    }

    abstract type IfcCartesianPointList extending IfcGeometricRepresentationItem {
    }

    type IfcColourRgb extending IfcColourSpecification {
        required property Red -> float64;
        required property Green -> float64;
        required property Blue -> float64;
    }

    type IfcCompositeProfileDef extending IfcProfileDef {
        property Label -> str;
        required multi link Profiles -> IfcProfileDef;
    }

    abstract type IfcCurve extending IfcGeometricRepresentationItem {
    }

    type IfcCurveStyleFont extending IfcPresentationItem {
        property Name -> str;
        required multi link PatternList -> IfcCurveStyleFontPattern;
    }

    type IfcDerivedUnitElement {
        required property Exponent -> int64;
        required link Unit -> IfcNamedUnit;
    }

    type IfcDirection extending IfcGeometricRepresentationItem {
        required property DirectionRatios -> array<float64>{
            constraint expression on (len(__subject__) = 2 or len(__subject__) = 3)
        };
    }

    abstract type IfcExtendedProperties extending IfcPropertyAbstraction {
        property Name -> str;
        property Description -> str;
        required multi link Properties -> IfcProperty;
    }

    type IfcLoop extending IfcTopologicalRepresentationItem {
    }

    type IfcMaterialLayer extending IfcMaterialDefinition {
        required property LayerThickness -> float64;
        property IsVentilated -> bool;
        property Name -> str;
        property Description -> str;
        property Category -> str;
        property Priority -> int64;
        link Material -> IfcMaterial;
    }

    type IfcMaterialList {
        required multi link Materials -> IfcMaterial;
    }

    type IfcMaterialProfile extending IfcMaterialDefinition {
        property Name -> str;
        property Description -> str;
        property Priority -> int64;
        property Category -> str;
        link Material -> IfcMaterial;
        required link Profile -> IfcProfileDef;
    }

    type IfcOrganization {
        property Identification -> str;
        required property Name -> str;
        property Description -> str;
        multi link Roles -> IfcActorRole;
        multi link Addresses -> IfcAddress;
    }

    type IfcPerson {
        property Identification -> str;
        property FamilyName -> str;
        property GivenName -> str;
        property MiddleNames -> tuple<str>;
        property PrefixTitles -> tuple<str>;
        property SuffixTitles -> tuple<str>;
        multi link Roles -> IfcActorRole;
        multi link Addresses -> IfcAddress;
    }

    abstract type IfcPoint extending IfcGeometricRepresentationItem {
    }

    type IfcPostalAddress extending IfcAddress {
        property InternalLocation -> str;
        property AddressLines -> tuple<str>;
        property PostalBox -> str;
        property Town -> str;
        property Region -> str;
        property PostalCode -> str;
        property Country -> str;
    }

    abstract type IfcPreDefinedColour extending IfcPreDefinedItem {
    }

    abstract type IfcPreDefinedCurveFont extending IfcPreDefinedItem {
    }

    abstract type IfcPreDefinedTextFont extending IfcPreDefinedItem {
    }

    abstract type IfcProductRepresentation {
        property Name -> str;
        property Description -> str;
        required multi link Representations -> IfcRepresentation;
    }

    type IfcSIUnit extending IfcNamedUnit {
        link Prefix -> IfcSIPrefix;
        required link Name -> IfcSIUnitName;
    }

    type IfcSegmentIndexSelect {
        required link IfcSegmentIndexSelect -> IfcArcIndex | IfcLineIndex;
    }

    abstract type IfcShapeModel extending IfcRepresentation {
    }

    abstract type IfcSimpleProperty extending IfcProperty {
    }

    abstract type IfcSolidModel extending IfcGeometricRepresentationItem {
    }

    abstract type IfcSurface extending IfcGeometricRepresentationItem {
    }

    type IfcTelecomAddress extending IfcAddress {
        property TelephoneNumbers -> tuple<str>;
        property FacsimileNumbers -> tuple<str>;
        property PagerNumber -> str;
        property ElectronicMailAddresses -> tuple<str>;
        property WWWHomePageURL -> str;
        property MessagingIDs -> tuple<str>;
    }

    abstract type IfcTessellatedItem extending IfcGeometricRepresentationItem {
    }

    type IfcTextStyleTextModel extending IfcPresentationItem {
        property TextAlign -> str;
        property TextDecoration -> str;
        property TextTransform -> str;
        link TextIndent -> IfcSizeSelect;
        link LetterSpacing -> IfcSizeSelect;
        link WordSpacing -> IfcSizeSelect;
        link LineHeight -> IfcSizeSelect;
    }

    type IfcValue {
        required link IfcValue -> IfcDerivedMeasureValue | IfcMeasureValue | IfcSimpleValue;
    }

    type IfcVertex extending IfcTopologicalRepresentationItem {
    }

    type IfcApplication {
        required property Version -> str;
        required property ApplicationFullName -> str;
        required property ApplicationIdentifier -> str;
        required link ApplicationDeveloper -> IfcOrganization;
    }

    type IfcArbitraryClosedProfileDef extending IfcProfileDef {
        required link OuterCurve -> IfcCurve;
    }

    abstract type IfcBoundedCurve extending IfcCurve {
    }

    abstract type IfcBoundedSurface extending IfcSurface {
    }

    type IfcCartesianPoint extending IfcPoint {
        required property Coordinates -> array<float64>{
            constraint expression on (len(__subject__) = 1 or len(__subject__) = 2 or len(__subject__) = 3)
        };
    }

    type IfcCartesianPointList2D extending IfcCartesianPointList {
        required property CoordList -> array<tuple<float64,float64>>;
        property TagList -> tuple<str>;
    }

    type IfcCartesianPointList3D extending IfcCartesianPointList {
        required property CoordList -> array<tuple<float64,float64,float64>>;
        property TagList -> tuple<str>;
    }

    type IfcColour {
        required link IfcColour -> IfcColourSpecification | IfcPreDefinedColour;
    }

    type IfcCurveStyleFontSelect {
        required link IfcCurveStyleFontSelect -> IfcCurveStyleFont | IfcPreDefinedCurveFont;
    }

    type IfcDerivedUnit {
        property UserDefinedType -> str;
        required multi link Elements -> IfcDerivedUnitElement;
        required link UnitType -> IfcDerivedUnitEnum;
    }

    type IfcEdge extending IfcTopologicalRepresentationItem {
        link EdgeStart -> IfcVertex;
        link EdgeEnd -> IfcVertex;
    }

    type IfcFaceBound extending IfcTopologicalRepresentationItem {
        required property Orientation -> bool;
        required link Bound -> IfcLoop;
    }

    type IfcGeometricSetSelect {
        required link IfcGeometricSetSelect -> IfcCurve | IfcPoint | IfcSurface;
    }

    type IfcIndexedPolygonalFace extending IfcTessellatedItem {
        required property CoordIndex -> tuple<int64>;
    }

    type IfcMaterialLayerSet extending IfcMaterialDefinition {
        property LayerSetName -> str;
        property Description -> str;
        required multi link MaterialLayers -> IfcMaterialLayer;
    }

    type IfcMaterialProfileSet extending IfcMaterialDefinition {
        property Name -> str;
        property Description -> str;
        required multi link MaterialProfiles -> IfcMaterialProfile;
        link CompositeProfile -> IfcCompositeProfileDef;
    }

    type IfcMaterialProperties extending IfcExtendedProperties {
        required link Material -> IfcMaterialDefinition;
    }

    type IfcMaterialSelect {
        required link IfcMaterialSelect -> IfcMaterialDefinition | IfcMaterialList | IfcMaterialUsageDefinition;
    }

    type IfcPersonAndOrganization {
        required link ThePerson -> IfcPerson;
        required link TheOrganization -> IfcOrganization;
        multi link Roles -> IfcActorRole;
    }

    type IfcProductDefinitionShape extending IfcProductRepresentation {
    }

    type IfcShapeRepresentation extending IfcShapeModel {
    }

    type IfcSurfaceStyleLighting extending IfcPresentationItem {
        required link DiffuseTransmissionColour -> IfcColourRgb;
        required link DiffuseReflectionColour -> IfcColourRgb;
        required link TransmissionColour -> IfcColourRgb;
        required link ReflectanceColour -> IfcColourRgb;
    }

    type IfcSurfaceStyleShading extending IfcPresentationItem {
        property Transparency -> float64;
        required link SurfaceColour -> IfcColourRgb;
    }

    type IfcTextFontSelect {
        required link IfcTextFontSelect -> IfcExternallyDefinedTextFont | IfcPreDefinedTextFont;
    }

    type IfcVector extending IfcGeometricRepresentationItem {
        required property Magnitude -> float64;
        required link Orientation -> IfcDirection;
    }

    type IfcVertexPoint extending IfcVertex {
        required link VertexGeometry -> IfcPoint;
    }

    type IfcBoundingBox extending IfcGeometricRepresentationItem {
        required property XDim -> float64;
        required property YDim -> float64;
        required property ZDim -> float64;
        required link Corner -> IfcCartesianPoint;
    }

    abstract type IfcCartesianTransformationOperator extending IfcGeometricRepresentationItem {
        property Scale -> float64;
        link Axis1 -> IfcDirection;
        link Axis2 -> IfcDirection;
        required link LocalOrigin -> IfcCartesianPoint;
    }

    type IfcCurveStyleFontAndScaling extending IfcPresentationItem {
        property Name -> str;
        required property CurveFontScaling -> float64;
        required link CurveFont -> IfcCurveStyleFontSelect;
    }

    type IfcEdgeCurve extending IfcEdge {
        required property SameSense -> bool;
        required link EdgeGeometry -> IfcCurve;
    }

    type IfcFace extending IfcTopologicalRepresentationItem {
        required multi link Bounds -> IfcFaceBound;
    }

    type IfcFaceOuterBound extending IfcFaceBound {
    }

    type IfcFillAreaStyleTiles extending IfcGeometricRepresentationItem {
        required property TilingScale -> float64;
        required multi link TilingPattern -> IfcVector;
    }

    type IfcGeometricSet extending IfcGeometricRepresentationItem {
        required multi link Elements -> IfcGeometricSetSelect;
    }

    type IfcHatchLineDistanceSelect {
        required link IfcHatchLineDistanceSelect -> IfcPositiveLengthMeasure | IfcVector;
    }

    type IfcIndexedPolyCurve extending IfcBoundedCurve {
        property SelfIntersect -> bool;
        required link Points -> IfcCartesianPointList;
        multi link Segments -> IfcSegmentIndexSelect;
    }

    type IfcMaterialProfileSetUsage extending IfcMaterialUsageDefinition {
        property CardinalPoint -> int64;
        property ReferenceExtent -> float64;
        required link ForProfileSet -> IfcMaterialProfileSet;
    }

    type IfcOrientedEdge extending IfcEdge {
        required property Orientation -> bool;
        required link EdgeElement -> IfcEdge;
    }

    type IfcOwnerHistory {
        property LastModifiedDate -> int64;
        required property CreationDate -> int64;
        required link OwningUser -> IfcPersonAndOrganization;
        required link OwningApplication -> IfcApplication;
        link State -> IfcStateEnum;
        link ChangeAction -> IfcChangeActionEnum;
        link LastModifyingUser -> IfcPersonAndOrganization;
        link LastModifyingApplication -> IfcApplication;
    }

    abstract type IfcPlacement extending IfcGeometricRepresentationItem {
        required link Location -> IfcCartesianPoint;
    }

    type IfcPolyline extending IfcBoundedCurve {
        required multi link Points -> IfcCartesianPoint;
    }

    abstract type IfcTessellatedFaceSet extending IfcTessellatedItem {
        required link Coordinates -> IfcCartesianPointList3D;
    }

    type IfcTextStyleForDefinedFont extending IfcPresentationItem {
        required link Colour -> IfcColour;
        link BackgroundColour -> IfcColour;
    }

    type IfcUnit {
        required link IfcUnit -> IfcDerivedUnit | IfcMonetaryUnit | IfcNamedUnit;
    }

    type IfcAxis2Placement2D extending IfcPlacement {
        link RefDirection -> IfcDirection;
    }

    type IfcAxis2Placement3D extending IfcPlacement {
        link Axis -> IfcDirection;
        link RefDirection -> IfcDirection;
    }

    abstract type IfcBSplineSurface extending IfcBoundedSurface {
        required property UDegree -> int64;
        required property VDegree -> int64;
        required property UClosed -> bool;
        required property VClosed -> bool;
        required property SelfIntersect -> bool;
        required multi link ControlPointsList -> IfcCartesianPoint;
        required link SurfaceForm -> IfcBSplineSurfaceForm;
    }

    type IfcCartesianTransformationOperator2D extending IfcCartesianTransformationOperator {
    }

    type IfcConnectedFaceSet extending IfcTopologicalRepresentationItem {
        required multi link CfsFaces -> IfcFace;
    }

    type IfcCurveFontOrScaledCurveFontSelect {
        required link IfcCurveFontOrScaledCurveFontSelect -> IfcCurveStyleFontAndScaling | IfcCurveStyleFontSelect;
    }

    type IfcEdgeLoop extending IfcLoop {
        required multi link EdgeList -> IfcOrientedEdge;
    }

    type IfcFaceSurface extending IfcFace {
        required property SameSense -> bool;
        required link FaceSurface -> IfcSurface;
    }

    type IfcGeometricCurveSet extending IfcGeometricSet {
    }

    type IfcMeasureWithUnit {
        required link ValueComponent -> IfcValue;
        required link UnitComponent -> IfcUnit;
    }

    type IfcPolygonalFaceSet extending IfcTessellatedFaceSet {
        property Closed -> bool;
        property PnIndex -> tuple<int64>;
        required multi link Faces -> IfcIndexedPolygonalFace;
    }

    type IfcPropertySingleValue extending IfcSimpleProperty {
        link NominalValue -> IfcValue;
        link Unit -> IfcUnit;
    }

    abstract type IfcRoot {
        required property GlobalId -> str;
        property Name -> str;
        property Description -> str;
        link OwnerHistory -> IfcOwnerHistory;
    }

    type IfcTextStyle extending IfcPresentationStyle {
        property ModelOrDraughting -> bool;
        link TextCharacterAppearance -> IfcTextStyleForDefinedFont;
        link TextStyle -> IfcTextStyleTextModel;
        required link TextFontStyle -> IfcTextFontSelect;
    }

    type IfcTriangulatedFaceSet extending IfcTessellatedFaceSet {
        property Normals -> array<tuple<float64,float64,float64>>;
        property Closed -> bool;
        required property CoordIndex -> array<tuple<int64,int64,int64>>;
        property PnIndex -> tuple<int64>;
    }

    type IfcUnitAssignment {
        required multi link Units -> IfcUnit;
    }

    type IfcAdvancedFace extending IfcFaceSurface {
    }

    type IfcAxis2Placement {
        required link IfcAxis2Placement -> IfcAxis2Placement2D | IfcAxis2Placement3D;
    }

    type IfcBSplineSurfaceWithKnots extending IfcBSplineSurface {
        required property UMultiplicities -> tuple<int64>;
        required property VMultiplicities -> tuple<int64>;
        required property UKnots -> tuple<float64>;
        required property VKnots -> tuple<float64>;
        required link KnotSpec -> IfcKnotType;
    }

    type IfcClosedShell extending IfcConnectedFaceSet {
    }

    type IfcConversionBasedUnit extending IfcNamedUnit {
        required property Name -> str;
        required link ConversionFactor -> IfcMeasureWithUnit;
    }

    type IfcCurveStyle extending IfcPresentationStyle {
        property ModelOrDraughting -> bool;
        link CurveFont -> IfcCurveFontOrScaledCurveFontSelect;
        link CurveWidth -> IfcSizeSelect;
        link CurveColour -> IfcColour;
    }

    abstract type IfcElementarySurface extending IfcSurface {
        required link Position -> IfcAxis2Placement3D;
    }

    abstract type IfcObjectDefinition extending IfcRoot {
    }

    abstract type IfcParameterizedProfileDef extending IfcProfileDef {
        link Position -> IfcAxis2Placement2D;
    }

    abstract type IfcPropertyDefinition extending IfcRoot {
    }

    abstract type IfcRelationship extending IfcRoot {
    }

    abstract type IfcSurfaceTexture extending IfcPresentationItem {
        required property RepeatS -> bool;
        required property RepeatT -> bool;
        property Mode -> str;
        property Parameter -> tuple<str>;
        link TextureTransform -> IfcCartesianTransformationOperator2D;
    }

    abstract type IfcSweptAreaSolid extending IfcSolidModel {
        required link SweptArea -> IfcProfileDef;
        link Position -> IfcAxis2Placement3D;
    }

    type IfcCShapeProfileDef extending IfcParameterizedProfileDef {
        required property Depth -> float64;
        required property Width -> float64;
        required property WallThickness -> float64;
        required property Girth -> float64;
        property InternalFilletRadius -> float64;
    }

    type IfcCircleProfileDef extending IfcParameterizedProfileDef {
        required property Radius -> float64;
    }

    abstract type IfcContext extending IfcObjectDefinition {
        property ObjectType -> str;
        property LongName -> str;
        property Phase -> str;
        multi link RepresentationContexts -> IfcRepresentationContext;
        link UnitsInContext -> IfcUnitAssignment;
    }

    type IfcDefinitionSelect {
        required link IfcDefinitionSelect -> IfcObjectDefinition | IfcPropertyDefinition;
    }

    type IfcExtrudedAreaSolid extending IfcSweptAreaSolid {
        required property Depth -> float64;
        required link ExtrudedDirection -> IfcDirection;
    }

    type IfcFillAreaStyleHatching extending IfcGeometricRepresentationItem {
        required property HatchLineAngle -> float64;
        required link HatchLineAppearance -> IfcCurveStyle;
        required link StartOfNextHatchLine -> IfcHatchLineDistanceSelect;
        link PointOfReferenceHatchLine -> IfcCartesianPoint;
        link PatternStart -> IfcCartesianPoint;
    }

    type IfcGeometricRepresentationContext extending IfcRepresentationContext {
        property CoordinateSpaceDimension -> int64;
        property Precision -> float64;
        link WorldCoordinateSystem -> IfcAxis2Placement;
        link TrueNorth -> IfcDirection;
    }

    type IfcIShapeProfileDef extending IfcParameterizedProfileDef {
        required property OverallWidth -> float64;
        required property OverallDepth -> float64;
        required property WebThickness -> float64;
        required property FlangeThickness -> float64;
        property FilletRadius -> float64;
        property FlangeEdgeRadius -> float64;
        property FlangeSlope -> float64;
    }

    type IfcLocalPlacement extending IfcObjectPlacement {
        link PlacementRelTo -> IfcObjectPlacement;
        required link RelativePlacement -> IfcAxis2Placement;
    }

    abstract type IfcManifoldSolidBrep extending IfcSolidModel {
        required link Outer -> IfcClosedShell;
    }

    abstract type IfcObject extending IfcObjectDefinition {
        property ObjectType -> str;
    }

    type IfcPlane extending IfcElementarySurface {
    }

    abstract type IfcPropertySetDefinition extending IfcPropertyDefinition {
    }

    type IfcRectangleProfileDef extending IfcParameterizedProfileDef {
        required property XDim -> float64;
        required property YDim -> float64;
    }

    abstract type IfcRelConnects extending IfcRelationship {
    }

    abstract type IfcRelDecomposes extending IfcRelationship {
    }

    abstract type IfcRelDefines extending IfcRelationship {
    }

    type IfcRepresentationMap {
        required link MappingOrigin -> IfcAxis2Placement;
        required link MappedRepresentation -> IfcRepresentation;
    }

    type IfcSurfaceStyleWithTextures extending IfcPresentationItem {
        required multi link Textures -> IfcSurfaceTexture;
    }

    type IfcAdvancedBrep extending IfcManifoldSolidBrep {
    }

    type IfcCircleHollowProfileDef extending IfcCircleProfileDef {
        required property WallThickness -> float64;
    }

    type IfcFillStyleSelect {
        required link IfcFillStyleSelect -> IfcColour | IfcExternallyDefinedHatchStyle | IfcFillAreaStyleHatching | IfcFillAreaStyleTiles;
    }

    type IfcGeometricRepresentationSubContext extending IfcGeometricRepresentationContext {
        property TargetScale -> float64;
        property UserDefinedTargetView -> str;
        required link ParentContext -> IfcGeometricRepresentationContext;
        required link TargetView -> IfcGeometricProjectionEnum;
    }

    abstract type IfcProduct extending IfcObject {
        link ObjectPlacement -> IfcObjectPlacement;
        link Representation -> IfcProductRepresentation;
    }

    type IfcProject extending IfcContext {
    }

    type IfcPropertySet extending IfcPropertySetDefinition {
        required multi link HasProperties -> IfcProperty;
    }

    type IfcPropertySetDefinitionSet {
        required multi link IfcPropertySetDefinitionSet -> IfcPropertySetDefinition;
    }

    type IfcRectangleHollowProfileDef extending IfcRectangleProfileDef {
        required property WallThickness -> float64;
        property InnerFilletRadius -> float64;
        property OuterFilletRadius -> float64;
    }

    type IfcRelAggregates extending IfcRelDecomposes {
        required link RelatingObject -> IfcObjectDefinition;
        required multi link RelatedObjects -> IfcObjectDefinition;
    }

    abstract type IfcRelAssociates extending IfcRelationship {
        required multi link RelatedObjects -> IfcDefinitionSelect;
    }

    type IfcSurfaceStyleElementSelect {
        required link IfcSurfaceStyleElementSelect -> IfcExternallyDefinedSurfaceStyle | IfcSurfaceStyleLighting | IfcSurfaceStyleRefraction | IfcSurfaceStyleShading | IfcSurfaceStyleWithTextures;
    }

    type IfcTypeObject extending IfcObjectDefinition {
        property ApplicableOccurrence -> str;
        multi link HasPropertySets -> IfcPropertySetDefinition;
    }

    abstract type IfcElement extending IfcProduct {
        property Tag -> str;
    }

    type IfcFillAreaStyle extending IfcPresentationStyle {
        property ModelorDraughting -> bool;
        required multi link FillStyles -> IfcFillStyleSelect;
    }

    type IfcPropertySetDefinitionSelect {
        required link IfcPropertySetDefinitionSelect -> IfcPropertySetDefinition | IfcPropertySetDefinitionSet;
    }

    type IfcRelAssociatesMaterial extending IfcRelAssociates {
        required link RelatingMaterial -> IfcMaterialSelect;
    }

    type IfcRelDefinesByType extending IfcRelDefines {
        required multi link RelatedObjects -> IfcObject;
        required link RelatingType -> IfcTypeObject;
    }

    abstract type IfcSpatialElement extending IfcProduct {
        property LongName -> str;
    }

    type IfcSurfaceStyle extending IfcPresentationStyle {
        required link Side -> IfcSurfaceSide;
        required multi link Styles -> IfcSurfaceStyleElementSelect;
    }

    type IfcTypeProduct extending IfcTypeObject {
        property Tag -> str;
        multi link RepresentationMaps -> IfcRepresentationMap;
    }

    abstract type IfcBuildingElement extending IfcElement {
    }

    abstract type IfcElementType extending IfcTypeProduct {
        property ElementType -> str;
    }

    abstract type IfcFeatureElement extending IfcElement {
    }

    type IfcPresentationStyleSelect {
        required link IfcPresentationStyleSelect -> IfcCurveStyle | IfcFillAreaStyle | IfcNullStyle | IfcSurfaceStyle | IfcTextStyle;
    }

    type IfcRelContainedInSpatialStructure extending IfcRelConnects {
        required multi link RelatedElements -> IfcProduct;
        required link RelatingStructure -> IfcSpatialElement;
    }

    type IfcRelDefinesByProperties extending IfcRelDefines {
        required multi link RelatedObjects -> IfcObjectDefinition;
        required link RelatingPropertyDefinition -> IfcPropertySetDefinitionSelect;
    }

    abstract type IfcSpatialStructureElement extending IfcSpatialElement {
        link CompositionType -> IfcElementCompositionEnum;
    }

    type IfcBeam extending IfcBuildingElement {
        link PredefinedType -> IfcBeamTypeEnum;
    }

    type IfcBuilding extending IfcSpatialStructureElement {
        property ElevationOfRefHeight -> float64;
        property ElevationOfTerrain -> float64;
        link BuildingAddress -> IfcPostalAddress;
    }

    type IfcBuildingElementProxy extending IfcBuildingElement {
        link PredefinedType -> IfcBuildingElementProxyTypeEnum;
    }

    abstract type IfcBuildingElementType extending IfcElementType {
    }

    type IfcBuildingStorey extending IfcSpatialStructureElement {
        property Elevation -> float64;
    }

    type IfcColumn extending IfcBuildingElement {
        link PredefinedType -> IfcColumnTypeEnum;
    }

    abstract type IfcFeatureElementSubtraction extending IfcFeatureElement {
    }

    type IfcFurnishingElementType extending IfcElementType {
    }

    type IfcMember extending IfcBuildingElement {
        link PredefinedType -> IfcMemberTypeEnum;
    }

    type IfcPresentationStyleAssignment {
        required multi link Styles -> IfcPresentationStyleSelect;
    }

    type IfcSite extending IfcSpatialStructureElement {
        property RefLatitude -> int64;
        property RefLongitude -> int64;
        property RefElevation -> float64;
        property LandTitleNumber -> str;
        link SiteAddress -> IfcPostalAddress;
    }

    type IfcBeamType extending IfcBuildingElementType {
        required link PredefinedType -> IfcBeamTypeEnum;
    }

    type IfcColumnType extending IfcBuildingElementType {
        required link PredefinedType -> IfcColumnTypeEnum;
    }

    type IfcCoveringType extending IfcBuildingElementType {
        required link PredefinedType -> IfcCoveringTypeEnum;
    }

    type IfcDoorType extending IfcBuildingElementType {
        property ParameterTakesPrecedence -> bool;
        property UserDefinedOperationType -> str;
        required link PredefinedType -> IfcDoorTypeEnum;
        required link OperationType -> IfcDoorTypeOperationEnum;
    }

    type IfcFurnitureType extending IfcFurnishingElementType {
        required link AssemblyPlace -> IfcAssemblyPlaceEnum;
        link PredefinedType -> IfcFurnitureTypeEnum;
    }

    type IfcOpeningElement extending IfcFeatureElementSubtraction {
        link PredefinedType -> IfcOpeningElementTypeEnum;
    }

    type IfcPileType extending IfcBuildingElementType {
        required link PredefinedType -> IfcPileTypeEnum;
    }

    type IfcRampType extending IfcBuildingElementType {
        required link PredefinedType -> IfcRampTypeEnum;
    }

    type IfcRelVoidsElement extending IfcRelDecomposes {
        required link RelatingBuildingElement -> IfcElement;
        required link RelatedOpeningElement -> IfcFeatureElementSubtraction;
    }

    type IfcSlabType extending IfcBuildingElementType {
        required link PredefinedType -> IfcSlabTypeEnum;
    }

    type IfcStyleAssignmentSelect {
        required link IfcStyleAssignmentSelect -> IfcPresentationStyle | IfcPresentationStyleAssignment;
    }

    type IfcWallType extending IfcBuildingElementType {
        required link PredefinedType -> IfcWallTypeEnum;
    }

    type IfcWindowType extending IfcBuildingElementType {
        property ParameterTakesPrecedence -> bool;
        property UserDefinedPartitioningType -> str;
        required link PredefinedType -> IfcWindowTypeEnum;
        required link PartitioningType -> IfcWindowTypePartitioningEnum;
    }

    type IfcStyledItem extending IfcRepresentationItem {
        property Name -> str;
        link Item -> IfcRepresentationItem;
        required multi link Styles -> IfcStyleAssignmentSelect;
    }


}
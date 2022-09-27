module default {

    type IfcAbsorbedDoseMeasure {
        required property `IfcAbsorbedDoseMeasure` -> float64;
    }

    type IfcAccelerationMeasure {
        required property `IfcAccelerationMeasure` -> float64;
    }

    type IfcAmountOfSubstanceMeasure {
        required property `IfcAmountOfSubstanceMeasure` -> float64;
    }

    type IfcAngularVelocityMeasure {
        required property `IfcAngularVelocityMeasure` -> float64;
    }

    type IfcArcIndex {
        required property `IfcArcIndex` -> tuple<int64,int64,int64>;
    }

    type IfcAreaDensityMeasure {
        required property `IfcAreaDensityMeasure` -> float64;
    }

    type IfcAreaMeasure {
        required property `IfcAreaMeasure` -> float64;
    }

    type IfcBinary {
        required property `IfcBinary` -> bytes;
    }

    type IfcBoolean {
        required property `IfcBoolean` -> bool;
    }

    type IfcBoxAlignment {
        required property `IfcBoxAlignment` -> str;
    }

    type IfcCardinalPointReference {
        required property `IfcCardinalPointReference` -> int64;
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

    type IfcCurvatureMeasure {
        required property `IfcCurvatureMeasure` -> float64;
    }

    type IfcDate {
        required property `IfcDate` -> str;
    }

    type IfcDateTime {
        required property `IfcDateTime` -> str;
    }

    type IfcDayInMonthNumber {
        required property `IfcDayInMonthNumber` -> int64;
    }

    type IfcDayInWeekNumber {
        required property `IfcDayInWeekNumber` -> int64;
    }

    type IfcDescriptiveMeasure {
        required property `IfcDescriptiveMeasure` -> str;
    }

    type IfcDimensionCount {
        required property `IfcDimensionCount` -> int64;
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

    type IfcEnergyMeasure {
        required property `IfcEnergyMeasure` -> float64;
    }

    type IfcFontStyle {
        required property `IfcFontStyle` -> str;
    }

    type IfcFontVariant {
        required property `IfcFontVariant` -> str;
    }

    type IfcFontWeight {
        required property `IfcFontWeight` -> str;
    }

    type IfcForceMeasure {
        required property `IfcForceMeasure` -> float64;
    }

    type IfcFrequencyMeasure {
        required property `IfcFrequencyMeasure` -> float64;
    }

    type IfcGloballyUniqueId {
        required property `IfcGloballyUniqueId` -> str;
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

    type IfcLabel {
        required property `IfcLabel` -> str;
    }

    type IfcLanguageId {
        required property `IfcLanguageId` -> str;
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

    type IfcLineIndex {
        required property `IfcLineIndex` -> tuple<int64>;
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

    type IfcMonthInYearNumber {
        required property `IfcMonthInYearNumber` -> int64;
    }

    type IfcNonNegativeLengthMeasure {
        required property `IfcNonNegativeLengthMeasure` -> float64;
    }

    type IfcNormalisedRatioMeasure {
        required property `IfcNormalisedRatioMeasure` -> float64;
    }

    type IfcNumericMeasure {
        required property `IfcNumericMeasure` -> int64;
    }

    type IfcParameterValue {
        required property `IfcParameterValue` -> float64;
    }

    type IfcPHMeasure {
        required property `IfcPHMeasure` -> float64;
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

    type IfcPresentableText {
        required property `IfcPresentableText` -> str;
    }

    type IfcPressureMeasure {
        required property `IfcPressureMeasure` -> float64;
    }

    type IfcPropertySetDefinitionSet {
        required multi link IfcPropertySetDefinitionSet -> IfcPropertySetDefinition;
    }

    type IfcRadioActivityMeasure {
        required property `IfcRadioActivityMeasure` -> float64;
    }

    type IfcRatioMeasure {
        required property `IfcRatioMeasure` -> float64;
    }

    type IfcReal {
        required property `IfcReal` -> float64;
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

    type IfcSectionalAreaIntegralMeasure {
        required property `IfcSectionalAreaIntegralMeasure` -> float64;
    }

    type IfcSectionModulusMeasure {
        required property `IfcSectionModulusMeasure` -> float64;
    }

    type IfcShearModulusMeasure {
        required property `IfcShearModulusMeasure` -> float64;
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

    type IfcSpecularExponent {
        required property `IfcSpecularExponent` -> float64;
    }

    type IfcSpecularRoughness {
        required property `IfcSpecularRoughness` -> float64;
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

    type IfcTextAlignment {
        required property `IfcTextAlignment` -> str;
    }

    type IfcTextDecoration {
        required property `IfcTextDecoration` -> str;
    }

    type IfcTextFontName {
        required property `IfcTextFontName` -> str;
    }

    type IfcTextTransformation {
        required property `IfcTextTransformation` -> str;
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

    type IfcURIReference {
        required property `IfcURIReference` -> str;
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

    type IfcWarpingConstantMeasure {
        required property `IfcWarpingConstantMeasure` -> float64;
    }

    type IfcWarpingMomentMeasure {
        required property `IfcWarpingMomentMeasure` -> float64;
    }

    type IfcActionRequest extending IfcControl {
        property Status -> str;
        property LongDescription -> str;
        required property PredefinedType -> str {
            constraint one_of ('EMAIL','FAX','NOTDEFINED','PHONE','POST','USERDEFINED','VERBAL');
        };
    }

    type IfcActor extending IfcObject {
        required link TheActor -> IfcOrganization | IfcPerson | IfcPersonAndOrganization;
    }

    type IfcActorRole {
        property UserDefinedRole -> str;
        property Description -> str;
        required property Role -> str {
            constraint one_of ('ARCHITECT','BUILDINGOPERATOR','BUILDINGOWNER','CIVILENGINEER','CLIENT','COMMISSIONINGENGINEER','CONSTRUCTIONMANAGER','CONSULTANT','CONTRACTOR','COSTENGINEER','ELECTRICALENGINEER','ENGINEER','FACILITIESMANAGER','FIELDCONSTRUCTIONMANAGER','MANUFACTURER','MECHANICALENGINEER','OWNER','PROJECTMANAGER','RESELLER','STRUCTURALENGINEER','SUBCONTRACTOR','SUPPLIER','USERDEFINED');
        };
    }

    type IfcActuator extending IfcDistributionControlElement {
        required property PredefinedType -> str {
            constraint one_of ('ELECTRICACTUATOR','HANDOPERATEDACTUATOR','HYDRAULICACTUATOR','NOTDEFINED','PNEUMATICACTUATOR','THERMOSTATICACTUATOR','USERDEFINED');
        };
    }

    type IfcActuatorType extending IfcDistributionControlElementType {
        required property PredefinedType -> str {
            constraint one_of ('ELECTRICACTUATOR','HANDOPERATEDACTUATOR','HYDRAULICACTUATOR','NOTDEFINED','PNEUMATICACTUATOR','THERMOSTATICACTUATOR','USERDEFINED');
        };
    }

    abstract type IfcAddress {
        property Description -> str;
        property UserDefinedPurpose -> str;
        required property Purpose -> str {
            constraint one_of ('DISTRIBUTIONPOINT','HOME','OFFICE','SITE','USERDEFINED');
        };
    }

    type IfcAdvancedBrep extending IfcManifoldSolidBrep {
    }

    type IfcAdvancedBrepWithVoids extending IfcAdvancedBrep {
        required multi link Voids -> IfcClosedShell;
    }

    type IfcAdvancedFace extending IfcFaceSurface {
    }

    type IfcAirTerminal extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('DIFFUSER','GRILLE','LOUVRE','NOTDEFINED','REGISTER','USERDEFINED');
        };
    }

    type IfcAirTerminalBox extending IfcFlowController {
        required property PredefinedType -> str {
            constraint one_of ('CONSTANTFLOW','NOTDEFINED','USERDEFINED','VARIABLEFLOWPRESSUREDEPENDANT','VARIABLEFLOWPRESSUREINDEPENDANT');
        };
    }

    type IfcAirTerminalBoxType extending IfcFlowControllerType {
        required property PredefinedType -> str {
            constraint one_of ('CONSTANTFLOW','NOTDEFINED','USERDEFINED','VARIABLEFLOWPRESSUREDEPENDANT','VARIABLEFLOWPRESSUREINDEPENDANT');
        };
    }

    type IfcAirTerminalType extending IfcFlowTerminalType {
        required property PredefinedType -> str {
            constraint one_of ('DIFFUSER','GRILLE','LOUVRE','NOTDEFINED','REGISTER','USERDEFINED');
        };
    }

    type IfcAirToAirHeatRecovery extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('FIXEDPLATECOUNTERFLOWEXCHANGER','FIXEDPLATECROSSFLOWEXCHANGER','FIXEDPLATEPARALLELFLOWEXCHANGER','HEATPIPE','NOTDEFINED','ROTARYWHEEL','RUNAROUNDCOILLOOP','THERMOSIPHONCOILTYPEHEATEXCHANGERS','THERMOSIPHONSEALEDTUBEHEATEXCHANGERS','TWINTOWERENTHALPYRECOVERYLOOPS','USERDEFINED');
        };
    }

    type IfcAirToAirHeatRecoveryType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('FIXEDPLATECOUNTERFLOWEXCHANGER','FIXEDPLATECROSSFLOWEXCHANGER','FIXEDPLATEPARALLELFLOWEXCHANGER','HEATPIPE','NOTDEFINED','ROTARYWHEEL','RUNAROUNDCOILLOOP','THERMOSIPHONCOILTYPEHEATEXCHANGERS','THERMOSIPHONSEALEDTUBEHEATEXCHANGERS','TWINTOWERENTHALPYRECOVERYLOOPS','USERDEFINED');
        };
    }

    type IfcAlarm extending IfcDistributionControlElement {
        required property PredefinedType -> str {
            constraint one_of ('BELL','BREAKGLASSBUTTON','LIGHT','MANUALPULLBOX','NOTDEFINED','SIREN','USERDEFINED','WHISTLE');
        };
    }

    type IfcAlarmType extending IfcDistributionControlElementType {
        required property PredefinedType -> str {
            constraint one_of ('BELL','BREAKGLASSBUTTON','LIGHT','MANUALPULLBOX','NOTDEFINED','SIREN','USERDEFINED','WHISTLE');
        };
    }

    type IfcAlignment extending IfcLinearPositioningElement {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcAlignment2DHorizontal extending IfcGeometricRepresentationItem {
        property StartDistAlong -> float64;
        required multi link Segments -> IfcAlignment2DHorizontalSegment;
    }

    type IfcAlignment2DHorizontalSegment extending IfcAlignment2DSegment {
        required link CurveGeometry -> IfcCurveSegment2D;
    }

    abstract type IfcAlignment2DSegment extending IfcGeometricRepresentationItem {
        property TangentialContinuity -> bool;
        property StartTag -> str;
        property EndTag -> str;
    }

    type IfcAlignment2DVerSegCircularArc extending IfcAlignment2DVerticalSegment {
        required property Radius -> float64;
        required property IsConvex -> bool;
    }

    type IfcAlignment2DVerSegLine extending IfcAlignment2DVerticalSegment {
    }

    type IfcAlignment2DVerSegParabolicArc extending IfcAlignment2DVerticalSegment {
        required property ParabolaConstant -> float64;
        required property IsConvex -> bool;
    }

    type IfcAlignment2DVertical extending IfcGeometricRepresentationItem {
        required multi link Segments -> IfcAlignment2DVerticalSegment;
    }

    abstract type IfcAlignment2DVerticalSegment extending IfcAlignment2DSegment {
        required property StartDistAlong -> float64;
        required property HorizontalLength -> float64;
        required property StartHeight -> float64;
        required property StartGradient -> float64;
    }

    type IfcAlignmentCurve extending IfcBoundedCurve {
        property Tag -> str;
        required link Horizontal -> IfcAlignment2DHorizontal;
        link Vertical -> IfcAlignment2DVertical;
    }

    type IfcAnnotation extending IfcProduct {
    }

    type IfcAnnotationFillArea extending IfcGeometricRepresentationItem {
        required link OuterBoundary -> IfcCurve;
        multi link InnerBoundaries -> IfcCurve;
    }

    type IfcApplication {
        required property Version -> str;
        required property ApplicationFullName -> str;
        required property ApplicationIdentifier -> str;
        required link ApplicationDeveloper -> IfcOrganization;
    }

    type IfcAppliedValue {
        property Name -> str;
        property Description -> str;
        property ApplicableDate -> str;
        property FixedUntilDate -> str;
        property Category -> str;
        property Condition -> str;
        required property ArithmeticOperator -> str {
            constraint one_of ('ADD','DIVIDE','MULTIPLY','SUBTRACT');
        };
        link AppliedValue -> IfcMeasureWithUnit | IfcReference | IfcAbsorbedDoseMeasure | IfcAccelerationMeasure | IfcAngularVelocityMeasure | IfcAreaDensityMeasure | IfcCompoundPlaneAngleMeasure | IfcCurvatureMeasure | IfcDoseEquivalentMeasure | IfcDynamicViscosityMeasure | IfcElectricCapacitanceMeasure | IfcElectricChargeMeasure | IfcElectricConductanceMeasure | IfcElectricResistanceMeasure | IfcElectricVoltageMeasure | IfcEnergyMeasure | IfcForceMeasure | IfcFrequencyMeasure | IfcHeatFluxDensityMeasure | IfcHeatingValueMeasure | IfcIlluminanceMeasure | IfcInductanceMeasure | IfcIntegerCountRateMeasure | IfcIonConcentrationMeasure | IfcIsothermalMoistureCapacityMeasure | IfcKinematicViscosityMeasure | IfcLinearForceMeasure | IfcLinearMomentMeasure | IfcLinearStiffnessMeasure | IfcLinearVelocityMeasure | IfcLuminousFluxMeasure | IfcLuminousIntensityDistributionMeasure | IfcMagneticFluxDensityMeasure | IfcMagneticFluxMeasure | IfcMassDensityMeasure | IfcMassFlowRateMeasure | IfcMassPerLengthMeasure | IfcModulusOfElasticityMeasure | IfcModulusOfLinearSubgradeReactionMeasure | IfcModulusOfRotationalSubgradeReactionMeasure | IfcModulusOfSubgradeReactionMeasure | IfcMoistureDiffusivityMeasure | IfcMolecularWeightMeasure | IfcMomentOfInertiaMeasure | IfcMonetaryMeasure | IfcPHMeasure | IfcPlanarForceMeasure | IfcPowerMeasure | IfcPressureMeasure | IfcRadioActivityMeasure | IfcRotationalFrequencyMeasure | IfcRotationalMassMeasure | IfcRotationalStiffnessMeasure | IfcSectionModulusMeasure | IfcSectionalAreaIntegralMeasure | IfcShearModulusMeasure | IfcSoundPowerLevelMeasure | IfcSoundPowerMeasure | IfcSoundPressureLevelMeasure | IfcSoundPressureMeasure | IfcSpecificHeatCapacityMeasure | IfcTemperatureGradientMeasure | IfcTemperatureRateOfChangeMeasure | IfcThermalAdmittanceMeasure | IfcThermalConductivityMeasure | IfcThermalExpansionCoefficientMeasure | IfcThermalResistanceMeasure | IfcThermalTransmittanceMeasure | IfcTorqueMeasure | IfcVaporPermeabilityMeasure | IfcVolumetricFlowRateMeasure | IfcWarpingConstantMeasure | IfcWarpingMomentMeasure | IfcAmountOfSubstanceMeasure | IfcAreaMeasure | IfcComplexNumber | IfcContextDependentMeasure | IfcCountMeasure | IfcDescriptiveMeasure | IfcElectricCurrentMeasure | IfcLengthMeasure | IfcLuminousIntensityMeasure | IfcMassMeasure | IfcNonNegativeLengthMeasure | IfcNormalisedRatioMeasure | IfcNumericMeasure | IfcParameterValue | IfcPlaneAngleMeasure | IfcPositiveLengthMeasure | IfcPositivePlaneAngleMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure | IfcSolidAngleMeasure | IfcThermodynamicTemperatureMeasure | IfcTimeMeasure | IfcVolumeMeasure | IfcBinary | IfcBoolean | IfcDate | IfcDateTime | IfcDuration | IfcIdentifier | IfcInteger | IfcLabel | IfcLogical | IfcPositiveInteger | IfcReal | IfcText | IfcTime | IfcTimeStamp;
        link UnitBasis -> IfcMeasureWithUnit;
        multi link Components -> IfcAppliedValue;
    }

    type IfcApproval {
        property Identifier -> str;
        property Name -> str;
        property Description -> str;
        property TimeOfApproval -> str;
        property Status -> str;
        property Level -> str;
        property Qualifier -> str;
        link RequestingApproval -> IfcOrganization | IfcPerson | IfcPersonAndOrganization;
        link GivingApproval -> IfcOrganization | IfcPerson | IfcPersonAndOrganization;
    }

    type IfcApprovalRelationship extending IfcResourceLevelRelationship {
        required link RelatingApproval -> IfcApproval;
        required multi link RelatedApprovals -> IfcApproval;
    }

    type IfcArbitraryClosedProfileDef extending IfcProfileDef {
        required link OuterCurve -> IfcCurve;
    }

    type IfcArbitraryOpenProfileDef extending IfcProfileDef {
        required link Curve -> IfcBoundedCurve;
    }

    type IfcArbitraryProfileDefWithVoids extending IfcArbitraryClosedProfileDef {
        required multi link InnerCurves -> IfcCurve;
    }

    type IfcAsset extending IfcGroup {
        property Identification -> str;
        property IncorporationDate -> str;
        link OriginalValue -> IfcCostValue;
        link CurrentValue -> IfcCostValue;
        link TotalReplacementCost -> IfcCostValue;
        link Owner -> IfcOrganization | IfcPerson | IfcPersonAndOrganization;
        link User -> IfcOrganization | IfcPerson | IfcPersonAndOrganization;
        link ResponsiblePerson -> IfcPerson;
        link DepreciatedValue -> IfcCostValue;
    }

    type IfcAsymmetricIShapeProfileDef extending IfcParameterizedProfileDef {
        required property BottomFlangeWidth -> float64;
        required property OverallDepth -> float64;
        required property WebThickness -> float64;
        required property BottomFlangeThickness -> float64;
        property BottomFlangeFilletRadius -> float64;
        required property TopFlangeWidth -> float64;
        property TopFlangeThickness -> float64;
        property TopFlangeFilletRadius -> float64;
        property BottomFlangeEdgeRadius -> float64;
        property BottomFlangeSlope -> float64;
        property TopFlangeEdgeRadius -> float64;
        property TopFlangeSlope -> float64;
    }

    type IfcAudioVisualAppliance extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('AMPLIFIER','CAMERA','DISPLAY','MICROPHONE','NOTDEFINED','PLAYER','PROJECTOR','RECEIVER','SPEAKER','SWITCHER','TELEPHONE','TUNER','USERDEFINED');
        };
    }

    type IfcAudioVisualApplianceType extending IfcFlowTerminalType {
        required property PredefinedType -> str {
            constraint one_of ('AMPLIFIER','CAMERA','DISPLAY','MICROPHONE','NOTDEFINED','PLAYER','PROJECTOR','RECEIVER','SPEAKER','SWITCHER','TELEPHONE','TUNER','USERDEFINED');
        };
    }

    type IfcAxis1Placement extending IfcPlacement {
        link Axis -> IfcDirection;
    }

    type IfcAxis2Placement2D extending IfcPlacement {
        link RefDirection -> IfcDirection;
    }

    type IfcAxis2Placement3D extending IfcPlacement {
        link Axis -> IfcDirection;
        link RefDirection -> IfcDirection;
    }

    type IfcBeam extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('BEAM','HOLLOWCORE','JOIST','LINTEL','NOTDEFINED','SPANDREL','T_BEAM','USERDEFINED');
        };
    }

    type IfcBeamStandardCase extending IfcBeam {
    }

    type IfcBeamType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('BEAM','HOLLOWCORE','JOIST','LINTEL','NOTDEFINED','SPANDREL','T_BEAM','USERDEFINED');
        };
    }

    type IfcBlobTexture extending IfcSurfaceTexture {
        required property RasterFormat -> str;
        required property RasterCode -> bytes;
    }

    type IfcBlock extending IfcCsgPrimitive3D {
        required property XLength -> float64;
        required property YLength -> float64;
        required property ZLength -> float64;
    }

    type IfcBoiler extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','STEAM','USERDEFINED','WATER');
        };
    }

    type IfcBoilerType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','STEAM','USERDEFINED','WATER');
        };
    }

    type IfcBooleanClippingResult extending IfcBooleanResult {
    }

    type IfcBooleanResult extending IfcGeometricRepresentationItem {
        required property Operator -> str {
            constraint one_of ('DIFFERENCE','INTERSECTION','UNION');
        };
        required link FirstOperand -> IfcBooleanResult | IfcCsgPrimitive3D | IfcHalfSpaceSolid | IfcSolidModel | IfcTessellatedFaceSet;
        required link SecondOperand -> IfcBooleanResult | IfcCsgPrimitive3D | IfcHalfSpaceSolid | IfcSolidModel | IfcTessellatedFaceSet;
    }

    abstract type IfcBoundaryCondition {
        property Name -> str;
    }

    type IfcBoundaryCurve extending IfcCompositeCurveOnSurface {
    }

    type IfcBoundaryEdgeCondition extending IfcBoundaryCondition {
        link TranslationalStiffnessByLengthX -> IfcBoolean | IfcModulusOfLinearSubgradeReactionMeasure;
        link TranslationalStiffnessByLengthY -> IfcBoolean | IfcModulusOfLinearSubgradeReactionMeasure;
        link TranslationalStiffnessByLengthZ -> IfcBoolean | IfcModulusOfLinearSubgradeReactionMeasure;
        link RotationalStiffnessByLengthX -> IfcBoolean | IfcModulusOfRotationalSubgradeReactionMeasure;
        link RotationalStiffnessByLengthY -> IfcBoolean | IfcModulusOfRotationalSubgradeReactionMeasure;
        link RotationalStiffnessByLengthZ -> IfcBoolean | IfcModulusOfRotationalSubgradeReactionMeasure;
    }

    type IfcBoundaryFaceCondition extending IfcBoundaryCondition {
        link TranslationalStiffnessByAreaX -> IfcBoolean | IfcModulusOfSubgradeReactionMeasure;
        link TranslationalStiffnessByAreaY -> IfcBoolean | IfcModulusOfSubgradeReactionMeasure;
        link TranslationalStiffnessByAreaZ -> IfcBoolean | IfcModulusOfSubgradeReactionMeasure;
    }

    type IfcBoundaryNodeCondition extending IfcBoundaryCondition {
        link TranslationalStiffnessX -> IfcBoolean | IfcLinearStiffnessMeasure;
        link TranslationalStiffnessY -> IfcBoolean | IfcLinearStiffnessMeasure;
        link TranslationalStiffnessZ -> IfcBoolean | IfcLinearStiffnessMeasure;
        link RotationalStiffnessX -> IfcBoolean | IfcRotationalStiffnessMeasure;
        link RotationalStiffnessY -> IfcBoolean | IfcRotationalStiffnessMeasure;
        link RotationalStiffnessZ -> IfcBoolean | IfcRotationalStiffnessMeasure;
    }

    type IfcBoundaryNodeConditionWarping extending IfcBoundaryNodeCondition {
        link WarpingStiffness -> IfcBoolean | IfcWarpingMomentMeasure;
    }

    abstract type IfcBoundedCurve extending IfcCurve {
    }

    abstract type IfcBoundedSurface extending IfcSurface {
    }

    type IfcBoundingBox extending IfcGeometricRepresentationItem {
        required property XDim -> float64;
        required property YDim -> float64;
        required property ZDim -> float64;
        required link Corner -> IfcCartesianPoint;
    }

    type IfcBoxedHalfSpace extending IfcHalfSpaceSolid {
        required link Enclosure -> IfcBoundingBox;
    }

    abstract type IfcBSplineCurve extending IfcBoundedCurve {
        required property Degree -> int64;
        required property ClosedCurve -> bool;
        required property SelfIntersect -> bool;
        required property CurveForm -> str {
            constraint one_of ('CIRCULAR_ARC','ELLIPTIC_ARC','HYPERBOLIC_ARC','PARABOLIC_ARC','POLYLINE_FORM','UNSPECIFIED');
        };
        required multi link ControlPointsList -> IfcCartesianPoint;
    }

    type IfcBSplineCurveWithKnots extending IfcBSplineCurve {
        required property KnotMultiplicities -> tuple<int64>;
        required property Knots -> tuple<float64>;
        required property KnotSpec -> str {
            constraint one_of ('PIECEWISE_BEZIER_KNOTS','QUASI_UNIFORM_KNOTS','UNIFORM_KNOTS','UNSPECIFIED');
        };
    }

    abstract type IfcBSplineSurface extending IfcBoundedSurface {
        required property UDegree -> int64;
        required property VDegree -> int64;
        required property UClosed -> bool;
        required property VClosed -> bool;
        required property SelfIntersect -> bool;
        required property SurfaceForm -> str {
            constraint one_of ('CONICAL_SURF','CYLINDRICAL_SURF','GENERALISED_CONE','PLANE_SURF','QUADRIC_SURF','RULED_SURF','SPHERICAL_SURF','SURF_OF_LINEAR_EXTRUSION','SURF_OF_REVOLUTION','TOROIDAL_SURF','UNSPECIFIED');
        };
        required multi link ControlPointsList -> List_of_IfcCartesianPoint;
    }

    type IfcBSplineSurfaceWithKnots extending IfcBSplineSurface {
        required property UMultiplicities -> tuple<int64>;
        required property VMultiplicities -> tuple<int64>;
        required property UKnots -> tuple<float64>;
        required property VKnots -> tuple<float64>;
        required property KnotSpec -> str {
            constraint one_of ('PIECEWISE_BEZIER_KNOTS','QUASI_UNIFORM_KNOTS','UNIFORM_KNOTS','UNSPECIFIED');
        };
    }

    type IfcBuilding extending IfcSpatialStructureElement {
        property ElevationOfRefHeight -> float64;
        property ElevationOfTerrain -> float64;
        link BuildingAddress -> IfcPostalAddress;
    }

    abstract type IfcBuildingElement extending IfcElement {
    }

    type IfcBuildingElementPart extending IfcElementComponent {
        required property PredefinedType -> str {
            constraint one_of ('INSULATION','NOTDEFINED','PRECASTPANEL','USERDEFINED');
        };
    }

    type IfcBuildingElementPartType extending IfcElementComponentType {
        required property PredefinedType -> str {
            constraint one_of ('INSULATION','NOTDEFINED','PRECASTPANEL','USERDEFINED');
        };
    }

    type IfcBuildingElementProxy extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('COMPLEX','ELEMENT','NOTDEFINED','PARTIAL','PROVISIONFORSPACE','PROVISIONFORVOID','USERDEFINED');
        };
    }

    type IfcBuildingElementProxyType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('COMPLEX','ELEMENT','NOTDEFINED','PARTIAL','PROVISIONFORSPACE','PROVISIONFORVOID','USERDEFINED');
        };
    }

    abstract type IfcBuildingElementType extending IfcElementType {
    }

    type IfcBuildingStorey extending IfcSpatialStructureElement {
        property Elevation -> float64;
    }

    type IfcBuildingSystem extending IfcSystem {
        property LongName -> str;
        required property PredefinedType -> str {
            constraint one_of ('FENESTRATION','FOUNDATION','LOADBEARING','NOTDEFINED','OUTERSHELL','SHADING','TRANSPORT','USERDEFINED');
        };
    }

    type IfcBurner extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcBurnerType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcCableCarrierFitting extending IfcFlowFitting {
        required property PredefinedType -> str {
            constraint one_of ('BEND','CROSS','NOTDEFINED','REDUCER','TEE','USERDEFINED');
        };
    }

    type IfcCableCarrierFittingType extending IfcFlowFittingType {
        required property PredefinedType -> str {
            constraint one_of ('BEND','CROSS','NOTDEFINED','REDUCER','TEE','USERDEFINED');
        };
    }

    type IfcCableCarrierSegment extending IfcFlowSegment {
        required property PredefinedType -> str {
            constraint one_of ('CABLELADDERSEGMENT','CABLETRAYSEGMENT','CABLETRUNKINGSEGMENT','CONDUITSEGMENT','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcCableCarrierSegmentType extending IfcFlowSegmentType {
        required property PredefinedType -> str {
            constraint one_of ('CABLELADDERSEGMENT','CABLETRAYSEGMENT','CABLETRUNKINGSEGMENT','CONDUITSEGMENT','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcCableFitting extending IfcFlowFitting {
        required property PredefinedType -> str {
            constraint one_of ('CONNECTOR','ENTRY','EXIT','JUNCTION','NOTDEFINED','TRANSITION','USERDEFINED');
        };
    }

    type IfcCableFittingType extending IfcFlowFittingType {
        required property PredefinedType -> str {
            constraint one_of ('CONNECTOR','ENTRY','EXIT','JUNCTION','NOTDEFINED','TRANSITION','USERDEFINED');
        };
    }

    type IfcCableSegment extending IfcFlowSegment {
        required property PredefinedType -> str {
            constraint one_of ('BUSBARSEGMENT','CABLESEGMENT','CONDUCTORSEGMENT','CORESEGMENT','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcCableSegmentType extending IfcFlowSegmentType {
        required property PredefinedType -> str {
            constraint one_of ('BUSBARSEGMENT','CABLESEGMENT','CONDUCTORSEGMENT','CORESEGMENT','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcCartesianPoint extending IfcPoint {
        required property Coordinates -> array<float64>{
            constraint expression on (len(__subject__) = 1 or len(__subject__) = 2 or len(__subject__) = 3)
        };
    }

    abstract type IfcCartesianPointList extending IfcGeometricRepresentationItem {
    }

    type IfcCartesianPointList2D extending IfcCartesianPointList {
        required property CoordList -> array<tuple<float64,float64>>;
        property TagList -> tuple<str>;
    }

    type IfcCartesianPointList3D extending IfcCartesianPointList {
        required property CoordList -> array<tuple<float64,float64,float64>>;
        property TagList -> tuple<str>;
    }

    abstract type IfcCartesianTransformationOperator extending IfcGeometricRepresentationItem {
        property Scale -> float64;
        link Axis1 -> IfcDirection;
        link Axis2 -> IfcDirection;
        required link LocalOrigin -> IfcCartesianPoint;
    }

    type IfcCartesianTransformationOperator2D extending IfcCartesianTransformationOperator {
    }

    type IfcCartesianTransformationOperator2DnonUniform extending IfcCartesianTransformationOperator2D {
        property Scale2 -> float64;
    }

    type IfcCartesianTransformationOperator3D extending IfcCartesianTransformationOperator {
        link Axis3 -> IfcDirection;
    }

    type IfcCartesianTransformationOperator3DnonUniform extending IfcCartesianTransformationOperator3D {
        property Scale2 -> float64;
        property Scale3 -> float64;
    }

    type IfcCenterLineProfileDef extending IfcArbitraryOpenProfileDef {
        required property Thickness -> float64;
    }

    type IfcChiller extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('AIRCOOLED','HEATRECOVERY','NOTDEFINED','USERDEFINED','WATERCOOLED');
        };
    }

    type IfcChillerType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('AIRCOOLED','HEATRECOVERY','NOTDEFINED','USERDEFINED','WATERCOOLED');
        };
    }

    type IfcChimney extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcChimneyType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcCircle extending IfcConic {
        required property Radius -> float64;
    }

    type IfcCircleHollowProfileDef extending IfcCircleProfileDef {
        required property WallThickness -> float64;
    }

    type IfcCircleProfileDef extending IfcParameterizedProfileDef {
        required property Radius -> float64;
    }

    type IfcCircularArcSegment2D extending IfcCurveSegment2D {
        required property Radius -> float64;
        required property IsCCW -> bool;
    }

    type IfcCivilElement extending IfcElement {
    }

    type IfcCivilElementType extending IfcElementType {
    }

    type IfcClassification extending IfcExternalInformation {
        property Source -> str;
        property Edition -> str;
        property EditionDate -> str;
        required property Name -> str;
        property Description -> str;
        property Location -> str;
        property ReferenceTokens -> tuple<str>;
    }

    type IfcClassificationReference extending IfcExternalReference {
        property Description -> str;
        property Sort -> str;
        link ReferencedSource -> IfcClassification | IfcClassificationReference;
    }

    type IfcClosedShell extending IfcConnectedFaceSet {
    }

    type IfcCoil extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('DXCOOLINGCOIL','ELECTRICHEATINGCOIL','GASHEATINGCOIL','HYDRONICCOIL','NOTDEFINED','STEAMHEATINGCOIL','USERDEFINED','WATERCOOLINGCOIL','WATERHEATINGCOIL');
        };
    }

    type IfcCoilType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('DXCOOLINGCOIL','ELECTRICHEATINGCOIL','GASHEATINGCOIL','HYDRONICCOIL','NOTDEFINED','STEAMHEATINGCOIL','USERDEFINED','WATERCOOLINGCOIL','WATERHEATINGCOIL');
        };
    }

    type IfcColourRgb extending IfcColourSpecification {
        required property Red -> float64;
        required property Green -> float64;
        required property Blue -> float64;
    }

    type IfcColourRgbList extending IfcPresentationItem {
        required property ColourList -> array<tuple<float64,float64,float64>>;
    }

    abstract type IfcColourSpecification extending IfcPresentationItem {
        property Name -> str;
    }

    type IfcColumn extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('COLUMN','NOTDEFINED','PILASTER','USERDEFINED');
        };
    }

    type IfcColumnStandardCase extending IfcColumn {
    }

    type IfcColumnType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('COLUMN','NOTDEFINED','PILASTER','USERDEFINED');
        };
    }

    type IfcCommunicationsAppliance extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('ANTENNA','COMPUTER','FAX','GATEWAY','MODEM','NETWORKAPPLIANCE','NETWORKBRIDGE','NETWORKHUB','NOTDEFINED','PRINTER','REPEATER','ROUTER','SCANNER','USERDEFINED');
        };
    }

    type IfcCommunicationsApplianceType extending IfcFlowTerminalType {
        required property PredefinedType -> str {
            constraint one_of ('ANTENNA','COMPUTER','FAX','GATEWAY','MODEM','NETWORKAPPLIANCE','NETWORKBRIDGE','NETWORKHUB','NOTDEFINED','PRINTER','REPEATER','ROUTER','SCANNER','USERDEFINED');
        };
    }

    type IfcComplexProperty extending IfcProperty {
        required property UsageName -> str;
        required multi link HasProperties -> IfcProperty;
    }

    type IfcComplexPropertyTemplate extending IfcPropertyTemplate {
        property UsageName -> str;
        required property TemplateType -> str {
            constraint one_of ('P_COMPLEX','Q_COMPLEX');
        };
        multi link HasPropertyTemplates -> IfcPropertyTemplate;
    }

    type IfcCompositeCurve extending IfcBoundedCurve {
        required property SelfIntersect -> bool;
        required multi link Segments -> IfcCompositeCurveSegment;
    }

    type IfcCompositeCurveOnSurface extending IfcCompositeCurve {
    }

    type IfcCompositeCurveSegment extending IfcGeometricRepresentationItem {
        required property SameSense -> bool;
        required property Transition -> str {
            constraint one_of ('CONTINUOUS','CONTSAMEGRADIENT','CONTSAMEGRADIENTSAMECURVATURE','DISCONTINUOUS');
        };
        required link ParentCurve -> IfcCurve;
    }

    type IfcCompositeProfileDef extending IfcProfileDef {
        property Label -> str;
        required multi link Profiles -> IfcProfileDef;
    }

    type IfcCompressor extending IfcFlowMovingDevice {
        required property PredefinedType -> str {
            constraint one_of ('BOOSTER','DYNAMIC','HERMETIC','NOTDEFINED','OPENTYPE','RECIPROCATING','ROLLINGPISTON','ROTARY','ROTARYVANE','SCROLL','SEMIHERMETIC','SINGLESCREW','SINGLESTAGE','TROCHOIDAL','TWINSCREW','USERDEFINED','WELDEDSHELLHERMETIC');
        };
    }

    type IfcCompressorType extending IfcFlowMovingDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('BOOSTER','DYNAMIC','HERMETIC','NOTDEFINED','OPENTYPE','RECIPROCATING','ROLLINGPISTON','ROTARY','ROTARYVANE','SCROLL','SEMIHERMETIC','SINGLESCREW','SINGLESTAGE','TROCHOIDAL','TWINSCREW','USERDEFINED','WELDEDSHELLHERMETIC');
        };
    }

    type IfcCondenser extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('AIRCOOLED','EVAPORATIVECOOLED','NOTDEFINED','USERDEFINED','WATERCOOLED','WATERCOOLEDBRAZEDPLATE','WATERCOOLEDSHELLCOIL','WATERCOOLEDSHELLTUBE','WATERCOOLEDTUBEINTUBE');
        };
    }

    type IfcCondenserType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('AIRCOOLED','EVAPORATIVECOOLED','NOTDEFINED','USERDEFINED','WATERCOOLED','WATERCOOLEDBRAZEDPLATE','WATERCOOLEDSHELLCOIL','WATERCOOLEDSHELLTUBE','WATERCOOLEDTUBEINTUBE');
        };
    }

    abstract type IfcConic extending IfcCurve {
        required link Position -> IfcAxis2Placement2D | IfcAxis2Placement3D;
    }

    type IfcConnectedFaceSet extending IfcTopologicalRepresentationItem {
        required multi link CfsFaces -> IfcFace;
    }

    type IfcConnectionCurveGeometry extending IfcConnectionGeometry {
        required link CurveOnRelatingElement -> IfcBoundedCurve | IfcEdgeCurve;
        link CurveOnRelatedElement -> IfcBoundedCurve | IfcEdgeCurve;
    }

    abstract type IfcConnectionGeometry {
    }

    type IfcConnectionPointEccentricity extending IfcConnectionPointGeometry {
        property EccentricityInX -> float64;
        property EccentricityInY -> float64;
        property EccentricityInZ -> float64;
    }

    type IfcConnectionPointGeometry extending IfcConnectionGeometry {
        required link PointOnRelatingElement -> IfcPoint | IfcVertexPoint;
        link PointOnRelatedElement -> IfcPoint | IfcVertexPoint;
    }

    type IfcConnectionSurfaceGeometry extending IfcConnectionGeometry {
        required link SurfaceOnRelatingElement -> IfcFaceBasedSurfaceModel | IfcFaceSurface | IfcSurface;
        link SurfaceOnRelatedElement -> IfcFaceBasedSurfaceModel | IfcFaceSurface | IfcSurface;
    }

    type IfcConnectionVolumeGeometry extending IfcConnectionGeometry {
        required link VolumeOnRelatingElement -> IfcClosedShell | IfcSolidModel;
        link VolumeOnRelatedElement -> IfcClosedShell | IfcSolidModel;
    }

    abstract type IfcConstraint {
        required property Name -> str;
        property Description -> str;
        property ConstraintSource -> str;
        property CreationTime -> str;
        property UserDefinedGrade -> str;
        required property ConstraintGrade -> str {
            constraint one_of ('ADVISORY','HARD','NOTDEFINED','SOFT','USERDEFINED');
        };
        link CreatingActor -> IfcOrganization | IfcPerson | IfcPersonAndOrganization;
    }

    type IfcConstructionEquipmentResource extending IfcConstructionResource {
        required property PredefinedType -> str {
            constraint one_of ('DEMOLISHING','EARTHMOVING','ERECTING','HEATING','LIGHTING','NOTDEFINED','PAVING','PUMPING','TRANSPORTING','USERDEFINED');
        };
    }

    type IfcConstructionEquipmentResourceType extending IfcConstructionResourceType {
        required property PredefinedType -> str {
            constraint one_of ('DEMOLISHING','EARTHMOVING','ERECTING','HEATING','LIGHTING','NOTDEFINED','PAVING','PUMPING','TRANSPORTING','USERDEFINED');
        };
    }

    type IfcConstructionMaterialResource extending IfcConstructionResource {
        required property PredefinedType -> str {
            constraint one_of ('AGGREGATES','CONCRETE','DRYWALL','FUEL','GYPSUM','MASONRY','METAL','NOTDEFINED','PLASTIC','USERDEFINED','WOOD');
        };
    }

    type IfcConstructionMaterialResourceType extending IfcConstructionResourceType {
        required property PredefinedType -> str {
            constraint one_of ('AGGREGATES','CONCRETE','DRYWALL','FUEL','GYPSUM','MASONRY','METAL','NOTDEFINED','PLASTIC','USERDEFINED','WOOD');
        };
    }

    type IfcConstructionProductResource extending IfcConstructionResource {
        required property PredefinedType -> str {
            constraint one_of ('ASSEMBLY','FORMWORK','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcConstructionProductResourceType extending IfcConstructionResourceType {
        required property PredefinedType -> str {
            constraint one_of ('ASSEMBLY','FORMWORK','NOTDEFINED','USERDEFINED');
        };
    }

    abstract type IfcConstructionResource extending IfcResource {
        link Usage -> IfcResourceTime;
        multi link BaseCosts -> IfcAppliedValue;
        link BaseQuantity -> IfcPhysicalQuantity;
    }

    abstract type IfcConstructionResourceType extending IfcTypeResource {
        multi link BaseCosts -> IfcAppliedValue;
        link BaseQuantity -> IfcPhysicalQuantity;
    }

    abstract type IfcContext extending IfcObjectDefinition {
        property ObjectType -> str;
        property LongName -> str;
        property Phase -> str;
        multi link RepresentationContexts -> IfcRepresentationContext;
        link UnitsInContext -> IfcUnitAssignment;
    }

    type IfcContextDependentUnit extending IfcNamedUnit {
        required property Name -> str;
    }

    abstract type IfcControl extending IfcObject {
        property Identification -> str;
    }

    type IfcController extending IfcDistributionControlElement {
        required property PredefinedType -> str {
            constraint one_of ('FLOATING','MULTIPOSITION','NOTDEFINED','PROGRAMMABLE','PROPORTIONAL','TWOPOSITION','USERDEFINED');
        };
    }

    type IfcControllerType extending IfcDistributionControlElementType {
        required property PredefinedType -> str {
            constraint one_of ('FLOATING','MULTIPOSITION','NOTDEFINED','PROGRAMMABLE','PROPORTIONAL','TWOPOSITION','USERDEFINED');
        };
    }

    type IfcConversionBasedUnit extending IfcNamedUnit {
        required property Name -> str;
        required link ConversionFactor -> IfcMeasureWithUnit;
    }

    type IfcConversionBasedUnitWithOffset extending IfcConversionBasedUnit {
        required property ConversionOffset -> float64;
    }

    type IfcCooledBeam extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('ACTIVE','NOTDEFINED','PASSIVE','USERDEFINED');
        };
    }

    type IfcCooledBeamType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('ACTIVE','NOTDEFINED','PASSIVE','USERDEFINED');
        };
    }

    type IfcCoolingTower extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('MECHANICALFORCEDDRAFT','MECHANICALINDUCEDDRAFT','NATURALDRAFT','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcCoolingTowerType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('MECHANICALFORCEDDRAFT','MECHANICALINDUCEDDRAFT','NATURALDRAFT','NOTDEFINED','USERDEFINED');
        };
    }

    abstract type IfcCoordinateOperation {
        required link SourceCRS -> IfcCoordinateReferenceSystem | IfcGeometricRepresentationContext;
        required link TargetCRS -> IfcCoordinateReferenceSystem;
    }

    abstract type IfcCoordinateReferenceSystem {
        required property Name -> str;
        property Description -> str;
        property GeodeticDatum -> str;
        property VerticalDatum -> str;
    }

    type IfcCostItem extending IfcControl {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
        multi link CostValues -> IfcCostValue;
        multi link CostQuantities -> IfcPhysicalQuantity;
    }

    type IfcCostSchedule extending IfcControl {
        property Status -> str;
        property SubmittedOn -> str;
        property UpdateDate -> str;
        required property PredefinedType -> str {
            constraint one_of ('BUDGET','COSTPLAN','ESTIMATE','NOTDEFINED','PRICEDBILLOFQUANTITIES','SCHEDULEOFRATES','TENDER','UNPRICEDBILLOFQUANTITIES','USERDEFINED');
        };
    }

    type IfcCostValue extending IfcAppliedValue {
    }

    type IfcCovering extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('CEILING','CLADDING','FLOORING','INSULATION','MEMBRANE','MOLDING','NOTDEFINED','ROOFING','SKIRTINGBOARD','SLEEVING','USERDEFINED','WRAPPING');
        };
    }

    type IfcCoveringType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('CEILING','CLADDING','FLOORING','INSULATION','MEMBRANE','MOLDING','NOTDEFINED','ROOFING','SKIRTINGBOARD','SLEEVING','USERDEFINED','WRAPPING');
        };
    }

    type IfcCrewResource extending IfcConstructionResource {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','OFFICE','SITE','USERDEFINED');
        };
    }

    type IfcCrewResourceType extending IfcConstructionResourceType {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','OFFICE','SITE','USERDEFINED');
        };
    }

    abstract type IfcCsgPrimitive3D extending IfcGeometricRepresentationItem {
        required link Position -> IfcAxis2Placement3D;
    }

    type IfcCsgSolid extending IfcSolidModel {
        required link TreeRootExpression -> IfcBooleanResult | IfcCsgPrimitive3D;
    }

    type IfcCShapeProfileDef extending IfcParameterizedProfileDef {
        required property Depth -> float64;
        required property Width -> float64;
        required property WallThickness -> float64;
        required property Girth -> float64;
        property InternalFilletRadius -> float64;
    }

    type IfcCurrencyRelationship extending IfcResourceLevelRelationship {
        required property ExchangeRate -> float64;
        property RateDateTime -> str;
        required link RelatingMonetaryUnit -> IfcMonetaryUnit;
        required link RelatedMonetaryUnit -> IfcMonetaryUnit;
        link RateSource -> IfcLibraryInformation;
    }

    type IfcCurtainWall extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcCurtainWallType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    abstract type IfcCurve extending IfcGeometricRepresentationItem {
    }

    type IfcCurveBoundedPlane extending IfcBoundedSurface {
        required link BasisSurface -> IfcPlane;
        required link OuterBoundary -> IfcCurve;
        required multi link InnerBoundaries -> IfcCurve;
    }

    type IfcCurveBoundedSurface extending IfcBoundedSurface {
        required property ImplicitOuter -> bool;
        required link BasisSurface -> IfcSurface;
        required multi link Boundaries -> IfcBoundaryCurve;
    }

    abstract type IfcCurveSegment2D extending IfcBoundedCurve {
        required property StartDirection -> float64;
        required property SegmentLength -> float64;
        required link StartPoint -> IfcCartesianPoint;
    }

    type IfcCurveStyle extending IfcPresentationStyle {
        property ModelOrDraughting -> bool;
        link CurveFont -> IfcCurveStyleFontAndScaling | IfcCurveStyleFont | IfcPreDefinedCurveFont;
        link CurveWidth -> IfcDescriptiveMeasure | IfcLengthMeasure | IfcNormalisedRatioMeasure | IfcPositiveLengthMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure;
        link CurveColour -> IfcColourSpecification | IfcPreDefinedColour;
    }

    type IfcCurveStyleFont extending IfcPresentationItem {
        property Name -> str;
        required multi link PatternList -> IfcCurveStyleFontPattern;
    }

    type IfcCurveStyleFontAndScaling extending IfcPresentationItem {
        property Name -> str;
        required property CurveFontScaling -> float64;
        required link CurveFont -> IfcCurveStyleFont | IfcPreDefinedCurveFont;
    }

    type IfcCurveStyleFontPattern extending IfcPresentationItem {
        required property VisibleSegmentLength -> float64;
        required property InvisibleSegmentLength -> float64;
    }

    type IfcCylindricalSurface extending IfcElementarySurface {
        required property Radius -> float64;
    }

    type IfcDamper extending IfcFlowController {
        required property PredefinedType -> str {
            constraint one_of ('BACKDRAFTDAMPER','BALANCINGDAMPER','BLASTDAMPER','CONTROLDAMPER','FIREDAMPER','FIRESMOKEDAMPER','FUMEHOODEXHAUST','GRAVITYDAMPER','GRAVITYRELIEFDAMPER','NOTDEFINED','RELIEFDAMPER','SMOKEDAMPER','USERDEFINED');
        };
    }

    type IfcDamperType extending IfcFlowControllerType {
        required property PredefinedType -> str {
            constraint one_of ('BACKDRAFTDAMPER','BALANCINGDAMPER','BLASTDAMPER','CONTROLDAMPER','FIREDAMPER','FIRESMOKEDAMPER','FUMEHOODEXHAUST','GRAVITYDAMPER','GRAVITYRELIEFDAMPER','NOTDEFINED','RELIEFDAMPER','SMOKEDAMPER','USERDEFINED');
        };
    }

    type IfcDerivedProfileDef extending IfcProfileDef {
        property Label -> str;
        required link ParentProfile -> IfcProfileDef;
        link Operator -> IfcCartesianTransformationOperator2D;
    }

    type IfcDerivedUnit {
        property UserDefinedType -> str;
        required property UnitType -> str {
            constraint one_of ('ACCELERATIONUNIT','ANGULARVELOCITYUNIT','AREADENSITYUNIT','COMPOUNDPLANEANGLEUNIT','CURVATUREUNIT','DYNAMICVISCOSITYUNIT','HEATFLUXDENSITYUNIT','HEATINGVALUEUNIT','INTEGERCOUNTRATEUNIT','IONCONCENTRATIONUNIT','ISOTHERMALMOISTURECAPACITYUNIT','KINEMATICVISCOSITYUNIT','LINEARFORCEUNIT','LINEARMOMENTUNIT','LINEARSTIFFNESSUNIT','LINEARVELOCITYUNIT','LUMINOUSINTENSITYDISTRIBUTIONUNIT','MASSDENSITYUNIT','MASSFLOWRATEUNIT','MASSPERLENGTHUNIT','MODULUSOFELASTICITYUNIT','MODULUSOFLINEARSUBGRADEREACTIONUNIT','MODULUSOFROTATIONALSUBGRADEREACTIONUNIT','MODULUSOFSUBGRADEREACTIONUNIT','MOISTUREDIFFUSIVITYUNIT','MOLECULARWEIGHTUNIT','MOMENTOFINERTIAUNIT','PHUNIT','PLANARFORCEUNIT','ROTATIONALFREQUENCYUNIT','ROTATIONALMASSUNIT','ROTATIONALSTIFFNESSUNIT','SECTIONAREAINTEGRALUNIT','SECTIONMODULUSUNIT','SHEARMODULUSUNIT','SOUNDPOWERLEVELUNIT','SOUNDPOWERUNIT','SOUNDPRESSURELEVELUNIT','SOUNDPRESSUREUNIT','SPECIFICHEATCAPACITYUNIT','TEMPERATUREGRADIENTUNIT','TEMPERATURERATEOFCHANGEUNIT','THERMALADMITTANCEUNIT','THERMALCONDUCTANCEUNIT','THERMALEXPANSIONCOEFFICIENTUNIT','THERMALRESISTANCEUNIT','THERMALTRANSMITTANCEUNIT','TORQUEUNIT','USERDEFINED','VAPORPERMEABILITYUNIT','VOLUMETRICFLOWRATEUNIT','WARPINGCONSTANTUNIT','WARPINGMOMENTUNIT');
        };
        required multi link Elements -> IfcDerivedUnitElement;
    }

    type IfcDerivedUnitElement {
        required property Exponent -> int64;
        required link Unit -> IfcNamedUnit;
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

    type IfcDirection extending IfcGeometricRepresentationItem {
        required property DirectionRatios -> array<float64>{
            constraint expression on (len(__subject__) = 2 or len(__subject__) = 3)
        };
    }

    type IfcDiscreteAccessory extending IfcElementComponent {
        required property PredefinedType -> str {
            constraint one_of ('ANCHORPLATE','BRACKET','NOTDEFINED','SHOE','USERDEFINED');
        };
    }

    type IfcDiscreteAccessoryType extending IfcElementComponentType {
        required property PredefinedType -> str {
            constraint one_of ('ANCHORPLATE','BRACKET','NOTDEFINED','SHOE','USERDEFINED');
        };
    }

    type IfcDistanceExpression extending IfcGeometricRepresentationItem {
        required property DistanceAlong -> float64;
        property OffsetLateral -> float64;
        property OffsetVertical -> float64;
        property OffsetLongitudinal -> float64;
        property AlongHorizontal -> bool;
    }

    type IfcDistributionChamberElement extending IfcDistributionFlowElement {
        required property PredefinedType -> str {
            constraint one_of ('FORMEDDUCT','INSPECTIONCHAMBER','INSPECTIONPIT','MANHOLE','METERCHAMBER','NOTDEFINED','SUMP','TRENCH','USERDEFINED','VALVECHAMBER');
        };
    }

    type IfcDistributionChamberElementType extending IfcDistributionFlowElementType {
        required property PredefinedType -> str {
            constraint one_of ('FORMEDDUCT','INSPECTIONCHAMBER','INSPECTIONPIT','MANHOLE','METERCHAMBER','NOTDEFINED','SUMP','TRENCH','USERDEFINED','VALVECHAMBER');
        };
    }

    type IfcDistributionCircuit extending IfcDistributionSystem {
    }

    type IfcDistributionControlElement extending IfcDistributionElement {
    }

    abstract type IfcDistributionControlElementType extending IfcDistributionElementType {
    }

    type IfcDistributionElement extending IfcElement {
    }

    type IfcDistributionElementType extending IfcElementType {
    }

    type IfcDistributionFlowElement extending IfcDistributionElement {
    }

    abstract type IfcDistributionFlowElementType extending IfcDistributionElementType {
    }

    type IfcDistributionPort extending IfcPort {
        required property PredefinedType -> str {
            constraint one_of ('CABLE','CABLECARRIER','DUCT','NOTDEFINED','PIPE','USERDEFINED');
        };
        required property SystemType -> str {
            constraint one_of ('AIRCONDITIONING','AUDIOVISUAL','CHEMICAL','CHILLEDWATER','COMMUNICATION','COMPRESSEDAIR','CONDENSERWATER','CONTROL','CONVEYING','DATA','DISPOSAL','DOMESTICCOLDWATER','DOMESTICHOTWATER','DRAINAGE','EARTHING','ELECTRICAL','ELECTROACOUSTIC','EXHAUST','FIREPROTECTION','FUEL','GAS','HAZARDOUS','HEATING','LIGHTING','LIGHTNINGPROTECTION','MUNICIPALSOLIDWASTE','NOTDEFINED','OIL','OPERATIONAL','POWERGENERATION','RAINWATER','REFRIGERATION','SECURITY','SEWAGE','SIGNAL','STORMWATER','TELEPHONE','TV','USERDEFINED','VACUUM','VENT','VENTILATION','WASTEWATER','WATERSUPPLY');
        };
        required property FlowDirection -> str {
            constraint one_of ('NOTDEFINED','SINK','SOURCE','SOURCEANDSINK');
        };
    }

    type IfcDistributionSystem extending IfcSystem {
        property LongName -> str;
        required property PredefinedType -> str {
            constraint one_of ('AIRCONDITIONING','AUDIOVISUAL','CHEMICAL','CHILLEDWATER','COMMUNICATION','COMPRESSEDAIR','CONDENSERWATER','CONTROL','CONVEYING','DATA','DISPOSAL','DOMESTICCOLDWATER','DOMESTICHOTWATER','DRAINAGE','EARTHING','ELECTRICAL','ELECTROACOUSTIC','EXHAUST','FIREPROTECTION','FUEL','GAS','HAZARDOUS','HEATING','LIGHTING','LIGHTNINGPROTECTION','MUNICIPALSOLIDWASTE','NOTDEFINED','OIL','OPERATIONAL','POWERGENERATION','RAINWATER','REFRIGERATION','SECURITY','SEWAGE','SIGNAL','STORMWATER','TELEPHONE','TV','USERDEFINED','VACUUM','VENT','VENTILATION','WASTEWATER','WATERSUPPLY');
        };
    }

    type IfcDocumentInformation extending IfcExternalInformation {
        required property Identification -> str;
        required property Name -> str;
        property Description -> str;
        property Location -> str;
        property Purpose -> str;
        property IntendedUse -> str;
        property Scope -> str;
        property Revision -> str;
        property CreationTime -> str;
        property LastRevisionTime -> str;
        property ElectronicFormat -> str;
        property ValidFrom -> str;
        property ValidUntil -> str;
        required property Confidentiality -> str {
            constraint one_of ('CONFIDENTIAL','NOTDEFINED','PERSONAL','PUBLIC','RESTRICTED','USERDEFINED');
        };
        required property Status -> str {
            constraint one_of ('DRAFT','FINAL','FINALDRAFT','NOTDEFINED','REVISION');
        };
        link DocumentOwner -> IfcOrganization | IfcPerson | IfcPersonAndOrganization;
        link Editors -> IfcOrganization | IfcPerson | IfcPersonAndOrganization;
    }

    type IfcDocumentInformationRelationship extending IfcResourceLevelRelationship {
        property RelationshipType -> str;
        required link RelatingDocument -> IfcDocumentInformation;
        required multi link RelatedDocuments -> IfcDocumentInformation;
    }

    type IfcDocumentReference extending IfcExternalReference {
        property Description -> str;
        link ReferencedDocument -> IfcDocumentInformation;
    }

    type IfcDoor extending IfcBuildingElement {
        property OverallHeight -> float64;
        property OverallWidth -> float64;
        property UserDefinedOperationType -> str;
        required property PredefinedType -> str {
            constraint one_of ('DOOR','GATE','NOTDEFINED','TRAPDOOR','USERDEFINED');
        };
        required property OperationType -> str {
            constraint one_of ('DOUBLE_DOOR_DOUBLE_SWING','DOUBLE_DOOR_FOLDING','DOUBLE_DOOR_SINGLE_SWING','DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_LEFT','DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_RIGHT','DOUBLE_DOOR_SLIDING','DOUBLE_SWING_LEFT','DOUBLE_SWING_RIGHT','FOLDING_TO_LEFT','FOLDING_TO_RIGHT','NOTDEFINED','REVOLVING','ROLLINGUP','SINGLE_SWING_LEFT','SINGLE_SWING_RIGHT','SLIDING_TO_LEFT','SLIDING_TO_RIGHT','SWING_FIXED_LEFT','SWING_FIXED_RIGHT','USERDEFINED');
        };
    }

    type IfcDoorLiningProperties extending IfcPreDefinedPropertySet {
        property LiningDepth -> float64;
        property LiningThickness -> float64;
        property ThresholdDepth -> float64;
        property ThresholdThickness -> float64;
        property TransomThickness -> float64;
        property TransomOffset -> float64;
        property LiningOffset -> float64;
        property ThresholdOffset -> float64;
        property CasingThickness -> float64;
        property CasingDepth -> float64;
        property LiningToPanelOffsetX -> float64;
        property LiningToPanelOffsetY -> float64;
        link ShapeAspectStyle -> IfcShapeAspect;
    }

    type IfcDoorPanelProperties extending IfcPreDefinedPropertySet {
        property PanelDepth -> float64;
        property PanelWidth -> float64;
        required property PanelOperation -> str {
            constraint one_of ('DOUBLE_ACTING','FIXEDPANEL','FOLDING','NOTDEFINED','REVOLVING','ROLLINGUP','SLIDING','SWINGING','USERDEFINED');
        };
        required property PanelPosition -> str {
            constraint one_of ('LEFT','MIDDLE','NOTDEFINED','RIGHT');
        };
        link ShapeAspectStyle -> IfcShapeAspect;
    }

    type IfcDoorStandardCase extending IfcDoor {
    }

    type IfcDoorStyle extending IfcTypeProduct {
        required property ParameterTakesPrecedence -> bool;
        required property Sizeable -> bool;
        required property ConstructionType -> str {
            constraint one_of ('ALUMINIUM','ALUMINIUM_PLASTIC','ALUMINIUM_WOOD','HIGH_GRADE_STEEL','NOTDEFINED','PLASTIC','STEEL','USERDEFINED','WOOD');
        };
        required property OperationType -> str {
            constraint one_of ('DOUBLE_DOOR_DOUBLE_SWING','DOUBLE_DOOR_FOLDING','DOUBLE_DOOR_SINGLE_SWING','DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_LEFT','DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_RIGHT','DOUBLE_DOOR_SLIDING','DOUBLE_SWING_LEFT','DOUBLE_SWING_RIGHT','FOLDING_TO_LEFT','FOLDING_TO_RIGHT','NOTDEFINED','REVOLVING','ROLLINGUP','SINGLE_SWING_LEFT','SINGLE_SWING_RIGHT','SLIDING_TO_LEFT','SLIDING_TO_RIGHT','USERDEFINED');
        };
    }

    type IfcDoorType extending IfcBuildingElementType {
        property ParameterTakesPrecedence -> bool;
        property UserDefinedOperationType -> str;
        required property PredefinedType -> str {
            constraint one_of ('DOOR','GATE','NOTDEFINED','TRAPDOOR','USERDEFINED');
        };
        required property OperationType -> str {
            constraint one_of ('DOUBLE_DOOR_DOUBLE_SWING','DOUBLE_DOOR_FOLDING','DOUBLE_DOOR_SINGLE_SWING','DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_LEFT','DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_RIGHT','DOUBLE_DOOR_SLIDING','DOUBLE_SWING_LEFT','DOUBLE_SWING_RIGHT','FOLDING_TO_LEFT','FOLDING_TO_RIGHT','NOTDEFINED','REVOLVING','ROLLINGUP','SINGLE_SWING_LEFT','SINGLE_SWING_RIGHT','SLIDING_TO_LEFT','SLIDING_TO_RIGHT','SWING_FIXED_LEFT','SWING_FIXED_RIGHT','USERDEFINED');
        };
    }

    type IfcDraughtingPreDefinedColour extending IfcPreDefinedColour {
    }

    type IfcDraughtingPreDefinedCurveFont extending IfcPreDefinedCurveFont {
    }

    type IfcDuctFitting extending IfcFlowFitting {
        required property PredefinedType -> str {
            constraint one_of ('BEND','CONNECTOR','ENTRY','EXIT','JUNCTION','NOTDEFINED','OBSTRUCTION','TRANSITION','USERDEFINED');
        };
    }

    type IfcDuctFittingType extending IfcFlowFittingType {
        required property PredefinedType -> str {
            constraint one_of ('BEND','CONNECTOR','ENTRY','EXIT','JUNCTION','NOTDEFINED','OBSTRUCTION','TRANSITION','USERDEFINED');
        };
    }

    type IfcDuctSegment extending IfcFlowSegment {
        required property PredefinedType -> str {
            constraint one_of ('FLEXIBLESEGMENT','NOTDEFINED','RIGIDSEGMENT','USERDEFINED');
        };
    }

    type IfcDuctSegmentType extending IfcFlowSegmentType {
        required property PredefinedType -> str {
            constraint one_of ('FLEXIBLESEGMENT','NOTDEFINED','RIGIDSEGMENT','USERDEFINED');
        };
    }

    type IfcDuctSilencer extending IfcFlowTreatmentDevice {
        required property PredefinedType -> str {
            constraint one_of ('FLATOVAL','NOTDEFINED','RECTANGULAR','ROUND','USERDEFINED');
        };
    }

    type IfcDuctSilencerType extending IfcFlowTreatmentDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('FLATOVAL','NOTDEFINED','RECTANGULAR','ROUND','USERDEFINED');
        };
    }

    type IfcEdge extending IfcTopologicalRepresentationItem {
        link EdgeStart -> IfcVertex;
        link EdgeEnd -> IfcVertex;
    }

    type IfcEdgeCurve extending IfcEdge {
        required property SameSense -> bool;
        required link EdgeGeometry -> IfcCurve;
    }

    type IfcEdgeLoop extending IfcLoop {
        required multi link EdgeList -> IfcOrientedEdge;
    }

    type IfcElectricAppliance extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('DISHWASHER','ELECTRICCOOKER','FREESTANDINGELECTRICHEATER','FREESTANDINGFAN','FREESTANDINGWATERCOOLER','FREESTANDINGWATERHEATER','FREEZER','FRIDGE_FREEZER','HANDDRYER','KITCHENMACHINE','MICROWAVE','NOTDEFINED','PHOTOCOPIER','REFRIGERATOR','TUMBLEDRYER','USERDEFINED','VENDINGMACHINE','WASHINGMACHINE');
        };
    }

    type IfcElectricApplianceType extending IfcFlowTerminalType {
        required property PredefinedType -> str {
            constraint one_of ('DISHWASHER','ELECTRICCOOKER','FREESTANDINGELECTRICHEATER','FREESTANDINGFAN','FREESTANDINGWATERCOOLER','FREESTANDINGWATERHEATER','FREEZER','FRIDGE_FREEZER','HANDDRYER','KITCHENMACHINE','MICROWAVE','NOTDEFINED','PHOTOCOPIER','REFRIGERATOR','TUMBLEDRYER','USERDEFINED','VENDINGMACHINE','WASHINGMACHINE');
        };
    }

    type IfcElectricDistributionBoard extending IfcFlowController {
        required property PredefinedType -> str {
            constraint one_of ('CONSUMERUNIT','DISTRIBUTIONBOARD','MOTORCONTROLCENTRE','NOTDEFINED','SWITCHBOARD','USERDEFINED');
        };
    }

    type IfcElectricDistributionBoardType extending IfcFlowControllerType {
        required property PredefinedType -> str {
            constraint one_of ('CONSUMERUNIT','DISTRIBUTIONBOARD','MOTORCONTROLCENTRE','NOTDEFINED','SWITCHBOARD','USERDEFINED');
        };
    }

    type IfcElectricFlowStorageDevice extending IfcFlowStorageDevice {
        required property PredefinedType -> str {
            constraint one_of ('BATTERY','CAPACITORBANK','HARMONICFILTER','INDUCTORBANK','NOTDEFINED','UPS','USERDEFINED');
        };
    }

    type IfcElectricFlowStorageDeviceType extending IfcFlowStorageDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('BATTERY','CAPACITORBANK','HARMONICFILTER','INDUCTORBANK','NOTDEFINED','UPS','USERDEFINED');
        };
    }

    type IfcElectricGenerator extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('CHP','ENGINEGENERATOR','NOTDEFINED','STANDALONE','USERDEFINED');
        };
    }

    type IfcElectricGeneratorType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('CHP','ENGINEGENERATOR','NOTDEFINED','STANDALONE','USERDEFINED');
        };
    }

    type IfcElectricMotor extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('DC','INDUCTION','NOTDEFINED','POLYPHASE','RELUCTANCESYNCHRONOUS','SYNCHRONOUS','USERDEFINED');
        };
    }

    type IfcElectricMotorType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('DC','INDUCTION','NOTDEFINED','POLYPHASE','RELUCTANCESYNCHRONOUS','SYNCHRONOUS','USERDEFINED');
        };
    }

    type IfcElectricTimeControl extending IfcFlowController {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','RELAY','TIMECLOCK','TIMEDELAY','USERDEFINED');
        };
    }

    type IfcElectricTimeControlType extending IfcFlowControllerType {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','RELAY','TIMECLOCK','TIMEDELAY','USERDEFINED');
        };
    }

    abstract type IfcElement extending IfcProduct {
        property Tag -> str;
    }

    abstract type IfcElementarySurface extending IfcSurface {
        required link Position -> IfcAxis2Placement3D;
    }

    type IfcElementAssembly extending IfcElement {
        required property AssemblyPlace -> str {
            constraint one_of ('FACTORY','NOTDEFINED','SITE');
        };
        required property PredefinedType -> str {
            constraint one_of ('ACCESSORY_ASSEMBLY','ARCH','BEAM_GRID','BRACED_FRAME','GIRDER','NOTDEFINED','REINFORCEMENT_UNIT','RIGID_FRAME','SLAB_FIELD','TRUSS','USERDEFINED');
        };
    }

    type IfcElementAssemblyType extending IfcElementType {
        required property PredefinedType -> str {
            constraint one_of ('ACCESSORY_ASSEMBLY','ARCH','BEAM_GRID','BRACED_FRAME','GIRDER','NOTDEFINED','REINFORCEMENT_UNIT','RIGID_FRAME','SLAB_FIELD','TRUSS','USERDEFINED');
        };
    }

    abstract type IfcElementComponent extending IfcElement {
    }

    abstract type IfcElementComponentType extending IfcElementType {
    }

    type IfcElementQuantity extending IfcQuantitySet {
        property MethodOfMeasurement -> str;
        required multi link Quantities -> IfcPhysicalQuantity;
    }

    abstract type IfcElementType extending IfcTypeProduct {
        property ElementType -> str;
    }

    type IfcEllipse extending IfcConic {
        required property SemiAxis1 -> float64;
        required property SemiAxis2 -> float64;
    }

    type IfcEllipseProfileDef extending IfcParameterizedProfileDef {
        required property SemiAxis1 -> float64;
        required property SemiAxis2 -> float64;
    }

    type IfcEnergyConversionDevice extending IfcDistributionFlowElement {
    }

    abstract type IfcEnergyConversionDeviceType extending IfcDistributionFlowElementType {
    }

    type IfcEngine extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('EXTERNALCOMBUSTION','INTERNALCOMBUSTION','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcEngineType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('EXTERNALCOMBUSTION','INTERNALCOMBUSTION','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcEvaporativeCooler extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('DIRECTEVAPORATIVEAIRWASHER','DIRECTEVAPORATIVEPACKAGEDROTARYAIRCOOLER','DIRECTEVAPORATIVERANDOMMEDIAAIRCOOLER','DIRECTEVAPORATIVERIGIDMEDIAAIRCOOLER','DIRECTEVAPORATIVESLINGERSPACKAGEDAIRCOOLER','INDIRECTDIRECTCOMBINATION','INDIRECTEVAPORATIVECOOLINGTOWERORCOILCOOLER','INDIRECTEVAPORATIVEPACKAGEAIRCOOLER','INDIRECTEVAPORATIVEWETCOIL','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcEvaporativeCoolerType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('DIRECTEVAPORATIVEAIRWASHER','DIRECTEVAPORATIVEPACKAGEDROTARYAIRCOOLER','DIRECTEVAPORATIVERANDOMMEDIAAIRCOOLER','DIRECTEVAPORATIVERIGIDMEDIAAIRCOOLER','DIRECTEVAPORATIVESLINGERSPACKAGEDAIRCOOLER','INDIRECTDIRECTCOMBINATION','INDIRECTEVAPORATIVECOOLINGTOWERORCOILCOOLER','INDIRECTEVAPORATIVEPACKAGEAIRCOOLER','INDIRECTEVAPORATIVEWETCOIL','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcEvaporator extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('DIRECTEXPANSION','DIRECTEXPANSIONBRAZEDPLATE','DIRECTEXPANSIONSHELLANDTUBE','DIRECTEXPANSIONTUBEINTUBE','FLOODEDSHELLANDTUBE','NOTDEFINED','SHELLANDCOIL','USERDEFINED');
        };
    }

    type IfcEvaporatorType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('DIRECTEXPANSION','DIRECTEXPANSIONBRAZEDPLATE','DIRECTEXPANSIONSHELLANDTUBE','DIRECTEXPANSIONTUBEINTUBE','FLOODEDSHELLANDTUBE','NOTDEFINED','SHELLANDCOIL','USERDEFINED');
        };
    }

    type IfcEvent extending IfcProcess {
        property UserDefinedEventTriggerType -> str;
        required property EventTriggerType -> str {
            constraint one_of ('EVENTCOMPLEX','EVENTMESSAGE','EVENTRULE','EVENTTIME','NOTDEFINED','USERDEFINED');
        };
        required property PredefinedType -> str {
            constraint one_of ('ENDEVENT','INTERMEDIATEEVENT','NOTDEFINED','STARTEVENT','USERDEFINED');
        };
        link EventOccurenceTime -> IfcEventTime;
    }

    type IfcEventTime extending IfcSchedulingTime {
        property ActualDate -> str;
        property EarlyDate -> str;
        property LateDate -> str;
        property ScheduleDate -> str;
    }

    type IfcEventType extending IfcTypeProcess {
        property UserDefinedEventTriggerType -> str;
        required property EventTriggerType -> str {
            constraint one_of ('EVENTCOMPLEX','EVENTMESSAGE','EVENTRULE','EVENTTIME','NOTDEFINED','USERDEFINED');
        };
        required property PredefinedType -> str {
            constraint one_of ('ENDEVENT','INTERMEDIATEEVENT','NOTDEFINED','STARTEVENT','USERDEFINED');
        };
    }

    abstract type IfcExtendedProperties extending IfcPropertyAbstraction {
        property Name -> str;
        property Description -> str;
        required multi link Properties -> IfcProperty;
    }

    abstract type IfcExternalInformation {
    }

    type IfcExternallyDefinedHatchStyle extending IfcExternalReference {
    }

    type IfcExternallyDefinedSurfaceStyle extending IfcExternalReference {
    }

    type IfcExternallyDefinedTextFont extending IfcExternalReference {
    }

    abstract type IfcExternalReference {
        property Location -> str;
        property Identification -> str;
        property Name -> str;
    }

    type IfcExternalReferenceRelationship extending IfcResourceLevelRelationship {
        required link RelatingReference -> IfcExternalReference;
        required link RelatedResourceObjects -> IfcActorRole | IfcAppliedValue | IfcApproval | IfcConstraint | IfcContextDependentUnit | IfcConversionBasedUnit | IfcExternalInformation | IfcExternalReference | IfcMaterialDefinition | IfcOrganization | IfcPerson | IfcPersonAndOrganization | IfcPhysicalQuantity | IfcProfileDef | IfcPropertyAbstraction | IfcShapeAspect | IfcTimeSeries;
    }

    type IfcExternalSpatialElement extending IfcExternalSpatialStructureElement {
        required property PredefinedType -> str {
            constraint one_of ('EXTERNAL','EXTERNAL_EARTH','EXTERNAL_FIRE','EXTERNAL_WATER','NOTDEFINED','USERDEFINED');
        };
    }

    abstract type IfcExternalSpatialStructureElement extending IfcSpatialElement {
    }

    type IfcExtrudedAreaSolid extending IfcSweptAreaSolid {
        required property Depth -> float64;
        required link ExtrudedDirection -> IfcDirection;
    }

    type IfcExtrudedAreaSolidTapered extending IfcExtrudedAreaSolid {
        required link EndSweptArea -> IfcProfileDef;
    }

    type IfcFace extending IfcTopologicalRepresentationItem {
        required multi link Bounds -> IfcFaceBound;
    }

    type IfcFaceBasedSurfaceModel extending IfcGeometricRepresentationItem {
        required multi link FbsmFaces -> IfcConnectedFaceSet;
    }

    type IfcFaceBound extending IfcTopologicalRepresentationItem {
        required property Orientation -> bool;
        required link Bound -> IfcLoop;
    }

    type IfcFaceOuterBound extending IfcFaceBound {
    }

    type IfcFaceSurface extending IfcFace {
        required property SameSense -> bool;
        required link FaceSurface -> IfcSurface;
    }

    type IfcFacetedBrep extending IfcManifoldSolidBrep {
    }

    type IfcFacetedBrepWithVoids extending IfcFacetedBrep {
        required multi link Voids -> IfcClosedShell;
    }

    type IfcFailureConnectionCondition extending IfcStructuralConnectionCondition {
        property TensionFailureX -> float64;
        property TensionFailureY -> float64;
        property TensionFailureZ -> float64;
        property CompressionFailureX -> float64;
        property CompressionFailureY -> float64;
        property CompressionFailureZ -> float64;
    }

    type IfcFan extending IfcFlowMovingDevice {
        required property PredefinedType -> str {
            constraint one_of ('CENTRIFUGALAIRFOIL','CENTRIFUGALBACKWARDINCLINEDCURVED','CENTRIFUGALFORWARDCURVED','CENTRIFUGALRADIAL','NOTDEFINED','PROPELLORAXIAL','TUBEAXIAL','USERDEFINED','VANEAXIAL');
        };
    }

    type IfcFanType extending IfcFlowMovingDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('CENTRIFUGALAIRFOIL','CENTRIFUGALBACKWARDINCLINEDCURVED','CENTRIFUGALFORWARDCURVED','CENTRIFUGALRADIAL','NOTDEFINED','PROPELLORAXIAL','TUBEAXIAL','USERDEFINED','VANEAXIAL');
        };
    }

    type IfcFastener extending IfcElementComponent {
        required property PredefinedType -> str {
            constraint one_of ('GLUE','MORTAR','NOTDEFINED','USERDEFINED','WELD');
        };
    }

    type IfcFastenerType extending IfcElementComponentType {
        required property PredefinedType -> str {
            constraint one_of ('GLUE','MORTAR','NOTDEFINED','USERDEFINED','WELD');
        };
    }

    abstract type IfcFeatureElement extending IfcElement {
    }

    abstract type IfcFeatureElementAddition extending IfcFeatureElement {
    }

    abstract type IfcFeatureElementSubtraction extending IfcFeatureElement {
    }

    type IfcFillAreaStyle extending IfcPresentationStyle {
        property ModelorDraughting -> bool;
        required link FillStyles -> IfcColourSpecification | IfcPreDefinedColour | IfcExternallyDefinedHatchStyle | IfcFillAreaStyleHatching | IfcFillAreaStyleTiles;
    }

    type IfcFillAreaStyleHatching extending IfcGeometricRepresentationItem {
        required property HatchLineAngle -> float64;
        required link HatchLineAppearance -> IfcCurveStyle;
        required link StartOfNextHatchLine -> IfcPositiveLengthMeasure | IfcVector;
        link PointOfReferenceHatchLine -> IfcCartesianPoint;
        link PatternStart -> IfcCartesianPoint;
    }

    type IfcFillAreaStyleTiles extending IfcGeometricRepresentationItem {
        required property TilingScale -> float64;
        required multi link TilingPattern -> IfcVector;
        required multi link Tiles -> IfcStyledItem;
    }

    type IfcFilter extending IfcFlowTreatmentDevice {
        required property PredefinedType -> str {
            constraint one_of ('AIRPARTICLEFILTER','COMPRESSEDAIRFILTER','NOTDEFINED','ODORFILTER','OILFILTER','STRAINER','USERDEFINED','WATERFILTER');
        };
    }

    type IfcFilterType extending IfcFlowTreatmentDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('AIRPARTICLEFILTER','COMPRESSEDAIRFILTER','NOTDEFINED','ODORFILTER','OILFILTER','STRAINER','USERDEFINED','WATERFILTER');
        };
    }

    type IfcFireSuppressionTerminal extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('BREECHINGINLET','FIREHYDRANT','HOSEREEL','NOTDEFINED','SPRINKLER','SPRINKLERDEFLECTOR','USERDEFINED');
        };
    }

    type IfcFireSuppressionTerminalType extending IfcFlowTerminalType {
        required property PredefinedType -> str {
            constraint one_of ('BREECHINGINLET','FIREHYDRANT','HOSEREEL','NOTDEFINED','SPRINKLER','SPRINKLERDEFLECTOR','USERDEFINED');
        };
    }

    type IfcFixedReferenceSweptAreaSolid extending IfcSweptAreaSolid {
        property StartParam -> float64;
        property EndParam -> float64;
        required link Directrix -> IfcCurve;
        required link FixedReference -> IfcDirection;
    }

    type IfcFlowController extending IfcDistributionFlowElement {
    }

    abstract type IfcFlowControllerType extending IfcDistributionFlowElementType {
    }

    type IfcFlowFitting extending IfcDistributionFlowElement {
    }

    abstract type IfcFlowFittingType extending IfcDistributionFlowElementType {
    }

    type IfcFlowInstrument extending IfcDistributionControlElement {
        required property PredefinedType -> str {
            constraint one_of ('AMMETER','FREQUENCYMETER','NOTDEFINED','PHASEANGLEMETER','POWERFACTORMETER','PRESSUREGAUGE','THERMOMETER','USERDEFINED','VOLTMETER_PEAK','VOLTMETER_RMS');
        };
    }

    type IfcFlowInstrumentType extending IfcDistributionControlElementType {
        required property PredefinedType -> str {
            constraint one_of ('AMMETER','FREQUENCYMETER','NOTDEFINED','PHASEANGLEMETER','POWERFACTORMETER','PRESSUREGAUGE','THERMOMETER','USERDEFINED','VOLTMETER_PEAK','VOLTMETER_RMS');
        };
    }

    type IfcFlowMeter extending IfcFlowController {
        required property PredefinedType -> str {
            constraint one_of ('ENERGYMETER','GASMETER','NOTDEFINED','OILMETER','USERDEFINED','WATERMETER');
        };
    }

    type IfcFlowMeterType extending IfcFlowControllerType {
        required property PredefinedType -> str {
            constraint one_of ('ENERGYMETER','GASMETER','NOTDEFINED','OILMETER','USERDEFINED','WATERMETER');
        };
    }

    type IfcFlowMovingDevice extending IfcDistributionFlowElement {
    }

    abstract type IfcFlowMovingDeviceType extending IfcDistributionFlowElementType {
    }

    type IfcFlowSegment extending IfcDistributionFlowElement {
    }

    abstract type IfcFlowSegmentType extending IfcDistributionFlowElementType {
    }

    type IfcFlowStorageDevice extending IfcDistributionFlowElement {
    }

    abstract type IfcFlowStorageDeviceType extending IfcDistributionFlowElementType {
    }

    type IfcFlowTerminal extending IfcDistributionFlowElement {
    }

    abstract type IfcFlowTerminalType extending IfcDistributionFlowElementType {
    }

    type IfcFlowTreatmentDevice extending IfcDistributionFlowElement {
    }

    abstract type IfcFlowTreatmentDeviceType extending IfcDistributionFlowElementType {
    }

    type IfcFooting extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('CAISSON_FOUNDATION','FOOTING_BEAM','NOTDEFINED','PAD_FOOTING','PILE_CAP','STRIP_FOOTING','USERDEFINED');
        };
    }

    type IfcFootingType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('CAISSON_FOUNDATION','FOOTING_BEAM','NOTDEFINED','PAD_FOOTING','PILE_CAP','STRIP_FOOTING','USERDEFINED');
        };
    }

    type IfcFurnishingElement extending IfcElement {
    }

    type IfcFurnishingElementType extending IfcElementType {
    }

    type IfcFurniture extending IfcFurnishingElement {
        required property PredefinedType -> str {
            constraint one_of ('BED','CHAIR','DESK','FILECABINET','NOTDEFINED','SHELF','SOFA','TABLE','USERDEFINED');
        };
    }

    type IfcFurnitureType extending IfcFurnishingElementType {
        required property AssemblyPlace -> str {
            constraint one_of ('FACTORY','NOTDEFINED','SITE');
        };
        required property PredefinedType -> str {
            constraint one_of ('BED','CHAIR','DESK','FILECABINET','NOTDEFINED','SHELF','SOFA','TABLE','USERDEFINED');
        };
    }

    type IfcGeographicElement extending IfcElement {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','TERRAIN','USERDEFINED');
        };
    }

    type IfcGeographicElementType extending IfcElementType {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','TERRAIN','USERDEFINED');
        };
    }

    type IfcGeometricCurveSet extending IfcGeometricSet {
    }

    type IfcGeometricRepresentationContext extending IfcRepresentationContext {
        property CoordinateSpaceDimension -> int64;
        property Precision -> float64;
        link WorldCoordinateSystem -> IfcAxis2Placement2D | IfcAxis2Placement3D;
        link TrueNorth -> IfcDirection;
    }

    abstract type IfcGeometricRepresentationItem extending IfcRepresentationItem {
    }

    type IfcGeometricRepresentationSubContext extending IfcGeometricRepresentationContext {
        property TargetScale -> float64;
        property UserDefinedTargetView -> str;
        required property TargetView -> str {
            constraint one_of ('ELEVATION_VIEW','GRAPH_VIEW','MODEL_VIEW','NOTDEFINED','PLAN_VIEW','REFLECTED_PLAN_VIEW','SECTION_VIEW','SKETCH_VIEW','USERDEFINED');
        };
        required link ParentContext -> IfcGeometricRepresentationContext;
    }

    type IfcGeometricSet extending IfcGeometricRepresentationItem {
        required link Elements -> IfcCurve | IfcPoint | IfcSurface;
    }

    type IfcGrid extending IfcPositioningElement {
        required property PredefinedType -> str {
            constraint one_of ('IRREGULAR','NOTDEFINED','RADIAL','RECTANGULAR','TRIANGULAR','USERDEFINED');
        };
        required multi link UAxes -> IfcGridAxis;
        required multi link VAxes -> IfcGridAxis;
        multi link WAxes -> IfcGridAxis;
    }

    type IfcGridAxis {
        property AxisTag -> str;
        required property SameSense -> bool;
        required link AxisCurve -> IfcCurve;
    }

    type IfcGridPlacement extending IfcObjectPlacement {
        required link PlacementLocation -> IfcVirtualGridIntersection;
        link PlacementRefDirection -> IfcDirection | IfcVirtualGridIntersection;
    }

    type IfcGroup extending IfcObject {
    }

    type IfcHalfSpaceSolid extending IfcGeometricRepresentationItem {
        required property AgreementFlag -> bool;
        required link BaseSurface -> IfcSurface;
    }

    type IfcHeatExchanger extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','PLATE','SHELLANDTUBE','USERDEFINED');
        };
    }

    type IfcHeatExchangerType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','PLATE','SHELLANDTUBE','USERDEFINED');
        };
    }

    type IfcHumidifier extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('ADIABATICAIRWASHER','ADIABATICATOMIZING','ADIABATICCOMPRESSEDAIRNOZZLE','ADIABATICPAN','ADIABATICRIGIDMEDIA','ADIABATICULTRASONIC','ADIABATICWETTEDELEMENT','ASSISTEDBUTANE','ASSISTEDELECTRIC','ASSISTEDNATURALGAS','ASSISTEDPROPANE','ASSISTEDSTEAM','NOTDEFINED','STEAMINJECTION','USERDEFINED');
        };
    }

    type IfcHumidifierType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('ADIABATICAIRWASHER','ADIABATICATOMIZING','ADIABATICCOMPRESSEDAIRNOZZLE','ADIABATICPAN','ADIABATICRIGIDMEDIA','ADIABATICULTRASONIC','ADIABATICWETTEDELEMENT','ASSISTEDBUTANE','ASSISTEDELECTRIC','ASSISTEDNATURALGAS','ASSISTEDPROPANE','ASSISTEDSTEAM','NOTDEFINED','STEAMINJECTION','USERDEFINED');
        };
    }

    type IfcImageTexture extending IfcSurfaceTexture {
        required property URLReference -> str;
    }

    type IfcIndexedColourMap extending IfcPresentationItem {
        property Opacity -> float64;
        required property ColourIndex -> tuple<int64>;
        required link MappedTo -> IfcTessellatedFaceSet;
        required link Colours -> IfcColourRgbList;
    }

    type IfcIndexedPolyCurve extending IfcBoundedCurve {
        property SelfIntersect -> bool;
        required link Points -> IfcCartesianPointList;
        link Segments -> IfcArcIndex | IfcLineIndex;
    }

    type IfcIndexedPolygonalFace extending IfcTessellatedItem {
        required property CoordIndex -> tuple<int64>;
    }

    type IfcIndexedPolygonalFaceWithVoids extending IfcIndexedPolygonalFace {
        required property InnerCoordIndices -> array<tuple<int64>>;
    }

    abstract type IfcIndexedTextureMap extending IfcTextureCoordinate {
        required link MappedTo -> IfcTessellatedFaceSet;
        required link TexCoords -> IfcTextureVertexList;
    }

    type IfcIndexedTriangleTextureMap extending IfcIndexedTextureMap {
        property TexCoordIndex -> array<tuple<int64,int64,int64>>;
    }

    type IfcInterceptor extending IfcFlowTreatmentDevice {
        required property PredefinedType -> str {
            constraint one_of ('CYCLONIC','GREASE','NOTDEFINED','OIL','PETROL','USERDEFINED');
        };
    }

    type IfcInterceptorType extending IfcFlowTreatmentDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('CYCLONIC','GREASE','NOTDEFINED','OIL','PETROL','USERDEFINED');
        };
    }

    type IfcIntersectionCurve extending IfcSurfaceCurve {
    }

    type IfcInventory extending IfcGroup {
        property LastUpdateDate -> str;
        required property PredefinedType -> str {
            constraint one_of ('ASSETINVENTORY','FURNITUREINVENTORY','NOTDEFINED','SPACEINVENTORY','USERDEFINED');
        };
        link Jurisdiction -> IfcOrganization | IfcPerson | IfcPersonAndOrganization;
        multi link ResponsiblePersons -> IfcPerson;
        link CurrentValue -> IfcCostValue;
        link OriginalValue -> IfcCostValue;
    }

    type IfcIrregularTimeSeries extending IfcTimeSeries {
        required multi link Values -> IfcIrregularTimeSeriesValue;
    }

    type IfcIrregularTimeSeriesValue {
        required property TimeStamp -> str;
        required link ListValues -> IfcAbsorbedDoseMeasure | IfcAccelerationMeasure | IfcAngularVelocityMeasure | IfcAreaDensityMeasure | IfcCompoundPlaneAngleMeasure | IfcCurvatureMeasure | IfcDoseEquivalentMeasure | IfcDynamicViscosityMeasure | IfcElectricCapacitanceMeasure | IfcElectricChargeMeasure | IfcElectricConductanceMeasure | IfcElectricResistanceMeasure | IfcElectricVoltageMeasure | IfcEnergyMeasure | IfcForceMeasure | IfcFrequencyMeasure | IfcHeatFluxDensityMeasure | IfcHeatingValueMeasure | IfcIlluminanceMeasure | IfcInductanceMeasure | IfcIntegerCountRateMeasure | IfcIonConcentrationMeasure | IfcIsothermalMoistureCapacityMeasure | IfcKinematicViscosityMeasure | IfcLinearForceMeasure | IfcLinearMomentMeasure | IfcLinearStiffnessMeasure | IfcLinearVelocityMeasure | IfcLuminousFluxMeasure | IfcLuminousIntensityDistributionMeasure | IfcMagneticFluxDensityMeasure | IfcMagneticFluxMeasure | IfcMassDensityMeasure | IfcMassFlowRateMeasure | IfcMassPerLengthMeasure | IfcModulusOfElasticityMeasure | IfcModulusOfLinearSubgradeReactionMeasure | IfcModulusOfRotationalSubgradeReactionMeasure | IfcModulusOfSubgradeReactionMeasure | IfcMoistureDiffusivityMeasure | IfcMolecularWeightMeasure | IfcMomentOfInertiaMeasure | IfcMonetaryMeasure | IfcPHMeasure | IfcPlanarForceMeasure | IfcPowerMeasure | IfcPressureMeasure | IfcRadioActivityMeasure | IfcRotationalFrequencyMeasure | IfcRotationalMassMeasure | IfcRotationalStiffnessMeasure | IfcSectionModulusMeasure | IfcSectionalAreaIntegralMeasure | IfcShearModulusMeasure | IfcSoundPowerLevelMeasure | IfcSoundPowerMeasure | IfcSoundPressureLevelMeasure | IfcSoundPressureMeasure | IfcSpecificHeatCapacityMeasure | IfcTemperatureGradientMeasure | IfcTemperatureRateOfChangeMeasure | IfcThermalAdmittanceMeasure | IfcThermalConductivityMeasure | IfcThermalExpansionCoefficientMeasure | IfcThermalResistanceMeasure | IfcThermalTransmittanceMeasure | IfcTorqueMeasure | IfcVaporPermeabilityMeasure | IfcVolumetricFlowRateMeasure | IfcWarpingConstantMeasure | IfcWarpingMomentMeasure | IfcAmountOfSubstanceMeasure | IfcAreaMeasure | IfcComplexNumber | IfcContextDependentMeasure | IfcCountMeasure | IfcDescriptiveMeasure | IfcElectricCurrentMeasure | IfcLengthMeasure | IfcLuminousIntensityMeasure | IfcMassMeasure | IfcNonNegativeLengthMeasure | IfcNormalisedRatioMeasure | IfcNumericMeasure | IfcParameterValue | IfcPlaneAngleMeasure | IfcPositiveLengthMeasure | IfcPositivePlaneAngleMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure | IfcSolidAngleMeasure | IfcThermodynamicTemperatureMeasure | IfcTimeMeasure | IfcVolumeMeasure | IfcBinary | IfcBoolean | IfcDate | IfcDateTime | IfcDuration | IfcIdentifier | IfcInteger | IfcLabel | IfcLogical | IfcPositiveInteger | IfcReal | IfcText | IfcTime | IfcTimeStamp;
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

    type IfcJunctionBox extending IfcFlowFitting {
        required property PredefinedType -> str {
            constraint one_of ('DATA','NOTDEFINED','POWER','USERDEFINED');
        };
    }

    type IfcJunctionBoxType extending IfcFlowFittingType {
        required property PredefinedType -> str {
            constraint one_of ('DATA','NOTDEFINED','POWER','USERDEFINED');
        };
    }

    type IfcLaborResource extending IfcConstructionResource {
        required property PredefinedType -> str {
            constraint one_of ('ADMINISTRATION','CARPENTRY','CLEANING','CONCRETE','DRYWALL','ELECTRIC','FINISHING','FLOORING','GENERAL','HVAC','LANDSCAPING','MASONRY','NOTDEFINED','PAINTING','PAVING','PLUMBING','ROOFING','SITEGRADING','STEELWORK','SURVEYING','USERDEFINED');
        };
    }

    type IfcLaborResourceType extending IfcConstructionResourceType {
        required property PredefinedType -> str {
            constraint one_of ('ADMINISTRATION','CARPENTRY','CLEANING','CONCRETE','DRYWALL','ELECTRIC','FINISHING','FLOORING','GENERAL','HVAC','LANDSCAPING','MASONRY','NOTDEFINED','PAINTING','PAVING','PLUMBING','ROOFING','SITEGRADING','STEELWORK','SURVEYING','USERDEFINED');
        };
    }

    type IfcLagTime extending IfcSchedulingTime {
        required property DurationType -> str {
            constraint one_of ('ELAPSEDTIME','NOTDEFINED','WORKTIME');
        };
        required link LagValue -> IfcDuration | IfcRatioMeasure;
    }

    type IfcLamp extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('COMPACTFLUORESCENT','FLUORESCENT','HALOGEN','HIGHPRESSUREMERCURY','HIGHPRESSURESODIUM','LED','METALHALIDE','NOTDEFINED','OLED','TUNGSTENFILAMENT','USERDEFINED');
        };
    }

    type IfcLampType extending IfcFlowTerminalType {
        required property PredefinedType -> str {
            constraint one_of ('COMPACTFLUORESCENT','FLUORESCENT','HALOGEN','HIGHPRESSUREMERCURY','HIGHPRESSURESODIUM','LED','METALHALIDE','NOTDEFINED','OLED','TUNGSTENFILAMENT','USERDEFINED');
        };
    }

    type IfcLibraryInformation extending IfcExternalInformation {
        required property Name -> str;
        property Version -> str;
        property VersionDate -> str;
        property Location -> str;
        property Description -> str;
        link Publisher -> IfcOrganization | IfcPerson | IfcPersonAndOrganization;
    }

    type IfcLibraryReference extending IfcExternalReference {
        property Description -> str;
        property Language -> str;
        link ReferencedLibrary -> IfcLibraryInformation;
    }

    type IfcLightDistributionData {
        required property MainPlaneAngle -> float64;
        required property SecondaryPlaneAngle -> tuple<float64>;
        required property LuminousIntensity -> tuple<float64>;
    }

    type IfcLightFixture extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('DIRECTIONSOURCE','NOTDEFINED','POINTSOURCE','SECURITYLIGHTING','USERDEFINED');
        };
    }

    type IfcLightFixtureType extending IfcFlowTerminalType {
        required property PredefinedType -> str {
            constraint one_of ('DIRECTIONSOURCE','NOTDEFINED','POINTSOURCE','SECURITYLIGHTING','USERDEFINED');
        };
    }

    type IfcLightIntensityDistribution {
        required property LightDistributionCurve -> str {
            constraint one_of ('NOTDEFINED','TYPE_A','TYPE_B','TYPE_C');
        };
        required multi link DistributionData -> IfcLightDistributionData;
    }

    abstract type IfcLightSource extending IfcGeometricRepresentationItem {
        property Name -> str;
        property AmbientIntensity -> float64;
        property Intensity -> float64;
        required link LightColour -> IfcColourRgb;
    }

    type IfcLightSourceAmbient extending IfcLightSource {
    }

    type IfcLightSourceDirectional extending IfcLightSource {
        required link Orientation -> IfcDirection;
    }

    type IfcLightSourceGoniometric extending IfcLightSource {
        required property ColourTemperature -> float64;
        required property LuminousFlux -> float64;
        required property LightEmissionSource -> str {
            constraint one_of ('COMPACTFLUORESCENT','FLUORESCENT','HIGHPRESSUREMERCURY','HIGHPRESSURESODIUM','LIGHTEMITTINGDIODE','LOWPRESSURESODIUM','LOWVOLTAGEHALOGEN','MAINVOLTAGEHALOGEN','METALHALIDE','NOTDEFINED','TUNGSTENFILAMENT');
        };
        required link Position -> IfcAxis2Placement3D;
        link ColourAppearance -> IfcColourRgb;
        required link LightDistributionDataSource -> IfcExternalReference | IfcLightIntensityDistribution;
    }

    type IfcLightSourcePositional extending IfcLightSource {
        required property Radius -> float64;
        required property ConstantAttenuation -> float64;
        required property DistanceAttenuation -> float64;
        required property QuadricAttenuation -> float64;
        required link Position -> IfcCartesianPoint;
    }

    type IfcLightSourceSpot extending IfcLightSourcePositional {
        property ConcentrationExponent -> float64;
        required property SpreadAngle -> float64;
        required property BeamWidthAngle -> float64;
        required link Orientation -> IfcDirection;
    }

    type IfcLine extending IfcCurve {
        required link Pnt -> IfcCartesianPoint;
        required link Dir -> IfcVector;
    }

    type IfcLinearPlacement extending IfcObjectPlacement {
        required link PlacementRelTo -> IfcCurve;
        required link Distance -> IfcDistanceExpression;
        link Orientation -> IfcOrientationExpression;
        link CartesianPosition -> IfcAxis2Placement3D;
    }

    abstract type IfcLinearPositioningElement extending IfcPositioningElement {
        required link Axis -> IfcCurve;
    }

    type IfcLineSegment2D extending IfcCurveSegment2D {
    }

    type IfcLocalPlacement extending IfcObjectPlacement {
        link PlacementRelTo -> IfcObjectPlacement;
        required link RelativePlacement -> IfcAxis2Placement2D | IfcAxis2Placement3D;
    }

    type IfcLoop extending IfcTopologicalRepresentationItem {
    }

    type IfcLShapeProfileDef extending IfcParameterizedProfileDef {
        required property Depth -> float64;
        property Width -> float64;
        required property Thickness -> float64;
        property FilletRadius -> float64;
        property EdgeRadius -> float64;
        property LegSlope -> float64;
    }

    abstract type IfcManifoldSolidBrep extending IfcSolidModel {
        required link Outer -> IfcClosedShell;
    }

    type IfcMapConversion extending IfcCoordinateOperation {
        required property Eastings -> float64;
        required property Northings -> float64;
        required property OrthogonalHeight -> float64;
        property XAxisAbscissa -> float64;
        property XAxisOrdinate -> float64;
        property Scale -> float64;
    }

    type IfcMappedItem extending IfcRepresentationItem {
        required link MappingSource -> IfcRepresentationMap;
        required link MappingTarget -> IfcCartesianTransformationOperator;
    }

    type IfcMaterial extending IfcMaterialDefinition {
        required property Name -> str;
        property Description -> str;
        property Category -> str;
    }

    type IfcMaterialClassificationRelationship {
        required link MaterialClassifications -> IfcClassification | IfcClassificationReference;
        required link ClassifiedMaterial -> IfcMaterial;
    }

    type IfcMaterialConstituent extending IfcMaterialDefinition {
        property Name -> str;
        property Description -> str;
        property Fraction -> float64;
        property Category -> str;
        required link Material -> IfcMaterial;
    }

    type IfcMaterialConstituentSet extending IfcMaterialDefinition {
        property Name -> str;
        property Description -> str;
        multi link MaterialConstituents -> IfcMaterialConstituent;
    }

    abstract type IfcMaterialDefinition {
    }

    type IfcMaterialDefinitionRepresentation extending IfcProductRepresentation {
        required link RepresentedMaterial -> IfcMaterial;
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

    type IfcMaterialLayerSet extending IfcMaterialDefinition {
        property LayerSetName -> str;
        property Description -> str;
        required multi link MaterialLayers -> IfcMaterialLayer;
    }

    type IfcMaterialLayerSetUsage extending IfcMaterialUsageDefinition {
        required property OffsetFromReferenceLine -> float64;
        property ReferenceExtent -> float64;
        required property DirectionSense -> str {
            constraint one_of ('NEGATIVE','POSITIVE');
        };
        required property LayerSetDirection -> str {
            constraint one_of ('AXIS1','AXIS2','AXIS3');
        };
        required link ForLayerSet -> IfcMaterialLayerSet;
    }

    type IfcMaterialLayerWithOffsets extending IfcMaterialLayer {
        required property OffsetValues -> array<float64>{
            constraint expression on (len(__subject__) = 1 or len(__subject__) = 2)
        };
        required property OffsetDirection -> str {
            constraint one_of ('AXIS1','AXIS2','AXIS3');
        };
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

    type IfcMaterialProfileSet extending IfcMaterialDefinition {
        property Name -> str;
        property Description -> str;
        required multi link MaterialProfiles -> IfcMaterialProfile;
        link CompositeProfile -> IfcCompositeProfileDef;
    }

    type IfcMaterialProfileSetUsage extending IfcMaterialUsageDefinition {
        property CardinalPoint -> int64;
        property ReferenceExtent -> float64;
        required link ForProfileSet -> IfcMaterialProfileSet;
    }

    type IfcMaterialProfileSetUsageTapering extending IfcMaterialProfileSetUsage {
        property CardinalEndPoint -> int64;
        required link ForProfileEndSet -> IfcMaterialProfileSet;
    }

    type IfcMaterialProfileWithOffsets extending IfcMaterialProfile {
        required property OffsetValues -> array<float64>{
            constraint expression on (len(__subject__) = 1 or len(__subject__) = 2)
        };
    }

    type IfcMaterialProperties extending IfcExtendedProperties {
        required link Material -> IfcMaterialDefinition;
    }

    type IfcMaterialRelationship extending IfcResourceLevelRelationship {
        property Expression -> str;
        required link RelatingMaterial -> IfcMaterial;
        required multi link RelatedMaterials -> IfcMaterial;
    }

    abstract type IfcMaterialUsageDefinition {
    }

    type IfcMeasureWithUnit {
        required link ValueComponent -> IfcAbsorbedDoseMeasure | IfcAccelerationMeasure | IfcAngularVelocityMeasure | IfcAreaDensityMeasure | IfcCompoundPlaneAngleMeasure | IfcCurvatureMeasure | IfcDoseEquivalentMeasure | IfcDynamicViscosityMeasure | IfcElectricCapacitanceMeasure | IfcElectricChargeMeasure | IfcElectricConductanceMeasure | IfcElectricResistanceMeasure | IfcElectricVoltageMeasure | IfcEnergyMeasure | IfcForceMeasure | IfcFrequencyMeasure | IfcHeatFluxDensityMeasure | IfcHeatingValueMeasure | IfcIlluminanceMeasure | IfcInductanceMeasure | IfcIntegerCountRateMeasure | IfcIonConcentrationMeasure | IfcIsothermalMoistureCapacityMeasure | IfcKinematicViscosityMeasure | IfcLinearForceMeasure | IfcLinearMomentMeasure | IfcLinearStiffnessMeasure | IfcLinearVelocityMeasure | IfcLuminousFluxMeasure | IfcLuminousIntensityDistributionMeasure | IfcMagneticFluxDensityMeasure | IfcMagneticFluxMeasure | IfcMassDensityMeasure | IfcMassFlowRateMeasure | IfcMassPerLengthMeasure | IfcModulusOfElasticityMeasure | IfcModulusOfLinearSubgradeReactionMeasure | IfcModulusOfRotationalSubgradeReactionMeasure | IfcModulusOfSubgradeReactionMeasure | IfcMoistureDiffusivityMeasure | IfcMolecularWeightMeasure | IfcMomentOfInertiaMeasure | IfcMonetaryMeasure | IfcPHMeasure | IfcPlanarForceMeasure | IfcPowerMeasure | IfcPressureMeasure | IfcRadioActivityMeasure | IfcRotationalFrequencyMeasure | IfcRotationalMassMeasure | IfcRotationalStiffnessMeasure | IfcSectionModulusMeasure | IfcSectionalAreaIntegralMeasure | IfcShearModulusMeasure | IfcSoundPowerLevelMeasure | IfcSoundPowerMeasure | IfcSoundPressureLevelMeasure | IfcSoundPressureMeasure | IfcSpecificHeatCapacityMeasure | IfcTemperatureGradientMeasure | IfcTemperatureRateOfChangeMeasure | IfcThermalAdmittanceMeasure | IfcThermalConductivityMeasure | IfcThermalExpansionCoefficientMeasure | IfcThermalResistanceMeasure | IfcThermalTransmittanceMeasure | IfcTorqueMeasure | IfcVaporPermeabilityMeasure | IfcVolumetricFlowRateMeasure | IfcWarpingConstantMeasure | IfcWarpingMomentMeasure | IfcAmountOfSubstanceMeasure | IfcAreaMeasure | IfcComplexNumber | IfcContextDependentMeasure | IfcCountMeasure | IfcDescriptiveMeasure | IfcElectricCurrentMeasure | IfcLengthMeasure | IfcLuminousIntensityMeasure | IfcMassMeasure | IfcNonNegativeLengthMeasure | IfcNormalisedRatioMeasure | IfcNumericMeasure | IfcParameterValue | IfcPlaneAngleMeasure | IfcPositiveLengthMeasure | IfcPositivePlaneAngleMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure | IfcSolidAngleMeasure | IfcThermodynamicTemperatureMeasure | IfcTimeMeasure | IfcVolumeMeasure | IfcBinary | IfcBoolean | IfcDate | IfcDateTime | IfcDuration | IfcIdentifier | IfcInteger | IfcLabel | IfcLogical | IfcPositiveInteger | IfcReal | IfcText | IfcTime | IfcTimeStamp;
        required link UnitComponent -> IfcDerivedUnit | IfcMonetaryUnit | IfcNamedUnit;
    }

    type IfcMechanicalFastener extending IfcElementComponent {
        property NominalDiameter -> float64;
        property NominalLength -> float64;
        required property PredefinedType -> str {
            constraint one_of ('ANCHORBOLT','BOLT','DOWEL','NAIL','NAILPLATE','NOTDEFINED','RIVET','SCREW','SHEARCONNECTOR','STAPLE','STUDSHEARCONNECTOR','USERDEFINED');
        };
    }

    type IfcMechanicalFastenerType extending IfcElementComponentType {
        property NominalDiameter -> float64;
        property NominalLength -> float64;
        required property PredefinedType -> str {
            constraint one_of ('ANCHORBOLT','BOLT','DOWEL','NAIL','NAILPLATE','NOTDEFINED','RIVET','SCREW','SHEARCONNECTOR','STAPLE','STUDSHEARCONNECTOR','USERDEFINED');
        };
    }

    type IfcMedicalDevice extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('AIRSTATION','FEEDAIRUNIT','NOTDEFINED','OXYGENGENERATOR','OXYGENPLANT','USERDEFINED','VACUUMSTATION');
        };
    }

    type IfcMedicalDeviceType extending IfcFlowTerminalType {
        required property PredefinedType -> str {
            constraint one_of ('AIRSTATION','FEEDAIRUNIT','NOTDEFINED','OXYGENGENERATOR','OXYGENPLANT','USERDEFINED','VACUUMSTATION');
        };
    }

    type IfcMember extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('BRACE','CHORD','COLLAR','MEMBER','MULLION','NOTDEFINED','PLATE','POST','PURLIN','RAFTER','STRINGER','STRUT','STUD','USERDEFINED');
        };
    }

    type IfcMemberStandardCase extending IfcMember {
    }

    type IfcMemberType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('BRACE','CHORD','COLLAR','MEMBER','MULLION','NOTDEFINED','PLATE','POST','PURLIN','RAFTER','STRINGER','STRUT','STUD','USERDEFINED');
        };
    }

    type IfcMetric extending IfcConstraint {
        property ValueSource -> str;
        required property Benchmark -> str {
            constraint one_of ('EQUALTO','GREATERTHAN','GREATERTHANOREQUALTO','INCLUDEDIN','INCLUDES','LESSTHAN','LESSTHANOREQUALTO','NOTEQUALTO','NOTINCLUDEDIN','NOTINCLUDES');
        };
        link DataValue -> IfcAppliedValue | IfcMeasureWithUnit | IfcReference | IfcTable | IfcTimeSeries | IfcAbsorbedDoseMeasure | IfcAccelerationMeasure | IfcAngularVelocityMeasure | IfcAreaDensityMeasure | IfcCompoundPlaneAngleMeasure | IfcCurvatureMeasure | IfcDoseEquivalentMeasure | IfcDynamicViscosityMeasure | IfcElectricCapacitanceMeasure | IfcElectricChargeMeasure | IfcElectricConductanceMeasure | IfcElectricResistanceMeasure | IfcElectricVoltageMeasure | IfcEnergyMeasure | IfcForceMeasure | IfcFrequencyMeasure | IfcHeatFluxDensityMeasure | IfcHeatingValueMeasure | IfcIlluminanceMeasure | IfcInductanceMeasure | IfcIntegerCountRateMeasure | IfcIonConcentrationMeasure | IfcIsothermalMoistureCapacityMeasure | IfcKinematicViscosityMeasure | IfcLinearForceMeasure | IfcLinearMomentMeasure | IfcLinearStiffnessMeasure | IfcLinearVelocityMeasure | IfcLuminousFluxMeasure | IfcLuminousIntensityDistributionMeasure | IfcMagneticFluxDensityMeasure | IfcMagneticFluxMeasure | IfcMassDensityMeasure | IfcMassFlowRateMeasure | IfcMassPerLengthMeasure | IfcModulusOfElasticityMeasure | IfcModulusOfLinearSubgradeReactionMeasure | IfcModulusOfRotationalSubgradeReactionMeasure | IfcModulusOfSubgradeReactionMeasure | IfcMoistureDiffusivityMeasure | IfcMolecularWeightMeasure | IfcMomentOfInertiaMeasure | IfcMonetaryMeasure | IfcPHMeasure | IfcPlanarForceMeasure | IfcPowerMeasure | IfcPressureMeasure | IfcRadioActivityMeasure | IfcRotationalFrequencyMeasure | IfcRotationalMassMeasure | IfcRotationalStiffnessMeasure | IfcSectionModulusMeasure | IfcSectionalAreaIntegralMeasure | IfcShearModulusMeasure | IfcSoundPowerLevelMeasure | IfcSoundPowerMeasure | IfcSoundPressureLevelMeasure | IfcSoundPressureMeasure | IfcSpecificHeatCapacityMeasure | IfcTemperatureGradientMeasure | IfcTemperatureRateOfChangeMeasure | IfcThermalAdmittanceMeasure | IfcThermalConductivityMeasure | IfcThermalExpansionCoefficientMeasure | IfcThermalResistanceMeasure | IfcThermalTransmittanceMeasure | IfcTorqueMeasure | IfcVaporPermeabilityMeasure | IfcVolumetricFlowRateMeasure | IfcWarpingConstantMeasure | IfcWarpingMomentMeasure | IfcAmountOfSubstanceMeasure | IfcAreaMeasure | IfcComplexNumber | IfcContextDependentMeasure | IfcCountMeasure | IfcDescriptiveMeasure | IfcElectricCurrentMeasure | IfcLengthMeasure | IfcLuminousIntensityMeasure | IfcMassMeasure | IfcNonNegativeLengthMeasure | IfcNormalisedRatioMeasure | IfcNumericMeasure | IfcParameterValue | IfcPlaneAngleMeasure | IfcPositiveLengthMeasure | IfcPositivePlaneAngleMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure | IfcSolidAngleMeasure | IfcThermodynamicTemperatureMeasure | IfcTimeMeasure | IfcVolumeMeasure | IfcBinary | IfcBoolean | IfcDate | IfcDateTime | IfcDuration | IfcIdentifier | IfcInteger | IfcLabel | IfcLogical | IfcPositiveInteger | IfcReal | IfcText | IfcTime | IfcTimeStamp;
        link ReferencePath -> IfcReference;
    }

    type IfcMirroredProfileDef extending IfcDerivedProfileDef {
    }

    type IfcMonetaryUnit {
        required property Currency -> str;
    }

    type IfcMotorConnection extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('BELTDRIVE','COUPLING','DIRECTDRIVE','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcMotorConnectionType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('BELTDRIVE','COUPLING','DIRECTDRIVE','NOTDEFINED','USERDEFINED');
        };
    }

    abstract type IfcNamedUnit {
        required property UnitType -> str {
            constraint one_of ('ABSORBEDDOSEUNIT','AMOUNTOFSUBSTANCEUNIT','AREAUNIT','DOSEEQUIVALENTUNIT','ELECTRICCAPACITANCEUNIT','ELECTRICCHARGEUNIT','ELECTRICCONDUCTANCEUNIT','ELECTRICCURRENTUNIT','ELECTRICRESISTANCEUNIT','ELECTRICVOLTAGEUNIT','ENERGYUNIT','FORCEUNIT','FREQUENCYUNIT','ILLUMINANCEUNIT','INDUCTANCEUNIT','LENGTHUNIT','LUMINOUSFLUXUNIT','LUMINOUSINTENSITYUNIT','MAGNETICFLUXDENSITYUNIT','MAGNETICFLUXUNIT','MASSUNIT','PLANEANGLEUNIT','POWERUNIT','PRESSUREUNIT','RADIOACTIVITYUNIT','SOLIDANGLEUNIT','THERMODYNAMICTEMPERATUREUNIT','TIMEUNIT','USERDEFINED','VOLUMEUNIT');
        };
        link Dimensions -> IfcDimensionalExponents;
    }

    abstract type IfcObject extending IfcObjectDefinition {
        property ObjectType -> str;
    }

    abstract type IfcObjectDefinition extending IfcRoot {
    }

    type IfcObjective extending IfcConstraint {
        property UserDefinedQualifier -> str;
        required property LogicalAggregator -> str {
            constraint one_of ('LOGICALAND','LOGICALNOTAND','LOGICALNOTOR','LOGICALOR','LOGICALXOR');
        };
        required property ObjectiveQualifier -> str {
            constraint one_of ('CODECOMPLIANCE','CODEWAIVER','DESIGNINTENT','EXTERNAL','HEALTHANDSAFETY','MERGECONFLICT','MODELVIEW','NOTDEFINED','PARAMETER','REQUIREMENT','SPECIFICATION','TRIGGERCONDITION','USERDEFINED');
        };
        multi link BenchmarkValues -> IfcConstraint;
    }

    abstract type IfcObjectPlacement {
    }

    type IfcOccupant extending IfcActor {
        required property PredefinedType -> str {
            constraint one_of ('ASSIGNEE','ASSIGNOR','LESSEE','LESSOR','LETTINGAGENT','NOTDEFINED','OWNER','TENANT','USERDEFINED');
        };
    }

    abstract type IfcOffsetCurve extending IfcCurve {
        required link BasisCurve -> IfcCurve;
    }

    type IfcOffsetCurve2D extending IfcOffsetCurve {
        required property Distance -> float64;
        required property SelfIntersect -> bool;
    }

    type IfcOffsetCurve3D extending IfcOffsetCurve {
        required property Distance -> float64;
        required property SelfIntersect -> bool;
        required link RefDirection -> IfcDirection;
    }

    type IfcOffsetCurveByDistances extending IfcOffsetCurve {
        property Tag -> str;
        required multi link OffsetValues -> IfcDistanceExpression;
    }

    type IfcOpeningElement extending IfcFeatureElementSubtraction {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','OPENING','RECESS','USERDEFINED');
        };
    }

    type IfcOpeningStandardCase extending IfcOpeningElement {
    }

    type IfcOpenShell extending IfcConnectedFaceSet {
    }

    type IfcOrganization {
        property Identification -> str;
        required property Name -> str;
        property Description -> str;
        multi link Roles -> IfcActorRole;
        multi link Addresses -> IfcAddress;
    }

    type IfcOrganizationRelationship extending IfcResourceLevelRelationship {
        required link RelatingOrganization -> IfcOrganization;
        required multi link RelatedOrganizations -> IfcOrganization;
    }

    type IfcOrientationExpression extending IfcGeometricRepresentationItem {
        required link LateralAxisDirection -> IfcDirection;
        required link VerticalAxisDirection -> IfcDirection;
    }

    type IfcOrientedEdge extending IfcEdge {
        required property Orientation -> bool;
        required link EdgeElement -> IfcEdge;
    }

    type IfcOuterBoundaryCurve extending IfcBoundaryCurve {
    }

    type IfcOutlet extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('AUDIOVISUALOUTLET','COMMUNICATIONSOUTLET','DATAOUTLET','NOTDEFINED','POWEROUTLET','TELEPHONEOUTLET','USERDEFINED');
        };
    }

    type IfcOutletType extending IfcFlowTerminalType {
        required property PredefinedType -> str {
            constraint one_of ('AUDIOVISUALOUTLET','COMMUNICATIONSOUTLET','DATAOUTLET','NOTDEFINED','POWEROUTLET','TELEPHONEOUTLET','USERDEFINED');
        };
    }

    type IfcOwnerHistory {
        property LastModifiedDate -> int64;
        required property CreationDate -> int64;
        required property ChangeAction -> str {
            constraint one_of ('ADDED','DELETED','MODIFIED','NOCHANGE','NOTDEFINED');
        };
        required property State -> str {
            constraint one_of ('LOCKED','READONLY','READONLYLOCKED','READWRITE','READWRITELOCKED');
        };
        required link OwningUser -> IfcPersonAndOrganization;
        required link OwningApplication -> IfcApplication;
        link LastModifyingUser -> IfcPersonAndOrganization;
        link LastModifyingApplication -> IfcApplication;
    }

    abstract type IfcParameterizedProfileDef extending IfcProfileDef {
        link Position -> IfcAxis2Placement2D;
    }

    type IfcPath extending IfcTopologicalRepresentationItem {
        required multi link EdgeList -> IfcOrientedEdge;
    }

    type IfcPcurve extending IfcCurve {
        required link BasisSurface -> IfcSurface;
        required link ReferenceCurve -> IfcCurve;
    }

    type IfcPerformanceHistory extending IfcControl {
        required property LifeCyclePhase -> str;
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcPermeableCoveringProperties extending IfcPreDefinedPropertySet {
        property FrameDepth -> float64;
        property FrameThickness -> float64;
        required property OperationType -> str {
            constraint one_of ('GRILL','LOUVER','NOTDEFINED','SCREEN','USERDEFINED');
        };
        required property PanelPosition -> str {
            constraint one_of ('BOTTOM','LEFT','MIDDLE','NOTDEFINED','RIGHT','TOP');
        };
        link ShapeAspectStyle -> IfcShapeAspect;
    }

    type IfcPermit extending IfcControl {
        property Status -> str;
        property LongDescription -> str;
        required property PredefinedType -> str {
            constraint one_of ('ACCESS','BUILDING','NOTDEFINED','USERDEFINED','WORK');
        };
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

    type IfcPersonAndOrganization {
        required link ThePerson -> IfcPerson;
        required link TheOrganization -> IfcOrganization;
        multi link Roles -> IfcActorRole;
    }

    type IfcPhysicalComplexQuantity extending IfcPhysicalQuantity {
        required property Discrimination -> str;
        property Quality -> str;
        property Usage -> str;
        required multi link HasQuantities -> IfcPhysicalQuantity;
    }

    abstract type IfcPhysicalQuantity {
        required property Name -> str;
        property Description -> str;
    }

    abstract type IfcPhysicalSimpleQuantity extending IfcPhysicalQuantity {
        link Unit -> IfcNamedUnit;
    }

    type IfcPile extending IfcBuildingElement {
        required property ConstructionType -> str {
            constraint one_of ('CAST_IN_PLACE','COMPOSITE','NOTDEFINED','PRECAST_CONCRETE','PREFAB_STEEL','USERDEFINED');
        };
        required property PredefinedType -> str {
            constraint one_of ('BORED','COHESION','DRIVEN','FRICTION','JETGROUTING','NOTDEFINED','SUPPORT','USERDEFINED');
        };
    }

    type IfcPileType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('BORED','COHESION','DRIVEN','FRICTION','JETGROUTING','NOTDEFINED','SUPPORT','USERDEFINED');
        };
    }

    type IfcPipeFitting extending IfcFlowFitting {
        required property PredefinedType -> str {
            constraint one_of ('BEND','CONNECTOR','ENTRY','EXIT','JUNCTION','NOTDEFINED','OBSTRUCTION','TRANSITION','USERDEFINED');
        };
    }

    type IfcPipeFittingType extending IfcFlowFittingType {
        required property PredefinedType -> str {
            constraint one_of ('BEND','CONNECTOR','ENTRY','EXIT','JUNCTION','NOTDEFINED','OBSTRUCTION','TRANSITION','USERDEFINED');
        };
    }

    type IfcPipeSegment extending IfcFlowSegment {
        required property PredefinedType -> str {
            constraint one_of ('CULVERT','FLEXIBLESEGMENT','GUTTER','NOTDEFINED','RIGIDSEGMENT','SPOOL','USERDEFINED');
        };
    }

    type IfcPipeSegmentType extending IfcFlowSegmentType {
        required property PredefinedType -> str {
            constraint one_of ('CULVERT','FLEXIBLESEGMENT','GUTTER','NOTDEFINED','RIGIDSEGMENT','SPOOL','USERDEFINED');
        };
    }

    type IfcPixelTexture extending IfcSurfaceTexture {
        required property Width -> int64;
        required property Height -> int64;
        required property ColourComponents -> int64;
        required property Pixel -> tuple<bytes>;
    }

    abstract type IfcPlacement extending IfcGeometricRepresentationItem {
        required link Location -> IfcCartesianPoint;
    }

    type IfcPlanarBox extending IfcPlanarExtent {
        required link Placement -> IfcAxis2Placement2D | IfcAxis2Placement3D;
    }

    type IfcPlanarExtent extending IfcGeometricRepresentationItem {
        required property SizeInX -> float64;
        required property SizeInY -> float64;
    }

    type IfcPlane extending IfcElementarySurface {
    }

    type IfcPlate extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('CURTAIN_PANEL','NOTDEFINED','SHEET','USERDEFINED');
        };
    }

    type IfcPlateStandardCase extending IfcPlate {
    }

    type IfcPlateType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('CURTAIN_PANEL','NOTDEFINED','SHEET','USERDEFINED');
        };
    }

    abstract type IfcPoint extending IfcGeometricRepresentationItem {
    }

    type IfcPointOnCurve extending IfcPoint {
        required property PointParameter -> float64;
        required link BasisCurve -> IfcCurve;
    }

    type IfcPointOnSurface extending IfcPoint {
        required property PointParameterU -> float64;
        required property PointParameterV -> float64;
        required link BasisSurface -> IfcSurface;
    }

    type IfcPolygonalBoundedHalfSpace extending IfcHalfSpaceSolid {
        required link Position -> IfcAxis2Placement3D;
        required link PolygonalBoundary -> IfcBoundedCurve;
    }

    type IfcPolygonalFaceSet extending IfcTessellatedFaceSet {
        property Closed -> bool;
        property PnIndex -> tuple<int64>;
        required multi link Faces -> IfcIndexedPolygonalFace;
    }

    type IfcPolyline extending IfcBoundedCurve {
        required multi link Points -> IfcCartesianPoint;
    }

    type IfcPolyLoop extending IfcLoop {
        required multi link Polygon -> IfcCartesianPoint;
    }

    abstract type IfcPort extending IfcProduct {
    }

    abstract type IfcPositioningElement extending IfcProduct {
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

    abstract type IfcPreDefinedItem extending IfcPresentationItem {
        required property Name -> str;
    }

    abstract type IfcPreDefinedProperties extending IfcPropertyAbstraction {
    }

    abstract type IfcPreDefinedPropertySet extending IfcPropertySetDefinition {
    }

    abstract type IfcPreDefinedTextFont extending IfcPreDefinedItem {
    }

    abstract type IfcPresentationItem {
    }

    type IfcPresentationLayerAssignment {
        required property Name -> str;
        property Description -> str;
        property Identifier -> str;
        required link AssignedItems -> IfcRepresentation | IfcRepresentationItem;
    }

    type IfcPresentationLayerWithStyle extending IfcPresentationLayerAssignment {
        required property LayerOn -> bool;
        required property LayerFrozen -> bool;
        required property LayerBlocked -> bool;
        required multi link LayerStyles -> IfcPresentationStyle;
    }

    abstract type IfcPresentationStyle {
        property Name -> str;
    }

    type IfcPresentationStyleAssignment {
        required link Styles -> IfcNullStyle | IfcCurveStyle | IfcFillAreaStyle | IfcSurfaceStyle | IfcTextStyle;
    }

    type IfcProcedure extending IfcProcess {
        required property PredefinedType -> str {
            constraint one_of ('ADVICE_CAUTION','ADVICE_NOTE','ADVICE_WARNING','CALIBRATION','DIAGNOSTIC','NOTDEFINED','SHUTDOWN','STARTUP','USERDEFINED');
        };
    }

    type IfcProcedureType extending IfcTypeProcess {
        required property PredefinedType -> str {
            constraint one_of ('ADVICE_CAUTION','ADVICE_NOTE','ADVICE_WARNING','CALIBRATION','DIAGNOSTIC','NOTDEFINED','SHUTDOWN','STARTUP','USERDEFINED');
        };
    }

    abstract type IfcProcess extending IfcObject {
        property Identification -> str;
        property LongDescription -> str;
    }

    abstract type IfcProduct extending IfcObject {
        link ObjectPlacement -> IfcObjectPlacement;
        link Representation -> IfcProductRepresentation;
    }

    type IfcProductDefinitionShape extending IfcProductRepresentation {
    }

    abstract type IfcProductRepresentation {
        property Name -> str;
        property Description -> str;
        required multi link Representations -> IfcRepresentation;
    }

    type IfcProfileDef {
        property ProfileName -> str;
        required property ProfileType -> str {
            constraint one_of ('AREA','CURVE');
        };
    }

    type IfcProfileProperties extending IfcExtendedProperties {
        required link ProfileDefinition -> IfcProfileDef;
    }

    type IfcProject extending IfcContext {
    }

    type IfcProjectedCRS extending IfcCoordinateReferenceSystem {
        property MapProjection -> str;
        property MapZone -> str;
        link MapUnit -> IfcNamedUnit;
    }

    type IfcProjectionElement extending IfcFeatureElementAddition {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcProjectLibrary extending IfcContext {
    }

    type IfcProjectOrder extending IfcControl {
        property Status -> str;
        property LongDescription -> str;
        required property PredefinedType -> str {
            constraint one_of ('CHANGEORDER','MAINTENANCEWORKORDER','MOVEORDER','NOTDEFINED','PURCHASEORDER','USERDEFINED','WORKORDER');
        };
    }

    abstract type IfcProperty extending IfcPropertyAbstraction {
        required property Name -> str;
        property Description -> str;
    }

    abstract type IfcPropertyAbstraction {
    }

    type IfcPropertyBoundedValue extending IfcSimpleProperty {
        link UpperBoundValue -> IfcAbsorbedDoseMeasure | IfcAccelerationMeasure | IfcAngularVelocityMeasure | IfcAreaDensityMeasure | IfcCompoundPlaneAngleMeasure | IfcCurvatureMeasure | IfcDoseEquivalentMeasure | IfcDynamicViscosityMeasure | IfcElectricCapacitanceMeasure | IfcElectricChargeMeasure | IfcElectricConductanceMeasure | IfcElectricResistanceMeasure | IfcElectricVoltageMeasure | IfcEnergyMeasure | IfcForceMeasure | IfcFrequencyMeasure | IfcHeatFluxDensityMeasure | IfcHeatingValueMeasure | IfcIlluminanceMeasure | IfcInductanceMeasure | IfcIntegerCountRateMeasure | IfcIonConcentrationMeasure | IfcIsothermalMoistureCapacityMeasure | IfcKinematicViscosityMeasure | IfcLinearForceMeasure | IfcLinearMomentMeasure | IfcLinearStiffnessMeasure | IfcLinearVelocityMeasure | IfcLuminousFluxMeasure | IfcLuminousIntensityDistributionMeasure | IfcMagneticFluxDensityMeasure | IfcMagneticFluxMeasure | IfcMassDensityMeasure | IfcMassFlowRateMeasure | IfcMassPerLengthMeasure | IfcModulusOfElasticityMeasure | IfcModulusOfLinearSubgradeReactionMeasure | IfcModulusOfRotationalSubgradeReactionMeasure | IfcModulusOfSubgradeReactionMeasure | IfcMoistureDiffusivityMeasure | IfcMolecularWeightMeasure | IfcMomentOfInertiaMeasure | IfcMonetaryMeasure | IfcPHMeasure | IfcPlanarForceMeasure | IfcPowerMeasure | IfcPressureMeasure | IfcRadioActivityMeasure | IfcRotationalFrequencyMeasure | IfcRotationalMassMeasure | IfcRotationalStiffnessMeasure | IfcSectionModulusMeasure | IfcSectionalAreaIntegralMeasure | IfcShearModulusMeasure | IfcSoundPowerLevelMeasure | IfcSoundPowerMeasure | IfcSoundPressureLevelMeasure | IfcSoundPressureMeasure | IfcSpecificHeatCapacityMeasure | IfcTemperatureGradientMeasure | IfcTemperatureRateOfChangeMeasure | IfcThermalAdmittanceMeasure | IfcThermalConductivityMeasure | IfcThermalExpansionCoefficientMeasure | IfcThermalResistanceMeasure | IfcThermalTransmittanceMeasure | IfcTorqueMeasure | IfcVaporPermeabilityMeasure | IfcVolumetricFlowRateMeasure | IfcWarpingConstantMeasure | IfcWarpingMomentMeasure | IfcAmountOfSubstanceMeasure | IfcAreaMeasure | IfcComplexNumber | IfcContextDependentMeasure | IfcCountMeasure | IfcDescriptiveMeasure | IfcElectricCurrentMeasure | IfcLengthMeasure | IfcLuminousIntensityMeasure | IfcMassMeasure | IfcNonNegativeLengthMeasure | IfcNormalisedRatioMeasure | IfcNumericMeasure | IfcParameterValue | IfcPlaneAngleMeasure | IfcPositiveLengthMeasure | IfcPositivePlaneAngleMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure | IfcSolidAngleMeasure | IfcThermodynamicTemperatureMeasure | IfcTimeMeasure | IfcVolumeMeasure | IfcBinary | IfcBoolean | IfcDate | IfcDateTime | IfcDuration | IfcIdentifier | IfcInteger | IfcLabel | IfcLogical | IfcPositiveInteger | IfcReal | IfcText | IfcTime | IfcTimeStamp;
        link LowerBoundValue -> IfcAbsorbedDoseMeasure | IfcAccelerationMeasure | IfcAngularVelocityMeasure | IfcAreaDensityMeasure | IfcCompoundPlaneAngleMeasure | IfcCurvatureMeasure | IfcDoseEquivalentMeasure | IfcDynamicViscosityMeasure | IfcElectricCapacitanceMeasure | IfcElectricChargeMeasure | IfcElectricConductanceMeasure | IfcElectricResistanceMeasure | IfcElectricVoltageMeasure | IfcEnergyMeasure | IfcForceMeasure | IfcFrequencyMeasure | IfcHeatFluxDensityMeasure | IfcHeatingValueMeasure | IfcIlluminanceMeasure | IfcInductanceMeasure | IfcIntegerCountRateMeasure | IfcIonConcentrationMeasure | IfcIsothermalMoistureCapacityMeasure | IfcKinematicViscosityMeasure | IfcLinearForceMeasure | IfcLinearMomentMeasure | IfcLinearStiffnessMeasure | IfcLinearVelocityMeasure | IfcLuminousFluxMeasure | IfcLuminousIntensityDistributionMeasure | IfcMagneticFluxDensityMeasure | IfcMagneticFluxMeasure | IfcMassDensityMeasure | IfcMassFlowRateMeasure | IfcMassPerLengthMeasure | IfcModulusOfElasticityMeasure | IfcModulusOfLinearSubgradeReactionMeasure | IfcModulusOfRotationalSubgradeReactionMeasure | IfcModulusOfSubgradeReactionMeasure | IfcMoistureDiffusivityMeasure | IfcMolecularWeightMeasure | IfcMomentOfInertiaMeasure | IfcMonetaryMeasure | IfcPHMeasure | IfcPlanarForceMeasure | IfcPowerMeasure | IfcPressureMeasure | IfcRadioActivityMeasure | IfcRotationalFrequencyMeasure | IfcRotationalMassMeasure | IfcRotationalStiffnessMeasure | IfcSectionModulusMeasure | IfcSectionalAreaIntegralMeasure | IfcShearModulusMeasure | IfcSoundPowerLevelMeasure | IfcSoundPowerMeasure | IfcSoundPressureLevelMeasure | IfcSoundPressureMeasure | IfcSpecificHeatCapacityMeasure | IfcTemperatureGradientMeasure | IfcTemperatureRateOfChangeMeasure | IfcThermalAdmittanceMeasure | IfcThermalConductivityMeasure | IfcThermalExpansionCoefficientMeasure | IfcThermalResistanceMeasure | IfcThermalTransmittanceMeasure | IfcTorqueMeasure | IfcVaporPermeabilityMeasure | IfcVolumetricFlowRateMeasure | IfcWarpingConstantMeasure | IfcWarpingMomentMeasure | IfcAmountOfSubstanceMeasure | IfcAreaMeasure | IfcComplexNumber | IfcContextDependentMeasure | IfcCountMeasure | IfcDescriptiveMeasure | IfcElectricCurrentMeasure | IfcLengthMeasure | IfcLuminousIntensityMeasure | IfcMassMeasure | IfcNonNegativeLengthMeasure | IfcNormalisedRatioMeasure | IfcNumericMeasure | IfcParameterValue | IfcPlaneAngleMeasure | IfcPositiveLengthMeasure | IfcPositivePlaneAngleMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure | IfcSolidAngleMeasure | IfcThermodynamicTemperatureMeasure | IfcTimeMeasure | IfcVolumeMeasure | IfcBinary | IfcBoolean | IfcDate | IfcDateTime | IfcDuration | IfcIdentifier | IfcInteger | IfcLabel | IfcLogical | IfcPositiveInteger | IfcReal | IfcText | IfcTime | IfcTimeStamp;
        link Unit -> IfcDerivedUnit | IfcMonetaryUnit | IfcNamedUnit;
        link SetPointValue -> IfcAbsorbedDoseMeasure | IfcAccelerationMeasure | IfcAngularVelocityMeasure | IfcAreaDensityMeasure | IfcCompoundPlaneAngleMeasure | IfcCurvatureMeasure | IfcDoseEquivalentMeasure | IfcDynamicViscosityMeasure | IfcElectricCapacitanceMeasure | IfcElectricChargeMeasure | IfcElectricConductanceMeasure | IfcElectricResistanceMeasure | IfcElectricVoltageMeasure | IfcEnergyMeasure | IfcForceMeasure | IfcFrequencyMeasure | IfcHeatFluxDensityMeasure | IfcHeatingValueMeasure | IfcIlluminanceMeasure | IfcInductanceMeasure | IfcIntegerCountRateMeasure | IfcIonConcentrationMeasure | IfcIsothermalMoistureCapacityMeasure | IfcKinematicViscosityMeasure | IfcLinearForceMeasure | IfcLinearMomentMeasure | IfcLinearStiffnessMeasure | IfcLinearVelocityMeasure | IfcLuminousFluxMeasure | IfcLuminousIntensityDistributionMeasure | IfcMagneticFluxDensityMeasure | IfcMagneticFluxMeasure | IfcMassDensityMeasure | IfcMassFlowRateMeasure | IfcMassPerLengthMeasure | IfcModulusOfElasticityMeasure | IfcModulusOfLinearSubgradeReactionMeasure | IfcModulusOfRotationalSubgradeReactionMeasure | IfcModulusOfSubgradeReactionMeasure | IfcMoistureDiffusivityMeasure | IfcMolecularWeightMeasure | IfcMomentOfInertiaMeasure | IfcMonetaryMeasure | IfcPHMeasure | IfcPlanarForceMeasure | IfcPowerMeasure | IfcPressureMeasure | IfcRadioActivityMeasure | IfcRotationalFrequencyMeasure | IfcRotationalMassMeasure | IfcRotationalStiffnessMeasure | IfcSectionModulusMeasure | IfcSectionalAreaIntegralMeasure | IfcShearModulusMeasure | IfcSoundPowerLevelMeasure | IfcSoundPowerMeasure | IfcSoundPressureLevelMeasure | IfcSoundPressureMeasure | IfcSpecificHeatCapacityMeasure | IfcTemperatureGradientMeasure | IfcTemperatureRateOfChangeMeasure | IfcThermalAdmittanceMeasure | IfcThermalConductivityMeasure | IfcThermalExpansionCoefficientMeasure | IfcThermalResistanceMeasure | IfcThermalTransmittanceMeasure | IfcTorqueMeasure | IfcVaporPermeabilityMeasure | IfcVolumetricFlowRateMeasure | IfcWarpingConstantMeasure | IfcWarpingMomentMeasure | IfcAmountOfSubstanceMeasure | IfcAreaMeasure | IfcComplexNumber | IfcContextDependentMeasure | IfcCountMeasure | IfcDescriptiveMeasure | IfcElectricCurrentMeasure | IfcLengthMeasure | IfcLuminousIntensityMeasure | IfcMassMeasure | IfcNonNegativeLengthMeasure | IfcNormalisedRatioMeasure | IfcNumericMeasure | IfcParameterValue | IfcPlaneAngleMeasure | IfcPositiveLengthMeasure | IfcPositivePlaneAngleMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure | IfcSolidAngleMeasure | IfcThermodynamicTemperatureMeasure | IfcTimeMeasure | IfcVolumeMeasure | IfcBinary | IfcBoolean | IfcDate | IfcDateTime | IfcDuration | IfcIdentifier | IfcInteger | IfcLabel | IfcLogical | IfcPositiveInteger | IfcReal | IfcText | IfcTime | IfcTimeStamp;
    }

    abstract type IfcPropertyDefinition extending IfcRoot {
    }

    type IfcPropertyDependencyRelationship extending IfcResourceLevelRelationship {
        property Expression -> str;
        required link DependingProperty -> IfcProperty;
        required link DependantProperty -> IfcProperty;
    }

    type IfcPropertyEnumeratedValue extending IfcSimpleProperty {
        link EnumerationValues -> IfcAbsorbedDoseMeasure | IfcAccelerationMeasure | IfcAngularVelocityMeasure | IfcAreaDensityMeasure | IfcCompoundPlaneAngleMeasure | IfcCurvatureMeasure | IfcDoseEquivalentMeasure | IfcDynamicViscosityMeasure | IfcElectricCapacitanceMeasure | IfcElectricChargeMeasure | IfcElectricConductanceMeasure | IfcElectricResistanceMeasure | IfcElectricVoltageMeasure | IfcEnergyMeasure | IfcForceMeasure | IfcFrequencyMeasure | IfcHeatFluxDensityMeasure | IfcHeatingValueMeasure | IfcIlluminanceMeasure | IfcInductanceMeasure | IfcIntegerCountRateMeasure | IfcIonConcentrationMeasure | IfcIsothermalMoistureCapacityMeasure | IfcKinematicViscosityMeasure | IfcLinearForceMeasure | IfcLinearMomentMeasure | IfcLinearStiffnessMeasure | IfcLinearVelocityMeasure | IfcLuminousFluxMeasure | IfcLuminousIntensityDistributionMeasure | IfcMagneticFluxDensityMeasure | IfcMagneticFluxMeasure | IfcMassDensityMeasure | IfcMassFlowRateMeasure | IfcMassPerLengthMeasure | IfcModulusOfElasticityMeasure | IfcModulusOfLinearSubgradeReactionMeasure | IfcModulusOfRotationalSubgradeReactionMeasure | IfcModulusOfSubgradeReactionMeasure | IfcMoistureDiffusivityMeasure | IfcMolecularWeightMeasure | IfcMomentOfInertiaMeasure | IfcMonetaryMeasure | IfcPHMeasure | IfcPlanarForceMeasure | IfcPowerMeasure | IfcPressureMeasure | IfcRadioActivityMeasure | IfcRotationalFrequencyMeasure | IfcRotationalMassMeasure | IfcRotationalStiffnessMeasure | IfcSectionModulusMeasure | IfcSectionalAreaIntegralMeasure | IfcShearModulusMeasure | IfcSoundPowerLevelMeasure | IfcSoundPowerMeasure | IfcSoundPressureLevelMeasure | IfcSoundPressureMeasure | IfcSpecificHeatCapacityMeasure | IfcTemperatureGradientMeasure | IfcTemperatureRateOfChangeMeasure | IfcThermalAdmittanceMeasure | IfcThermalConductivityMeasure | IfcThermalExpansionCoefficientMeasure | IfcThermalResistanceMeasure | IfcThermalTransmittanceMeasure | IfcTorqueMeasure | IfcVaporPermeabilityMeasure | IfcVolumetricFlowRateMeasure | IfcWarpingConstantMeasure | IfcWarpingMomentMeasure | IfcAmountOfSubstanceMeasure | IfcAreaMeasure | IfcComplexNumber | IfcContextDependentMeasure | IfcCountMeasure | IfcDescriptiveMeasure | IfcElectricCurrentMeasure | IfcLengthMeasure | IfcLuminousIntensityMeasure | IfcMassMeasure | IfcNonNegativeLengthMeasure | IfcNormalisedRatioMeasure | IfcNumericMeasure | IfcParameterValue | IfcPlaneAngleMeasure | IfcPositiveLengthMeasure | IfcPositivePlaneAngleMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure | IfcSolidAngleMeasure | IfcThermodynamicTemperatureMeasure | IfcTimeMeasure | IfcVolumeMeasure | IfcBinary | IfcBoolean | IfcDate | IfcDateTime | IfcDuration | IfcIdentifier | IfcInteger | IfcLabel | IfcLogical | IfcPositiveInteger | IfcReal | IfcText | IfcTime | IfcTimeStamp;
        link EnumerationReference -> IfcPropertyEnumeration;
    }

    type IfcPropertyEnumeration extending IfcPropertyAbstraction {
        required property Name -> str;
        required link EnumerationValues -> IfcAbsorbedDoseMeasure | IfcAccelerationMeasure | IfcAngularVelocityMeasure | IfcAreaDensityMeasure | IfcCompoundPlaneAngleMeasure | IfcCurvatureMeasure | IfcDoseEquivalentMeasure | IfcDynamicViscosityMeasure | IfcElectricCapacitanceMeasure | IfcElectricChargeMeasure | IfcElectricConductanceMeasure | IfcElectricResistanceMeasure | IfcElectricVoltageMeasure | IfcEnergyMeasure | IfcForceMeasure | IfcFrequencyMeasure | IfcHeatFluxDensityMeasure | IfcHeatingValueMeasure | IfcIlluminanceMeasure | IfcInductanceMeasure | IfcIntegerCountRateMeasure | IfcIonConcentrationMeasure | IfcIsothermalMoistureCapacityMeasure | IfcKinematicViscosityMeasure | IfcLinearForceMeasure | IfcLinearMomentMeasure | IfcLinearStiffnessMeasure | IfcLinearVelocityMeasure | IfcLuminousFluxMeasure | IfcLuminousIntensityDistributionMeasure | IfcMagneticFluxDensityMeasure | IfcMagneticFluxMeasure | IfcMassDensityMeasure | IfcMassFlowRateMeasure | IfcMassPerLengthMeasure | IfcModulusOfElasticityMeasure | IfcModulusOfLinearSubgradeReactionMeasure | IfcModulusOfRotationalSubgradeReactionMeasure | IfcModulusOfSubgradeReactionMeasure | IfcMoistureDiffusivityMeasure | IfcMolecularWeightMeasure | IfcMomentOfInertiaMeasure | IfcMonetaryMeasure | IfcPHMeasure | IfcPlanarForceMeasure | IfcPowerMeasure | IfcPressureMeasure | IfcRadioActivityMeasure | IfcRotationalFrequencyMeasure | IfcRotationalMassMeasure | IfcRotationalStiffnessMeasure | IfcSectionModulusMeasure | IfcSectionalAreaIntegralMeasure | IfcShearModulusMeasure | IfcSoundPowerLevelMeasure | IfcSoundPowerMeasure | IfcSoundPressureLevelMeasure | IfcSoundPressureMeasure | IfcSpecificHeatCapacityMeasure | IfcTemperatureGradientMeasure | IfcTemperatureRateOfChangeMeasure | IfcThermalAdmittanceMeasure | IfcThermalConductivityMeasure | IfcThermalExpansionCoefficientMeasure | IfcThermalResistanceMeasure | IfcThermalTransmittanceMeasure | IfcTorqueMeasure | IfcVaporPermeabilityMeasure | IfcVolumetricFlowRateMeasure | IfcWarpingConstantMeasure | IfcWarpingMomentMeasure | IfcAmountOfSubstanceMeasure | IfcAreaMeasure | IfcComplexNumber | IfcContextDependentMeasure | IfcCountMeasure | IfcDescriptiveMeasure | IfcElectricCurrentMeasure | IfcLengthMeasure | IfcLuminousIntensityMeasure | IfcMassMeasure | IfcNonNegativeLengthMeasure | IfcNormalisedRatioMeasure | IfcNumericMeasure | IfcParameterValue | IfcPlaneAngleMeasure | IfcPositiveLengthMeasure | IfcPositivePlaneAngleMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure | IfcSolidAngleMeasure | IfcThermodynamicTemperatureMeasure | IfcTimeMeasure | IfcVolumeMeasure | IfcBinary | IfcBoolean | IfcDate | IfcDateTime | IfcDuration | IfcIdentifier | IfcInteger | IfcLabel | IfcLogical | IfcPositiveInteger | IfcReal | IfcText | IfcTime | IfcTimeStamp;
        link Unit -> IfcDerivedUnit | IfcMonetaryUnit | IfcNamedUnit;
    }

    type IfcPropertyListValue extending IfcSimpleProperty {
        link ListValues -> IfcAbsorbedDoseMeasure | IfcAccelerationMeasure | IfcAngularVelocityMeasure | IfcAreaDensityMeasure | IfcCompoundPlaneAngleMeasure | IfcCurvatureMeasure | IfcDoseEquivalentMeasure | IfcDynamicViscosityMeasure | IfcElectricCapacitanceMeasure | IfcElectricChargeMeasure | IfcElectricConductanceMeasure | IfcElectricResistanceMeasure | IfcElectricVoltageMeasure | IfcEnergyMeasure | IfcForceMeasure | IfcFrequencyMeasure | IfcHeatFluxDensityMeasure | IfcHeatingValueMeasure | IfcIlluminanceMeasure | IfcInductanceMeasure | IfcIntegerCountRateMeasure | IfcIonConcentrationMeasure | IfcIsothermalMoistureCapacityMeasure | IfcKinematicViscosityMeasure | IfcLinearForceMeasure | IfcLinearMomentMeasure | IfcLinearStiffnessMeasure | IfcLinearVelocityMeasure | IfcLuminousFluxMeasure | IfcLuminousIntensityDistributionMeasure | IfcMagneticFluxDensityMeasure | IfcMagneticFluxMeasure | IfcMassDensityMeasure | IfcMassFlowRateMeasure | IfcMassPerLengthMeasure | IfcModulusOfElasticityMeasure | IfcModulusOfLinearSubgradeReactionMeasure | IfcModulusOfRotationalSubgradeReactionMeasure | IfcModulusOfSubgradeReactionMeasure | IfcMoistureDiffusivityMeasure | IfcMolecularWeightMeasure | IfcMomentOfInertiaMeasure | IfcMonetaryMeasure | IfcPHMeasure | IfcPlanarForceMeasure | IfcPowerMeasure | IfcPressureMeasure | IfcRadioActivityMeasure | IfcRotationalFrequencyMeasure | IfcRotationalMassMeasure | IfcRotationalStiffnessMeasure | IfcSectionModulusMeasure | IfcSectionalAreaIntegralMeasure | IfcShearModulusMeasure | IfcSoundPowerLevelMeasure | IfcSoundPowerMeasure | IfcSoundPressureLevelMeasure | IfcSoundPressureMeasure | IfcSpecificHeatCapacityMeasure | IfcTemperatureGradientMeasure | IfcTemperatureRateOfChangeMeasure | IfcThermalAdmittanceMeasure | IfcThermalConductivityMeasure | IfcThermalExpansionCoefficientMeasure | IfcThermalResistanceMeasure | IfcThermalTransmittanceMeasure | IfcTorqueMeasure | IfcVaporPermeabilityMeasure | IfcVolumetricFlowRateMeasure | IfcWarpingConstantMeasure | IfcWarpingMomentMeasure | IfcAmountOfSubstanceMeasure | IfcAreaMeasure | IfcComplexNumber | IfcContextDependentMeasure | IfcCountMeasure | IfcDescriptiveMeasure | IfcElectricCurrentMeasure | IfcLengthMeasure | IfcLuminousIntensityMeasure | IfcMassMeasure | IfcNonNegativeLengthMeasure | IfcNormalisedRatioMeasure | IfcNumericMeasure | IfcParameterValue | IfcPlaneAngleMeasure | IfcPositiveLengthMeasure | IfcPositivePlaneAngleMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure | IfcSolidAngleMeasure | IfcThermodynamicTemperatureMeasure | IfcTimeMeasure | IfcVolumeMeasure | IfcBinary | IfcBoolean | IfcDate | IfcDateTime | IfcDuration | IfcIdentifier | IfcInteger | IfcLabel | IfcLogical | IfcPositiveInteger | IfcReal | IfcText | IfcTime | IfcTimeStamp;
        link Unit -> IfcDerivedUnit | IfcMonetaryUnit | IfcNamedUnit;
    }

    type IfcPropertyReferenceValue extending IfcSimpleProperty {
        property UsageName -> str;
        link PropertyReference -> IfcAddress | IfcAppliedValue | IfcExternalReference | IfcMaterialDefinition | IfcOrganization | IfcPerson | IfcPersonAndOrganization | IfcTable | IfcTimeSeries;
    }

    type IfcPropertySet extending IfcPropertySetDefinition {
        required multi link HasProperties -> IfcProperty;
    }

    abstract type IfcPropertySetDefinition extending IfcPropertyDefinition {
    }

    type IfcPropertySetTemplate extending IfcPropertyTemplateDefinition {
        property ApplicableEntity -> str;
        required property TemplateType -> str {
            constraint one_of ('NOTDEFINED','PSET_OCCURRENCEDRIVEN','PSET_PERFORMANCEDRIVEN','PSET_TYPEDRIVENONLY','PSET_TYPEDRIVENOVERRIDE','QTO_OCCURRENCEDRIVEN','QTO_TYPEDRIVENONLY','QTO_TYPEDRIVENOVERRIDE');
        };
        required multi link HasPropertyTemplates -> IfcPropertyTemplate;
    }

    type IfcPropertySingleValue extending IfcSimpleProperty {
        link NominalValue -> IfcAbsorbedDoseMeasure | IfcAccelerationMeasure | IfcAngularVelocityMeasure | IfcAreaDensityMeasure | IfcCompoundPlaneAngleMeasure | IfcCurvatureMeasure | IfcDoseEquivalentMeasure | IfcDynamicViscosityMeasure | IfcElectricCapacitanceMeasure | IfcElectricChargeMeasure | IfcElectricConductanceMeasure | IfcElectricResistanceMeasure | IfcElectricVoltageMeasure | IfcEnergyMeasure | IfcForceMeasure | IfcFrequencyMeasure | IfcHeatFluxDensityMeasure | IfcHeatingValueMeasure | IfcIlluminanceMeasure | IfcInductanceMeasure | IfcIntegerCountRateMeasure | IfcIonConcentrationMeasure | IfcIsothermalMoistureCapacityMeasure | IfcKinematicViscosityMeasure | IfcLinearForceMeasure | IfcLinearMomentMeasure | IfcLinearStiffnessMeasure | IfcLinearVelocityMeasure | IfcLuminousFluxMeasure | IfcLuminousIntensityDistributionMeasure | IfcMagneticFluxDensityMeasure | IfcMagneticFluxMeasure | IfcMassDensityMeasure | IfcMassFlowRateMeasure | IfcMassPerLengthMeasure | IfcModulusOfElasticityMeasure | IfcModulusOfLinearSubgradeReactionMeasure | IfcModulusOfRotationalSubgradeReactionMeasure | IfcModulusOfSubgradeReactionMeasure | IfcMoistureDiffusivityMeasure | IfcMolecularWeightMeasure | IfcMomentOfInertiaMeasure | IfcMonetaryMeasure | IfcPHMeasure | IfcPlanarForceMeasure | IfcPowerMeasure | IfcPressureMeasure | IfcRadioActivityMeasure | IfcRotationalFrequencyMeasure | IfcRotationalMassMeasure | IfcRotationalStiffnessMeasure | IfcSectionModulusMeasure | IfcSectionalAreaIntegralMeasure | IfcShearModulusMeasure | IfcSoundPowerLevelMeasure | IfcSoundPowerMeasure | IfcSoundPressureLevelMeasure | IfcSoundPressureMeasure | IfcSpecificHeatCapacityMeasure | IfcTemperatureGradientMeasure | IfcTemperatureRateOfChangeMeasure | IfcThermalAdmittanceMeasure | IfcThermalConductivityMeasure | IfcThermalExpansionCoefficientMeasure | IfcThermalResistanceMeasure | IfcThermalTransmittanceMeasure | IfcTorqueMeasure | IfcVaporPermeabilityMeasure | IfcVolumetricFlowRateMeasure | IfcWarpingConstantMeasure | IfcWarpingMomentMeasure | IfcAmountOfSubstanceMeasure | IfcAreaMeasure | IfcComplexNumber | IfcContextDependentMeasure | IfcCountMeasure | IfcDescriptiveMeasure | IfcElectricCurrentMeasure | IfcLengthMeasure | IfcLuminousIntensityMeasure | IfcMassMeasure | IfcNonNegativeLengthMeasure | IfcNormalisedRatioMeasure | IfcNumericMeasure | IfcParameterValue | IfcPlaneAngleMeasure | IfcPositiveLengthMeasure | IfcPositivePlaneAngleMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure | IfcSolidAngleMeasure | IfcThermodynamicTemperatureMeasure | IfcTimeMeasure | IfcVolumeMeasure | IfcBinary | IfcBoolean | IfcDate | IfcDateTime | IfcDuration | IfcIdentifier | IfcInteger | IfcLabel | IfcLogical | IfcPositiveInteger | IfcReal | IfcText | IfcTime | IfcTimeStamp;
        link Unit -> IfcDerivedUnit | IfcMonetaryUnit | IfcNamedUnit;
    }

    type IfcPropertyTableValue extending IfcSimpleProperty {
        property Expression -> str;
        required property CurveInterpolation -> str {
            constraint one_of ('LINEAR','LOG_LINEAR','LOG_LOG','NOTDEFINED');
        };
        link DefiningValues -> IfcAbsorbedDoseMeasure | IfcAccelerationMeasure | IfcAngularVelocityMeasure | IfcAreaDensityMeasure | IfcCompoundPlaneAngleMeasure | IfcCurvatureMeasure | IfcDoseEquivalentMeasure | IfcDynamicViscosityMeasure | IfcElectricCapacitanceMeasure | IfcElectricChargeMeasure | IfcElectricConductanceMeasure | IfcElectricResistanceMeasure | IfcElectricVoltageMeasure | IfcEnergyMeasure | IfcForceMeasure | IfcFrequencyMeasure | IfcHeatFluxDensityMeasure | IfcHeatingValueMeasure | IfcIlluminanceMeasure | IfcInductanceMeasure | IfcIntegerCountRateMeasure | IfcIonConcentrationMeasure | IfcIsothermalMoistureCapacityMeasure | IfcKinematicViscosityMeasure | IfcLinearForceMeasure | IfcLinearMomentMeasure | IfcLinearStiffnessMeasure | IfcLinearVelocityMeasure | IfcLuminousFluxMeasure | IfcLuminousIntensityDistributionMeasure | IfcMagneticFluxDensityMeasure | IfcMagneticFluxMeasure | IfcMassDensityMeasure | IfcMassFlowRateMeasure | IfcMassPerLengthMeasure | IfcModulusOfElasticityMeasure | IfcModulusOfLinearSubgradeReactionMeasure | IfcModulusOfRotationalSubgradeReactionMeasure | IfcModulusOfSubgradeReactionMeasure | IfcMoistureDiffusivityMeasure | IfcMolecularWeightMeasure | IfcMomentOfInertiaMeasure | IfcMonetaryMeasure | IfcPHMeasure | IfcPlanarForceMeasure | IfcPowerMeasure | IfcPressureMeasure | IfcRadioActivityMeasure | IfcRotationalFrequencyMeasure | IfcRotationalMassMeasure | IfcRotationalStiffnessMeasure | IfcSectionModulusMeasure | IfcSectionalAreaIntegralMeasure | IfcShearModulusMeasure | IfcSoundPowerLevelMeasure | IfcSoundPowerMeasure | IfcSoundPressureLevelMeasure | IfcSoundPressureMeasure | IfcSpecificHeatCapacityMeasure | IfcTemperatureGradientMeasure | IfcTemperatureRateOfChangeMeasure | IfcThermalAdmittanceMeasure | IfcThermalConductivityMeasure | IfcThermalExpansionCoefficientMeasure | IfcThermalResistanceMeasure | IfcThermalTransmittanceMeasure | IfcTorqueMeasure | IfcVaporPermeabilityMeasure | IfcVolumetricFlowRateMeasure | IfcWarpingConstantMeasure | IfcWarpingMomentMeasure | IfcAmountOfSubstanceMeasure | IfcAreaMeasure | IfcComplexNumber | IfcContextDependentMeasure | IfcCountMeasure | IfcDescriptiveMeasure | IfcElectricCurrentMeasure | IfcLengthMeasure | IfcLuminousIntensityMeasure | IfcMassMeasure | IfcNonNegativeLengthMeasure | IfcNormalisedRatioMeasure | IfcNumericMeasure | IfcParameterValue | IfcPlaneAngleMeasure | IfcPositiveLengthMeasure | IfcPositivePlaneAngleMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure | IfcSolidAngleMeasure | IfcThermodynamicTemperatureMeasure | IfcTimeMeasure | IfcVolumeMeasure | IfcBinary | IfcBoolean | IfcDate | IfcDateTime | IfcDuration | IfcIdentifier | IfcInteger | IfcLabel | IfcLogical | IfcPositiveInteger | IfcReal | IfcText | IfcTime | IfcTimeStamp;
        link DefinedValues -> IfcAbsorbedDoseMeasure | IfcAccelerationMeasure | IfcAngularVelocityMeasure | IfcAreaDensityMeasure | IfcCompoundPlaneAngleMeasure | IfcCurvatureMeasure | IfcDoseEquivalentMeasure | IfcDynamicViscosityMeasure | IfcElectricCapacitanceMeasure | IfcElectricChargeMeasure | IfcElectricConductanceMeasure | IfcElectricResistanceMeasure | IfcElectricVoltageMeasure | IfcEnergyMeasure | IfcForceMeasure | IfcFrequencyMeasure | IfcHeatFluxDensityMeasure | IfcHeatingValueMeasure | IfcIlluminanceMeasure | IfcInductanceMeasure | IfcIntegerCountRateMeasure | IfcIonConcentrationMeasure | IfcIsothermalMoistureCapacityMeasure | IfcKinematicViscosityMeasure | IfcLinearForceMeasure | IfcLinearMomentMeasure | IfcLinearStiffnessMeasure | IfcLinearVelocityMeasure | IfcLuminousFluxMeasure | IfcLuminousIntensityDistributionMeasure | IfcMagneticFluxDensityMeasure | IfcMagneticFluxMeasure | IfcMassDensityMeasure | IfcMassFlowRateMeasure | IfcMassPerLengthMeasure | IfcModulusOfElasticityMeasure | IfcModulusOfLinearSubgradeReactionMeasure | IfcModulusOfRotationalSubgradeReactionMeasure | IfcModulusOfSubgradeReactionMeasure | IfcMoistureDiffusivityMeasure | IfcMolecularWeightMeasure | IfcMomentOfInertiaMeasure | IfcMonetaryMeasure | IfcPHMeasure | IfcPlanarForceMeasure | IfcPowerMeasure | IfcPressureMeasure | IfcRadioActivityMeasure | IfcRotationalFrequencyMeasure | IfcRotationalMassMeasure | IfcRotationalStiffnessMeasure | IfcSectionModulusMeasure | IfcSectionalAreaIntegralMeasure | IfcShearModulusMeasure | IfcSoundPowerLevelMeasure | IfcSoundPowerMeasure | IfcSoundPressureLevelMeasure | IfcSoundPressureMeasure | IfcSpecificHeatCapacityMeasure | IfcTemperatureGradientMeasure | IfcTemperatureRateOfChangeMeasure | IfcThermalAdmittanceMeasure | IfcThermalConductivityMeasure | IfcThermalExpansionCoefficientMeasure | IfcThermalResistanceMeasure | IfcThermalTransmittanceMeasure | IfcTorqueMeasure | IfcVaporPermeabilityMeasure | IfcVolumetricFlowRateMeasure | IfcWarpingConstantMeasure | IfcWarpingMomentMeasure | IfcAmountOfSubstanceMeasure | IfcAreaMeasure | IfcComplexNumber | IfcContextDependentMeasure | IfcCountMeasure | IfcDescriptiveMeasure | IfcElectricCurrentMeasure | IfcLengthMeasure | IfcLuminousIntensityMeasure | IfcMassMeasure | IfcNonNegativeLengthMeasure | IfcNormalisedRatioMeasure | IfcNumericMeasure | IfcParameterValue | IfcPlaneAngleMeasure | IfcPositiveLengthMeasure | IfcPositivePlaneAngleMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure | IfcSolidAngleMeasure | IfcThermodynamicTemperatureMeasure | IfcTimeMeasure | IfcVolumeMeasure | IfcBinary | IfcBoolean | IfcDate | IfcDateTime | IfcDuration | IfcIdentifier | IfcInteger | IfcLabel | IfcLogical | IfcPositiveInteger | IfcReal | IfcText | IfcTime | IfcTimeStamp;
        link DefiningUnit -> IfcDerivedUnit | IfcMonetaryUnit | IfcNamedUnit;
        link DefinedUnit -> IfcDerivedUnit | IfcMonetaryUnit | IfcNamedUnit;
    }

    abstract type IfcPropertyTemplate extending IfcPropertyTemplateDefinition {
    }

    abstract type IfcPropertyTemplateDefinition extending IfcPropertyDefinition {
    }

    type IfcProtectiveDevice extending IfcFlowController {
        required property PredefinedType -> str {
            constraint one_of ('CIRCUITBREAKER','EARTHINGSWITCH','EARTHLEAKAGECIRCUITBREAKER','FUSEDISCONNECTOR','NOTDEFINED','RESIDUALCURRENTCIRCUITBREAKER','RESIDUALCURRENTSWITCH','USERDEFINED','VARISTOR');
        };
    }

    type IfcProtectiveDeviceTrippingUnit extending IfcDistributionControlElement {
        required property PredefinedType -> str {
            constraint one_of ('ELECTROMAGNETIC','ELECTRONIC','NOTDEFINED','RESIDUALCURRENT','THERMAL','USERDEFINED');
        };
    }

    type IfcProtectiveDeviceTrippingUnitType extending IfcDistributionControlElementType {
        required property PredefinedType -> str {
            constraint one_of ('ELECTROMAGNETIC','ELECTRONIC','NOTDEFINED','RESIDUALCURRENT','THERMAL','USERDEFINED');
        };
    }

    type IfcProtectiveDeviceType extending IfcFlowControllerType {
        required property PredefinedType -> str {
            constraint one_of ('CIRCUITBREAKER','EARTHINGSWITCH','EARTHLEAKAGECIRCUITBREAKER','FUSEDISCONNECTOR','NOTDEFINED','RESIDUALCURRENTCIRCUITBREAKER','RESIDUALCURRENTSWITCH','USERDEFINED','VARISTOR');
        };
    }

    type IfcProxy extending IfcProduct {
        property Tag -> str;
        required property ProxyType -> str {
            constraint one_of ('ACTOR','CONTROL','GROUP','NOTDEFINED','PROCESS','PRODUCT','PROJECT','RESOURCE');
        };
    }

    type IfcPump extending IfcFlowMovingDevice {
        required property PredefinedType -> str {
            constraint one_of ('CIRCULATOR','ENDSUCTION','NOTDEFINED','SPLITCASE','SUBMERSIBLEPUMP','SUMPPUMP','USERDEFINED','VERTICALINLINE','VERTICALTURBINE');
        };
    }

    type IfcPumpType extending IfcFlowMovingDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('CIRCULATOR','ENDSUCTION','NOTDEFINED','SPLITCASE','SUBMERSIBLEPUMP','SUMPPUMP','USERDEFINED','VERTICALINLINE','VERTICALTURBINE');
        };
    }

    type IfcQuantityArea extending IfcPhysicalSimpleQuantity {
        required property AreaValue -> float64;
        property Formula -> str;
    }

    type IfcQuantityCount extending IfcPhysicalSimpleQuantity {
        required property CountValue -> int64;
        property Formula -> str;
    }

    type IfcQuantityLength extending IfcPhysicalSimpleQuantity {
        required property LengthValue -> float64;
        property Formula -> str;
    }

    abstract type IfcQuantitySet extending IfcPropertySetDefinition {
    }

    type IfcQuantityTime extending IfcPhysicalSimpleQuantity {
        required property TimeValue -> float64;
        property Formula -> str;
    }

    type IfcQuantityVolume extending IfcPhysicalSimpleQuantity {
        required property VolumeValue -> float64;
        property Formula -> str;
    }

    type IfcQuantityWeight extending IfcPhysicalSimpleQuantity {
        required property WeightValue -> float64;
        property Formula -> str;
    }

    type IfcRailing extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('BALUSTRADE','GUARDRAIL','HANDRAIL','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcRailingType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('BALUSTRADE','GUARDRAIL','HANDRAIL','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcRamp extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('HALF_TURN_RAMP','NOTDEFINED','QUARTER_TURN_RAMP','SPIRAL_RAMP','STRAIGHT_RUN_RAMP','TWO_QUARTER_TURN_RAMP','TWO_STRAIGHT_RUN_RAMP','USERDEFINED');
        };
    }

    type IfcRampFlight extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','SPIRAL','STRAIGHT','USERDEFINED');
        };
    }

    type IfcRampFlightType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','SPIRAL','STRAIGHT','USERDEFINED');
        };
    }

    type IfcRampType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('HALF_TURN_RAMP','NOTDEFINED','QUARTER_TURN_RAMP','SPIRAL_RAMP','STRAIGHT_RUN_RAMP','TWO_QUARTER_TURN_RAMP','TWO_STRAIGHT_RUN_RAMP','USERDEFINED');
        };
    }

    type IfcRationalBSplineCurveWithKnots extending IfcBSplineCurveWithKnots {
        required property WeightsData -> tuple<float64>;
    }

    type IfcRationalBSplineSurfaceWithKnots extending IfcBSplineSurfaceWithKnots {
        required property WeightsData -> array<tuple<float64>>;
    }

    type IfcRectangleHollowProfileDef extending IfcRectangleProfileDef {
        required property WallThickness -> float64;
        property InnerFilletRadius -> float64;
        property OuterFilletRadius -> float64;
    }

    type IfcRectangleProfileDef extending IfcParameterizedProfileDef {
        required property XDim -> float64;
        required property YDim -> float64;
    }

    type IfcRectangularPyramid extending IfcCsgPrimitive3D {
        required property XLength -> float64;
        required property YLength -> float64;
        required property Height -> float64;
    }

    type IfcRectangularTrimmedSurface extending IfcBoundedSurface {
        required property U1 -> float64;
        required property V1 -> float64;
        required property U2 -> float64;
        required property V2 -> float64;
        required property Usense -> bool;
        required property Vsense -> bool;
        required link BasisSurface -> IfcSurface;
    }

    type IfcRecurrencePattern {
        property DayComponent -> tuple<int64>;
        property WeekdayComponent -> tuple<int64>;
        property MonthComponent -> tuple<int64>;
        property Position -> int64;
        property Interval -> int64;
        property Occurrences -> int64;
        required property RecurrenceType -> str {
            constraint one_of ('BY_DAY_COUNT','BY_WEEKDAY_COUNT','DAILY','MONTHLY_BY_DAY_OF_MONTH','MONTHLY_BY_POSITION','WEEKLY','YEARLY_BY_DAY_OF_MONTH','YEARLY_BY_POSITION');
        };
        multi link TimePeriods -> IfcTimePeriod;
    }

    type IfcReference {
        property TypeIdentifier -> str;
        property AttributeIdentifier -> str;
        property InstanceName -> str;
        property ListPositions -> tuple<int64>;
        link InnerReference -> IfcReference;
    }

    type IfcReferent extending IfcPositioningElement {
        property RestartDistance -> float64;
        required property PredefinedType -> str {
            constraint one_of ('KILOPOINT','MILEPOINT','NOTDEFINED','STATION','USERDEFINED');
        };
    }

    type IfcRegularTimeSeries extending IfcTimeSeries {
        required property TimeStep -> float64;
        required multi link Values -> IfcTimeSeriesValue;
    }

    type IfcReinforcementBarProperties extending IfcPreDefinedProperties {
        required property TotalCrossSectionArea -> float64;
        required property SteelGrade -> str;
        property EffectiveDepth -> float64;
        property NominalBarDiameter -> float64;
        property BarCount -> int64;
        required property BarSurface -> str {
            constraint one_of ('PLAIN','TEXTURED');
        };
    }

    type IfcReinforcementDefinitionProperties extending IfcPreDefinedPropertySet {
        property DefinitionType -> str;
        required multi link ReinforcementSectionDefinitions -> IfcSectionReinforcementProperties;
    }

    type IfcReinforcingBar extending IfcReinforcingElement {
        property NominalDiameter -> float64;
        property CrossSectionArea -> float64;
        property BarLength -> float64;
        required property BarSurface -> str {
            constraint one_of ('PLAIN','TEXTURED');
        };
        required property PredefinedType -> str {
            constraint one_of ('ANCHORING','EDGE','LIGATURE','MAIN','NOTDEFINED','PUNCHING','RING','SHEAR','STUD','USERDEFINED');
        };
    }

    type IfcReinforcingBarType extending IfcReinforcingElementType {
        property NominalDiameter -> float64;
        property CrossSectionArea -> float64;
        property BarLength -> float64;
        property BendingShapeCode -> str;
        required property BarSurface -> str {
            constraint one_of ('PLAIN','TEXTURED');
        };
        required property PredefinedType -> str {
            constraint one_of ('ANCHORING','EDGE','LIGATURE','MAIN','NOTDEFINED','PUNCHING','RING','SHEAR','STUD','USERDEFINED');
        };
        link BendingParameters -> IfcLengthMeasure | IfcPlaneAngleMeasure;
    }

    abstract type IfcReinforcingElement extending IfcElementComponent {
        property SteelGrade -> str;
    }

    abstract type IfcReinforcingElementType extending IfcElementComponentType {
    }

    type IfcReinforcingMesh extending IfcReinforcingElement {
        property MeshLength -> float64;
        property MeshWidth -> float64;
        property LongitudinalBarNominalDiameter -> float64;
        property TransverseBarNominalDiameter -> float64;
        property LongitudinalBarCrossSectionArea -> float64;
        property TransverseBarCrossSectionArea -> float64;
        property LongitudinalBarSpacing -> float64;
        property TransverseBarSpacing -> float64;
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcReinforcingMeshType extending IfcReinforcingElementType {
        property MeshLength -> float64;
        property MeshWidth -> float64;
        property LongitudinalBarNominalDiameter -> float64;
        property TransverseBarNominalDiameter -> float64;
        property LongitudinalBarCrossSectionArea -> float64;
        property TransverseBarCrossSectionArea -> float64;
        property LongitudinalBarSpacing -> float64;
        property TransverseBarSpacing -> float64;
        property BendingShapeCode -> str;
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
        link BendingParameters -> IfcLengthMeasure | IfcPlaneAngleMeasure;
    }

    type IfcRelAggregates extending IfcRelDecomposes {
        required link RelatingObject -> IfcObjectDefinition;
        required multi link RelatedObjects -> IfcObjectDefinition;
    }

    abstract type IfcRelAssigns extending IfcRelationship {
        required property RelatedObjectsType -> str {
            constraint one_of ('ACTOR','CONTROL','GROUP','NOTDEFINED','PROCESS','PRODUCT','PROJECT','RESOURCE');
        };
        required multi link RelatedObjects -> IfcObjectDefinition;
    }

    type IfcRelAssignsToActor extending IfcRelAssigns {
        required link RelatingActor -> IfcActor;
        link ActingRole -> IfcActorRole;
    }

    type IfcRelAssignsToControl extending IfcRelAssigns {
        required link RelatingControl -> IfcControl;
    }

    type IfcRelAssignsToGroup extending IfcRelAssigns {
        required link RelatingGroup -> IfcGroup;
    }

    type IfcRelAssignsToGroupByFactor extending IfcRelAssignsToGroup {
        required property Factor -> float64;
    }

    type IfcRelAssignsToProcess extending IfcRelAssigns {
        required link RelatingProcess -> IfcProcess | IfcTypeProcess;
        link QuantityInProcess -> IfcMeasureWithUnit;
    }

    type IfcRelAssignsToProduct extending IfcRelAssigns {
        required link RelatingProduct -> IfcProduct | IfcTypeProduct;
    }

    type IfcRelAssignsToResource extending IfcRelAssigns {
        required link RelatingResource -> IfcResource | IfcTypeResource;
    }

    abstract type IfcRelAssociates extending IfcRelationship {
        required link RelatedObjects -> IfcObjectDefinition | IfcPropertyDefinition;
    }

    type IfcRelAssociatesApproval extending IfcRelAssociates {
        required link RelatingApproval -> IfcApproval;
    }

    type IfcRelAssociatesClassification extending IfcRelAssociates {
        required link RelatingClassification -> IfcClassification | IfcClassificationReference;
    }

    type IfcRelAssociatesConstraint extending IfcRelAssociates {
        property Intent -> str;
        required link RelatingConstraint -> IfcConstraint;
    }

    type IfcRelAssociatesDocument extending IfcRelAssociates {
        required link RelatingDocument -> IfcDocumentInformation | IfcDocumentReference;
    }

    type IfcRelAssociatesLibrary extending IfcRelAssociates {
        required link RelatingLibrary -> IfcLibraryInformation | IfcLibraryReference;
    }

    type IfcRelAssociatesMaterial extending IfcRelAssociates {
        required link RelatingMaterial -> IfcMaterialDefinition | IfcMaterialList | IfcMaterialUsageDefinition;
    }

    abstract type IfcRelationship extending IfcRoot {
    }

    abstract type IfcRelConnects extending IfcRelationship {
    }

    type IfcRelConnectsElements extending IfcRelConnects {
        link ConnectionGeometry -> IfcConnectionGeometry;
        required link RelatingElement -> IfcElement;
        required link RelatedElement -> IfcElement;
    }

    type IfcRelConnectsPathElements extending IfcRelConnectsElements {
        required property RelatingPriorities -> tuple<int64>;
        required property RelatedPriorities -> tuple<int64>;
        required property RelatedConnectionType -> str {
            constraint one_of ('ATEND','ATPATH','ATSTART','NOTDEFINED');
        };
        required property RelatingConnectionType -> str {
            constraint one_of ('ATEND','ATPATH','ATSTART','NOTDEFINED');
        };
    }

    type IfcRelConnectsPorts extending IfcRelConnects {
        required link RelatingPort -> IfcPort;
        required link RelatedPort -> IfcPort;
        link RealizingElement -> IfcElement;
    }

    type IfcRelConnectsPortToElement extending IfcRelConnects {
        required link RelatingPort -> IfcPort;
        required link RelatedElement -> IfcDistributionElement;
    }

    type IfcRelConnectsStructuralActivity extending IfcRelConnects {
        required link RelatingElement -> IfcElement | IfcStructuralItem;
        required link RelatedStructuralActivity -> IfcStructuralActivity;
    }

    type IfcRelConnectsStructuralMember extending IfcRelConnects {
        property SupportedLength -> float64;
        required link RelatingStructuralMember -> IfcStructuralMember;
        required link RelatedStructuralConnection -> IfcStructuralConnection;
        link AppliedCondition -> IfcBoundaryCondition;
        link AdditionalConditions -> IfcStructuralConnectionCondition;
        link ConditionCoordinateSystem -> IfcAxis2Placement3D;
    }

    type IfcRelConnectsWithEccentricity extending IfcRelConnectsStructuralMember {
        required link ConnectionConstraint -> IfcConnectionGeometry;
    }

    type IfcRelConnectsWithRealizingElements extending IfcRelConnectsElements {
        property ConnectionType -> str;
        required multi link RealizingElements -> IfcElement;
    }

    type IfcRelContainedInSpatialStructure extending IfcRelConnects {
        required multi link RelatedElements -> IfcProduct;
        required link RelatingStructure -> IfcSpatialElement;
    }

    type IfcRelCoversBldgElements extending IfcRelConnects {
        required link RelatingBuildingElement -> IfcElement;
        required multi link RelatedCoverings -> IfcCovering;
    }

    type IfcRelCoversSpaces extending IfcRelConnects {
        required link RelatingSpace -> IfcSpace;
        required multi link RelatedCoverings -> IfcCovering;
    }

    type IfcRelDeclares extending IfcRelationship {
        required link RelatingContext -> IfcContext;
        required link RelatedDefinitions -> IfcObjectDefinition | IfcPropertyDefinition;
    }

    abstract type IfcRelDecomposes extending IfcRelationship {
    }

    abstract type IfcRelDefines extending IfcRelationship {
    }

    type IfcRelDefinesByObject extending IfcRelDefines {
        required multi link RelatedObjects -> IfcObject;
        required link RelatingObject -> IfcObject;
    }

    type IfcRelDefinesByProperties extending IfcRelDefines {
        required multi link RelatedObjects -> IfcObjectDefinition;
        required link RelatingPropertyDefinition -> IfcPropertySetDefinitionSet | IfcPropertySetDefinition;
    }

    type IfcRelDefinesByTemplate extending IfcRelDefines {
        required multi link RelatedPropertySets -> IfcPropertySetDefinition;
        required link RelatingTemplate -> IfcPropertySetTemplate;
    }

    type IfcRelDefinesByType extending IfcRelDefines {
        required multi link RelatedObjects -> IfcObject;
        required link RelatingType -> IfcTypeObject;
    }

    type IfcRelFillsElement extending IfcRelConnects {
        required link RelatingOpeningElement -> IfcOpeningElement;
        required link RelatedBuildingElement -> IfcElement;
    }

    type IfcRelFlowControlElements extending IfcRelConnects {
        required multi link RelatedControlElements -> IfcDistributionControlElement;
        required link RelatingFlowElement -> IfcDistributionFlowElement;
    }

    type IfcRelInterferesElements extending IfcRelConnects {
        property InterferenceType -> str;
        required property ImpliedOrder -> bool;
        required link RelatingElement -> IfcElement;
        required link RelatedElement -> IfcElement;
        link InterferenceGeometry -> IfcConnectionGeometry;
    }

    type IfcRelNests extending IfcRelDecomposes {
        required link RelatingObject -> IfcObjectDefinition;
        required multi link RelatedObjects -> IfcObjectDefinition;
    }

    type IfcRelProjectsElement extending IfcRelDecomposes {
        required link RelatingElement -> IfcElement;
        required link RelatedFeatureElement -> IfcFeatureElementAddition;
    }

    type IfcRelReferencedInSpatialStructure extending IfcRelConnects {
        required multi link RelatedElements -> IfcProduct;
        required link RelatingStructure -> IfcSpatialElement;
    }

    type IfcRelSequence extending IfcRelConnects {
        property UserDefinedSequenceType -> str;
        required property SequenceType -> str {
            constraint one_of ('FINISH_FINISH','FINISH_START','NOTDEFINED','START_FINISH','START_START','USERDEFINED');
        };
        required link RelatingProcess -> IfcProcess;
        required link RelatedProcess -> IfcProcess;
        link TimeLag -> IfcLagTime;
    }

    type IfcRelServicesBuildings extending IfcRelConnects {
        required link RelatingSystem -> IfcSystem;
        required multi link RelatedBuildings -> IfcSpatialElement;
    }

    type IfcRelSpaceBoundary extending IfcRelConnects {
        required property InternalOrExternalBoundary -> str {
            constraint one_of ('EXTERNAL','EXTERNAL_EARTH','EXTERNAL_FIRE','EXTERNAL_WATER','INTERNAL','NOTDEFINED');
        };
        required property PhysicalOrVirtualBoundary -> str {
            constraint one_of ('NOTDEFINED','PHYSICAL','VIRTUAL');
        };
        required link RelatingSpace -> IfcExternalSpatialElement | IfcSpace;
        required link RelatedBuildingElement -> IfcElement;
        link ConnectionGeometry -> IfcConnectionGeometry;
    }

    type IfcRelSpaceBoundary1stLevel extending IfcRelSpaceBoundary {
        link ParentBoundary -> IfcRelSpaceBoundary1stLevel;
    }

    type IfcRelSpaceBoundary2ndLevel extending IfcRelSpaceBoundary1stLevel {
        link CorrespondingBoundary -> IfcRelSpaceBoundary2ndLevel;
    }

    type IfcRelVoidsElement extending IfcRelDecomposes {
        required link RelatingBuildingElement -> IfcElement;
        required link RelatedOpeningElement -> IfcFeatureElementSubtraction;
    }

    type IfcReparametrisedCompositeCurveSegment extending IfcCompositeCurveSegment {
        required property ParamLength -> float64;
    }

    abstract type IfcRepresentation {
        property RepresentationIdentifier -> str;
        property RepresentationType -> str;
        required link ContextOfItems -> IfcRepresentationContext;
        required multi link Items -> IfcRepresentationItem;
    }

    abstract type IfcRepresentationContext {
        property ContextIdentifier -> str;
        property ContextType -> str;
    }

    abstract type IfcRepresentationItem {
    }

    type IfcRepresentationMap {
        required link MappingOrigin -> IfcAxis2Placement2D | IfcAxis2Placement3D;
        required link MappedRepresentation -> IfcRepresentation;
    }

    abstract type IfcResource extending IfcObject {
        property Identification -> str;
        property LongDescription -> str;
    }

    type IfcResourceApprovalRelationship extending IfcResourceLevelRelationship {
        required link RelatedResourceObjects -> IfcActorRole | IfcAppliedValue | IfcApproval | IfcConstraint | IfcContextDependentUnit | IfcConversionBasedUnit | IfcExternalInformation | IfcExternalReference | IfcMaterialDefinition | IfcOrganization | IfcPerson | IfcPersonAndOrganization | IfcPhysicalQuantity | IfcProfileDef | IfcPropertyAbstraction | IfcShapeAspect | IfcTimeSeries;
        required link RelatingApproval -> IfcApproval;
    }

    type IfcResourceConstraintRelationship extending IfcResourceLevelRelationship {
        required link RelatingConstraint -> IfcConstraint;
        required link RelatedResourceObjects -> IfcActorRole | IfcAppliedValue | IfcApproval | IfcConstraint | IfcContextDependentUnit | IfcConversionBasedUnit | IfcExternalInformation | IfcExternalReference | IfcMaterialDefinition | IfcOrganization | IfcPerson | IfcPersonAndOrganization | IfcPhysicalQuantity | IfcProfileDef | IfcPropertyAbstraction | IfcShapeAspect | IfcTimeSeries;
    }

    abstract type IfcResourceLevelRelationship {
        property Name -> str;
        property Description -> str;
    }

    type IfcResourceTime extending IfcSchedulingTime {
        property ScheduleWork -> str;
        property ScheduleUsage -> float64;
        property ScheduleStart -> str;
        property ScheduleFinish -> str;
        property ScheduleContour -> str;
        property LevelingDelay -> str;
        property IsOverAllocated -> bool;
        property StatusTime -> str;
        property ActualWork -> str;
        property ActualUsage -> float64;
        property ActualStart -> str;
        property ActualFinish -> str;
        property RemainingWork -> str;
        property RemainingUsage -> float64;
        property Completion -> float64;
    }

    type IfcRevolvedAreaSolid extending IfcSweptAreaSolid {
        required property Angle -> float64;
        required link Axis -> IfcAxis1Placement;
    }

    type IfcRevolvedAreaSolidTapered extending IfcRevolvedAreaSolid {
        required link EndSweptArea -> IfcProfileDef;
    }

    type IfcRightCircularCone extending IfcCsgPrimitive3D {
        required property Height -> float64;
        required property BottomRadius -> float64;
    }

    type IfcRightCircularCylinder extending IfcCsgPrimitive3D {
        required property Height -> float64;
        required property Radius -> float64;
    }

    type IfcRoof extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('BARREL_ROOF','BUTTERFLY_ROOF','DOME_ROOF','FLAT_ROOF','FREEFORM','GABLE_ROOF','GAMBREL_ROOF','HIPPED_GABLE_ROOF','HIP_ROOF','MANSARD_ROOF','NOTDEFINED','PAVILION_ROOF','RAINBOW_ROOF','SHED_ROOF','USERDEFINED');
        };
    }

    type IfcRoofType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('BARREL_ROOF','BUTTERFLY_ROOF','DOME_ROOF','FLAT_ROOF','FREEFORM','GABLE_ROOF','GAMBREL_ROOF','HIPPED_GABLE_ROOF','HIP_ROOF','MANSARD_ROOF','NOTDEFINED','PAVILION_ROOF','RAINBOW_ROOF','SHED_ROOF','USERDEFINED');
        };
    }

    abstract type IfcRoot {
        required property GlobalId -> str;
        property Name -> str;
        property Description -> str;
        link OwnerHistory -> IfcOwnerHistory;
    }

    type IfcRoundedRectangleProfileDef extending IfcRectangleProfileDef {
        required property RoundingRadius -> float64;
    }

    type IfcSanitaryTerminal extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('BATH','BIDET','CISTERN','NOTDEFINED','SANITARYFOUNTAIN','SHOWER','SINK','TOILETPAN','URINAL','USERDEFINED','WASHHANDBASIN','WCSEAT');
        };
    }

    type IfcSanitaryTerminalType extending IfcFlowTerminalType {
        required property PredefinedType -> str {
            constraint one_of ('BATH','BIDET','CISTERN','NOTDEFINED','SANITARYFOUNTAIN','SHOWER','SINK','TOILETPAN','URINAL','USERDEFINED','WASHHANDBASIN','WCSEAT');
        };
    }

    abstract type IfcSchedulingTime {
        property Name -> str;
        property UserDefinedDataOrigin -> str;
        required property DataOrigin -> str {
            constraint one_of ('MEASURED','NOTDEFINED','PREDICTED','SIMULATED','USERDEFINED');
        };
    }

    type IfcSeamCurve extending IfcSurfaceCurve {
    }

    abstract type IfcSectionedSolid extending IfcSolidModel {
        required link Directrix -> IfcCurve;
        required multi link CrossSections -> IfcProfileDef;
    }

    type IfcSectionedSolidHorizontal extending IfcSectionedSolid {
        required property FixedAxisVertical -> bool;
        required multi link CrossSectionPositions -> IfcDistanceExpression;
    }

    type IfcSectionedSpine extending IfcGeometricRepresentationItem {
        required link SpineCurve -> IfcCompositeCurve;
        required multi link CrossSections -> IfcProfileDef;
        required multi link CrossSectionPositions -> IfcAxis2Placement3D;
    }

    type IfcSectionProperties extending IfcPreDefinedProperties {
        required property SectionType -> str {
            constraint one_of ('TAPERED','UNIFORM');
        };
        required link StartProfile -> IfcProfileDef;
        link EndProfile -> IfcProfileDef;
    }

    type IfcSectionReinforcementProperties extending IfcPreDefinedProperties {
        required property LongitudinalStartPosition -> float64;
        required property LongitudinalEndPosition -> float64;
        property TransversePosition -> float64;
        required property ReinforcementRole -> str {
            constraint one_of ('ANCHORING','EDGE','LIGATURE','MAIN','NOTDEFINED','PUNCHING','RING','SHEAR','STUD','USERDEFINED');
        };
        required link SectionDefinition -> IfcSectionProperties;
        required multi link CrossSectionReinforcementDefinitions -> IfcReinforcementBarProperties;
    }

    type IfcSensor extending IfcDistributionControlElement {
        required property PredefinedType -> str {
            constraint one_of ('CO2SENSOR','CONDUCTANCESENSOR','CONTACTSENSOR','COSENSOR','FIRESENSOR','FLOWSENSOR','FROSTSENSOR','GASSENSOR','HEATSENSOR','HUMIDITYSENSOR','IDENTIFIERSENSOR','IONCONCENTRATIONSENSOR','LEVELSENSOR','LIGHTSENSOR','MOISTURESENSOR','MOVEMENTSENSOR','NOTDEFINED','PHSENSOR','PRESSURESENSOR','RADIATIONSENSOR','RADIOACTIVITYSENSOR','SMOKESENSOR','SOUNDSENSOR','TEMPERATURESENSOR','USERDEFINED','WINDSENSOR');
        };
    }

    type IfcSensorType extending IfcDistributionControlElementType {
        required property PredefinedType -> str {
            constraint one_of ('CO2SENSOR','CONDUCTANCESENSOR','CONTACTSENSOR','COSENSOR','FIRESENSOR','FLOWSENSOR','FROSTSENSOR','GASSENSOR','HEATSENSOR','HUMIDITYSENSOR','IDENTIFIERSENSOR','IONCONCENTRATIONSENSOR','LEVELSENSOR','LIGHTSENSOR','MOISTURESENSOR','MOVEMENTSENSOR','NOTDEFINED','PHSENSOR','PRESSURESENSOR','RADIATIONSENSOR','RADIOACTIVITYSENSOR','SMOKESENSOR','SOUNDSENSOR','TEMPERATURESENSOR','USERDEFINED','WINDSENSOR');
        };
    }

    type IfcShadingDevice extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('AWNING','JALOUSIE','NOTDEFINED','SHUTTER','USERDEFINED');
        };
    }

    type IfcShadingDeviceType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('AWNING','JALOUSIE','NOTDEFINED','SHUTTER','USERDEFINED');
        };
    }

    type IfcShapeAspect {
        property Name -> str;
        property Description -> str;
        required property ProductDefinitional -> bool;
        required multi link ShapeRepresentations -> IfcShapeModel;
        link PartOfProductDefinitionShape -> IfcProductDefinitionShape | IfcRepresentationMap;
    }

    abstract type IfcShapeModel extending IfcRepresentation {
    }

    type IfcShapeRepresentation extending IfcShapeModel {
    }

    type IfcShellBasedSurfaceModel extending IfcGeometricRepresentationItem {
        required link SbsmBoundary -> IfcClosedShell | IfcOpenShell;
    }

    abstract type IfcSimpleProperty extending IfcProperty {
    }

    type IfcSimplePropertyTemplate extending IfcPropertyTemplate {
        property PrimaryMeasureType -> str;
        property SecondaryMeasureType -> str;
        property Expression -> str;
        required property TemplateType -> str {
            constraint one_of ('P_BOUNDEDVALUE','P_ENUMERATEDVALUE','P_LISTVALUE','P_REFERENCEVALUE','P_SINGLEVALUE','P_TABLEVALUE','Q_AREA','Q_COUNT','Q_LENGTH','Q_TIME','Q_VOLUME','Q_WEIGHT');
        };
        required property AccessState -> str {
            constraint one_of ('LOCKED','READONLY','READONLYLOCKED','READWRITE','READWRITELOCKED');
        };
        link Enumerators -> IfcPropertyEnumeration;
        link PrimaryUnit -> IfcDerivedUnit | IfcMonetaryUnit | IfcNamedUnit;
        link SecondaryUnit -> IfcDerivedUnit | IfcMonetaryUnit | IfcNamedUnit;
    }

    type IfcSite extending IfcSpatialStructureElement {
        property RefLatitude -> int64;
        property RefLongitude -> int64;
        property RefElevation -> float64;
        property LandTitleNumber -> str;
        link SiteAddress -> IfcPostalAddress;
    }

    type IfcSIUnit extending IfcNamedUnit {
        required property Prefix -> str {
            constraint one_of ('ATTO','CENTI','DECA','DECI','EXA','FEMTO','GIGA','HECTO','KILO','MEGA','MICRO','MILLI','NANO','PETA','PICO','TERA');
        };
        required property Name -> str {
            constraint one_of ('AMPERE','BECQUEREL','CANDELA','COULOMB','CUBIC_METRE','DEGREE_CELSIUS','FARAD','GRAM','GRAY','HENRY','HERTZ','JOULE','KELVIN','LUMEN','LUX','METRE','MOLE','NEWTON','OHM','PASCAL','RADIAN','SECOND','SIEMENS','SIEVERT','SQUARE_METRE','STERADIAN','TESLA','VOLT','WATT','WEBER');
        };
    }

    type IfcSlab extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('BASESLAB','FLOOR','LANDING','NOTDEFINED','ROOF','USERDEFINED');
        };
    }

    type IfcSlabElementedCase extending IfcSlab {
    }

    type IfcSlabStandardCase extending IfcSlab {
    }

    type IfcSlabType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('BASESLAB','FLOOR','LANDING','NOTDEFINED','ROOF','USERDEFINED');
        };
    }

    type IfcSlippageConnectionCondition extending IfcStructuralConnectionCondition {
        property SlippageX -> float64;
        property SlippageY -> float64;
        property SlippageZ -> float64;
    }

    type IfcSolarDevice extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','SOLARCOLLECTOR','SOLARPANEL','USERDEFINED');
        };
    }

    type IfcSolarDeviceType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','SOLARCOLLECTOR','SOLARPANEL','USERDEFINED');
        };
    }

    abstract type IfcSolidModel extending IfcGeometricRepresentationItem {
    }

    type IfcSpace extending IfcSpatialStructureElement {
        property ElevationWithFlooring -> float64;
        required property PredefinedType -> str {
            constraint one_of ('EXTERNAL','GFA','INTERNAL','NOTDEFINED','PARKING','SPACE','USERDEFINED');
        };
    }

    type IfcSpaceHeater extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('CONVECTOR','NOTDEFINED','RADIATOR','USERDEFINED');
        };
    }

    type IfcSpaceHeaterType extending IfcFlowTerminalType {
        required property PredefinedType -> str {
            constraint one_of ('CONVECTOR','NOTDEFINED','RADIATOR','USERDEFINED');
        };
    }

    type IfcSpaceType extending IfcSpatialStructureElementType {
        property LongName -> str;
        required property PredefinedType -> str {
            constraint one_of ('EXTERNAL','GFA','INTERNAL','NOTDEFINED','PARKING','SPACE','USERDEFINED');
        };
    }

    abstract type IfcSpatialElement extending IfcProduct {
        property LongName -> str;
    }

    abstract type IfcSpatialElementType extending IfcTypeProduct {
        property ElementType -> str;
    }

    abstract type IfcSpatialStructureElement extending IfcSpatialElement {
        required property CompositionType -> str {
            constraint one_of ('COMPLEX','ELEMENT','PARTIAL');
        };
    }

    abstract type IfcSpatialStructureElementType extending IfcSpatialElementType {
    }

    type IfcSpatialZone extending IfcSpatialElement {
        required property PredefinedType -> str {
            constraint one_of ('CONSTRUCTION','FIRESAFETY','LIGHTING','NOTDEFINED','OCCUPANCY','SECURITY','THERMAL','TRANSPORT','USERDEFINED','VENTILATION');
        };
    }

    type IfcSpatialZoneType extending IfcSpatialElementType {
        property LongName -> str;
        required property PredefinedType -> str {
            constraint one_of ('CONSTRUCTION','FIRESAFETY','LIGHTING','NOTDEFINED','OCCUPANCY','SECURITY','THERMAL','TRANSPORT','USERDEFINED','VENTILATION');
        };
    }

    type IfcSphere extending IfcCsgPrimitive3D {
        required property Radius -> float64;
    }

    type IfcSphericalSurface extending IfcElementarySurface {
        required property Radius -> float64;
    }

    type IfcStackTerminal extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('BIRDCAGE','COWL','NOTDEFINED','RAINWATERHOPPER','USERDEFINED');
        };
    }

    type IfcStackTerminalType extending IfcFlowTerminalType {
        required property PredefinedType -> str {
            constraint one_of ('BIRDCAGE','COWL','NOTDEFINED','RAINWATERHOPPER','USERDEFINED');
        };
    }

    type IfcStair extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('CURVED_RUN_STAIR','DOUBLE_RETURN_STAIR','HALF_TURN_STAIR','HALF_WINDING_STAIR','NOTDEFINED','QUARTER_TURN_STAIR','QUARTER_WINDING_STAIR','SPIRAL_STAIR','STRAIGHT_RUN_STAIR','THREE_QUARTER_TURN_STAIR','THREE_QUARTER_WINDING_STAIR','TWO_CURVED_RUN_STAIR','TWO_QUARTER_TURN_STAIR','TWO_QUARTER_WINDING_STAIR','TWO_STRAIGHT_RUN_STAIR','USERDEFINED');
        };
    }

    type IfcStairFlight extending IfcBuildingElement {
        property NumberOfRisers -> int64;
        property NumberOfTreads -> int64;
        property RiserHeight -> float64;
        property TreadLength -> float64;
        required property PredefinedType -> str {
            constraint one_of ('CURVED','FREEFORM','NOTDEFINED','SPIRAL','STRAIGHT','USERDEFINED','WINDER');
        };
    }

    type IfcStairFlightType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('CURVED','FREEFORM','NOTDEFINED','SPIRAL','STRAIGHT','USERDEFINED','WINDER');
        };
    }

    type IfcStairType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('CURVED_RUN_STAIR','DOUBLE_RETURN_STAIR','HALF_TURN_STAIR','HALF_WINDING_STAIR','NOTDEFINED','QUARTER_TURN_STAIR','QUARTER_WINDING_STAIR','SPIRAL_STAIR','STRAIGHT_RUN_STAIR','THREE_QUARTER_TURN_STAIR','THREE_QUARTER_WINDING_STAIR','TWO_CURVED_RUN_STAIR','TWO_QUARTER_TURN_STAIR','TWO_QUARTER_WINDING_STAIR','TWO_STRAIGHT_RUN_STAIR','USERDEFINED');
        };
    }

    abstract type IfcStructuralAction extending IfcStructuralActivity {
        property DestabilizingLoad -> bool;
    }

    abstract type IfcStructuralActivity extending IfcProduct {
        required property GlobalOrLocal -> str {
            constraint one_of ('GLOBAL_COORDS','LOCAL_COORDS');
        };
        required link AppliedLoad -> IfcStructuralLoad;
    }

    type IfcStructuralAnalysisModel extending IfcSystem {
        required property PredefinedType -> str {
            constraint one_of ('IN_PLANE_LOADING_2D','LOADING_3D','NOTDEFINED','OUT_PLANE_LOADING_2D','USERDEFINED');
        };
        link OrientationOf2DPlane -> IfcAxis2Placement3D;
        multi link LoadedBy -> IfcStructuralLoadGroup;
        multi link HasResults -> IfcStructuralResultGroup;
        link SharedPlacement -> IfcObjectPlacement;
    }

    abstract type IfcStructuralConnection extending IfcStructuralItem {
        link AppliedCondition -> IfcBoundaryCondition;
    }

    abstract type IfcStructuralConnectionCondition {
        property Name -> str;
    }

    type IfcStructuralCurveAction extending IfcStructuralAction {
        required property ProjectedOrTrue -> str {
            constraint one_of ('PROJECTED_LENGTH','TRUE_LENGTH');
        };
        required property PredefinedType -> str {
            constraint one_of ('CONST','DISCRETE','EQUIDISTANT','LINEAR','NOTDEFINED','PARABOLA','POLYGONAL','SINUS','USERDEFINED');
        };
    }

    type IfcStructuralCurveConnection extending IfcStructuralConnection {
        required link Axis -> IfcDirection;
    }

    type IfcStructuralCurveMember extending IfcStructuralMember {
        required property PredefinedType -> str {
            constraint one_of ('CABLE','COMPRESSION_MEMBER','NOTDEFINED','PIN_JOINED_MEMBER','RIGID_JOINED_MEMBER','TENSION_MEMBER','USERDEFINED');
        };
        required link Axis -> IfcDirection;
    }

    type IfcStructuralCurveMemberVarying extending IfcStructuralCurveMember {
    }

    type IfcStructuralCurveReaction extending IfcStructuralReaction {
        required property PredefinedType -> str {
            constraint one_of ('CONST','DISCRETE','EQUIDISTANT','LINEAR','NOTDEFINED','PARABOLA','POLYGONAL','SINUS','USERDEFINED');
        };
    }

    abstract type IfcStructuralItem extending IfcProduct {
    }

    type IfcStructuralLinearAction extending IfcStructuralCurveAction {
    }

    abstract type IfcStructuralLoad {
        property Name -> str;
    }

    type IfcStructuralLoadCase extending IfcStructuralLoadGroup {
        property SelfWeightCoefficients -> tuple<float64,float64,float64>;
    }

    type IfcStructuralLoadConfiguration extending IfcStructuralLoad {
        property Locations -> array<tuple<float64>>{
            constraint expression on (len(__subject__) = 1 or len(__subject__) = 2)
        };
        required multi link Values -> IfcStructuralLoadOrResult;
    }

    type IfcStructuralLoadGroup extending IfcGroup {
        property Coefficient -> float64;
        property Purpose -> str;
        required property ActionSource -> str {
            constraint one_of ('BRAKES','BUOYANCY','COMPLETION_G1','CREEP','CURRENT','DEAD_LOAD_G','EARTHQUAKE_E','ERECTION','FIRE','ICE','IMPACT','IMPULSE','LACK_OF_FIT','LIVE_LOAD_Q','NOTDEFINED','PRESTRESSING_P','PROPPING','RAIN','SETTLEMENT_U','SHRINKAGE','SNOW_S','SYSTEM_IMPERFECTION','TEMPERATURE_T','TRANSPORT','USERDEFINED','WAVE','WIND_W');
        };
        required property ActionType -> str {
            constraint one_of ('EXTRAORDINARY_A','NOTDEFINED','PERMANENT_G','USERDEFINED','VARIABLE_Q');
        };
        required property PredefinedType -> str {
            constraint one_of ('LOAD_CASE','LOAD_COMBINATION','LOAD_GROUP','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcStructuralLoadLinearForce extending IfcStructuralLoadStatic {
        property LinearForceX -> float64;
        property LinearForceY -> float64;
        property LinearForceZ -> float64;
        property LinearMomentX -> float64;
        property LinearMomentY -> float64;
        property LinearMomentZ -> float64;
    }

    abstract type IfcStructuralLoadOrResult extending IfcStructuralLoad {
    }

    type IfcStructuralLoadPlanarForce extending IfcStructuralLoadStatic {
        property PlanarForceX -> float64;
        property PlanarForceY -> float64;
        property PlanarForceZ -> float64;
    }

    type IfcStructuralLoadSingleDisplacement extending IfcStructuralLoadStatic {
        property DisplacementX -> float64;
        property DisplacementY -> float64;
        property DisplacementZ -> float64;
        property RotationalDisplacementRX -> float64;
        property RotationalDisplacementRY -> float64;
        property RotationalDisplacementRZ -> float64;
    }

    type IfcStructuralLoadSingleDisplacementDistortion extending IfcStructuralLoadSingleDisplacement {
        property Distortion -> float64;
    }

    type IfcStructuralLoadSingleForce extending IfcStructuralLoadStatic {
        property ForceX -> float64;
        property ForceY -> float64;
        property ForceZ -> float64;
        property MomentX -> float64;
        property MomentY -> float64;
        property MomentZ -> float64;
    }

    type IfcStructuralLoadSingleForceWarping extending IfcStructuralLoadSingleForce {
        property WarpingMoment -> float64;
    }

    abstract type IfcStructuralLoadStatic extending IfcStructuralLoadOrResult {
    }

    type IfcStructuralLoadTemperature extending IfcStructuralLoadStatic {
        property DeltaTConstant -> float64;
        property DeltaTY -> float64;
        property DeltaTZ -> float64;
    }

    abstract type IfcStructuralMember extending IfcStructuralItem {
    }

    type IfcStructuralPlanarAction extending IfcStructuralSurfaceAction {
    }

    type IfcStructuralPointAction extending IfcStructuralAction {
    }

    type IfcStructuralPointConnection extending IfcStructuralConnection {
        link ConditionCoordinateSystem -> IfcAxis2Placement3D;
    }

    type IfcStructuralPointReaction extending IfcStructuralReaction {
    }

    abstract type IfcStructuralReaction extending IfcStructuralActivity {
    }

    type IfcStructuralResultGroup extending IfcGroup {
        required property IsLinear -> bool;
        required property TheoryType -> str {
            constraint one_of ('FIRST_ORDER_THEORY','FULL_NONLINEAR_THEORY','NOTDEFINED','SECOND_ORDER_THEORY','THIRD_ORDER_THEORY','USERDEFINED');
        };
        link ResultForLoadGroup -> IfcStructuralLoadGroup;
    }

    type IfcStructuralSurfaceAction extending IfcStructuralAction {
        required property ProjectedOrTrue -> str {
            constraint one_of ('PROJECTED_LENGTH','TRUE_LENGTH');
        };
        required property PredefinedType -> str {
            constraint one_of ('BILINEAR','CONST','DISCRETE','ISOCONTOUR','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcStructuralSurfaceConnection extending IfcStructuralConnection {
    }

    type IfcStructuralSurfaceMember extending IfcStructuralMember {
        property Thickness -> float64;
        required property PredefinedType -> str {
            constraint one_of ('BENDING_ELEMENT','MEMBRANE_ELEMENT','NOTDEFINED','SHELL','USERDEFINED');
        };
    }

    type IfcStructuralSurfaceMemberVarying extending IfcStructuralSurfaceMember {
    }

    type IfcStructuralSurfaceReaction extending IfcStructuralReaction {
        required property PredefinedType -> str {
            constraint one_of ('BILINEAR','CONST','DISCRETE','ISOCONTOUR','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcStyledItem extending IfcRepresentationItem {
        property Name -> str;
        link Item -> IfcRepresentationItem;
        required link Styles -> IfcPresentationStyle | IfcPresentationStyleAssignment;
    }

    type IfcStyledRepresentation extending IfcStyleModel {
    }

    abstract type IfcStyleModel extending IfcRepresentation {
    }

    type IfcSubContractResource extending IfcConstructionResource {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','PURCHASE','USERDEFINED','WORK');
        };
    }

    type IfcSubContractResourceType extending IfcConstructionResourceType {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','PURCHASE','USERDEFINED','WORK');
        };
    }

    type IfcSubedge extending IfcEdge {
        required link ParentEdge -> IfcEdge;
    }

    abstract type IfcSurface extending IfcGeometricRepresentationItem {
    }

    type IfcSurfaceCurve extending IfcCurve {
        required property MasterRepresentation -> str {
            constraint one_of ('CURVE3D','PCURVE_S1','PCURVE_S2');
        };
        required link Curve3D -> IfcCurve;
        required multi link AssociatedGeometry -> IfcPcurve;
    }

    type IfcSurfaceCurveSweptAreaSolid extending IfcSweptAreaSolid {
        property StartParam -> float64;
        property EndParam -> float64;
        required link Directrix -> IfcCurve;
        required link ReferenceSurface -> IfcSurface;
    }

    type IfcSurfaceFeature extending IfcFeatureElement {
        required property PredefinedType -> str {
            constraint one_of ('MARK','NOTDEFINED','TAG','TREATMENT','USERDEFINED');
        };
    }

    type IfcSurfaceOfLinearExtrusion extending IfcSweptSurface {
        required property Depth -> float64;
        required link ExtrudedDirection -> IfcDirection;
    }

    type IfcSurfaceOfRevolution extending IfcSweptSurface {
        required link AxisPosition -> IfcAxis1Placement;
    }

    type IfcSurfaceReinforcementArea extending IfcStructuralLoadOrResult {
        property SurfaceReinforcement1 -> array<float64>{
            constraint expression on (len(__subject__) = 2 or len(__subject__) = 3)
        };
        property SurfaceReinforcement2 -> array<float64>{
            constraint expression on (len(__subject__) = 2 or len(__subject__) = 3)
        };
        property ShearReinforcement -> float64;
    }

    type IfcSurfaceStyle extending IfcPresentationStyle {
        required property Side -> str {
            constraint one_of ('BOTH','NEGATIVE','POSITIVE');
        };
        required link Styles -> IfcExternallyDefinedSurfaceStyle | IfcSurfaceStyleLighting | IfcSurfaceStyleRefraction | IfcSurfaceStyleShading | IfcSurfaceStyleWithTextures;
    }

    type IfcSurfaceStyleLighting extending IfcPresentationItem {
        required link DiffuseTransmissionColour -> IfcColourRgb;
        required link DiffuseReflectionColour -> IfcColourRgb;
        required link TransmissionColour -> IfcColourRgb;
        required link ReflectanceColour -> IfcColourRgb;
    }

    type IfcSurfaceStyleRefraction extending IfcPresentationItem {
        property RefractionIndex -> float64;
        property DispersionFactor -> float64;
    }

    type IfcSurfaceStyleRendering extending IfcSurfaceStyleShading {
        required property ReflectanceMethod -> str {
            constraint one_of ('BLINN','FLAT','GLASS','MATT','METAL','MIRROR','NOTDEFINED','PHONG','PLASTIC','STRAUSS');
        };
        link DiffuseColour -> IfcNormalisedRatioMeasure | IfcColourRgb;
        link TransmissionColour -> IfcNormalisedRatioMeasure | IfcColourRgb;
        link DiffuseTransmissionColour -> IfcNormalisedRatioMeasure | IfcColourRgb;
        link ReflectionColour -> IfcNormalisedRatioMeasure | IfcColourRgb;
        link SpecularColour -> IfcNormalisedRatioMeasure | IfcColourRgb;
        link SpecularHighlight -> IfcSpecularExponent | IfcSpecularRoughness;
    }

    type IfcSurfaceStyleShading extending IfcPresentationItem {
        property Transparency -> float64;
        required link SurfaceColour -> IfcColourRgb;
    }

    type IfcSurfaceStyleWithTextures extending IfcPresentationItem {
        required multi link Textures -> IfcSurfaceTexture;
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

    type IfcSweptDiskSolid extending IfcSolidModel {
        required property Radius -> float64;
        property InnerRadius -> float64;
        property StartParam -> float64;
        property EndParam -> float64;
        required link Directrix -> IfcCurve;
    }

    type IfcSweptDiskSolidPolygonal extending IfcSweptDiskSolid {
        property FilletRadius -> float64;
    }

    abstract type IfcSweptSurface extending IfcSurface {
        required link SweptCurve -> IfcProfileDef;
        link Position -> IfcAxis2Placement3D;
    }

    type IfcSwitchingDevice extending IfcFlowController {
        required property PredefinedType -> str {
            constraint one_of ('CONTACTOR','DIMMERSWITCH','EMERGENCYSTOP','KEYPAD','MOMENTARYSWITCH','NOTDEFINED','SELECTORSWITCH','STARTER','SWITCHDISCONNECTOR','TOGGLESWITCH','USERDEFINED');
        };
    }

    type IfcSwitchingDeviceType extending IfcFlowControllerType {
        required property PredefinedType -> str {
            constraint one_of ('CONTACTOR','DIMMERSWITCH','EMERGENCYSTOP','KEYPAD','MOMENTARYSWITCH','NOTDEFINED','SELECTORSWITCH','STARTER','SWITCHDISCONNECTOR','TOGGLESWITCH','USERDEFINED');
        };
    }

    type IfcSystem extending IfcGroup {
    }

    type IfcSystemFurnitureElement extending IfcFurnishingElement {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','PANEL','USERDEFINED','WORKSURFACE');
        };
    }

    type IfcSystemFurnitureElementType extending IfcFurnishingElementType {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','PANEL','USERDEFINED','WORKSURFACE');
        };
    }

    type IfcTable {
        property Name -> str;
        multi link Rows -> IfcTableRow;
        multi link Columns -> IfcTableColumn;
    }

    type IfcTableColumn {
        property Identifier -> str;
        property Name -> str;
        property Description -> str;
        link Unit -> IfcDerivedUnit | IfcMonetaryUnit | IfcNamedUnit;
        link ReferencePath -> IfcReference;
    }

    type IfcTableRow {
        property IsHeading -> bool;
        link RowCells -> IfcAbsorbedDoseMeasure | IfcAccelerationMeasure | IfcAngularVelocityMeasure | IfcAreaDensityMeasure | IfcCompoundPlaneAngleMeasure | IfcCurvatureMeasure | IfcDoseEquivalentMeasure | IfcDynamicViscosityMeasure | IfcElectricCapacitanceMeasure | IfcElectricChargeMeasure | IfcElectricConductanceMeasure | IfcElectricResistanceMeasure | IfcElectricVoltageMeasure | IfcEnergyMeasure | IfcForceMeasure | IfcFrequencyMeasure | IfcHeatFluxDensityMeasure | IfcHeatingValueMeasure | IfcIlluminanceMeasure | IfcInductanceMeasure | IfcIntegerCountRateMeasure | IfcIonConcentrationMeasure | IfcIsothermalMoistureCapacityMeasure | IfcKinematicViscosityMeasure | IfcLinearForceMeasure | IfcLinearMomentMeasure | IfcLinearStiffnessMeasure | IfcLinearVelocityMeasure | IfcLuminousFluxMeasure | IfcLuminousIntensityDistributionMeasure | IfcMagneticFluxDensityMeasure | IfcMagneticFluxMeasure | IfcMassDensityMeasure | IfcMassFlowRateMeasure | IfcMassPerLengthMeasure | IfcModulusOfElasticityMeasure | IfcModulusOfLinearSubgradeReactionMeasure | IfcModulusOfRotationalSubgradeReactionMeasure | IfcModulusOfSubgradeReactionMeasure | IfcMoistureDiffusivityMeasure | IfcMolecularWeightMeasure | IfcMomentOfInertiaMeasure | IfcMonetaryMeasure | IfcPHMeasure | IfcPlanarForceMeasure | IfcPowerMeasure | IfcPressureMeasure | IfcRadioActivityMeasure | IfcRotationalFrequencyMeasure | IfcRotationalMassMeasure | IfcRotationalStiffnessMeasure | IfcSectionModulusMeasure | IfcSectionalAreaIntegralMeasure | IfcShearModulusMeasure | IfcSoundPowerLevelMeasure | IfcSoundPowerMeasure | IfcSoundPressureLevelMeasure | IfcSoundPressureMeasure | IfcSpecificHeatCapacityMeasure | IfcTemperatureGradientMeasure | IfcTemperatureRateOfChangeMeasure | IfcThermalAdmittanceMeasure | IfcThermalConductivityMeasure | IfcThermalExpansionCoefficientMeasure | IfcThermalResistanceMeasure | IfcThermalTransmittanceMeasure | IfcTorqueMeasure | IfcVaporPermeabilityMeasure | IfcVolumetricFlowRateMeasure | IfcWarpingConstantMeasure | IfcWarpingMomentMeasure | IfcAmountOfSubstanceMeasure | IfcAreaMeasure | IfcComplexNumber | IfcContextDependentMeasure | IfcCountMeasure | IfcDescriptiveMeasure | IfcElectricCurrentMeasure | IfcLengthMeasure | IfcLuminousIntensityMeasure | IfcMassMeasure | IfcNonNegativeLengthMeasure | IfcNormalisedRatioMeasure | IfcNumericMeasure | IfcParameterValue | IfcPlaneAngleMeasure | IfcPositiveLengthMeasure | IfcPositivePlaneAngleMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure | IfcSolidAngleMeasure | IfcThermodynamicTemperatureMeasure | IfcTimeMeasure | IfcVolumeMeasure | IfcBinary | IfcBoolean | IfcDate | IfcDateTime | IfcDuration | IfcIdentifier | IfcInteger | IfcLabel | IfcLogical | IfcPositiveInteger | IfcReal | IfcText | IfcTime | IfcTimeStamp;
    }

    type IfcTank extending IfcFlowStorageDevice {
        required property PredefinedType -> str {
            constraint one_of ('BASIN','BREAKPRESSURE','EXPANSION','FEEDANDEXPANSION','NOTDEFINED','PRESSUREVESSEL','STORAGE','USERDEFINED','VESSEL');
        };
    }

    type IfcTankType extending IfcFlowStorageDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('BASIN','BREAKPRESSURE','EXPANSION','FEEDANDEXPANSION','NOTDEFINED','PRESSUREVESSEL','STORAGE','USERDEFINED','VESSEL');
        };
    }

    type IfcTask extending IfcProcess {
        property Status -> str;
        property WorkMethod -> str;
        required property IsMilestone -> bool;
        property Priority -> int64;
        required property PredefinedType -> str {
            constraint one_of ('ATTENDANCE','CONSTRUCTION','DEMOLITION','DISMANTLE','DISPOSAL','INSTALLATION','LOGISTIC','MAINTENANCE','MOVE','NOTDEFINED','OPERATION','REMOVAL','RENOVATION','USERDEFINED');
        };
        link TaskTime -> IfcTaskTime;
    }

    type IfcTaskTime extending IfcSchedulingTime {
        property ScheduleDuration -> str;
        property ScheduleStart -> str;
        property ScheduleFinish -> str;
        property EarlyStart -> str;
        property EarlyFinish -> str;
        property LateStart -> str;
        property LateFinish -> str;
        property FreeFloat -> str;
        property TotalFloat -> str;
        property IsCritical -> bool;
        property StatusTime -> str;
        property ActualDuration -> str;
        property ActualStart -> str;
        property ActualFinish -> str;
        property RemainingTime -> str;
        property Completion -> float64;
        required property DurationType -> str {
            constraint one_of ('ELAPSEDTIME','NOTDEFINED','WORKTIME');
        };
    }

    type IfcTaskTimeRecurring extending IfcTaskTime {
        required link Recurrence -> IfcRecurrencePattern;
    }

    type IfcTaskType extending IfcTypeProcess {
        property WorkMethod -> str;
        required property PredefinedType -> str {
            constraint one_of ('ATTENDANCE','CONSTRUCTION','DEMOLITION','DISMANTLE','DISPOSAL','INSTALLATION','LOGISTIC','MAINTENANCE','MOVE','NOTDEFINED','OPERATION','REMOVAL','RENOVATION','USERDEFINED');
        };
    }

    type IfcTelecomAddress extending IfcAddress {
        property TelephoneNumbers -> tuple<str>;
        property FacsimileNumbers -> tuple<str>;
        property PagerNumber -> str;
        property ElectronicMailAddresses -> tuple<str>;
        property WWWHomePageURL -> str;
        property MessagingIDs -> tuple<str>;
    }

    type IfcTendon extending IfcReinforcingElement {
        property NominalDiameter -> float64;
        property CrossSectionArea -> float64;
        property TensionForce -> float64;
        property PreStress -> float64;
        property FrictionCoefficient -> float64;
        property AnchorageSlip -> float64;
        property MinCurvatureRadius -> float64;
        required property PredefinedType -> str {
            constraint one_of ('BAR','COATED','NOTDEFINED','STRAND','USERDEFINED','WIRE');
        };
    }

    type IfcTendonAnchor extending IfcReinforcingElement {
        required property PredefinedType -> str {
            constraint one_of ('COUPLER','FIXED_END','NOTDEFINED','TENSIONING_END','USERDEFINED');
        };
    }

    type IfcTendonAnchorType extending IfcReinforcingElementType {
        required property PredefinedType -> str {
            constraint one_of ('COUPLER','FIXED_END','NOTDEFINED','TENSIONING_END','USERDEFINED');
        };
    }

    type IfcTendonType extending IfcReinforcingElementType {
        property NominalDiameter -> float64;
        property CrossSectionArea -> float64;
        property SheathDiameter -> float64;
        required property PredefinedType -> str {
            constraint one_of ('BAR','COATED','NOTDEFINED','STRAND','USERDEFINED','WIRE');
        };
    }

    abstract type IfcTessellatedFaceSet extending IfcTessellatedItem {
        required link Coordinates -> IfcCartesianPointList3D;
    }

    abstract type IfcTessellatedItem extending IfcGeometricRepresentationItem {
    }

    type IfcTextLiteral extending IfcGeometricRepresentationItem {
        required property Literal -> str;
        required property Path -> str {
            constraint one_of ('DOWN','LEFT','RIGHT','UP');
        };
        required link Placement -> IfcAxis2Placement2D | IfcAxis2Placement3D;
    }

    type IfcTextLiteralWithExtent extending IfcTextLiteral {
        required property BoxAlignment -> str;
        required link Extent -> IfcPlanarExtent;
    }

    type IfcTextStyle extending IfcPresentationStyle {
        property ModelOrDraughting -> bool;
        link TextCharacterAppearance -> IfcTextStyleForDefinedFont;
        link TextStyle -> IfcTextStyleTextModel;
        required link TextFontStyle -> IfcExternallyDefinedTextFont | IfcPreDefinedTextFont;
    }

    type IfcTextStyleFontModel extending IfcPreDefinedTextFont {
        required property FontFamily -> tuple<str>;
        property FontStyle -> str;
        property FontVariant -> str;
        property FontWeight -> str;
        required link FontSize -> IfcDescriptiveMeasure | IfcLengthMeasure | IfcNormalisedRatioMeasure | IfcPositiveLengthMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure;
    }

    type IfcTextStyleForDefinedFont extending IfcPresentationItem {
        required link Colour -> IfcColourSpecification | IfcPreDefinedColour;
        link BackgroundColour -> IfcColourSpecification | IfcPreDefinedColour;
    }

    type IfcTextStyleTextModel extending IfcPresentationItem {
        property TextAlign -> str;
        property TextDecoration -> str;
        property TextTransform -> str;
        link TextIndent -> IfcDescriptiveMeasure | IfcLengthMeasure | IfcNormalisedRatioMeasure | IfcPositiveLengthMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure;
        link LetterSpacing -> IfcDescriptiveMeasure | IfcLengthMeasure | IfcNormalisedRatioMeasure | IfcPositiveLengthMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure;
        link WordSpacing -> IfcDescriptiveMeasure | IfcLengthMeasure | IfcNormalisedRatioMeasure | IfcPositiveLengthMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure;
        link LineHeight -> IfcDescriptiveMeasure | IfcLengthMeasure | IfcNormalisedRatioMeasure | IfcPositiveLengthMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure;
    }

    abstract type IfcTextureCoordinate extending IfcPresentationItem {
        required multi link Maps -> IfcSurfaceTexture;
    }

    type IfcTextureCoordinateGenerator extending IfcTextureCoordinate {
        required property Mode -> str;
        property Parameter -> tuple<float64>;
    }

    type IfcTextureMap extending IfcTextureCoordinate {
        required multi link Vertices -> IfcTextureVertex;
        required link MappedTo -> IfcFace;
    }

    type IfcTextureVertex extending IfcPresentationItem {
        required property Coordinates -> tuple<float64,float64>;
    }

    type IfcTextureVertexList extending IfcPresentationItem {
        required property TexCoordsList -> array<tuple<float64,float64>>;
    }

    type IfcTimePeriod {
        required property StartTime -> str;
        required property EndTime -> str;
    }

    abstract type IfcTimeSeries {
        required property Name -> str;
        property Description -> str;
        required property StartTime -> str;
        required property EndTime -> str;
        property UserDefinedDataOrigin -> str;
        required property DataOrigin -> str {
            constraint one_of ('MEASURED','NOTDEFINED','PREDICTED','SIMULATED','USERDEFINED');
        };
        required property TimeSeriesDataType -> str {
            constraint one_of ('CONTINUOUS','DISCRETE','DISCRETEBINARY','NOTDEFINED','PIECEWISEBINARY','PIECEWISECONSTANT','PIECEWISECONTINUOUS');
        };
        link Unit -> IfcDerivedUnit | IfcMonetaryUnit | IfcNamedUnit;
    }

    type IfcTimeSeriesValue {
        required link ListValues -> IfcAbsorbedDoseMeasure | IfcAccelerationMeasure | IfcAngularVelocityMeasure | IfcAreaDensityMeasure | IfcCompoundPlaneAngleMeasure | IfcCurvatureMeasure | IfcDoseEquivalentMeasure | IfcDynamicViscosityMeasure | IfcElectricCapacitanceMeasure | IfcElectricChargeMeasure | IfcElectricConductanceMeasure | IfcElectricResistanceMeasure | IfcElectricVoltageMeasure | IfcEnergyMeasure | IfcForceMeasure | IfcFrequencyMeasure | IfcHeatFluxDensityMeasure | IfcHeatingValueMeasure | IfcIlluminanceMeasure | IfcInductanceMeasure | IfcIntegerCountRateMeasure | IfcIonConcentrationMeasure | IfcIsothermalMoistureCapacityMeasure | IfcKinematicViscosityMeasure | IfcLinearForceMeasure | IfcLinearMomentMeasure | IfcLinearStiffnessMeasure | IfcLinearVelocityMeasure | IfcLuminousFluxMeasure | IfcLuminousIntensityDistributionMeasure | IfcMagneticFluxDensityMeasure | IfcMagneticFluxMeasure | IfcMassDensityMeasure | IfcMassFlowRateMeasure | IfcMassPerLengthMeasure | IfcModulusOfElasticityMeasure | IfcModulusOfLinearSubgradeReactionMeasure | IfcModulusOfRotationalSubgradeReactionMeasure | IfcModulusOfSubgradeReactionMeasure | IfcMoistureDiffusivityMeasure | IfcMolecularWeightMeasure | IfcMomentOfInertiaMeasure | IfcMonetaryMeasure | IfcPHMeasure | IfcPlanarForceMeasure | IfcPowerMeasure | IfcPressureMeasure | IfcRadioActivityMeasure | IfcRotationalFrequencyMeasure | IfcRotationalMassMeasure | IfcRotationalStiffnessMeasure | IfcSectionModulusMeasure | IfcSectionalAreaIntegralMeasure | IfcShearModulusMeasure | IfcSoundPowerLevelMeasure | IfcSoundPowerMeasure | IfcSoundPressureLevelMeasure | IfcSoundPressureMeasure | IfcSpecificHeatCapacityMeasure | IfcTemperatureGradientMeasure | IfcTemperatureRateOfChangeMeasure | IfcThermalAdmittanceMeasure | IfcThermalConductivityMeasure | IfcThermalExpansionCoefficientMeasure | IfcThermalResistanceMeasure | IfcThermalTransmittanceMeasure | IfcTorqueMeasure | IfcVaporPermeabilityMeasure | IfcVolumetricFlowRateMeasure | IfcWarpingConstantMeasure | IfcWarpingMomentMeasure | IfcAmountOfSubstanceMeasure | IfcAreaMeasure | IfcComplexNumber | IfcContextDependentMeasure | IfcCountMeasure | IfcDescriptiveMeasure | IfcElectricCurrentMeasure | IfcLengthMeasure | IfcLuminousIntensityMeasure | IfcMassMeasure | IfcNonNegativeLengthMeasure | IfcNormalisedRatioMeasure | IfcNumericMeasure | IfcParameterValue | IfcPlaneAngleMeasure | IfcPositiveLengthMeasure | IfcPositivePlaneAngleMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure | IfcSolidAngleMeasure | IfcThermodynamicTemperatureMeasure | IfcTimeMeasure | IfcVolumeMeasure | IfcBinary | IfcBoolean | IfcDate | IfcDateTime | IfcDuration | IfcIdentifier | IfcInteger | IfcLabel | IfcLogical | IfcPositiveInteger | IfcReal | IfcText | IfcTime | IfcTimeStamp;
    }

    abstract type IfcTopologicalRepresentationItem extending IfcRepresentationItem {
    }

    type IfcTopologyRepresentation extending IfcShapeModel {
    }

    type IfcToroidalSurface extending IfcElementarySurface {
        required property MajorRadius -> float64;
        required property MinorRadius -> float64;
    }

    type IfcTransformer extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('CURRENT','FREQUENCY','INVERTER','NOTDEFINED','RECTIFIER','USERDEFINED','VOLTAGE');
        };
    }

    type IfcTransformerType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('CURRENT','FREQUENCY','INVERTER','NOTDEFINED','RECTIFIER','USERDEFINED','VOLTAGE');
        };
    }

    type IfcTransitionCurveSegment2D extending IfcCurveSegment2D {
        property StartRadius -> float64;
        property EndRadius -> float64;
        required property IsStartRadiusCCW -> bool;
        required property IsEndRadiusCCW -> bool;
        required property TransitionCurveType -> str {
            constraint one_of ('BIQUADRATICPARABOLA','BLOSSCURVE','CLOTHOIDCURVE','COSINECURVE','CUBICPARABOLA','SINECURVE');
        };
    }

    type IfcTransportElement extending IfcElement {
        required property PredefinedType -> str {
            constraint one_of ('CRANEWAY','ELEVATOR','ESCALATOR','LIFTINGGEAR','MOVINGWALKWAY','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcTransportElementType extending IfcElementType {
        required property PredefinedType -> str {
            constraint one_of ('CRANEWAY','ELEVATOR','ESCALATOR','LIFTINGGEAR','MOVINGWALKWAY','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcTrapeziumProfileDef extending IfcParameterizedProfileDef {
        required property BottomXDim -> float64;
        required property TopXDim -> float64;
        required property YDim -> float64;
        required property TopXOffset -> float64;
    }

    type IfcTriangulatedFaceSet extending IfcTessellatedFaceSet {
        property Normals -> array<tuple<float64,float64,float64>>;
        property Closed -> bool;
        required property CoordIndex -> array<tuple<int64,int64,int64>>;
        property PnIndex -> tuple<int64>;
    }

    type IfcTriangulatedIrregularNetwork extending IfcTriangulatedFaceSet {
        required property Flags -> tuple<int64>;
    }

    type IfcTrimmedCurve extending IfcBoundedCurve {
        required property SenseAgreement -> bool;
        required property MasterRepresentation -> str {
            constraint one_of ('CARTESIAN','PARAMETER','UNSPECIFIED');
        };
        required link BasisCurve -> IfcCurve;
        required link Trim1 -> IfcParameterValue | IfcCartesianPoint;
        required link Trim2 -> IfcParameterValue | IfcCartesianPoint;
    }

    type IfcTShapeProfileDef extending IfcParameterizedProfileDef {
        required property Depth -> float64;
        required property FlangeWidth -> float64;
        required property WebThickness -> float64;
        required property FlangeThickness -> float64;
        property FilletRadius -> float64;
        property FlangeEdgeRadius -> float64;
        property WebEdgeRadius -> float64;
        property WebSlope -> float64;
        property FlangeSlope -> float64;
    }

    type IfcTubeBundle extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('FINNED','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcTubeBundleType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('FINNED','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcTypeObject extending IfcObjectDefinition {
        property ApplicableOccurrence -> str;
        multi link HasPropertySets -> IfcPropertySetDefinition;
    }

    abstract type IfcTypeProcess extending IfcTypeObject {
        property Identification -> str;
        property LongDescription -> str;
        property ProcessType -> str;
    }

    type IfcTypeProduct extending IfcTypeObject {
        property Tag -> str;
        multi link RepresentationMaps -> IfcRepresentationMap;
    }

    abstract type IfcTypeResource extending IfcTypeObject {
        property Identification -> str;
        property LongDescription -> str;
        property ResourceType -> str;
    }

    type IfcUnitaryControlElement extending IfcDistributionControlElement {
        required property PredefinedType -> str {
            constraint one_of ('ALARMPANEL','CONTROLPANEL','GASDETECTIONPANEL','HUMIDISTAT','INDICATORPANEL','MIMICPANEL','NOTDEFINED','THERMOSTAT','USERDEFINED','WEATHERSTATION');
        };
    }

    type IfcUnitaryControlElementType extending IfcDistributionControlElementType {
        required property PredefinedType -> str {
            constraint one_of ('ALARMPANEL','CONTROLPANEL','GASDETECTIONPANEL','HUMIDISTAT','INDICATORPANEL','MIMICPANEL','NOTDEFINED','THERMOSTAT','USERDEFINED','WEATHERSTATION');
        };
    }

    type IfcUnitaryEquipment extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('AIRCONDITIONINGUNIT','AIRHANDLER','DEHUMIDIFIER','NOTDEFINED','ROOFTOPUNIT','SPLITSYSTEM','USERDEFINED');
        };
    }

    type IfcUnitaryEquipmentType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('AIRCONDITIONINGUNIT','AIRHANDLER','DEHUMIDIFIER','NOTDEFINED','ROOFTOPUNIT','SPLITSYSTEM','USERDEFINED');
        };
    }

    type IfcUnitAssignment {
        required link Units -> IfcDerivedUnit | IfcMonetaryUnit | IfcNamedUnit;
    }

    type IfcUShapeProfileDef extending IfcParameterizedProfileDef {
        required property Depth -> float64;
        required property FlangeWidth -> float64;
        required property WebThickness -> float64;
        required property FlangeThickness -> float64;
        property FilletRadius -> float64;
        property EdgeRadius -> float64;
        property FlangeSlope -> float64;
    }

    type IfcValve extending IfcFlowController {
        required property PredefinedType -> str {
            constraint one_of ('AIRRELEASE','ANTIVACUUM','CHANGEOVER','CHECK','COMMISSIONING','DIVERTING','DOUBLECHECK','DOUBLEREGULATING','DRAWOFFCOCK','FAUCET','FLUSHING','GASCOCK','GASTAP','ISOLATING','MIXING','NOTDEFINED','PRESSUREREDUCING','PRESSURERELIEF','REGULATING','SAFETYCUTOFF','STEAMTRAP','STOPCOCK','USERDEFINED');
        };
    }

    type IfcValveType extending IfcFlowControllerType {
        required property PredefinedType -> str {
            constraint one_of ('AIRRELEASE','ANTIVACUUM','CHANGEOVER','CHECK','COMMISSIONING','DIVERTING','DOUBLECHECK','DOUBLEREGULATING','DRAWOFFCOCK','FAUCET','FLUSHING','GASCOCK','GASTAP','ISOLATING','MIXING','NOTDEFINED','PRESSUREREDUCING','PRESSURERELIEF','REGULATING','SAFETYCUTOFF','STEAMTRAP','STOPCOCK','USERDEFINED');
        };
    }

    type IfcVector extending IfcGeometricRepresentationItem {
        required property Magnitude -> float64;
        required link Orientation -> IfcDirection;
    }

    type IfcVertex extending IfcTopologicalRepresentationItem {
    }

    type IfcVertexLoop extending IfcLoop {
        required link LoopVertex -> IfcVertex;
    }

    type IfcVertexPoint extending IfcVertex {
        required link VertexGeometry -> IfcPoint;
    }

    type IfcVibrationIsolator extending IfcElementComponent {
        required property PredefinedType -> str {
            constraint one_of ('COMPRESSION','NOTDEFINED','SPRING','USERDEFINED');
        };
    }

    type IfcVibrationIsolatorType extending IfcElementComponentType {
        required property PredefinedType -> str {
            constraint one_of ('COMPRESSION','NOTDEFINED','SPRING','USERDEFINED');
        };
    }

    type IfcVirtualElement extending IfcElement {
    }

    type IfcVirtualGridIntersection {
        required property OffsetDistances -> array<float64>{
            constraint expression on (len(__subject__) = 2 or len(__subject__) = 3)
        };
        required multi link IntersectingAxes -> IfcGridAxis;
    }

    type IfcVoidingFeature extending IfcFeatureElementSubtraction {
        required property PredefinedType -> str {
            constraint one_of ('CHAMFER','CUTOUT','EDGE','HOLE','MITER','NOTCH','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcWall extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('ELEMENTEDWALL','MOVABLE','NOTDEFINED','PARAPET','PARTITIONING','PLUMBINGWALL','POLYGONAL','SHEAR','SOLIDWALL','STANDARD','USERDEFINED');
        };
    }

    type IfcWallElementedCase extending IfcWall {
    }

    type IfcWallStandardCase extending IfcWall {
    }

    type IfcWallType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('ELEMENTEDWALL','MOVABLE','NOTDEFINED','PARAPET','PARTITIONING','PLUMBINGWALL','POLYGONAL','SHEAR','SOLIDWALL','STANDARD','USERDEFINED');
        };
    }

    type IfcWasteTerminal extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('FLOORTRAP','FLOORWASTE','GULLYSUMP','GULLYTRAP','NOTDEFINED','ROOFDRAIN','USERDEFINED','WASTEDISPOSALUNIT','WASTETRAP');
        };
    }

    type IfcWasteTerminalType extending IfcFlowTerminalType {
        required property PredefinedType -> str {
            constraint one_of ('FLOORTRAP','FLOORWASTE','GULLYSUMP','GULLYTRAP','NOTDEFINED','ROOFDRAIN','USERDEFINED','WASTEDISPOSALUNIT','WASTETRAP');
        };
    }

    type IfcWindow extending IfcBuildingElement {
        property OverallHeight -> float64;
        property OverallWidth -> float64;
        property UserDefinedPartitioningType -> str;
        required property PredefinedType -> str {
            constraint one_of ('LIGHTDOME','NOTDEFINED','SKYLIGHT','USERDEFINED','WINDOW');
        };
        required property PartitioningType -> str {
            constraint one_of ('DOUBLE_PANEL_HORIZONTAL','DOUBLE_PANEL_VERTICAL','NOTDEFINED','SINGLE_PANEL','TRIPLE_PANEL_BOTTOM','TRIPLE_PANEL_HORIZONTAL','TRIPLE_PANEL_LEFT','TRIPLE_PANEL_RIGHT','TRIPLE_PANEL_TOP','TRIPLE_PANEL_VERTICAL','USERDEFINED');
        };
    }

    type IfcWindowLiningProperties extending IfcPreDefinedPropertySet {
        property LiningDepth -> float64;
        property LiningThickness -> float64;
        property TransomThickness -> float64;
        property MullionThickness -> float64;
        property FirstTransomOffset -> float64;
        property SecondTransomOffset -> float64;
        property FirstMullionOffset -> float64;
        property SecondMullionOffset -> float64;
        property LiningOffset -> float64;
        property LiningToPanelOffsetX -> float64;
        property LiningToPanelOffsetY -> float64;
        link ShapeAspectStyle -> IfcShapeAspect;
    }

    type IfcWindowPanelProperties extending IfcPreDefinedPropertySet {
        property FrameDepth -> float64;
        property FrameThickness -> float64;
        required property OperationType -> str {
            constraint one_of ('BOTTOMHUNG','FIXEDCASEMENT','NOTDEFINED','OTHEROPERATION','PIVOTHORIZONTAL','PIVOTVERTICAL','REMOVABLECASEMENT','SIDEHUNGLEFTHAND','SIDEHUNGRIGHTHAND','SLIDINGHORIZONTAL','SLIDINGVERTICAL','TILTANDTURNLEFTHAND','TILTANDTURNRIGHTHAND','TOPHUNG');
        };
        required property PanelPosition -> str {
            constraint one_of ('BOTTOM','LEFT','MIDDLE','NOTDEFINED','RIGHT','TOP');
        };
        link ShapeAspectStyle -> IfcShapeAspect;
    }

    type IfcWindowStandardCase extending IfcWindow {
    }

    type IfcWindowStyle extending IfcTypeProduct {
        required property ParameterTakesPrecedence -> bool;
        required property Sizeable -> bool;
        required property ConstructionType -> str {
            constraint one_of ('ALUMINIUM','ALUMINIUM_WOOD','HIGH_GRADE_STEEL','NOTDEFINED','OTHER_CONSTRUCTION','PLASTIC','STEEL','WOOD');
        };
        required property OperationType -> str {
            constraint one_of ('DOUBLE_PANEL_HORIZONTAL','DOUBLE_PANEL_VERTICAL','NOTDEFINED','SINGLE_PANEL','TRIPLE_PANEL_BOTTOM','TRIPLE_PANEL_HORIZONTAL','TRIPLE_PANEL_LEFT','TRIPLE_PANEL_RIGHT','TRIPLE_PANEL_TOP','TRIPLE_PANEL_VERTICAL','USERDEFINED');
        };
    }

    type IfcWindowType extending IfcBuildingElementType {
        property ParameterTakesPrecedence -> bool;
        property UserDefinedPartitioningType -> str;
        required property PredefinedType -> str {
            constraint one_of ('LIGHTDOME','NOTDEFINED','SKYLIGHT','USERDEFINED','WINDOW');
        };
        required property PartitioningType -> str {
            constraint one_of ('DOUBLE_PANEL_HORIZONTAL','DOUBLE_PANEL_VERTICAL','NOTDEFINED','SINGLE_PANEL','TRIPLE_PANEL_BOTTOM','TRIPLE_PANEL_HORIZONTAL','TRIPLE_PANEL_LEFT','TRIPLE_PANEL_RIGHT','TRIPLE_PANEL_TOP','TRIPLE_PANEL_VERTICAL','USERDEFINED');
        };
    }

    type IfcWorkCalendar extending IfcControl {
        required property PredefinedType -> str {
            constraint one_of ('FIRSTSHIFT','NOTDEFINED','SECONDSHIFT','THIRDSHIFT','USERDEFINED');
        };
        multi link WorkingTimes -> IfcWorkTime;
        multi link ExceptionTimes -> IfcWorkTime;
    }

    abstract type IfcWorkControl extending IfcControl {
        required property CreationDate -> str;
        property Purpose -> str;
        property Duration -> str;
        property TotalFloat -> str;
        required property StartTime -> str;
        property FinishTime -> str;
        multi link Creators -> IfcPerson;
    }

    type IfcWorkPlan extending IfcWorkControl {
        required property PredefinedType -> str {
            constraint one_of ('ACTUAL','BASELINE','NOTDEFINED','PLANNED','USERDEFINED');
        };
    }

    type IfcWorkSchedule extending IfcWorkControl {
        required property PredefinedType -> str {
            constraint one_of ('ACTUAL','BASELINE','NOTDEFINED','PLANNED','USERDEFINED');
        };
    }

    type IfcWorkTime extending IfcSchedulingTime {
        property `Start` -> str;
        property Finish -> str;
        link RecurrencePattern -> IfcRecurrencePattern;
    }

    type IfcZone extending IfcSystem {
        property LongName -> str;
    }

    type IfcZShapeProfileDef extending IfcParameterizedProfileDef {
        required property Depth -> float64;
        required property FlangeWidth -> float64;
        required property WebThickness -> float64;
        required property FlangeThickness -> float64;
        property FilletRadius -> float64;
        property EdgeRadius -> float64;
    }

    type List_of_IfcCartesianPoint {
        required multi link IfcCartesianPoints -> IfcCartesianPoint;
    }

    type IfcNullStyle {
        required property `IfcNullStyle` -> str {
            constraint one_of ('NULL');
        };
    }

}
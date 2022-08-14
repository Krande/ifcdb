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
        required property `IfcArcIndex` -> tuple<int64, int64, int64>;
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

    abstract type IfcBoundaryCondition  {
        required property Name -> str;
    }

    type IfcBoxAlignment {
        required property `IfcBoxAlignment` -> str;
    }

    type IfcCardinalPointReference {
        required property `IfcCardinalPointReference` -> int64;
    }

    type IfcComplexNumber {
        required property `IfcComplexNumber` -> tuple<float64, float64>;
    }

    type IfcCompoundPlaneAngleMeasure {
        required property `IfcCompoundPlaneAngleMeasure` -> tuple<int64, int64, int64, int64>;
    }

    abstract type IfcConnectionGeometry  {
    }

    type IfcContextDependentMeasure {
        required property `IfcContextDependentMeasure` -> float64;
    }

    abstract type IfcCoordinateReferenceSystem  {
        property Name -> str;
        required property Description -> str;
        required property GeodeticDatum -> str;
        required property VerticalDatum -> str;
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

    type IfcDimensionalExponents  {
        property LengthExponent -> int64;
        property MassExponent -> int64;
        property TimeExponent -> int64;
        property ElectricCurrentExponent -> int64;
        property ThermodynamicTemperatureExponent -> int64;
        property AmountOfSubstanceExponent -> int64;
        property LuminousIntensityExponent -> int64;
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

    abstract type IfcExternalInformation  {
    }

    abstract type IfcExternalReference  {
        required property Location -> str;
        required property Identification -> str;
        required property Name -> str;
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

    type IfcLightDistributionData  {
        property MainPlaneAngle -> float64;
        property SecondaryPlaneAngle -> tuple<float64>;
        property LuminousIntensity -> tuple<float64>;
    }

    type IfcLineIndex {
        required property `IfcLineIndex` -> tuple<int64, int64>;
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

    abstract type IfcMaterialDefinition  {
    }

    abstract type IfcMaterialUsageDefinition  {
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

    type IfcMonetaryUnit  {
        property Currency -> str;
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

    type IfcNullStyle {
        required property IfcNullStyle -> str {
            constraint one_of ('NULL');
        };
    }

    type IfcNumericMeasure {
        required property `IfcNumericMeasure` -> int64;
    }

    abstract type IfcObjectPlacement  {
    }

    type IfcPHMeasure {
        required property `IfcPHMeasure` -> float64;
    }

    type IfcParameterValue {
        required property `IfcParameterValue` -> float64;
    }

    abstract type IfcPhysicalQuantity  {
        property Name -> str;
        required property Description -> str;
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

    abstract type IfcPresentationItem  {
    }

    abstract type IfcPresentationStyle  {
        required property Name -> str;
    }

    type IfcPressureMeasure {
        required property `IfcPressureMeasure` -> float64;
    }

    abstract type IfcPropertyAbstraction  {
    }

    type IfcPropertySetDefinitionSet {
        required multi link `IfcPropertySetDefinitionSet` -> IfcPropertySetDefinition;
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

    type IfcReference  {
        required property TypeIdentifier -> str;
        required property AttributeIdentifier -> str;
        required property InstanceName -> str;
        required property ListPositions -> tuple<int64>;
        required link InnerReference -> IfcReference;
    }

    abstract type IfcRepresentationContext  {
        required property ContextIdentifier -> str;
        required property ContextType -> str;
    }

    abstract type IfcRepresentationItem  {
    }

    abstract type IfcResourceLevelRelationship  {
        required property Name -> str;
        required property Description -> str;
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

    type IfcSectionModulusMeasure {
        required property `IfcSectionModulusMeasure` -> float64;
    }

    type IfcSectionalAreaIntegralMeasure {
        required property `IfcSectionalAreaIntegralMeasure` -> float64;
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

    abstract type IfcStructuralConnectionCondition  {
        required property Name -> str;
    }

    abstract type IfcStructuralLoad  {
        required property Name -> str;
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

    type IfcTimePeriod  {
        property StartTime -> str;
        property EndTime -> str;
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

    type IfcActorRole  {
        property Role -> str {
            constraint one_of ('ARCHITECT','BUILDINGOPERATOR','BUILDINGOWNER','CIVILENGINEER','CLIENT','COMMISSIONINGENGINEER','CONSTRUCTIONMANAGER','CONSULTANT','CONTRACTOR','COSTENGINEER','ELECTRICALENGINEER','ENGINEER','FACILITIESMANAGER','FIELDCONSTRUCTIONMANAGER','MANUFACTURER','MECHANICALENGINEER','OWNER','PROJECTMANAGER','RESELLER','STRUCTURALENGINEER','SUBCONTRACTOR','SUPPLIER','USERDEFINED');
        };
        required property UserDefinedRole -> str;
        required property Description -> str;
    }

    abstract type IfcAddress  {
        required property Purpose -> str {
            constraint one_of ('DISTRIBUTIONPOINT','HOME','OFFICE','SITE','USERDEFINED');
        };
        required property Description -> str;
        required property UserDefinedPurpose -> str;
    }

    type IfcBendingParameterSelect {
        link IfcBendingParameterSelect -> IfcLengthMeasure | IfcPlaneAngleMeasure;
    }

    type IfcClassification extending IfcExternalInformation {
        required property Source -> str;
        required property Edition -> str;
        required property EditionDate -> str;
        property Name -> str;
        required property Description -> str;
        required property Location -> str;
        required property ReferenceTokens -> tuple<str>;
    }

    type IfcClassificationReference extending IfcExternalReference {
        required property Description -> str;
        required property Sort -> str;
    }

    type IfcColourRgbList extending IfcPresentationItem {
        property ColourList -> tuple<float64, float64, float64>;
    }

    abstract type IfcColourSpecification extending IfcPresentationItem {
        required property Name -> str;
    }

    type IfcCurveStyleFontPattern extending IfcPresentationItem {
        property VisibleSegmentLength -> float64;
        property InvisibleSegmentLength -> float64;
    }

    type IfcDerivedMeasureValue {
        link IfcDerivedMeasureValue -> IfcAbsorbedDoseMeasure | IfcAccelerationMeasure | IfcAngularVelocityMeasure | IfcAreaDensityMeasure | IfcCompoundPlaneAngleMeasure | IfcCurvatureMeasure | IfcDoseEquivalentMeasure | IfcDynamicViscosityMeasure | IfcElectricCapacitanceMeasure | IfcElectricChargeMeasure | IfcElectricConductanceMeasure | IfcElectricResistanceMeasure | IfcElectricVoltageMeasure | IfcEnergyMeasure | IfcForceMeasure | IfcFrequencyMeasure | IfcHeatFluxDensityMeasure | IfcHeatingValueMeasure | IfcIlluminanceMeasure | IfcInductanceMeasure | IfcIntegerCountRateMeasure | IfcIonConcentrationMeasure | IfcIsothermalMoistureCapacityMeasure | IfcKinematicViscosityMeasure | IfcLinearForceMeasure | IfcLinearMomentMeasure | IfcLinearStiffnessMeasure | IfcLinearVelocityMeasure | IfcLuminousFluxMeasure | IfcLuminousIntensityDistributionMeasure | IfcMagneticFluxDensityMeasure | IfcMagneticFluxMeasure | IfcMassDensityMeasure | IfcMassFlowRateMeasure | IfcMassPerLengthMeasure | IfcModulusOfElasticityMeasure | IfcModulusOfLinearSubgradeReactionMeasure | IfcModulusOfRotationalSubgradeReactionMeasure | IfcModulusOfSubgradeReactionMeasure | IfcMoistureDiffusivityMeasure | IfcMolecularWeightMeasure | IfcMomentOfInertiaMeasure | IfcMonetaryMeasure | IfcPHMeasure | IfcPlanarForceMeasure | IfcPowerMeasure | IfcPressureMeasure | IfcRadioActivityMeasure | IfcRotationalFrequencyMeasure | IfcRotationalMassMeasure | IfcRotationalStiffnessMeasure | IfcSectionModulusMeasure | IfcSectionalAreaIntegralMeasure | IfcShearModulusMeasure | IfcSoundPowerLevelMeasure | IfcSoundPowerMeasure | IfcSoundPressureLevelMeasure | IfcSoundPressureMeasure | IfcSpecificHeatCapacityMeasure | IfcTemperatureGradientMeasure | IfcTemperatureRateOfChangeMeasure | IfcThermalAdmittanceMeasure | IfcThermalConductivityMeasure | IfcThermalExpansionCoefficientMeasure | IfcThermalResistanceMeasure | IfcThermalTransmittanceMeasure | IfcTorqueMeasure | IfcVaporPermeabilityMeasure | IfcVolumetricFlowRateMeasure | IfcWarpingConstantMeasure | IfcWarpingMomentMeasure;
    }

    type IfcExternallyDefinedHatchStyle extending IfcExternalReference {
    }

    type IfcExternallyDefinedSurfaceStyle extending IfcExternalReference {
    }

    type IfcExternallyDefinedTextFont extending IfcExternalReference {
    }

    type IfcFailureConnectionCondition extending IfcStructuralConnectionCondition {
        required property TensionFailureX -> float64;
        required property TensionFailureY -> float64;
        required property TensionFailureZ -> float64;
        required property CompressionFailureX -> float64;
        required property CompressionFailureY -> float64;
        required property CompressionFailureZ -> float64;
    }

    abstract type IfcGeometricRepresentationItem extending IfcRepresentationItem {
    }

    type IfcLightIntensityDistribution  {
        property LightDistributionCurve -> str {
            constraint one_of ('NOTDEFINED','TYPE_A','TYPE_B','TYPE_C');
        };
        link DistributionData -> IfcLightDistributionData;
    }

    type IfcMaterial extending IfcMaterialDefinition {
        property Name -> str;
        required property Description -> str;
        required property Category -> str;
    }

    type IfcMeasureValue {
        link IfcMeasureValue -> IfcAmountOfSubstanceMeasure | IfcAreaMeasure | IfcComplexNumber | IfcContextDependentMeasure | IfcCountMeasure | IfcDescriptiveMeasure | IfcElectricCurrentMeasure | IfcLengthMeasure | IfcLuminousIntensityMeasure | IfcMassMeasure | IfcNonNegativeLengthMeasure | IfcNormalisedRatioMeasure | IfcNumericMeasure | IfcParameterValue | IfcPlaneAngleMeasure | IfcPositiveLengthMeasure | IfcPositivePlaneAngleMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure | IfcSolidAngleMeasure | IfcThermodynamicTemperatureMeasure | IfcTimeMeasure | IfcVolumeMeasure;
    }

    type IfcModulusOfRotationalSubgradeReactionSelect {
        link IfcModulusOfRotationalSubgradeReactionSelect -> IfcBoolean | IfcModulusOfRotationalSubgradeReactionMeasure;
    }

    type IfcModulusOfSubgradeReactionSelect {
        link IfcModulusOfSubgradeReactionSelect -> IfcBoolean | IfcModulusOfSubgradeReactionMeasure;
    }

    type IfcModulusOfTranslationalSubgradeReactionSelect {
        link IfcModulusOfTranslationalSubgradeReactionSelect -> IfcBoolean | IfcModulusOfLinearSubgradeReactionMeasure;
    }

    abstract type IfcNamedUnit  {
        link Dimensions -> IfcDimensionalExponents;
        property UnitType -> str {
            constraint one_of ('ABSORBEDDOSEUNIT','AMOUNTOFSUBSTANCEUNIT','AREAUNIT','DOSEEQUIVALENTUNIT','ELECTRICCAPACITANCEUNIT','ELECTRICCHARGEUNIT','ELECTRICCONDUCTANCEUNIT','ELECTRICCURRENTUNIT','ELECTRICRESISTANCEUNIT','ELECTRICVOLTAGEUNIT','ENERGYUNIT','FORCEUNIT','FREQUENCYUNIT','ILLUMINANCEUNIT','INDUCTANCEUNIT','LENGTHUNIT','LUMINOUSFLUXUNIT','LUMINOUSINTENSITYUNIT','MAGNETICFLUXDENSITYUNIT','MAGNETICFLUXUNIT','MASSUNIT','PLANEANGLEUNIT','POWERUNIT','PRESSUREUNIT','RADIOACTIVITYUNIT','SOLIDANGLEUNIT','THERMODYNAMICTEMPERATUREUNIT','TIMEUNIT','USERDEFINED','VOLUMEUNIT');
        };
    }

    type IfcPhysicalComplexQuantity extending IfcPhysicalQuantity {
        link HasQuantities -> IfcPhysicalQuantity;
        property Discrimination -> str;
        required property Quality -> str;
        required property Usage -> str;
    }

    abstract type IfcPreDefinedItem extending IfcPresentationItem {
        property Name -> str;
    }

    abstract type IfcPreDefinedProperties extending IfcPropertyAbstraction {
    }

    type IfcProfileDef  {
        property ProfileType -> str {
            constraint one_of ('AREA','CURVE');
        };
        required property ProfileName -> str;
    }

    abstract type IfcProperty extending IfcPropertyAbstraction {
        property Name -> str;
        required property Description -> str;
    }

    type IfcRecurrencePattern  {
        property RecurrenceType -> str {
            constraint one_of ('BY_DAY_COUNT','BY_WEEKDAY_COUNT','DAILY','MONTHLY_BY_DAY_OF_MONTH','MONTHLY_BY_POSITION','WEEKLY','YEARLY_BY_DAY_OF_MONTH','YEARLY_BY_POSITION');
        };
        required multi property DayComponent -> int64;
        required multi property WeekdayComponent -> int64;
        required multi property MonthComponent -> int64;
        required property Position -> int64;
        required property Interval -> int64;
        required property Occurrences -> int64;
        required link TimePeriods -> IfcTimePeriod;
    }

    abstract type IfcRepresentation  {
        link ContextOfItems -> IfcRepresentationContext;
        required property RepresentationIdentifier -> str;
        required property RepresentationType -> str;
        link Items -> IfcRepresentationItem;
    }

    type IfcRotationalStiffnessSelect {
        link IfcRotationalStiffnessSelect -> IfcBoolean | IfcRotationalStiffnessMeasure;
    }

    abstract type IfcSchedulingTime  {
        required property Name -> str;
        required property DataOrigin -> str {
            constraint one_of ('MEASURED','NOTDEFINED','PREDICTED','SIMULATED','USERDEFINED');
        };
        required property UserDefinedDataOrigin -> str;
    }

    type IfcSegmentIndexSelect {
        link IfcSegmentIndexSelect -> IfcArcIndex | IfcLineIndex;
    }

    type IfcSimpleValue {
        link IfcSimpleValue -> IfcBinary | IfcBoolean | IfcDate | IfcDateTime | IfcDuration | IfcIdentifier | IfcInteger | IfcLabel | IfcLogical | IfcPositiveInteger | IfcReal | IfcText | IfcTime | IfcTimeStamp;
    }

    type IfcSizeSelect {
        link IfcSizeSelect -> IfcDescriptiveMeasure | IfcLengthMeasure | IfcNormalisedRatioMeasure | IfcPositiveLengthMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure;
    }

    type IfcSlippageConnectionCondition extending IfcStructuralConnectionCondition {
        required property SlippageX -> float64;
        required property SlippageY -> float64;
        required property SlippageZ -> float64;
    }

    type IfcSpecularHighlightSelect {
        link IfcSpecularHighlightSelect -> IfcSpecularExponent | IfcSpecularRoughness;
    }

    abstract type IfcStructuralLoadOrResult extending IfcStructuralLoad {
    }

    type IfcSurfaceStyleRefraction extending IfcPresentationItem {
        required property RefractionIndex -> float64;
        required property DispersionFactor -> float64;
    }

    type IfcTextureVertex extending IfcPresentationItem {
        property Coordinates -> tuple<float64, float64>;
    }

    type IfcTextureVertexList extending IfcPresentationItem {
        property TexCoordsList -> tuple<float64, float64>;
    }

    type IfcTimeOrRatioSelect {
        link IfcTimeOrRatioSelect -> IfcDuration | IfcRatioMeasure;
    }

    abstract type IfcTopologicalRepresentationItem extending IfcRepresentationItem {
    }

    type IfcTranslationalStiffnessSelect {
        link IfcTranslationalStiffnessSelect -> IfcBoolean | IfcLinearStiffnessMeasure;
    }

    type IfcWarpingStiffnessSelect {
        link IfcWarpingStiffnessSelect -> IfcBoolean | IfcWarpingMomentMeasure;
    }

    abstract type IfcAlignment2DSegment extending IfcGeometricRepresentationItem {
        required property TangentialContinuity -> bool;
        required property StartTag -> str;
        required property EndTag -> str;
    }

    type IfcBooleanResult extending IfcGeometricRepresentationItem {
        property Operator -> str {
            constraint one_of ('DIFFERENCE','INTERSECTION','UNION');
        };
    }

    type IfcBoundaryEdgeCondition extending IfcBoundaryCondition {
        required link TranslationalStiffnessByLengthX -> IfcModulusOfTranslationalSubgradeReactionSelect;
        required link TranslationalStiffnessByLengthY -> IfcModulusOfTranslationalSubgradeReactionSelect;
        required link TranslationalStiffnessByLengthZ -> IfcModulusOfTranslationalSubgradeReactionSelect;
        required link RotationalStiffnessByLengthX -> IfcModulusOfRotationalSubgradeReactionSelect;
        required link RotationalStiffnessByLengthY -> IfcModulusOfRotationalSubgradeReactionSelect;
        required link RotationalStiffnessByLengthZ -> IfcModulusOfRotationalSubgradeReactionSelect;
    }

    type IfcBoundaryFaceCondition extending IfcBoundaryCondition {
        required link TranslationalStiffnessByAreaX -> IfcModulusOfSubgradeReactionSelect;
        required link TranslationalStiffnessByAreaY -> IfcModulusOfSubgradeReactionSelect;
        required link TranslationalStiffnessByAreaZ -> IfcModulusOfSubgradeReactionSelect;
    }

    type IfcBoundaryNodeCondition extending IfcBoundaryCondition {
        required link TranslationalStiffnessX -> IfcTranslationalStiffnessSelect;
        required link TranslationalStiffnessY -> IfcTranslationalStiffnessSelect;
        required link TranslationalStiffnessZ -> IfcTranslationalStiffnessSelect;
        required link RotationalStiffnessX -> IfcRotationalStiffnessSelect;
        required link RotationalStiffnessY -> IfcRotationalStiffnessSelect;
        required link RotationalStiffnessZ -> IfcRotationalStiffnessSelect;
    }

    abstract type IfcCartesianPointList extending IfcGeometricRepresentationItem {
    }

    type IfcClassificationReferenceSelect {
        link IfcClassificationReferenceSelect -> IfcClassification | IfcClassificationReference;
    }

    type IfcClassificationSelect {
        link IfcClassificationSelect -> IfcClassification | IfcClassificationReference;
    }

    type IfcColourRgb extending IfcColourSpecification {
        property Red -> float64;
        property Green -> float64;
        property Blue -> float64;
    }

    type IfcComplexProperty extending IfcProperty {
        property UsageName -> str;
        link HasProperties -> IfcProperty;
    }

    type IfcCompositeProfileDef extending IfcProfileDef {
        link Profiles -> IfcProfileDef;
        required property Label -> str;
    }

    type IfcContextDependentUnit extending IfcNamedUnit {
        property Name -> str;
    }

    abstract type IfcCurve extending IfcGeometricRepresentationItem {
    }

    type IfcCurveStyleFont extending IfcPresentationItem {
        required property Name -> str;
        link PatternList -> IfcCurveStyleFontPattern;
    }

    type IfcDerivedUnitElement  {
        link Unit -> IfcNamedUnit;
        property Exponent -> int64;
    }

    type IfcDirection extending IfcGeometricRepresentationItem {
        property DirectionRatios -> tuple<float64, float64, float64>;
    }

    type IfcDistanceExpression extending IfcGeometricRepresentationItem {
        property DistanceAlong -> float64;
        required property OffsetLateral -> float64;
        required property OffsetVertical -> float64;
        required property OffsetLongitudinal -> float64;
        required property AlongHorizontal -> bool;
    }

    type IfcEventTime extending IfcSchedulingTime {
        required property ActualDate -> str;
        required property EarlyDate -> str;
        required property LateDate -> str;
        required property ScheduleDate -> str;
    }

    abstract type IfcExtendedProperties extending IfcPropertyAbstraction {
        required property Name -> str;
        required property Description -> str;
        link Properties -> IfcProperty;
    }

    type IfcLagTime extending IfcSchedulingTime {
        link LagValue -> IfcTimeOrRatioSelect;
        property DurationType -> str {
            constraint one_of ('ELAPSEDTIME','NOTDEFINED','WORKTIME');
        };
    }

    type IfcLayeredItem {
        link IfcLayeredItem -> IfcRepresentation | IfcRepresentationItem;
    }

    type IfcLightDistributionDataSourceSelect {
        link IfcLightDistributionDataSourceSelect -> IfcExternalReference | IfcLightIntensityDistribution;
    }

    type IfcLoop extending IfcTopologicalRepresentationItem {
    }

    type IfcMaterialConstituent extending IfcMaterialDefinition {
        required property Name -> str;
        required property Description -> str;
        link Material -> IfcMaterial;
        required property Fraction -> float64;
        required property Category -> str;
    }

    type IfcMaterialLayer extending IfcMaterialDefinition {
        required link Material -> IfcMaterial;
        property LayerThickness -> float64;
        required property IsVentilated -> bool;
        required property Name -> str;
        required property Description -> str;
        required property Category -> str;
        required property Priority -> int64;
    }

    type IfcMaterialList  {
        link Materials -> IfcMaterial;
    }

    type IfcMaterialProfile extending IfcMaterialDefinition {
        required property Name -> str;
        required property Description -> str;
        required link Material -> IfcMaterial;
        link Profile -> IfcProfileDef;
        required property Priority -> int64;
        required property Category -> str;
    }

    type IfcMaterialRelationship extending IfcResourceLevelRelationship {
        link RelatingMaterial -> IfcMaterial;
        link RelatedMaterials -> IfcMaterial;
        required property Expression -> str;
    }

    type IfcOrganization  {
        required property Identification -> str;
        property Name -> str;
        required property Description -> str;
        required link Roles -> IfcActorRole;
        required link Addresses -> IfcAddress;
    }

    type IfcPerson  {
        required property Identification -> str;
        required property FamilyName -> str;
        required property GivenName -> str;
        required property MiddleNames -> tuple<str>;
        required property PrefixTitles -> tuple<str>;
        required property SuffixTitles -> tuple<str>;
        required link Roles -> IfcActorRole;
        required link Addresses -> IfcAddress;
    }

    abstract type IfcPhysicalSimpleQuantity extending IfcPhysicalQuantity {
        required link Unit -> IfcNamedUnit;
    }

    type IfcPlanarExtent extending IfcGeometricRepresentationItem {
        property SizeInX -> float64;
        property SizeInY -> float64;
    }

    abstract type IfcPoint extending IfcGeometricRepresentationItem {
    }

    type IfcPostalAddress extending IfcAddress {
        required property InternalLocation -> str;
        required property AddressLines -> tuple<str>;
        required property PostalBox -> str;
        required property Town -> str;
        required property Region -> str;
        required property PostalCode -> str;
        required property Country -> str;
    }

    abstract type IfcPreDefinedColour extending IfcPreDefinedItem {
    }

    abstract type IfcPreDefinedCurveFont extending IfcPreDefinedItem {
    }

    abstract type IfcPreDefinedTextFont extending IfcPreDefinedItem {
    }

    abstract type IfcProductRepresentation  {
        required property Name -> str;
        required property Description -> str;
        link Representations -> IfcRepresentation;
    }

    type IfcProjectedCRS extending IfcCoordinateReferenceSystem {
        required property MapProjection -> str;
        required property MapZone -> str;
        required link MapUnit -> IfcNamedUnit;
    }

    type IfcPropertyDependencyRelationship extending IfcResourceLevelRelationship {
        link DependingProperty -> IfcProperty;
        link DependantProperty -> IfcProperty;
        required property Expression -> str;
    }

    type IfcReinforcementBarProperties extending IfcPreDefinedProperties {
        property TotalCrossSectionArea -> float64;
        property SteelGrade -> str;
        required property BarSurface -> str {
            constraint one_of ('PLAIN','TEXTURED');
        };
        required property EffectiveDepth -> float64;
        required property NominalBarDiameter -> float64;
        required property BarCount -> int64;
    }

    type IfcResourceTime extending IfcSchedulingTime {
        required property ScheduleWork -> str;
        required property ScheduleUsage -> float64;
        required property ScheduleStart -> str;
        required property ScheduleFinish -> str;
        required property ScheduleContour -> str;
        required property LevelingDelay -> str;
        required property IsOverAllocated -> bool;
        required property StatusTime -> str;
        required property ActualWork -> str;
        required property ActualUsage -> float64;
        required property ActualStart -> str;
        required property ActualFinish -> str;
        required property RemainingWork -> str;
        required property RemainingUsage -> float64;
        required property Completion -> float64;
    }

    type IfcSIUnit extending IfcNamedUnit {
        required property Prefix -> str {
            constraint one_of ('ATTO','CENTI','DECA','DECI','EXA','FEMTO','GIGA','HECTO','KILO','MEGA','MICRO','MILLI','NANO','PETA','PICO','TERA');
        };
        property Name -> str {
            constraint one_of ('AMPERE','BECQUEREL','CANDELA','COULOMB','CUBIC_METRE','DEGREE_CELSIUS','FARAD','GRAM','GRAY','HENRY','HERTZ','JOULE','KELVIN','LUMEN','LUX','METRE','MOLE','NEWTON','OHM','PASCAL','RADIAN','SECOND','SIEMENS','SIEVERT','SQUARE_METRE','STERADIAN','TESLA','VOLT','WATT','WEBER');
        };
    }

    type IfcSectionProperties extending IfcPreDefinedProperties {
        property SectionType -> str {
            constraint one_of ('TAPERED','UNIFORM');
        };
        link StartProfile -> IfcProfileDef;
        required link EndProfile -> IfcProfileDef;
    }

    abstract type IfcShapeModel extending IfcRepresentation {
    }

    abstract type IfcSimpleProperty extending IfcProperty {
    }

    abstract type IfcSolidModel extending IfcGeometricRepresentationItem {
    }

    type IfcStructuralLoadConfiguration extending IfcStructuralLoad {
        link Values -> IfcStructuralLoadOrResult;
        required property Locations -> tuple<float64, float64>;
    }

    abstract type IfcStructuralLoadStatic extending IfcStructuralLoadOrResult {
    }

    abstract type IfcStyleModel extending IfcRepresentation {
    }

    abstract type IfcSurface extending IfcGeometricRepresentationItem {
    }

    type IfcSurfaceReinforcementArea extending IfcStructuralLoadOrResult {
        required property SurfaceReinforcement1 -> tuple<float64, float64, float64>;
        required property SurfaceReinforcement2 -> tuple<float64, float64, float64>;
        required property ShearReinforcement -> float64;
    }

    type IfcTaskTime extending IfcSchedulingTime {
        required property DurationType -> str {
            constraint one_of ('ELAPSEDTIME','NOTDEFINED','WORKTIME');
        };
        required property ScheduleDuration -> str;
        required property ScheduleStart -> str;
        required property ScheduleFinish -> str;
        required property EarlyStart -> str;
        required property EarlyFinish -> str;
        required property LateStart -> str;
        required property LateFinish -> str;
        required property FreeFloat -> str;
        required property TotalFloat -> str;
        required property IsCritical -> bool;
        required property StatusTime -> str;
        required property ActualDuration -> str;
        required property ActualStart -> str;
        required property ActualFinish -> str;
        required property RemainingTime -> str;
        required property Completion -> float64;
    }

    type IfcTelecomAddress extending IfcAddress {
        required property TelephoneNumbers -> tuple<str>;
        required property FacsimileNumbers -> tuple<str>;
        required property PagerNumber -> str;
        required property ElectronicMailAddresses -> tuple<str>;
        required property WWWHomePageURL -> str;
        required property MessagingIDs -> tuple<str>;
    }

    abstract type IfcTessellatedItem extending IfcGeometricRepresentationItem {
    }

    type IfcTextStyleTextModel extending IfcPresentationItem {
        required link TextIndent -> IfcSizeSelect;
        required property TextAlign -> str;
        required property TextDecoration -> str;
        required link LetterSpacing -> IfcSizeSelect;
        required link WordSpacing -> IfcSizeSelect;
        required property TextTransform -> str;
        required link LineHeight -> IfcSizeSelect;
    }

    type IfcValue {
        link IfcValue -> IfcDerivedMeasureValue | IfcMeasureValue | IfcSimpleValue;
    }

    type IfcVertex extending IfcTopologicalRepresentationItem {
    }

    type IfcWorkTime extending IfcSchedulingTime {
        required link RecurrencePattern -> IfcRecurrencePattern;
        required property `Start` -> str;
        required property Finish -> str;
    }

    abstract type IfcAlignment2DVerticalSegment extending IfcAlignment2DSegment {
        property StartDistAlong -> float64;
        property HorizontalLength -> float64;
        property StartHeight -> float64;
        property StartGradient -> float64;
    }

    type IfcAnnotationFillArea extending IfcGeometricRepresentationItem {
        link OuterBoundary -> IfcCurve;
        required link InnerBoundaries -> IfcCurve;
    }

    type IfcApplication  {
        link ApplicationDeveloper -> IfcOrganization;
        property Version -> str;
        property ApplicationFullName -> str;
        property ApplicationIdentifier -> str;
    }

    type IfcArbitraryClosedProfileDef extending IfcProfileDef {
        link OuterCurve -> IfcCurve;
    }

    type IfcBooleanClippingResult extending IfcBooleanResult {
    }

    type IfcBoundaryNodeConditionWarping extending IfcBoundaryNodeCondition {
        required link WarpingStiffness -> IfcWarpingStiffnessSelect;
    }

    abstract type IfcBoundedCurve extending IfcCurve {
    }

    abstract type IfcBoundedSurface extending IfcSurface {
    }

    type IfcCartesianPoint extending IfcPoint {
        property Coordinates -> tuple<float64, float64, float64>;
    }

    type IfcCartesianPointList2D extending IfcCartesianPointList {
        property CoordList -> tuple<float64, float64>;
        required property TagList -> tuple<str>;
    }

    type IfcCartesianPointList3D extending IfcCartesianPointList {
        property CoordList -> tuple<float64, float64, float64>;
        required property TagList -> tuple<str>;
    }

    type IfcColour {
        link IfcColour -> IfcColourSpecification | IfcPreDefinedColour;
    }

    type IfcColourOrFactor {
        link IfcColourOrFactor -> IfcColourRgb | IfcNormalisedRatioMeasure;
    }

    type IfcCompositeCurveSegment extending IfcGeometricRepresentationItem {
        property Transition -> str {
            constraint one_of ('CONTINUOUS','CONTSAMEGRADIENT','CONTSAMEGRADIENTSAMECURVATURE','DISCONTINUOUS');
        };
        property SameSense -> bool;
        link ParentCurve -> IfcCurve;
    }

    type IfcCurveStyleFontSelect {
        link IfcCurveStyleFontSelect -> IfcCurveStyleFont | IfcPreDefinedCurveFont;
    }

    type IfcDerivedUnit  {
        link Elements -> IfcDerivedUnitElement;
        property UnitType -> str {
            constraint one_of ('ACCELERATIONUNIT','ANGULARVELOCITYUNIT','AREADENSITYUNIT','COMPOUNDPLANEANGLEUNIT','CURVATUREUNIT','DYNAMICVISCOSITYUNIT','HEATFLUXDENSITYUNIT','HEATINGVALUEUNIT','INTEGERCOUNTRATEUNIT','IONCONCENTRATIONUNIT','ISOTHERMALMOISTURECAPACITYUNIT','KINEMATICVISCOSITYUNIT','LINEARFORCEUNIT','LINEARMOMENTUNIT','LINEARSTIFFNESSUNIT','LINEARVELOCITYUNIT','LUMINOUSINTENSITYDISTRIBUTIONUNIT','MASSDENSITYUNIT','MASSFLOWRATEUNIT','MASSPERLENGTHUNIT','MODULUSOFELASTICITYUNIT','MODULUSOFLINEARSUBGRADEREACTIONUNIT','MODULUSOFROTATIONALSUBGRADEREACTIONUNIT','MODULUSOFSUBGRADEREACTIONUNIT','MOISTUREDIFFUSIVITYUNIT','MOLECULARWEIGHTUNIT','MOMENTOFINERTIAUNIT','PHUNIT','PLANARFORCEUNIT','ROTATIONALFREQUENCYUNIT','ROTATIONALMASSUNIT','ROTATIONALSTIFFNESSUNIT','SECTIONAREAINTEGRALUNIT','SECTIONMODULUSUNIT','SHEARMODULUSUNIT','SOUNDPOWERLEVELUNIT','SOUNDPOWERUNIT','SOUNDPRESSURELEVELUNIT','SOUNDPRESSUREUNIT','SPECIFICHEATCAPACITYUNIT','TEMPERATUREGRADIENTUNIT','TEMPERATURERATEOFCHANGEUNIT','THERMALADMITTANCEUNIT','THERMALCONDUCTANCEUNIT','THERMALEXPANSIONCOEFFICIENTUNIT','THERMALRESISTANCEUNIT','THERMALTRANSMITTANCEUNIT','TORQUEUNIT','USERDEFINED','VAPORPERMEABILITYUNIT','VOLUMETRICFLOWRATEUNIT','WARPINGCONSTANTUNIT','WARPINGMOMENTUNIT');
        };
        required property UserDefinedType -> str;
    }

    type IfcDraughtingPreDefinedColour extending IfcPreDefinedColour {
    }

    type IfcDraughtingPreDefinedCurveFont extending IfcPreDefinedCurveFont {
    }

    type IfcEdge extending IfcTopologicalRepresentationItem {
        link EdgeStart -> IfcVertex;
        link EdgeEnd -> IfcVertex;
    }

    type IfcFaceBound extending IfcTopologicalRepresentationItem {
        link Bound -> IfcLoop;
        property Orientation -> bool;
    }

    type IfcGeometricSetSelect {
        link IfcGeometricSetSelect -> IfcCurve | IfcPoint | IfcSurface;
    }

    type IfcGridAxis  {
        required property AxisTag -> str;
        link AxisCurve -> IfcCurve;
        property SameSense -> bool;
    }

    type IfcHalfSpaceSolid extending IfcGeometricRepresentationItem {
        link BaseSurface -> IfcSurface;
        property AgreementFlag -> bool;
    }

    type IfcIndexedPolygonalFace extending IfcTessellatedItem {
        property CoordIndex -> tuple<int64, int64, int64>;
    }

    type IfcIrregularTimeSeriesValue  {
        property TimeStamp -> str;
        link ListValues -> IfcValue;
    }

    abstract type IfcLightSource extending IfcGeometricRepresentationItem {
        required property Name -> str;
        link LightColour -> IfcColourRgb;
        required property AmbientIntensity -> float64;
        required property Intensity -> float64;
    }

    type IfcMaterialClassificationRelationship  {
        link MaterialClassifications -> IfcClassificationSelect;
        link ClassifiedMaterial -> IfcMaterial;
    }

    type IfcMaterialConstituentSet extending IfcMaterialDefinition {
        required property Name -> str;
        required property Description -> str;
        required link MaterialConstituents -> IfcMaterialConstituent;
    }

    type IfcMaterialDefinitionRepresentation extending IfcProductRepresentation {
        link RepresentedMaterial -> IfcMaterial;
    }

    type IfcMaterialLayerSet extending IfcMaterialDefinition {
        link MaterialLayers -> IfcMaterialLayer;
        required property LayerSetName -> str;
        required property Description -> str;
    }

    type IfcMaterialLayerWithOffsets extending IfcMaterialLayer {
        property OffsetDirection -> str {
            constraint one_of ('AXIS1','AXIS2','AXIS3');
        };
        multi property OffsetValues -> tuple<float64, float64>;
    }

    type IfcMaterialProfileSet extending IfcMaterialDefinition {
        required property Name -> str;
        required property Description -> str;
        link MaterialProfiles -> IfcMaterialProfile;
        required link CompositeProfile -> IfcCompositeProfileDef;
    }

    type IfcMaterialProfileWithOffsets extending IfcMaterialProfile {
        multi property OffsetValues -> tuple<float64, float64>;
    }

    type IfcMaterialProperties extending IfcExtendedProperties {
        link Material -> IfcMaterialDefinition;
    }

    type IfcMaterialSelect {
        link IfcMaterialSelect -> IfcMaterialDefinition | IfcMaterialList | IfcMaterialUsageDefinition;
    }

    abstract type IfcOffsetCurve extending IfcCurve {
        link BasisCurve -> IfcCurve;
    }

    type IfcOrganizationRelationship extending IfcResourceLevelRelationship {
        link RelatingOrganization -> IfcOrganization;
        link RelatedOrganizations -> IfcOrganization;
    }

    type IfcOrientationExpression extending IfcGeometricRepresentationItem {
        link LateralAxisDirection -> IfcDirection;
        link VerticalAxisDirection -> IfcDirection;
    }

    type IfcPcurve extending IfcCurve {
        link BasisSurface -> IfcSurface;
        link ReferenceCurve -> IfcCurve;
    }

    type IfcPersonAndOrganization  {
        link ThePerson -> IfcPerson;
        link TheOrganization -> IfcOrganization;
        required link Roles -> IfcActorRole;
    }

    type IfcPointOnCurve extending IfcPoint {
        link BasisCurve -> IfcCurve;
        property PointParameter -> float64;
    }

    type IfcPointOnSurface extending IfcPoint {
        link BasisSurface -> IfcSurface;
        property PointParameterU -> float64;
        property PointParameterV -> float64;
    }

    type IfcPresentationLayerAssignment  {
        property Name -> str;
        required property Description -> str;
        link AssignedItems -> IfcLayeredItem;
        required property Identifier -> str;
    }

    type IfcProductDefinitionShape extending IfcProductRepresentation {
    }

    type IfcProfileProperties extending IfcExtendedProperties {
        link ProfileDefinition -> IfcProfileDef;
    }

    type IfcQuantityArea extending IfcPhysicalSimpleQuantity {
        property AreaValue -> float64;
        required property Formula -> str;
    }

    type IfcQuantityCount extending IfcPhysicalSimpleQuantity {
        property CountValue -> int64;
        required property Formula -> str;
    }

    type IfcQuantityLength extending IfcPhysicalSimpleQuantity {
        property LengthValue -> float64;
        required property Formula -> str;
    }

    type IfcQuantityTime extending IfcPhysicalSimpleQuantity {
        property TimeValue -> float64;
        required property Formula -> str;
    }

    type IfcQuantityVolume extending IfcPhysicalSimpleQuantity {
        property VolumeValue -> float64;
        required property Formula -> str;
    }

    type IfcQuantityWeight extending IfcPhysicalSimpleQuantity {
        property WeightValue -> float64;
        required property Formula -> str;
    }

    type IfcSectionReinforcementProperties extending IfcPreDefinedProperties {
        property LongitudinalStartPosition -> float64;
        property LongitudinalEndPosition -> float64;
        required property TransversePosition -> float64;
        property ReinforcementRole -> str {
            constraint one_of ('ANCHORING','EDGE','LIGATURE','MAIN','NOTDEFINED','PUNCHING','RING','SHEAR','STUD','USERDEFINED');
        };
        link SectionDefinition -> IfcSectionProperties;
        link CrossSectionReinforcementDefinitions -> IfcReinforcementBarProperties;
    }

    abstract type IfcSectionedSolid extending IfcSolidModel {
        link Directrix -> IfcCurve;
        link CrossSections -> IfcProfileDef;
    }

    type IfcShapeRepresentation extending IfcShapeModel {
    }

    type IfcStructuralLoadLinearForce extending IfcStructuralLoadStatic {
        required property LinearForceX -> float64;
        required property LinearForceY -> float64;
        required property LinearForceZ -> float64;
        required property LinearMomentX -> float64;
        required property LinearMomentY -> float64;
        required property LinearMomentZ -> float64;
    }

    type IfcStructuralLoadPlanarForce extending IfcStructuralLoadStatic {
        required property PlanarForceX -> float64;
        required property PlanarForceY -> float64;
        required property PlanarForceZ -> float64;
    }

    type IfcStructuralLoadSingleDisplacement extending IfcStructuralLoadStatic {
        required property DisplacementX -> float64;
        required property DisplacementY -> float64;
        required property DisplacementZ -> float64;
        required property RotationalDisplacementRX -> float64;
        required property RotationalDisplacementRY -> float64;
        required property RotationalDisplacementRZ -> float64;
    }

    type IfcStructuralLoadSingleForce extending IfcStructuralLoadStatic {
        required property ForceX -> float64;
        required property ForceY -> float64;
        required property ForceZ -> float64;
        required property MomentX -> float64;
        required property MomentY -> float64;
        required property MomentZ -> float64;
    }

    type IfcStructuralLoadTemperature extending IfcStructuralLoadStatic {
        required property DeltaTConstant -> float64;
        required property DeltaTY -> float64;
        required property DeltaTZ -> float64;
    }

    type IfcStyledRepresentation extending IfcStyleModel {
    }

    type IfcSurfaceStyleLighting extending IfcPresentationItem {
        link DiffuseTransmissionColour -> IfcColourRgb;
        link DiffuseReflectionColour -> IfcColourRgb;
        link TransmissionColour -> IfcColourRgb;
        link ReflectanceColour -> IfcColourRgb;
    }

    type IfcSurfaceStyleShading extending IfcPresentationItem {
        link SurfaceColour -> IfcColourRgb;
        required property Transparency -> float64;
    }

    type IfcSweptDiskSolid extending IfcSolidModel {
        link Directrix -> IfcCurve;
        property Radius -> float64;
        required property InnerRadius -> float64;
        required property StartParam -> float64;
        required property EndParam -> float64;
    }

    type IfcTableRow  {
        required link RowCells -> IfcValue;
        required property IsHeading -> bool;
    }

    type IfcTaskTimeRecurring extending IfcTaskTime {
        link Recurrence -> IfcRecurrencePattern;
    }

    type IfcTextFontSelect {
        link IfcTextFontSelect -> IfcExternallyDefinedTextFont | IfcPreDefinedTextFont;
    }

    type IfcTextStyleFontModel extending IfcPreDefinedTextFont {
        property FontFamily -> tuple<str>;
        required property FontStyle -> str;
        required property FontVariant -> str;
        required property FontWeight -> str;
        link FontSize -> IfcSizeSelect;
    }

    type IfcTimeSeriesValue  {
        link ListValues -> IfcValue;
    }

    type IfcTopologyRepresentation extending IfcShapeModel {
    }

    type IfcVector extending IfcGeometricRepresentationItem {
        link Orientation -> IfcDirection;
        property Magnitude -> float64;
    }

    type IfcVertexLoop extending IfcLoop {
        link LoopVertex -> IfcVertex;
    }

    type IfcVertexPoint extending IfcVertex {
        link VertexGeometry -> IfcPoint;
    }

    type IfcActorSelect {
        link IfcActorSelect -> IfcOrganization | IfcPerson | IfcPersonAndOrganization;
    }

    type IfcAlignment2DVerSegCircularArc extending IfcAlignment2DVerticalSegment {
        property Radius -> float64;
        property IsConvex -> bool;
    }

    type IfcAlignment2DVerSegLine extending IfcAlignment2DVerticalSegment {
    }

    type IfcAlignment2DVerSegParabolicArc extending IfcAlignment2DVerticalSegment {
        property ParabolaConstant -> float64;
        property IsConvex -> bool;
    }

    type IfcAlignment2DVertical extending IfcGeometricRepresentationItem {
        link Segments -> IfcAlignment2DVerticalSegment;
    }

    type IfcArbitraryOpenProfileDef extending IfcProfileDef {
        link Curve -> IfcBoundedCurve;
    }

    type IfcArbitraryProfileDefWithVoids extending IfcArbitraryClosedProfileDef {
        link InnerCurves -> IfcCurve;
    }

    abstract type IfcBSplineCurve extending IfcBoundedCurve {
        property Degree -> int64;
        link ControlPointsList -> IfcCartesianPoint;
        property CurveForm -> str {
            constraint one_of ('CIRCULAR_ARC','ELLIPTIC_ARC','HYPERBOLIC_ARC','PARABOLIC_ARC','POLYLINE_FORM','UNSPECIFIED');
        };
        property ClosedCurve -> bool;
        property SelfIntersect -> bool;
    }

    abstract type IfcBSplineSurface extending IfcBoundedSurface {
        property UDegree -> int64;
        property VDegree -> int64;
        link ControlPointsList -> IfcCartesianPoint;
        property SurfaceForm -> str {
            constraint one_of ('CONICAL_SURF','CYLINDRICAL_SURF','GENERALISED_CONE','PLANE_SURF','QUADRIC_SURF','RULED_SURF','SPHERICAL_SURF','SURF_OF_LINEAR_EXTRUSION','SURF_OF_REVOLUTION','TOROIDAL_SURF','UNSPECIFIED');
        };
        property UClosed -> bool;
        property VClosed -> bool;
        property SelfIntersect -> bool;
    }

    type IfcBoundingBox extending IfcGeometricRepresentationItem {
        link Corner -> IfcCartesianPoint;
        property XDim -> float64;
        property YDim -> float64;
        property ZDim -> float64;
    }

    abstract type IfcCartesianTransformationOperator extending IfcGeometricRepresentationItem {
        required link Axis1 -> IfcDirection;
        required link Axis2 -> IfcDirection;
        link LocalOrigin -> IfcCartesianPoint;
        required property Scale -> float64;
    }

    type IfcCompositeCurve extending IfcBoundedCurve {
        link Segments -> IfcCompositeCurveSegment;
        property SelfIntersect -> bool;
    }

    abstract type IfcCurveSegment2D extending IfcBoundedCurve {
        link StartPoint -> IfcCartesianPoint;
        property StartDirection -> float64;
        property SegmentLength -> float64;
    }

    type IfcCurveStyleFontAndScaling extending IfcPresentationItem {
        required property Name -> str;
        link CurveFont -> IfcCurveStyleFontSelect;
        property CurveFontScaling -> float64;
    }

    type IfcEdgeCurve extending IfcEdge {
        link EdgeGeometry -> IfcCurve;
        property SameSense -> bool;
    }

    type IfcFace extending IfcTopologicalRepresentationItem {
        link Bounds -> IfcFaceBound;
    }

    type IfcFaceOuterBound extending IfcFaceBound {
    }

    type IfcFillAreaStyleTiles extending IfcGeometricRepresentationItem {
        link TilingPattern -> IfcVector;
        property TilingScale -> float64;
    }

    type IfcGeometricSet extending IfcGeometricRepresentationItem {
        link Elements -> IfcGeometricSetSelect;
    }

    type IfcHatchLineDistanceSelect {
        link IfcHatchLineDistanceSelect -> IfcPositiveLengthMeasure | IfcVector;
    }

    type IfcIndexedPolyCurve extending IfcBoundedCurve {
        link Points -> IfcCartesianPointList;
        required link Segments -> IfcSegmentIndexSelect;
        required property SelfIntersect -> bool;
    }

    type IfcIndexedPolygonalFaceWithVoids extending IfcIndexedPolygonalFace {
        property InnerCoordIndices -> tuple<int64, int64, int64>;
    }

    type IfcLightSourceAmbient extending IfcLightSource {
    }

    type IfcLightSourceDirectional extending IfcLightSource {
        link Orientation -> IfcDirection;
    }

    type IfcLightSourcePositional extending IfcLightSource {
        link Position -> IfcCartesianPoint;
        property Radius -> float64;
        property ConstantAttenuation -> float64;
        property DistanceAttenuation -> float64;
        property QuadricAttenuation -> float64;
    }

    type IfcLine extending IfcCurve {
        link Pnt -> IfcCartesianPoint;
        link Dir -> IfcVector;
    }

    type IfcMaterialLayerSetUsage extending IfcMaterialUsageDefinition {
        link ForLayerSet -> IfcMaterialLayerSet;
        property LayerSetDirection -> str {
            constraint one_of ('AXIS1','AXIS2','AXIS3');
        };
        property DirectionSense -> str {
            constraint one_of ('NEGATIVE','POSITIVE');
        };
        property OffsetFromReferenceLine -> float64;
        required property ReferenceExtent -> float64;
    }

    type IfcMaterialProfileSetUsage extending IfcMaterialUsageDefinition {
        link ForProfileSet -> IfcMaterialProfileSet;
        required property CardinalPoint -> int64;
        required property ReferenceExtent -> float64;
    }

    type IfcOffsetCurve2D extending IfcOffsetCurve {
        property Distance -> float64;
        property SelfIntersect -> bool;
    }

    type IfcOffsetCurve3D extending IfcOffsetCurve {
        property Distance -> float64;
        property SelfIntersect -> bool;
        link RefDirection -> IfcDirection;
    }

    type IfcOffsetCurveByDistances extending IfcOffsetCurve {
        link OffsetValues -> IfcDistanceExpression;
        required property Tag -> str;
    }

    type IfcOrientedEdge extending IfcEdge {
        link EdgeElement -> IfcEdge;
        property Orientation -> bool;
    }

    type IfcOwnerHistory  {
        link OwningUser -> IfcPersonAndOrganization;
        link OwningApplication -> IfcApplication;
        required property State -> str {
            constraint one_of ('LOCKED','READONLY','READONLYLOCKED','READWRITE','READWRITELOCKED');
        };
        required property ChangeAction -> str {
            constraint one_of ('ADDED','DELETED','MODIFIED','NOCHANGE','NOTDEFINED');
        };
        required property LastModifiedDate -> int64;
        required link LastModifyingUser -> IfcPersonAndOrganization;
        required link LastModifyingApplication -> IfcApplication;
        property CreationDate -> int64;
    }

    abstract type IfcPlacement extending IfcGeometricRepresentationItem {
        link Location -> IfcCartesianPoint;
    }

    type IfcPointOrVertexPoint {
        link IfcPointOrVertexPoint -> IfcPoint | IfcVertexPoint;
    }

    type IfcPolyLoop extending IfcLoop {
        link Polygon -> IfcCartesianPoint;
    }

    type IfcPolyline extending IfcBoundedCurve {
        link Points -> IfcCartesianPoint;
    }

    type IfcPresentationLayerWithStyle extending IfcPresentationLayerAssignment {
        property LayerOn -> bool;
        property LayerFrozen -> bool;
        property LayerBlocked -> bool;
        link LayerStyles -> IfcPresentationStyle;
    }

    type IfcRectangularTrimmedSurface extending IfcBoundedSurface {
        link BasisSurface -> IfcSurface;
        property U1 -> float64;
        property V1 -> float64;
        property U2 -> float64;
        property V2 -> float64;
        property Usense -> bool;
        property Vsense -> bool;
    }

    type IfcReparametrisedCompositeCurveSegment extending IfcCompositeCurveSegment {
        property ParamLength -> float64;
    }

    type IfcSectionedSolidHorizontal extending IfcSectionedSolid {
        link CrossSectionPositions -> IfcDistanceExpression;
        property FixedAxisVertical -> bool;
    }

    type IfcStructuralLoadSingleDisplacementDistortion extending IfcStructuralLoadSingleDisplacement {
        required property Distortion -> float64;
    }

    type IfcStructuralLoadSingleForceWarping extending IfcStructuralLoadSingleForce {
        required property WarpingMoment -> float64;
    }

    type IfcSubedge extending IfcEdge {
        link ParentEdge -> IfcEdge;
    }

    type IfcSurfaceCurve extending IfcCurve {
        link Curve3D -> IfcCurve;
        link AssociatedGeometry -> IfcPcurve;
        property MasterRepresentation -> str {
            constraint one_of ('CURVE3D','PCURVE_S1','PCURVE_S2');
        };
    }

    type IfcSurfaceStyleRendering extending IfcSurfaceStyleShading {
        required link DiffuseColour -> IfcColourOrFactor;
        required link TransmissionColour -> IfcColourOrFactor;
        required link DiffuseTransmissionColour -> IfcColourOrFactor;
        required link ReflectionColour -> IfcColourOrFactor;
        required link SpecularColour -> IfcColourOrFactor;
        required link SpecularHighlight -> IfcSpecularHighlightSelect;
        property ReflectanceMethod -> str {
            constraint one_of ('BLINN','FLAT','GLASS','MATT','METAL','MIRROR','NOTDEFINED','PHONG','PLASTIC','STRAUSS');
        };
    }

    type IfcSweptDiskSolidPolygonal extending IfcSweptDiskSolid {
        required property FilletRadius -> float64;
    }

    abstract type IfcTessellatedFaceSet extending IfcTessellatedItem {
        link Coordinates -> IfcCartesianPointList3D;
    }

    type IfcTextStyleForDefinedFont extending IfcPresentationItem {
        link Colour -> IfcColour;
        required link BackgroundColour -> IfcColour;
    }

    type IfcTrimmingSelect {
        link IfcTrimmingSelect -> IfcCartesianPoint | IfcParameterValue;
    }

    type IfcUnit {
        link IfcUnit -> IfcDerivedUnit | IfcMonetaryUnit | IfcNamedUnit;
    }

    type IfcVectorOrDirection {
        link IfcVectorOrDirection -> IfcDirection | IfcVector;
    }

    type IfcVirtualGridIntersection  {
        link IntersectingAxes -> IfcGridAxis;
        property OffsetDistances -> tuple<float64, float64, float64>;
    }

    type IfcAlignment2DHorizontalSegment extending IfcAlignment2DSegment {
        link CurveGeometry -> IfcCurveSegment2D;
    }

    type IfcApproval  {
        required property Identifier -> str;
        required property Name -> str;
        required property Description -> str;
        required property TimeOfApproval -> str;
        required property Status -> str;
        required property Level -> str;
        required property Qualifier -> str;
        required link RequestingApproval -> IfcActorSelect;
        required link GivingApproval -> IfcActorSelect;
    }

    type IfcAxis1Placement extending IfcPlacement {
        required link Axis -> IfcDirection;
    }

    type IfcAxis2Placement2D extending IfcPlacement {
        required link RefDirection -> IfcDirection;
    }

    type IfcAxis2Placement3D extending IfcPlacement {
        required link Axis -> IfcDirection;
        required link RefDirection -> IfcDirection;
    }

    type IfcBSplineCurveWithKnots extending IfcBSplineCurve {
        property KnotMultiplicities -> tuple<int64, int64>;
        property Knots -> tuple<float64, float64>;
        property KnotSpec -> str {
            constraint one_of ('PIECEWISE_BEZIER_KNOTS','QUASI_UNIFORM_KNOTS','UNIFORM_KNOTS','UNSPECIFIED');
        };
    }

    type IfcBSplineSurfaceWithKnots extending IfcBSplineSurface {
        property UMultiplicities -> tuple<int64, int64>;
        property VMultiplicities -> tuple<int64, int64>;
        property UKnots -> tuple<float64, float64>;
        property VKnots -> tuple<float64, float64>;
        property KnotSpec -> str {
            constraint one_of ('PIECEWISE_BEZIER_KNOTS','QUASI_UNIFORM_KNOTS','UNIFORM_KNOTS','UNSPECIFIED');
        };
    }

    type IfcBoxedHalfSpace extending IfcHalfSpaceSolid {
        link Enclosure -> IfcBoundingBox;
    }

    type IfcCartesianTransformationOperator2D extending IfcCartesianTransformationOperator {
    }

    type IfcCartesianTransformationOperator3D extending IfcCartesianTransformationOperator {
        required link Axis3 -> IfcDirection;
    }

    type IfcCenterLineProfileDef extending IfcArbitraryOpenProfileDef {
        property Thickness -> float64;
    }

    type IfcCircularArcSegment2D extending IfcCurveSegment2D {
        property Radius -> float64;
        property IsCCW -> bool;
    }

    type IfcCompositeCurveOnSurface extending IfcCompositeCurve {
    }

    type IfcConnectedFaceSet extending IfcTopologicalRepresentationItem {
        link CfsFaces -> IfcFace;
    }

    type IfcConnectionPointGeometry extending IfcConnectionGeometry {
        link PointOnRelatingElement -> IfcPointOrVertexPoint;
        required link PointOnRelatedElement -> IfcPointOrVertexPoint;
    }

    abstract type IfcConstraint  {
        property Name -> str;
        required property Description -> str;
        property ConstraintGrade -> str {
            constraint one_of ('ADVISORY','HARD','NOTDEFINED','SOFT','USERDEFINED');
        };
        required property ConstraintSource -> str;
        required link CreatingActor -> IfcActorSelect;
        required property CreationTime -> str;
        required property UserDefinedGrade -> str;
    }

    type IfcCurveFontOrScaledCurveFontSelect {
        link IfcCurveFontOrScaledCurveFontSelect -> IfcCurveStyleFontAndScaling | IfcCurveStyleFontSelect;
    }

    type IfcCurveOrEdgeCurve {
        link IfcCurveOrEdgeCurve -> IfcBoundedCurve | IfcEdgeCurve;
    }

    type IfcDocumentInformation extending IfcExternalInformation {
        property Identification -> str;
        property Name -> str;
        required property Description -> str;
        required property Location -> str;
        required property Purpose -> str;
        required property IntendedUse -> str;
        required property Scope -> str;
        required property Revision -> str;
        required link DocumentOwner -> IfcActorSelect;
        required link Editors -> IfcActorSelect;
        required property CreationTime -> str;
        required property LastRevisionTime -> str;
        required property ElectronicFormat -> str;
        required property ValidFrom -> str;
        required property ValidUntil -> str;
        required property Confidentiality -> str {
            constraint one_of ('CONFIDENTIAL','NOTDEFINED','PERSONAL','PUBLIC','RESTRICTED','USERDEFINED');
        };
        required property Status -> str {
            constraint one_of ('DRAFT','FINAL','FINALDRAFT','NOTDEFINED','REVISION');
        };
    }

    type IfcEdgeLoop extending IfcLoop {
        link EdgeList -> IfcOrientedEdge;
    }

    type IfcFaceSurface extending IfcFace {
        link FaceSurface -> IfcSurface;
        property SameSense -> bool;
    }

    type IfcGeometricCurveSet extending IfcGeometricSet {
    }

    type IfcGridPlacementDirectionSelect {
        link IfcGridPlacementDirectionSelect -> IfcDirection | IfcVirtualGridIntersection;
    }

    type IfcIndexedColourMap extending IfcPresentationItem {
        link MappedTo -> IfcTessellatedFaceSet;
        required property Opacity -> float64;
        link Colours -> IfcColourRgbList;
        property ColourIndex -> tuple<int64>;
    }

    type IfcIntersectionCurve extending IfcSurfaceCurve {
    }

    type IfcLibraryInformation extending IfcExternalInformation {
        property Name -> str;
        required property Version -> str;
        required link Publisher -> IfcActorSelect;
        required property VersionDate -> str;
        required property Location -> str;
        required property Description -> str;
    }

    type IfcLightSourceSpot extending IfcLightSourcePositional {
        link Orientation -> IfcDirection;
        required property ConcentrationExponent -> float64;
        property SpreadAngle -> float64;
        property BeamWidthAngle -> float64;
    }

    type IfcLineSegment2D extending IfcCurveSegment2D {
    }

    type IfcMaterialProfileSetUsageTapering extending IfcMaterialProfileSetUsage {
        link ForProfileEndSet -> IfcMaterialProfileSet;
        required property CardinalEndPoint -> int64;
    }

    type IfcMeasureWithUnit  {
        link ValueComponent -> IfcValue;
        link UnitComponent -> IfcUnit;
    }

    type IfcPath extending IfcTopologicalRepresentationItem {
        link EdgeList -> IfcOrientedEdge;
    }

    type IfcPolygonalFaceSet extending IfcTessellatedFaceSet {
        required property Closed -> bool;
        link Faces -> IfcIndexedPolygonalFace;
        required property PnIndex -> tuple<int64>;
    }

    type IfcPropertyBoundedValue extending IfcSimpleProperty {
        required link UpperBoundValue -> IfcValue;
        required link LowerBoundValue -> IfcValue;
        required link Unit -> IfcUnit;
        required link SetPointValue -> IfcValue;
    }

    type IfcPropertyEnumeration extending IfcPropertyAbstraction {
        property Name -> str;
        link EnumerationValues -> IfcValue;
        required link Unit -> IfcUnit;
    }

    type IfcPropertyListValue extending IfcSimpleProperty {
        required link ListValues -> IfcValue;
        required link Unit -> IfcUnit;
    }

    type IfcPropertySingleValue extending IfcSimpleProperty {
        required link NominalValue -> IfcValue;
        required link Unit -> IfcUnit;
    }

    type IfcPropertyTableValue extending IfcSimpleProperty {
        required link DefiningValues -> IfcValue;
        required link DefinedValues -> IfcValue;
        required property Expression -> str;
        required link DefiningUnit -> IfcUnit;
        required link DefinedUnit -> IfcUnit;
        required property CurveInterpolation -> str {
            constraint one_of ('LINEAR','LOG_LINEAR','LOG_LOG','NOTDEFINED');
        };
    }

    abstract type IfcRoot  {
        property GlobalId -> str;
        required link OwnerHistory -> IfcOwnerHistory;
        required property Name -> str;
        required property Description -> str;
    }

    type IfcSeamCurve extending IfcSurfaceCurve {
    }

    type IfcTableColumn  {
        required property Identifier -> str;
        required property Name -> str;
        required property Description -> str;
        required link Unit -> IfcUnit;
        required link ReferencePath -> IfcReference;
    }

    type IfcTextStyle extending IfcPresentationStyle {
        required link TextCharacterAppearance -> IfcTextStyleForDefinedFont;
        required link TextStyle -> IfcTextStyleTextModel;
        link TextFontStyle -> IfcTextFontSelect;
        required property ModelOrDraughting -> bool;
    }

    abstract type IfcTimeSeries  {
        property Name -> str;
        required property Description -> str;
        property StartTime -> str;
        property EndTime -> str;
        property TimeSeriesDataType -> str {
            constraint one_of ('CONTINUOUS','DISCRETE','DISCRETEBINARY','NOTDEFINED','PIECEWISEBINARY','PIECEWISECONSTANT','PIECEWISECONTINUOUS');
        };
        property DataOrigin -> str {
            constraint one_of ('MEASURED','NOTDEFINED','PREDICTED','SIMULATED','USERDEFINED');
        };
        required property UserDefinedDataOrigin -> str;
        required link Unit -> IfcUnit;
    }

    type IfcTransitionCurveSegment2D extending IfcCurveSegment2D {
        required property StartRadius -> float64;
        required property EndRadius -> float64;
        property IsStartRadiusCCW -> bool;
        property IsEndRadiusCCW -> bool;
        property TransitionCurveType -> str {
            constraint one_of ('BIQUADRATICPARABOLA','BLOSSCURVE','CLOTHOIDCURVE','COSINECURVE','CUBICPARABOLA','SINECURVE');
        };
    }

    type IfcTriangulatedFaceSet extending IfcTessellatedFaceSet {
        required property Normals -> tuple<float64, float64, float64>;
        required property Closed -> bool;
        property CoordIndex -> tuple<int64, int64, int64>;
        required property PnIndex -> tuple<int64>;
    }

    type IfcTrimmedCurve extending IfcBoundedCurve {
        link BasisCurve -> IfcCurve;
        link Trim1 -> IfcTrimmingSelect;
        link Trim2 -> IfcTrimmingSelect;
        property SenseAgreement -> bool;
        property MasterRepresentation -> str {
            constraint one_of ('CARTESIAN','PARAMETER','UNSPECIFIED');
        };
    }

    type IfcUnitAssignment  {
        link Units -> IfcUnit;
    }

    type IfcAdvancedFace extending IfcFaceSurface {
    }

    type IfcAlignment2DHorizontal extending IfcGeometricRepresentationItem {
        required property StartDistAlong -> float64;
        link Segments -> IfcAlignment2DHorizontalSegment;
    }

    type IfcAppliedValueSelect {
        link IfcAppliedValueSelect -> IfcMeasureWithUnit | IfcReference | IfcValue;
    }

    type IfcApprovalRelationship extending IfcResourceLevelRelationship {
        link RelatingApproval -> IfcApproval;
        link RelatedApprovals -> IfcApproval;
    }

    type IfcAxis2Placement {
        link IfcAxis2Placement -> IfcAxis2Placement2D | IfcAxis2Placement3D;
    }

    type IfcBoundaryCurve extending IfcCompositeCurveOnSurface {
    }

    type IfcCartesianTransformationOperator2DnonUniform extending IfcCartesianTransformationOperator2D {
        required property Scale2 -> float64;
    }

    type IfcCartesianTransformationOperator3DnonUniform extending IfcCartesianTransformationOperator3D {
        required property Scale2 -> float64;
        required property Scale3 -> float64;
    }

    type IfcClosedShell extending IfcConnectedFaceSet {
    }

    type IfcConnectionCurveGeometry extending IfcConnectionGeometry {
        link CurveOnRelatingElement -> IfcCurveOrEdgeCurve;
        required link CurveOnRelatedElement -> IfcCurveOrEdgeCurve;
    }

    type IfcConnectionPointEccentricity extending IfcConnectionPointGeometry {
        required property EccentricityInX -> float64;
        required property EccentricityInY -> float64;
        required property EccentricityInZ -> float64;
    }

    type IfcConversionBasedUnit extending IfcNamedUnit {
        property Name -> str;
        link ConversionFactor -> IfcMeasureWithUnit;
    }

    abstract type IfcCsgPrimitive3D extending IfcGeometricRepresentationItem {
        link Position -> IfcAxis2Placement3D;
    }

    type IfcCurrencyRelationship extending IfcResourceLevelRelationship {
        link RelatingMonetaryUnit -> IfcMonetaryUnit;
        link RelatedMonetaryUnit -> IfcMonetaryUnit;
        property ExchangeRate -> float64;
        required property RateDateTime -> str;
        required link RateSource -> IfcLibraryInformation;
    }

    type IfcCurveOnSurface {
        link IfcCurveOnSurface -> IfcCompositeCurveOnSurface | IfcPcurve | IfcSurfaceCurve;
    }

    type IfcCurveStyle extending IfcPresentationStyle {
        required link CurveFont -> IfcCurveFontOrScaledCurveFontSelect;
        required link CurveWidth -> IfcSizeSelect;
        required link CurveColour -> IfcColour;
        required property ModelOrDraughting -> bool;
    }

    type IfcDerivedProfileDef extending IfcProfileDef {
        link ParentProfile -> IfcProfileDef;
        link Operator -> IfcCartesianTransformationOperator2D;
        required property Label -> str;
    }

    type IfcDocumentInformationRelationship extending IfcResourceLevelRelationship {
        link RelatingDocument -> IfcDocumentInformation;
        link RelatedDocuments -> IfcDocumentInformation;
        required property RelationshipType -> str;
    }

    type IfcDocumentReference extending IfcExternalReference {
        required property Description -> str;
        required link ReferencedDocument -> IfcDocumentInformation;
    }

    abstract type IfcElementarySurface extending IfcSurface {
        link Position -> IfcAxis2Placement3D;
    }

    type IfcFaceBasedSurfaceModel extending IfcGeometricRepresentationItem {
        link FbsmFaces -> IfcConnectedFaceSet;
    }

    type IfcGridPlacement extending IfcObjectPlacement {
        link PlacementLocation -> IfcVirtualGridIntersection;
        required link PlacementRefDirection -> IfcGridPlacementDirectionSelect;
    }

    type IfcIrregularTimeSeries extending IfcTimeSeries {
        link Values -> IfcIrregularTimeSeriesValue;
    }

    type IfcLibraryReference extending IfcExternalReference {
        required property Description -> str;
        required property Language -> str;
        required link ReferencedLibrary -> IfcLibraryInformation;
    }

    type IfcLightSourceGoniometric extending IfcLightSource {
        link Position -> IfcAxis2Placement3D;
        required link ColourAppearance -> IfcColourRgb;
        property ColourTemperature -> float64;
        property LuminousFlux -> float64;
        property LightEmissionSource -> str {
            constraint one_of ('COMPACTFLUORESCENT','FLUORESCENT','HIGHPRESSUREMERCURY','HIGHPRESSURESODIUM','LIGHTEMITTINGDIODE','LOWPRESSURESODIUM','LOWVOLTAGEHALOGEN','MAINVOLTAGEHALOGEN','METALHALIDE','NOTDEFINED','TUNGSTENFILAMENT');
        };
        link LightDistributionDataSource -> IfcLightDistributionDataSourceSelect;
    }

    type IfcLinearPlacement extending IfcObjectPlacement {
        link PlacementRelTo -> IfcCurve;
        link Distance -> IfcDistanceExpression;
        required link Orientation -> IfcOrientationExpression;
        required link CartesianPosition -> IfcAxis2Placement3D;
    }

    abstract type IfcObjectDefinition extending IfcRoot {
    }

    type IfcObjective extending IfcConstraint {
        required link BenchmarkValues -> IfcConstraint;
        required property LogicalAggregator -> str {
            constraint one_of ('LOGICALAND','LOGICALNOTAND','LOGICALNOTOR','LOGICALOR','LOGICALXOR');
        };
        property ObjectiveQualifier -> str {
            constraint one_of ('CODECOMPLIANCE','CODEWAIVER','DESIGNINTENT','EXTERNAL','HEALTHANDSAFETY','MERGECONFLICT','MODELVIEW','NOTDEFINED','PARAMETER','REQUIREMENT','SPECIFICATION','TRIGGERCONDITION','USERDEFINED');
        };
        required property UserDefinedQualifier -> str;
    }

    type IfcOpenShell extending IfcConnectedFaceSet {
    }

    abstract type IfcParameterizedProfileDef extending IfcProfileDef {
        required link Position -> IfcAxis2Placement2D;
    }

    type IfcPolygonalBoundedHalfSpace extending IfcHalfSpaceSolid {
        link Position -> IfcAxis2Placement3D;
        link PolygonalBoundary -> IfcBoundedCurve;
    }

    abstract type IfcPropertyDefinition extending IfcRoot {
    }

    type IfcPropertyEnumeratedValue extending IfcSimpleProperty {
        required link EnumerationValues -> IfcValue;
        required link EnumerationReference -> IfcPropertyEnumeration;
    }

    type IfcRationalBSplineCurveWithKnots extending IfcBSplineCurveWithKnots {
        property WeightsData -> tuple<float64, float64>;
    }

    type IfcRationalBSplineSurfaceWithKnots extending IfcBSplineSurfaceWithKnots {
        property WeightsData -> tuple<float64, float64>;
    }

    type IfcRegularTimeSeries extending IfcTimeSeries {
        property TimeStep -> float64;
        link Values -> IfcTimeSeriesValue;
    }

    abstract type IfcRelationship extending IfcRoot {
    }

    type IfcSectionedSpine extending IfcGeometricRepresentationItem {
        link SpineCurve -> IfcCompositeCurve;
        link CrossSections -> IfcProfileDef;
        link CrossSectionPositions -> IfcAxis2Placement3D;
    }

    abstract type IfcSurfaceTexture extending IfcPresentationItem {
        property RepeatS -> bool;
        property RepeatT -> bool;
        required property Mode -> str;
        required link TextureTransform -> IfcCartesianTransformationOperator2D;
        required property Parameter -> tuple<str>;
    }

    abstract type IfcSweptAreaSolid extending IfcSolidModel {
        link SweptArea -> IfcProfileDef;
        required link Position -> IfcAxis2Placement3D;
    }

    abstract type IfcSweptSurface extending IfcSurface {
        link SweptCurve -> IfcProfileDef;
        required link Position -> IfcAxis2Placement3D;
    }

    type IfcTable  {
        required property Name -> str;
        required link Rows -> IfcTableRow;
        required link Columns -> IfcTableColumn;
    }

    type IfcTriangulatedIrregularNetwork extending IfcTriangulatedFaceSet {
        property Flags -> tuple<int64>;
    }

    type IfcAlignmentCurve extending IfcBoundedCurve {
        link Horizontal -> IfcAlignment2DHorizontal;
        required link Vertical -> IfcAlignment2DVertical;
        required property Tag -> str;
    }

    type IfcAppliedValue  {
        required property Name -> str;
        required property Description -> str;
        required link AppliedValue -> IfcAppliedValueSelect;
        required link UnitBasis -> IfcMeasureWithUnit;
        required property ApplicableDate -> str;
        required property FixedUntilDate -> str;
        required property Category -> str;
        required property Condition -> str;
        required property ArithmeticOperator -> str {
            constraint one_of ('ADD','DIVIDE','MULTIPLY','SUBTRACT');
        };
        required link Components -> IfcAppliedValue;
    }

    type IfcAsymmetricIShapeProfileDef extending IfcParameterizedProfileDef {
        property BottomFlangeWidth -> float64;
        property OverallDepth -> float64;
        property WebThickness -> float64;
        property BottomFlangeThickness -> float64;
        required property BottomFlangeFilletRadius -> float64;
        property TopFlangeWidth -> float64;
        required property TopFlangeThickness -> float64;
        required property TopFlangeFilletRadius -> float64;
        required property BottomFlangeEdgeRadius -> float64;
        required property BottomFlangeSlope -> float64;
        required property TopFlangeEdgeRadius -> float64;
        required property TopFlangeSlope -> float64;
    }

    type IfcBlobTexture extending IfcSurfaceTexture {
        property RasterFormat -> str;
        property RasterCode -> bytes;
    }

    type IfcBlock extending IfcCsgPrimitive3D {
        property XLength -> float64;
        property YLength -> float64;
        property ZLength -> float64;
    }

    type IfcBooleanOperand {
        link IfcBooleanOperand -> IfcBooleanResult | IfcCsgPrimitive3D | IfcHalfSpaceSolid | IfcSolidModel | IfcTessellatedFaceSet;
    }

    type IfcCShapeProfileDef extending IfcParameterizedProfileDef {
        property Depth -> float64;
        property Width -> float64;
        property WallThickness -> float64;
        property Girth -> float64;
        required property InternalFilletRadius -> float64;
    }

    type IfcCircleProfileDef extending IfcParameterizedProfileDef {
        property Radius -> float64;
    }

    abstract type IfcConic extending IfcCurve {
        link Position -> IfcAxis2Placement;
    }

    abstract type IfcContext extending IfcObjectDefinition {
        required property ObjectType -> str;
        required property LongName -> str;
        required property Phase -> str;
        required link RepresentationContexts -> IfcRepresentationContext;
        required link UnitsInContext -> IfcUnitAssignment;
    }

    type IfcConversionBasedUnitWithOffset extending IfcConversionBasedUnit {
        property ConversionOffset -> float64;
    }

    type IfcCsgSelect {
        link IfcCsgSelect -> IfcBooleanResult | IfcCsgPrimitive3D;
    }

    type IfcCurveBoundedSurface extending IfcBoundedSurface {
        link BasisSurface -> IfcSurface;
        link Boundaries -> IfcBoundaryCurve;
        property ImplicitOuter -> bool;
    }

    type IfcCylindricalSurface extending IfcElementarySurface {
        property Radius -> float64;
    }

    type IfcDefinitionSelect {
        link IfcDefinitionSelect -> IfcObjectDefinition | IfcPropertyDefinition;
    }

    type IfcDocumentSelect {
        link IfcDocumentSelect -> IfcDocumentInformation | IfcDocumentReference;
    }

    type IfcEllipseProfileDef extending IfcParameterizedProfileDef {
        property SemiAxis1 -> float64;
        property SemiAxis2 -> float64;
    }

    type IfcExtrudedAreaSolid extending IfcSweptAreaSolid {
        link ExtrudedDirection -> IfcDirection;
        property Depth -> float64;
    }

    type IfcFillAreaStyleHatching extending IfcGeometricRepresentationItem {
        link HatchLineAppearance -> IfcCurveStyle;
        link StartOfNextHatchLine -> IfcHatchLineDistanceSelect;
        required link PointOfReferenceHatchLine -> IfcCartesianPoint;
        required link PatternStart -> IfcCartesianPoint;
        property HatchLineAngle -> float64;
    }

    type IfcFixedReferenceSweptAreaSolid extending IfcSweptAreaSolid {
        link Directrix -> IfcCurve;
        required property StartParam -> float64;
        required property EndParam -> float64;
        link FixedReference -> IfcDirection;
    }

    type IfcGeometricRepresentationContext extending IfcRepresentationContext {
        property CoordinateSpaceDimension -> int64;
        required property Precision -> float64;
        link WorldCoordinateSystem -> IfcAxis2Placement;
        required link TrueNorth -> IfcDirection;
    }

    type IfcIShapeProfileDef extending IfcParameterizedProfileDef {
        property OverallWidth -> float64;
        property OverallDepth -> float64;
        property WebThickness -> float64;
        property FlangeThickness -> float64;
        required property FilletRadius -> float64;
        required property FlangeEdgeRadius -> float64;
        required property FlangeSlope -> float64;
    }

    type IfcImageTexture extending IfcSurfaceTexture {
        property URLReference -> str;
    }

    type IfcLShapeProfileDef extending IfcParameterizedProfileDef {
        property Depth -> float64;
        required property Width -> float64;
        property Thickness -> float64;
        required property FilletRadius -> float64;
        required property EdgeRadius -> float64;
        required property LegSlope -> float64;
    }

    type IfcLibrarySelect {
        link IfcLibrarySelect -> IfcLibraryInformation | IfcLibraryReference;
    }

    type IfcLocalPlacement extending IfcObjectPlacement {
        required link PlacementRelTo -> IfcObjectPlacement;
        link RelativePlacement -> IfcAxis2Placement;
    }

    abstract type IfcManifoldSolidBrep extending IfcSolidModel {
        link Outer -> IfcClosedShell;
    }

    type IfcMirroredProfileDef extending IfcDerivedProfileDef {
    }

    abstract type IfcObject extending IfcObjectDefinition {
        required property ObjectType -> str;
    }

    type IfcOuterBoundaryCurve extending IfcBoundaryCurve {
    }

    type IfcPixelTexture extending IfcSurfaceTexture {
        property Width -> int64;
        property Height -> int64;
        property ColourComponents -> int64;
        property Pixel -> tuple<bytes>;
    }

    type IfcPlanarBox extending IfcPlanarExtent {
        link Placement -> IfcAxis2Placement;
    }

    type IfcPlane extending IfcElementarySurface {
    }

    abstract type IfcPropertySetDefinition extending IfcPropertyDefinition {
    }

    abstract type IfcPropertyTemplateDefinition extending IfcPropertyDefinition {
    }

    type IfcRectangleProfileDef extending IfcParameterizedProfileDef {
        property XDim -> float64;
        property YDim -> float64;
    }

    type IfcRectangularPyramid extending IfcCsgPrimitive3D {
        property XLength -> float64;
        property YLength -> float64;
        property Height -> float64;
    }

    abstract type IfcRelAssigns extending IfcRelationship {
        link RelatedObjects -> IfcObjectDefinition;
        required property RelatedObjectsType -> str {
            constraint one_of ('ACTOR','CONTROL','GROUP','NOTDEFINED','PROCESS','PRODUCT','PROJECT','RESOURCE');
        };
    }

    abstract type IfcRelConnects extending IfcRelationship {
    }

    abstract type IfcRelDecomposes extending IfcRelationship {
    }

    abstract type IfcRelDefines extending IfcRelationship {
    }

    type IfcRepresentationMap  {
        link MappingOrigin -> IfcAxis2Placement;
        link MappedRepresentation -> IfcRepresentation;
    }

    type IfcRevolvedAreaSolid extending IfcSweptAreaSolid {
        link Axis -> IfcAxis1Placement;
        property Angle -> float64;
    }

    type IfcRightCircularCone extending IfcCsgPrimitive3D {
        property Height -> float64;
        property BottomRadius -> float64;
    }

    type IfcRightCircularCylinder extending IfcCsgPrimitive3D {
        property Height -> float64;
        property Radius -> float64;
    }

    type IfcShell {
        link IfcShell -> IfcClosedShell | IfcOpenShell;
    }

    type IfcSolidOrShell {
        link IfcSolidOrShell -> IfcClosedShell | IfcSolidModel;
    }

    type IfcSphere extending IfcCsgPrimitive3D {
        property Radius -> float64;
    }

    type IfcSphericalSurface extending IfcElementarySurface {
        property Radius -> float64;
    }

    type IfcSurfaceCurveSweptAreaSolid extending IfcSweptAreaSolid {
        link Directrix -> IfcCurve;
        required property StartParam -> float64;
        required property EndParam -> float64;
        link ReferenceSurface -> IfcSurface;
    }

    type IfcSurfaceOfLinearExtrusion extending IfcSweptSurface {
        link ExtrudedDirection -> IfcDirection;
        property Depth -> float64;
    }

    type IfcSurfaceOfRevolution extending IfcSweptSurface {
        link AxisPosition -> IfcAxis1Placement;
    }

    type IfcSurfaceOrFaceSurface {
        link IfcSurfaceOrFaceSurface -> IfcFaceBasedSurfaceModel | IfcFaceSurface | IfcSurface;
    }

    type IfcSurfaceStyleWithTextures extending IfcPresentationItem {
        link Textures -> IfcSurfaceTexture;
    }

    type IfcTShapeProfileDef extending IfcParameterizedProfileDef {
        property Depth -> float64;
        property FlangeWidth -> float64;
        property WebThickness -> float64;
        property FlangeThickness -> float64;
        required property FilletRadius -> float64;
        required property FlangeEdgeRadius -> float64;
        required property WebEdgeRadius -> float64;
        required property WebSlope -> float64;
        required property FlangeSlope -> float64;
    }

    type IfcTextLiteral extending IfcGeometricRepresentationItem {
        property Literal -> str;
        link Placement -> IfcAxis2Placement;
        property Path -> str {
            constraint one_of ('DOWN','LEFT','RIGHT','UP');
        };
    }

    abstract type IfcTextureCoordinate extending IfcPresentationItem {
        link Maps -> IfcSurfaceTexture;
    }

    type IfcToroidalSurface extending IfcElementarySurface {
        property MajorRadius -> float64;
        property MinorRadius -> float64;
    }

    type IfcTrapeziumProfileDef extending IfcParameterizedProfileDef {
        property BottomXDim -> float64;
        property TopXDim -> float64;
        property YDim -> float64;
        property TopXOffset -> float64;
    }

    type IfcUShapeProfileDef extending IfcParameterizedProfileDef {
        property Depth -> float64;
        property FlangeWidth -> float64;
        property WebThickness -> float64;
        property FlangeThickness -> float64;
        required property FilletRadius -> float64;
        required property EdgeRadius -> float64;
        required property FlangeSlope -> float64;
    }

    type IfcZShapeProfileDef extending IfcParameterizedProfileDef {
        property Depth -> float64;
        property FlangeWidth -> float64;
        property WebThickness -> float64;
        property FlangeThickness -> float64;
        required property FilletRadius -> float64;
        required property EdgeRadius -> float64;
    }

    type IfcActor extending IfcObject {
        link TheActor -> IfcActorSelect;
    }

    type IfcAdvancedBrep extending IfcManifoldSolidBrep {
    }

    type IfcCircle extending IfcConic {
        property Radius -> float64;
    }

    type IfcCircleHollowProfileDef extending IfcCircleProfileDef {
        property WallThickness -> float64;
    }

    type IfcConnectionSurfaceGeometry extending IfcConnectionGeometry {
        link SurfaceOnRelatingElement -> IfcSurfaceOrFaceSurface;
        required link SurfaceOnRelatedElement -> IfcSurfaceOrFaceSurface;
    }

    type IfcConnectionVolumeGeometry extending IfcConnectionGeometry {
        link VolumeOnRelatingElement -> IfcSolidOrShell;
        required link VolumeOnRelatedElement -> IfcSolidOrShell;
    }

    abstract type IfcControl extending IfcObject {
        required property Identification -> str;
    }

    type IfcCoordinateReferenceSystemSelect {
        link IfcCoordinateReferenceSystemSelect -> IfcCoordinateReferenceSystem | IfcGeometricRepresentationContext;
    }

    type IfcCostValue extending IfcAppliedValue {
    }

    type IfcCsgSolid extending IfcSolidModel {
        link TreeRootExpression -> IfcCsgSelect;
    }

    type IfcCurveBoundedPlane extending IfcBoundedSurface {
        link BasisSurface -> IfcPlane;
        link OuterBoundary -> IfcCurve;
        link InnerBoundaries -> IfcCurve;
    }

    type IfcEllipse extending IfcConic {
        property SemiAxis1 -> float64;
        property SemiAxis2 -> float64;
    }

    type IfcExtrudedAreaSolidTapered extending IfcExtrudedAreaSolid {
        link EndSweptArea -> IfcProfileDef;
    }

    type IfcFacetedBrep extending IfcManifoldSolidBrep {
    }

    type IfcFillStyleSelect {
        link IfcFillStyleSelect -> IfcColour | IfcExternallyDefinedHatchStyle | IfcFillAreaStyleHatching | IfcFillAreaStyleTiles;
    }

    type IfcGeometricRepresentationSubContext extending IfcGeometricRepresentationContext {
        link ParentContext -> IfcGeometricRepresentationContext;
        required property TargetScale -> float64;
        property TargetView -> str {
            constraint one_of ('ELEVATION_VIEW','GRAPH_VIEW','MODEL_VIEW','NOTDEFINED','PLAN_VIEW','REFLECTED_PLAN_VIEW','SECTION_VIEW','SKETCH_VIEW','USERDEFINED');
        };
        required property UserDefinedTargetView -> str;
    }

    type IfcGroup extending IfcObject {
    }

    abstract type IfcIndexedTextureMap extending IfcTextureCoordinate {
        link MappedTo -> IfcTessellatedFaceSet;
        link TexCoords -> IfcTextureVertexList;
    }

    type IfcMappedItem extending IfcRepresentationItem {
        link MappingSource -> IfcRepresentationMap;
        link MappingTarget -> IfcCartesianTransformationOperator;
    }

    type IfcMetricValueSelect {
        link IfcMetricValueSelect -> IfcAppliedValue | IfcMeasureWithUnit | IfcReference | IfcTable | IfcTimeSeries | IfcValue;
    }

    type IfcObjectReferenceSelect {
        link IfcObjectReferenceSelect -> IfcAddress | IfcAppliedValue | IfcExternalReference | IfcMaterialDefinition | IfcOrganization | IfcPerson | IfcPersonAndOrganization | IfcTable | IfcTimeSeries;
    }

    abstract type IfcPreDefinedPropertySet extending IfcPropertySetDefinition {
    }

    abstract type IfcProcess extending IfcObject {
        required property Identification -> str;
        required property LongDescription -> str;
    }

    abstract type IfcProduct extending IfcObject {
        required link ObjectPlacement -> IfcObjectPlacement;
        required link Representation -> IfcProductRepresentation;
    }

    type IfcProductRepresentationSelect {
        link IfcProductRepresentationSelect -> IfcProductDefinitionShape | IfcRepresentationMap;
    }

    type IfcProject extending IfcContext {
    }

    type IfcProjectLibrary extending IfcContext {
    }

    type IfcPropertySet extending IfcPropertySetDefinition {
        link HasProperties -> IfcProperty;
    }

    type IfcPropertySetDefinitionSelect {
        link IfcPropertySetDefinitionSelect -> IfcPropertySetDefinition | IfcPropertySetDefinitionSet;
    }

    abstract type IfcPropertyTemplate extending IfcPropertyTemplateDefinition {
    }

    abstract type IfcQuantitySet extending IfcPropertySetDefinition {
    }

    type IfcRectangleHollowProfileDef extending IfcRectangleProfileDef {
        property WallThickness -> float64;
        required property InnerFilletRadius -> float64;
        required property OuterFilletRadius -> float64;
    }

    type IfcRelAggregates extending IfcRelDecomposes {
        link RelatingObject -> IfcObjectDefinition;
        link RelatedObjects -> IfcObjectDefinition;
    }

    abstract type IfcRelAssociates extending IfcRelationship {
        link RelatedObjects -> IfcDefinitionSelect;
    }

    type IfcRelDeclares extending IfcRelationship {
        link RelatingContext -> IfcContext;
        link RelatedDefinitions -> IfcDefinitionSelect;
    }

    type IfcRelDefinesByObject extending IfcRelDefines {
        link RelatedObjects -> IfcObject;
        link RelatingObject -> IfcObject;
    }

    type IfcRelNests extending IfcRelDecomposes {
        link RelatingObject -> IfcObjectDefinition;
        link RelatedObjects -> IfcObjectDefinition;
    }

    abstract type IfcResource extending IfcObject {
        required property Identification -> str;
        required property LongDescription -> str;
    }

    type IfcRevolvedAreaSolidTapered extending IfcRevolvedAreaSolid {
        link EndSweptArea -> IfcProfileDef;
    }

    type IfcRoundedRectangleProfileDef extending IfcRectangleProfileDef {
        property RoundingRadius -> float64;
    }

    type IfcShellBasedSurfaceModel extending IfcGeometricRepresentationItem {
        link SbsmBoundary -> IfcShell;
    }

    type IfcSurfaceStyleElementSelect {
        link IfcSurfaceStyleElementSelect -> IfcExternallyDefinedSurfaceStyle | IfcSurfaceStyleLighting | IfcSurfaceStyleRefraction | IfcSurfaceStyleShading | IfcSurfaceStyleWithTextures;
    }

    type IfcTextLiteralWithExtent extending IfcTextLiteral {
        link Extent -> IfcPlanarExtent;
        property BoxAlignment -> str;
    }

    type IfcTextureCoordinateGenerator extending IfcTextureCoordinate {
        property Mode -> str;
        required property Parameter -> tuple<float64>;
    }

    type IfcTextureMap extending IfcTextureCoordinate {
        link Vertices -> IfcTextureVertex;
        link MappedTo -> IfcFace;
    }

    type IfcTypeObject extending IfcObjectDefinition {
        required property ApplicableOccurrence -> str;
        required link HasPropertySets -> IfcPropertySetDefinition;
    }

    type IfcActionRequest extending IfcControl {
        required property PredefinedType -> str {
            constraint one_of ('EMAIL','FAX','NOTDEFINED','PHONE','POST','USERDEFINED','VERBAL');
        };
        required property Status -> str;
        required property LongDescription -> str;
    }

    type IfcAdvancedBrepWithVoids extending IfcAdvancedBrep {
        link Voids -> IfcClosedShell;
    }

    type IfcAnnotation extending IfcProduct {
    }

    type IfcAsset extending IfcGroup {
        required property Identification -> str;
        required link OriginalValue -> IfcCostValue;
        required link CurrentValue -> IfcCostValue;
        required link TotalReplacementCost -> IfcCostValue;
        required link Owner -> IfcActorSelect;
        required link User -> IfcActorSelect;
        required link ResponsiblePerson -> IfcPerson;
        required property IncorporationDate -> str;
        required link DepreciatedValue -> IfcCostValue;
    }

    type IfcComplexPropertyTemplate extending IfcPropertyTemplate {
        required property UsageName -> str;
        required property TemplateType -> str {
            constraint one_of ('P_COMPLEX','Q_COMPLEX');
        };
        required link HasPropertyTemplates -> IfcPropertyTemplate;
    }

    abstract type IfcConstructionResource extending IfcResource {
        required link Usage -> IfcResourceTime;
        required link BaseCosts -> IfcAppliedValue;
        required link BaseQuantity -> IfcPhysicalQuantity;
    }

    abstract type IfcCoordinateOperation  {
        link SourceCRS -> IfcCoordinateReferenceSystemSelect;
        link TargetCRS -> IfcCoordinateReferenceSystem;
    }

    type IfcCostItem extending IfcControl {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
        required link CostValues -> IfcCostValue;
        required link CostQuantities -> IfcPhysicalQuantity;
    }

    type IfcCostSchedule extending IfcControl {
        required property PredefinedType -> str {
            constraint one_of ('BUDGET','COSTPLAN','ESTIMATE','NOTDEFINED','PRICEDBILLOFQUANTITIES','SCHEDULEOFRATES','TENDER','UNPRICEDBILLOFQUANTITIES','USERDEFINED');
        };
        required property Status -> str;
        required property SubmittedOn -> str;
        required property UpdateDate -> str;
    }

    abstract type IfcElement extending IfcProduct {
        required property Tag -> str;
    }

    type IfcElementQuantity extending IfcQuantitySet {
        required property MethodOfMeasurement -> str;
        link Quantities -> IfcPhysicalQuantity;
    }

    type IfcEvent extending IfcProcess {
        required property PredefinedType -> str {
            constraint one_of ('ENDEVENT','INTERMEDIATEEVENT','NOTDEFINED','STARTEVENT','USERDEFINED');
        };
        required property EventTriggerType -> str {
            constraint one_of ('EVENTCOMPLEX','EVENTMESSAGE','EVENTRULE','EVENTTIME','NOTDEFINED','USERDEFINED');
        };
        required property UserDefinedEventTriggerType -> str;
        required link EventOccurenceTime -> IfcEventTime;
    }

    type IfcFacetedBrepWithVoids extending IfcFacetedBrep {
        link Voids -> IfcClosedShell;
    }

    type IfcFillAreaStyle extending IfcPresentationStyle {
        link FillStyles -> IfcFillStyleSelect;
        required property ModelorDraughting -> bool;
    }

    type IfcIndexedTriangleTextureMap extending IfcIndexedTextureMap {
        required property TexCoordIndex -> tuple<int64, int64, int64>;
    }

    type IfcInventory extending IfcGroup {
        required property PredefinedType -> str {
            constraint one_of ('ASSETINVENTORY','FURNITUREINVENTORY','NOTDEFINED','SPACEINVENTORY','USERDEFINED');
        };
        required link Jurisdiction -> IfcActorSelect;
        required link ResponsiblePersons -> IfcPerson;
        required property LastUpdateDate -> str;
        required link CurrentValue -> IfcCostValue;
        required link OriginalValue -> IfcCostValue;
    }

    type IfcMetric extending IfcConstraint {
        property Benchmark -> str {
            constraint one_of ('EQUALTO','GREATERTHAN','GREATERTHANOREQUALTO','INCLUDEDIN','INCLUDES','LESSTHAN','LESSTHANOREQUALTO','NOTEQUALTO','NOTINCLUDEDIN','NOTINCLUDES');
        };
        required property ValueSource -> str;
        required link DataValue -> IfcMetricValueSelect;
        required link ReferencePath -> IfcReference;
    }

    type IfcOccupant extending IfcActor {
        required property PredefinedType -> str {
            constraint one_of ('ASSIGNEE','ASSIGNOR','LESSEE','LESSOR','LETTINGAGENT','NOTDEFINED','OWNER','TENANT','USERDEFINED');
        };
    }

    type IfcPerformanceHistory extending IfcControl {
        property LifeCyclePhase -> str;
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcPermit extending IfcControl {
        required property PredefinedType -> str {
            constraint one_of ('ACCESS','BUILDING','NOTDEFINED','USERDEFINED','WORK');
        };
        required property Status -> str;
        required property LongDescription -> str;
    }

    abstract type IfcPort extending IfcProduct {
    }

    abstract type IfcPositioningElement extending IfcProduct {
    }

    type IfcProcedure extending IfcProcess {
        required property PredefinedType -> str {
            constraint one_of ('ADVICE_CAUTION','ADVICE_NOTE','ADVICE_WARNING','CALIBRATION','DIAGNOSTIC','NOTDEFINED','SHUTDOWN','STARTUP','USERDEFINED');
        };
    }

    type IfcProjectOrder extending IfcControl {
        required property PredefinedType -> str {
            constraint one_of ('CHANGEORDER','MAINTENANCEWORKORDER','MOVEORDER','NOTDEFINED','PURCHASEORDER','USERDEFINED','WORKORDER');
        };
        required property Status -> str;
        required property LongDescription -> str;
    }

    type IfcPropertyReferenceValue extending IfcSimpleProperty {
        required property UsageName -> str;
        required link PropertyReference -> IfcObjectReferenceSelect;
    }

    type IfcPropertySetTemplate extending IfcPropertyTemplateDefinition {
        required property TemplateType -> str {
            constraint one_of ('NOTDEFINED','PSET_OCCURRENCEDRIVEN','PSET_PERFORMANCEDRIVEN','PSET_TYPEDRIVENONLY','PSET_TYPEDRIVENOVERRIDE','QTO_OCCURRENCEDRIVEN','QTO_TYPEDRIVENONLY','QTO_TYPEDRIVENOVERRIDE');
        };
        required property ApplicableEntity -> str;
        link HasPropertyTemplates -> IfcPropertyTemplate;
    }

    type IfcProxy extending IfcProduct {
        property ProxyType -> str {
            constraint one_of ('ACTOR','CONTROL','GROUP','NOTDEFINED','PROCESS','PRODUCT','PROJECT','RESOURCE');
        };
        required property Tag -> str;
    }

    type IfcReinforcementDefinitionProperties extending IfcPreDefinedPropertySet {
        required property DefinitionType -> str;
        link ReinforcementSectionDefinitions -> IfcSectionReinforcementProperties;
    }

    type IfcRelAssignsToActor extending IfcRelAssigns {
        link RelatingActor -> IfcActor;
        required link ActingRole -> IfcActorRole;
    }

    type IfcRelAssignsToControl extending IfcRelAssigns {
        link RelatingControl -> IfcControl;
    }

    type IfcRelAssignsToGroup extending IfcRelAssigns {
        link RelatingGroup -> IfcGroup;
    }

    type IfcRelAssociatesApproval extending IfcRelAssociates {
        link RelatingApproval -> IfcApproval;
    }

    type IfcRelAssociatesClassification extending IfcRelAssociates {
        link RelatingClassification -> IfcClassificationSelect;
    }

    type IfcRelAssociatesConstraint extending IfcRelAssociates {
        required property Intent -> str;
        link RelatingConstraint -> IfcConstraint;
    }

    type IfcRelAssociatesDocument extending IfcRelAssociates {
        link RelatingDocument -> IfcDocumentSelect;
    }

    type IfcRelAssociatesLibrary extending IfcRelAssociates {
        link RelatingLibrary -> IfcLibrarySelect;
    }

    type IfcRelAssociatesMaterial extending IfcRelAssociates {
        link RelatingMaterial -> IfcMaterialSelect;
    }

    type IfcRelDefinesByProperties extending IfcRelDefines {
        link RelatedObjects -> IfcObjectDefinition;
        link RelatingPropertyDefinition -> IfcPropertySetDefinitionSelect;
    }

    type IfcRelDefinesByType extending IfcRelDefines {
        link RelatedObjects -> IfcObject;
        link RelatingType -> IfcTypeObject;
    }

    type IfcRelSequence extending IfcRelConnects {
        link RelatingProcess -> IfcProcess;
        link RelatedProcess -> IfcProcess;
        required link TimeLag -> IfcLagTime;
        required property SequenceType -> str {
            constraint one_of ('FINISH_FINISH','FINISH_START','NOTDEFINED','START_FINISH','START_START','USERDEFINED');
        };
        required property UserDefinedSequenceType -> str;
    }

    type IfcShapeAspect  {
        link ShapeRepresentations -> IfcShapeModel;
        required property Name -> str;
        required property Description -> str;
        property ProductDefinitional -> bool;
        required link PartOfProductDefinitionShape -> IfcProductRepresentationSelect;
    }

    type IfcSimplePropertyTemplate extending IfcPropertyTemplate {
        required property TemplateType -> str {
            constraint one_of ('P_BOUNDEDVALUE','P_ENUMERATEDVALUE','P_LISTVALUE','P_REFERENCEVALUE','P_SINGLEVALUE','P_TABLEVALUE','Q_AREA','Q_COUNT','Q_LENGTH','Q_TIME','Q_VOLUME','Q_WEIGHT');
        };
        required property PrimaryMeasureType -> str;
        required property SecondaryMeasureType -> str;
        required link Enumerators -> IfcPropertyEnumeration;
        required link PrimaryUnit -> IfcUnit;
        required link SecondaryUnit -> IfcUnit;
        required property Expression -> str;
        required property AccessState -> str {
            constraint one_of ('LOCKED','READONLY','READONLYLOCKED','READWRITE','READWRITELOCKED');
        };
    }

    abstract type IfcSpatialElement extending IfcProduct {
        required property LongName -> str;
    }

    abstract type IfcStructuralActivity extending IfcProduct {
        link AppliedLoad -> IfcStructuralLoad;
        property GlobalOrLocal -> str {
            constraint one_of ('GLOBAL_COORDS','LOCAL_COORDS');
        };
    }

    abstract type IfcStructuralItem extending IfcProduct {
    }

    type IfcStructuralLoadGroup extending IfcGroup {
        property PredefinedType -> str {
            constraint one_of ('LOAD_CASE','LOAD_COMBINATION','LOAD_GROUP','NOTDEFINED','USERDEFINED');
        };
        property ActionType -> str {
            constraint one_of ('EXTRAORDINARY_A','NOTDEFINED','PERMANENT_G','USERDEFINED','VARIABLE_Q');
        };
        property ActionSource -> str {
            constraint one_of ('BRAKES','BUOYANCY','COMPLETION_G1','CREEP','CURRENT','DEAD_LOAD_G','EARTHQUAKE_E','ERECTION','FIRE','ICE','IMPACT','IMPULSE','LACK_OF_FIT','LIVE_LOAD_Q','NOTDEFINED','PRESTRESSING_P','PROPPING','RAIN','SETTLEMENT_U','SHRINKAGE','SNOW_S','SYSTEM_IMPERFECTION','TEMPERATURE_T','TRANSPORT','USERDEFINED','WAVE','WIND_W');
        };
        required property Coefficient -> float64;
        required property Purpose -> str;
    }

    type IfcSurfaceStyle extending IfcPresentationStyle {
        property Side -> str {
            constraint one_of ('BOTH','NEGATIVE','POSITIVE');
        };
        link Styles -> IfcSurfaceStyleElementSelect;
    }

    type IfcSystem extending IfcGroup {
    }

    type IfcTask extending IfcProcess {
        required property Status -> str;
        required property WorkMethod -> str;
        property IsMilestone -> bool;
        required property Priority -> int64;
        required link TaskTime -> IfcTaskTime;
        required property PredefinedType -> str {
            constraint one_of ('ATTENDANCE','CONSTRUCTION','DEMOLITION','DISMANTLE','DISPOSAL','INSTALLATION','LOGISTIC','MAINTENANCE','MOVE','NOTDEFINED','OPERATION','REMOVAL','RENOVATION','USERDEFINED');
        };
    }

    abstract type IfcTypeProcess extending IfcTypeObject {
        required property Identification -> str;
        required property LongDescription -> str;
        required property ProcessType -> str;
    }

    type IfcTypeProduct extending IfcTypeObject {
        required link RepresentationMaps -> IfcRepresentationMap;
        required property Tag -> str;
    }

    abstract type IfcTypeResource extending IfcTypeObject {
        required property Identification -> str;
        required property LongDescription -> str;
        required property ResourceType -> str;
    }

    type IfcWorkCalendar extending IfcControl {
        required link WorkingTimes -> IfcWorkTime;
        required link ExceptionTimes -> IfcWorkTime;
        required property PredefinedType -> str {
            constraint one_of ('FIRSTSHIFT','NOTDEFINED','SECONDSHIFT','THIRDSHIFT','USERDEFINED');
        };
    }

    abstract type IfcWorkControl extending IfcControl {
        property CreationDate -> str;
        required link Creators -> IfcPerson;
        required property Purpose -> str;
        required property Duration -> str;
        required property TotalFloat -> str;
        property StartTime -> str;
        required property FinishTime -> str;
    }

    abstract type IfcBuildingElement extending IfcElement {
    }

    type IfcBuildingSystem extending IfcSystem {
        required property PredefinedType -> str {
            constraint one_of ('FENESTRATION','FOUNDATION','LOADBEARING','NOTDEFINED','OUTERSHELL','SHADING','TRANSPORT','USERDEFINED');
        };
        required property LongName -> str;
    }

    type IfcCivilElement extending IfcElement {
    }

    type IfcConstructionEquipmentResource extending IfcConstructionResource {
        required property PredefinedType -> str {
            constraint one_of ('DEMOLISHING','EARTHMOVING','ERECTING','HEATING','LIGHTING','NOTDEFINED','PAVING','PUMPING','TRANSPORTING','USERDEFINED');
        };
    }

    type IfcConstructionMaterialResource extending IfcConstructionResource {
        required property PredefinedType -> str {
            constraint one_of ('AGGREGATES','CONCRETE','DRYWALL','FUEL','GYPSUM','MASONRY','METAL','NOTDEFINED','PLASTIC','USERDEFINED','WOOD');
        };
    }

    type IfcConstructionProductResource extending IfcConstructionResource {
        required property PredefinedType -> str {
            constraint one_of ('ASSEMBLY','FORMWORK','NOTDEFINED','USERDEFINED');
        };
    }

    abstract type IfcConstructionResourceType extending IfcTypeResource {
        required link BaseCosts -> IfcAppliedValue;
        required link BaseQuantity -> IfcPhysicalQuantity;
    }

    type IfcCrewResource extending IfcConstructionResource {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','OFFICE','SITE','USERDEFINED');
        };
    }

    type IfcDistributionElement extending IfcElement {
    }

    type IfcDistributionPort extending IfcPort {
        required property FlowDirection -> str {
            constraint one_of ('NOTDEFINED','SINK','SOURCE','SOURCEANDSINK');
        };
        required property PredefinedType -> str {
            constraint one_of ('CABLE','CABLECARRIER','DUCT','NOTDEFINED','PIPE','USERDEFINED');
        };
        required property SystemType -> str {
            constraint one_of ('AIRCONDITIONING','AUDIOVISUAL','CHEMICAL','CHILLEDWATER','COMMUNICATION','COMPRESSEDAIR','CONDENSERWATER','CONTROL','CONVEYING','DATA','DISPOSAL','DOMESTICCOLDWATER','DOMESTICHOTWATER','DRAINAGE','EARTHING','ELECTRICAL','ELECTROACOUSTIC','EXHAUST','FIREPROTECTION','FUEL','GAS','HAZARDOUS','HEATING','LIGHTING','LIGHTNINGPROTECTION','MUNICIPALSOLIDWASTE','NOTDEFINED','OIL','OPERATIONAL','POWERGENERATION','RAINWATER','REFRIGERATION','SECURITY','SEWAGE','SIGNAL','STORMWATER','TELEPHONE','TV','USERDEFINED','VACUUM','VENT','VENTILATION','WASTEWATER','WATERSUPPLY');
        };
    }

    type IfcDistributionSystem extending IfcSystem {
        required property LongName -> str;
        required property PredefinedType -> str {
            constraint one_of ('AIRCONDITIONING','AUDIOVISUAL','CHEMICAL','CHILLEDWATER','COMMUNICATION','COMPRESSEDAIR','CONDENSERWATER','CONTROL','CONVEYING','DATA','DISPOSAL','DOMESTICCOLDWATER','DOMESTICHOTWATER','DRAINAGE','EARTHING','ELECTRICAL','ELECTROACOUSTIC','EXHAUST','FIREPROTECTION','FUEL','GAS','HAZARDOUS','HEATING','LIGHTING','LIGHTNINGPROTECTION','MUNICIPALSOLIDWASTE','NOTDEFINED','OIL','OPERATIONAL','POWERGENERATION','RAINWATER','REFRIGERATION','SECURITY','SEWAGE','SIGNAL','STORMWATER','TELEPHONE','TV','USERDEFINED','VACUUM','VENT','VENTILATION','WASTEWATER','WATERSUPPLY');
        };
    }

    type IfcDoorLiningProperties extending IfcPreDefinedPropertySet {
        required property LiningDepth -> float64;
        required property LiningThickness -> float64;
        required property ThresholdDepth -> float64;
        required property ThresholdThickness -> float64;
        required property TransomThickness -> float64;
        required property TransomOffset -> float64;
        required property LiningOffset -> float64;
        required property ThresholdOffset -> float64;
        required property CasingThickness -> float64;
        required property CasingDepth -> float64;
        required link ShapeAspectStyle -> IfcShapeAspect;
        required property LiningToPanelOffsetX -> float64;
        required property LiningToPanelOffsetY -> float64;
    }

    type IfcDoorPanelProperties extending IfcPreDefinedPropertySet {
        required property PanelDepth -> float64;
        property PanelOperation -> str {
            constraint one_of ('DOUBLE_ACTING','FIXEDPANEL','FOLDING','NOTDEFINED','REVOLVING','ROLLINGUP','SLIDING','SWINGING','USERDEFINED');
        };
        required property PanelWidth -> float64;
        property PanelPosition -> str {
            constraint one_of ('LEFT','MIDDLE','NOTDEFINED','RIGHT');
        };
        required link ShapeAspectStyle -> IfcShapeAspect;
    }

    type IfcDoorStyle extending IfcTypeProduct {
        property OperationType -> str {
            constraint one_of ('DOUBLE_DOOR_DOUBLE_SWING','DOUBLE_DOOR_FOLDING','DOUBLE_DOOR_SINGLE_SWING','DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_LEFT','DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_RIGHT','DOUBLE_DOOR_SLIDING','DOUBLE_SWING_LEFT','DOUBLE_SWING_RIGHT','FOLDING_TO_LEFT','FOLDING_TO_RIGHT','NOTDEFINED','REVOLVING','ROLLINGUP','SINGLE_SWING_LEFT','SINGLE_SWING_RIGHT','SLIDING_TO_LEFT','SLIDING_TO_RIGHT','USERDEFINED');
        };
        property ConstructionType -> str {
            constraint one_of ('ALUMINIUM','ALUMINIUM_PLASTIC','ALUMINIUM_WOOD','HIGH_GRADE_STEEL','NOTDEFINED','PLASTIC','STEEL','USERDEFINED','WOOD');
        };
        property ParameterTakesPrecedence -> bool;
        property Sizeable -> bool;
    }

    type IfcElementAssembly extending IfcElement {
        required property AssemblyPlace -> str {
            constraint one_of ('FACTORY','NOTDEFINED','SITE');
        };
        required property PredefinedType -> str {
            constraint one_of ('ACCESSORY_ASSEMBLY','ARCH','BEAM_GRID','BRACED_FRAME','GIRDER','NOTDEFINED','REINFORCEMENT_UNIT','RIGID_FRAME','SLAB_FIELD','TRUSS','USERDEFINED');
        };
    }

    abstract type IfcElementComponent extending IfcElement {
    }

    abstract type IfcElementType extending IfcTypeProduct {
        required property ElementType -> str;
    }

    type IfcEventType extending IfcTypeProcess {
        property PredefinedType -> str {
            constraint one_of ('ENDEVENT','INTERMEDIATEEVENT','NOTDEFINED','STARTEVENT','USERDEFINED');
        };
        property EventTriggerType -> str {
            constraint one_of ('EVENTCOMPLEX','EVENTMESSAGE','EVENTRULE','EVENTTIME','NOTDEFINED','USERDEFINED');
        };
        required property UserDefinedEventTriggerType -> str;
    }

    abstract type IfcExternalSpatialStructureElement extending IfcSpatialElement {
    }

    abstract type IfcFeatureElement extending IfcElement {
    }

    type IfcFurnishingElement extending IfcElement {
    }

    type IfcGeographicElement extending IfcElement {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','TERRAIN','USERDEFINED');
        };
    }

    type IfcGrid extending IfcPositioningElement {
        link UAxes -> IfcGridAxis;
        link VAxes -> IfcGridAxis;
        required link WAxes -> IfcGridAxis;
        required property PredefinedType -> str {
            constraint one_of ('IRREGULAR','NOTDEFINED','RADIAL','RECTANGULAR','TRIANGULAR','USERDEFINED');
        };
    }

    type IfcLaborResource extending IfcConstructionResource {
        required property PredefinedType -> str {
            constraint one_of ('ADMINISTRATION','CARPENTRY','CLEANING','CONCRETE','DRYWALL','ELECTRIC','FINISHING','FLOORING','GENERAL','HVAC','LANDSCAPING','MASONRY','NOTDEFINED','PAINTING','PAVING','PLUMBING','ROOFING','SITEGRADING','STEELWORK','SURVEYING','USERDEFINED');
        };
    }

    abstract type IfcLinearPositioningElement extending IfcPositioningElement {
        link Axis -> IfcCurve;
    }

    type IfcMapConversion extending IfcCoordinateOperation {
        property Eastings -> float64;
        property Northings -> float64;
        property OrthogonalHeight -> float64;
        required property XAxisAbscissa -> float64;
        required property XAxisOrdinate -> float64;
        required property Scale -> float64;
    }

    type IfcPermeableCoveringProperties extending IfcPreDefinedPropertySet {
        property OperationType -> str {
            constraint one_of ('GRILL','LOUVER','NOTDEFINED','SCREEN','USERDEFINED');
        };
        property PanelPosition -> str {
            constraint one_of ('BOTTOM','LEFT','MIDDLE','NOTDEFINED','RIGHT','TOP');
        };
        required property FrameDepth -> float64;
        required property FrameThickness -> float64;
        required link ShapeAspectStyle -> IfcShapeAspect;
    }

    type IfcPresentationStyleSelect {
        link IfcPresentationStyleSelect -> IfcCurveStyle | IfcFillAreaStyle | IfcNullStyle | IfcSurfaceStyle | IfcTextStyle;
    }

    type IfcProcedureType extending IfcTypeProcess {
        property PredefinedType -> str {
            constraint one_of ('ADVICE_CAUTION','ADVICE_NOTE','ADVICE_WARNING','CALIBRATION','DIAGNOSTIC','NOTDEFINED','SHUTDOWN','STARTUP','USERDEFINED');
        };
    }

    type IfcProcessSelect {
        link IfcProcessSelect -> IfcProcess | IfcTypeProcess;
    }

    type IfcProductSelect {
        link IfcProductSelect -> IfcProduct | IfcTypeProduct;
    }

    type IfcReferent extending IfcPositioningElement {
        required property PredefinedType -> str {
            constraint one_of ('KILOPOINT','MILEPOINT','NOTDEFINED','STATION','USERDEFINED');
        };
        required property RestartDistance -> float64;
    }

    type IfcRelAssignsToGroupByFactor extending IfcRelAssignsToGroup {
        property Factor -> float64;
    }

    type IfcRelConnectsElements extending IfcRelConnects {
        required link ConnectionGeometry -> IfcConnectionGeometry;
        link RelatingElement -> IfcElement;
        link RelatedElement -> IfcElement;
    }

    type IfcRelConnectsPorts extending IfcRelConnects {
        link RelatingPort -> IfcPort;
        link RelatedPort -> IfcPort;
        required link RealizingElement -> IfcElement;
    }

    type IfcRelContainedInSpatialStructure extending IfcRelConnects {
        link RelatedElements -> IfcProduct;
        link RelatingStructure -> IfcSpatialElement;
    }

    type IfcRelDefinesByTemplate extending IfcRelDefines {
        link RelatedPropertySets -> IfcPropertySetDefinition;
        link RelatingTemplate -> IfcPropertySetTemplate;
    }

    type IfcRelInterferesElements extending IfcRelConnects {
        link RelatingElement -> IfcElement;
        link RelatedElement -> IfcElement;
        required link InterferenceGeometry -> IfcConnectionGeometry;
        required property InterferenceType -> str;
        property ImpliedOrder -> bool;
    }

    type IfcRelReferencedInSpatialStructure extending IfcRelConnects {
        link RelatedElements -> IfcProduct;
        link RelatingStructure -> IfcSpatialElement;
    }

    type IfcRelServicesBuildings extending IfcRelConnects {
        link RelatingSystem -> IfcSystem;
        link RelatedBuildings -> IfcSpatialElement;
    }

    type IfcResourceObjectSelect {
        link IfcResourceObjectSelect -> IfcActorRole | IfcAppliedValue | IfcApproval | IfcConstraint | IfcContextDependentUnit | IfcConversionBasedUnit | IfcExternalInformation | IfcExternalReference | IfcMaterialDefinition | IfcOrganization | IfcPerson | IfcPersonAndOrganization | IfcPhysicalQuantity | IfcProfileDef | IfcPropertyAbstraction | IfcShapeAspect | IfcTimeSeries;
    }

    type IfcResourceSelect {
        link IfcResourceSelect -> IfcResource | IfcTypeResource;
    }

    abstract type IfcSpatialElementType extending IfcTypeProduct {
        required property ElementType -> str;
    }

    abstract type IfcSpatialStructureElement extending IfcSpatialElement {
        required property CompositionType -> str {
            constraint one_of ('COMPLEX','ELEMENT','PARTIAL');
        };
    }

    type IfcSpatialZone extending IfcSpatialElement {
        required property PredefinedType -> str {
            constraint one_of ('CONSTRUCTION','FIRESAFETY','LIGHTING','NOTDEFINED','OCCUPANCY','SECURITY','THERMAL','TRANSPORT','USERDEFINED','VENTILATION');
        };
    }

    abstract type IfcStructuralAction extending IfcStructuralActivity {
        required property DestabilizingLoad -> bool;
    }

    type IfcStructuralActivityAssignmentSelect {
        link IfcStructuralActivityAssignmentSelect -> IfcElement | IfcStructuralItem;
    }

    abstract type IfcStructuralConnection extending IfcStructuralItem {
        required link AppliedCondition -> IfcBoundaryCondition;
    }

    type IfcStructuralLoadCase extending IfcStructuralLoadGroup {
        required property SelfWeightCoefficients -> tuple<float64, float64, float64>;
    }

    abstract type IfcStructuralMember extending IfcStructuralItem {
    }

    abstract type IfcStructuralReaction extending IfcStructuralActivity {
    }

    type IfcStructuralResultGroup extending IfcGroup {
        property TheoryType -> str {
            constraint one_of ('FIRST_ORDER_THEORY','FULL_NONLINEAR_THEORY','NOTDEFINED','SECOND_ORDER_THEORY','THIRD_ORDER_THEORY','USERDEFINED');
        };
        required link ResultForLoadGroup -> IfcStructuralLoadGroup;
        property IsLinear -> bool;
    }

    type IfcSubContractResource extending IfcConstructionResource {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','PURCHASE','USERDEFINED','WORK');
        };
    }

    type IfcTaskType extending IfcTypeProcess {
        property PredefinedType -> str {
            constraint one_of ('ATTENDANCE','CONSTRUCTION','DEMOLITION','DISMANTLE','DISPOSAL','INSTALLATION','LOGISTIC','MAINTENANCE','MOVE','NOTDEFINED','OPERATION','REMOVAL','RENOVATION','USERDEFINED');
        };
        required property WorkMethod -> str;
    }

    type IfcTransportElement extending IfcElement {
        required property PredefinedType -> str {
            constraint one_of ('CRANEWAY','ELEVATOR','ESCALATOR','LIFTINGGEAR','MOVINGWALKWAY','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcVirtualElement extending IfcElement {
    }

    type IfcWindowLiningProperties extending IfcPreDefinedPropertySet {
        required property LiningDepth -> float64;
        required property LiningThickness -> float64;
        required property TransomThickness -> float64;
        required property MullionThickness -> float64;
        required property FirstTransomOffset -> float64;
        required property SecondTransomOffset -> float64;
        required property FirstMullionOffset -> float64;
        required property SecondMullionOffset -> float64;
        required link ShapeAspectStyle -> IfcShapeAspect;
        required property LiningOffset -> float64;
        required property LiningToPanelOffsetX -> float64;
        required property LiningToPanelOffsetY -> float64;
    }

    type IfcWindowPanelProperties extending IfcPreDefinedPropertySet {
        property OperationType -> str {
            constraint one_of ('BOTTOMHUNG','FIXEDCASEMENT','NOTDEFINED','OTHEROPERATION','PIVOTHORIZONTAL','PIVOTVERTICAL','REMOVABLECASEMENT','SIDEHUNGLEFTHAND','SIDEHUNGRIGHTHAND','SLIDINGHORIZONTAL','SLIDINGVERTICAL','TILTANDTURNLEFTHAND','TILTANDTURNRIGHTHAND','TOPHUNG');
        };
        property PanelPosition -> str {
            constraint one_of ('BOTTOM','LEFT','MIDDLE','NOTDEFINED','RIGHT','TOP');
        };
        required property FrameDepth -> float64;
        required property FrameThickness -> float64;
        required link ShapeAspectStyle -> IfcShapeAspect;
    }

    type IfcWindowStyle extending IfcTypeProduct {
        property ConstructionType -> str {
            constraint one_of ('ALUMINIUM','ALUMINIUM_WOOD','HIGH_GRADE_STEEL','NOTDEFINED','OTHER_CONSTRUCTION','PLASTIC','STEEL','WOOD');
        };
        property OperationType -> str {
            constraint one_of ('DOUBLE_PANEL_HORIZONTAL','DOUBLE_PANEL_VERTICAL','NOTDEFINED','SINGLE_PANEL','TRIPLE_PANEL_BOTTOM','TRIPLE_PANEL_HORIZONTAL','TRIPLE_PANEL_LEFT','TRIPLE_PANEL_RIGHT','TRIPLE_PANEL_TOP','TRIPLE_PANEL_VERTICAL','USERDEFINED');
        };
        property ParameterTakesPrecedence -> bool;
        property Sizeable -> bool;
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

    type IfcZone extending IfcSystem {
        required property LongName -> str;
    }

    type IfcAlignment extending IfcLinearPositioningElement {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcBeam extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('BEAM','HOLLOWCORE','JOIST','LINTEL','NOTDEFINED','SPANDREL','T_BEAM','USERDEFINED');
        };
    }

    type IfcBuilding extending IfcSpatialStructureElement {
        required property ElevationOfRefHeight -> float64;
        required property ElevationOfTerrain -> float64;
        required link BuildingAddress -> IfcPostalAddress;
    }

    type IfcBuildingElementPart extending IfcElementComponent {
        required property PredefinedType -> str {
            constraint one_of ('INSULATION','NOTDEFINED','PRECASTPANEL','USERDEFINED');
        };
    }

    type IfcBuildingElementProxy extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('COMPLEX','ELEMENT','NOTDEFINED','PARTIAL','PROVISIONFORSPACE','PROVISIONFORVOID','USERDEFINED');
        };
    }

    abstract type IfcBuildingElementType extending IfcElementType {
    }

    type IfcBuildingStorey extending IfcSpatialStructureElement {
        required property Elevation -> float64;
    }

    type IfcChimney extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcCivilElementType extending IfcElementType {
    }

    type IfcColumn extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('COLUMN','NOTDEFINED','PILASTER','USERDEFINED');
        };
    }

    type IfcConstructionEquipmentResourceType extending IfcConstructionResourceType {
        property PredefinedType -> str {
            constraint one_of ('DEMOLISHING','EARTHMOVING','ERECTING','HEATING','LIGHTING','NOTDEFINED','PAVING','PUMPING','TRANSPORTING','USERDEFINED');
        };
    }

    type IfcConstructionMaterialResourceType extending IfcConstructionResourceType {
        property PredefinedType -> str {
            constraint one_of ('AGGREGATES','CONCRETE','DRYWALL','FUEL','GYPSUM','MASONRY','METAL','NOTDEFINED','PLASTIC','USERDEFINED','WOOD');
        };
    }

    type IfcConstructionProductResourceType extending IfcConstructionResourceType {
        property PredefinedType -> str {
            constraint one_of ('ASSEMBLY','FORMWORK','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcCovering extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('CEILING','CLADDING','FLOORING','INSULATION','MEMBRANE','MOLDING','NOTDEFINED','ROOFING','SKIRTINGBOARD','SLEEVING','USERDEFINED','WRAPPING');
        };
    }

    type IfcCrewResourceType extending IfcConstructionResourceType {
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','OFFICE','SITE','USERDEFINED');
        };
    }

    type IfcCurtainWall extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcDiscreteAccessory extending IfcElementComponent {
        required property PredefinedType -> str {
            constraint one_of ('ANCHORPLATE','BRACKET','NOTDEFINED','SHOE','USERDEFINED');
        };
    }

    type IfcDistributionCircuit extending IfcDistributionSystem {
    }

    type IfcDistributionControlElement extending IfcDistributionElement {
    }

    type IfcDistributionElementType extending IfcElementType {
    }

    type IfcDistributionFlowElement extending IfcDistributionElement {
    }

    type IfcDoor extending IfcBuildingElement {
        required property OverallHeight -> float64;
        required property OverallWidth -> float64;
        required property PredefinedType -> str {
            constraint one_of ('DOOR','GATE','NOTDEFINED','TRAPDOOR','USERDEFINED');
        };
        required property OperationType -> str {
            constraint one_of ('DOUBLE_DOOR_DOUBLE_SWING','DOUBLE_DOOR_FOLDING','DOUBLE_DOOR_SINGLE_SWING','DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_LEFT','DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_RIGHT','DOUBLE_DOOR_SLIDING','DOUBLE_SWING_LEFT','DOUBLE_SWING_RIGHT','FOLDING_TO_LEFT','FOLDING_TO_RIGHT','NOTDEFINED','REVOLVING','ROLLINGUP','SINGLE_SWING_LEFT','SINGLE_SWING_RIGHT','SLIDING_TO_LEFT','SLIDING_TO_RIGHT','SWING_FIXED_LEFT','SWING_FIXED_RIGHT','USERDEFINED');
        };
        required property UserDefinedOperationType -> str;
    }

    type IfcElementAssemblyType extending IfcElementType {
        property PredefinedType -> str {
            constraint one_of ('ACCESSORY_ASSEMBLY','ARCH','BEAM_GRID','BRACED_FRAME','GIRDER','NOTDEFINED','REINFORCEMENT_UNIT','RIGID_FRAME','SLAB_FIELD','TRUSS','USERDEFINED');
        };
    }

    abstract type IfcElementComponentType extending IfcElementType {
    }

    type IfcExternalReferenceRelationship extending IfcResourceLevelRelationship {
        link RelatingReference -> IfcExternalReference;
        link RelatedResourceObjects -> IfcResourceObjectSelect;
    }

    type IfcExternalSpatialElement extending IfcExternalSpatialStructureElement {
        required property PredefinedType -> str {
            constraint one_of ('EXTERNAL','EXTERNAL_EARTH','EXTERNAL_FIRE','EXTERNAL_WATER','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcFastener extending IfcElementComponent {
        required property PredefinedType -> str {
            constraint one_of ('GLUE','MORTAR','NOTDEFINED','USERDEFINED','WELD');
        };
    }

    abstract type IfcFeatureElementAddition extending IfcFeatureElement {
    }

    abstract type IfcFeatureElementSubtraction extending IfcFeatureElement {
    }

    type IfcFooting extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('CAISSON_FOUNDATION','FOOTING_BEAM','NOTDEFINED','PAD_FOOTING','PILE_CAP','STRIP_FOOTING','USERDEFINED');
        };
    }

    type IfcFurnishingElementType extending IfcElementType {
    }

    type IfcFurniture extending IfcFurnishingElement {
        required property PredefinedType -> str {
            constraint one_of ('BED','CHAIR','DESK','FILECABINET','NOTDEFINED','SHELF','SOFA','TABLE','USERDEFINED');
        };
    }

    type IfcGeographicElementType extending IfcElementType {
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','TERRAIN','USERDEFINED');
        };
    }

    type IfcLaborResourceType extending IfcConstructionResourceType {
        property PredefinedType -> str {
            constraint one_of ('ADMINISTRATION','CARPENTRY','CLEANING','CONCRETE','DRYWALL','ELECTRIC','FINISHING','FLOORING','GENERAL','HVAC','LANDSCAPING','MASONRY','NOTDEFINED','PAINTING','PAVING','PLUMBING','ROOFING','SITEGRADING','STEELWORK','SURVEYING','USERDEFINED');
        };
    }

    type IfcMechanicalFastener extending IfcElementComponent {
        required property NominalDiameter -> float64;
        required property NominalLength -> float64;
        required property PredefinedType -> str {
            constraint one_of ('ANCHORBOLT','BOLT','DOWEL','NAIL','NAILPLATE','NOTDEFINED','RIVET','SCREW','SHEARCONNECTOR','STAPLE','STUDSHEARCONNECTOR','USERDEFINED');
        };
    }

    type IfcMember extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('BRACE','CHORD','COLLAR','MEMBER','MULLION','NOTDEFINED','PLATE','POST','PURLIN','RAFTER','STRINGER','STRUT','STUD','USERDEFINED');
        };
    }

    type IfcPile extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('BORED','COHESION','DRIVEN','FRICTION','JETGROUTING','NOTDEFINED','SUPPORT','USERDEFINED');
        };
        required property ConstructionType -> str {
            constraint one_of ('CAST_IN_PLACE','COMPOSITE','NOTDEFINED','PRECAST_CONCRETE','PREFAB_STEEL','USERDEFINED');
        };
    }

    type IfcPlate extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('CURTAIN_PANEL','NOTDEFINED','SHEET','USERDEFINED');
        };
    }

    type IfcPresentationStyleAssignment  {
        link Styles -> IfcPresentationStyleSelect;
    }

    type IfcRailing extending IfcBuildingElement {
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

    abstract type IfcReinforcingElement extending IfcElementComponent {
        required property SteelGrade -> str;
    }

    type IfcRelAssignsToProcess extending IfcRelAssigns {
        link RelatingProcess -> IfcProcessSelect;
        required link QuantityInProcess -> IfcMeasureWithUnit;
    }

    type IfcRelAssignsToProduct extending IfcRelAssigns {
        link RelatingProduct -> IfcProductSelect;
    }

    type IfcRelAssignsToResource extending IfcRelAssigns {
        link RelatingResource -> IfcResourceSelect;
    }

    type IfcRelConnectsPathElements extending IfcRelConnectsElements {
        property RelatingPriorities -> tuple<int64>;
        property RelatedPriorities -> tuple<int64>;
        property RelatedConnectionType -> str {
            constraint one_of ('ATEND','ATPATH','ATSTART','NOTDEFINED');
        };
        property RelatingConnectionType -> str {
            constraint one_of ('ATEND','ATPATH','ATSTART','NOTDEFINED');
        };
    }

    type IfcRelConnectsPortToElement extending IfcRelConnects {
        link RelatingPort -> IfcPort;
        link RelatedElement -> IfcDistributionElement;
    }

    type IfcRelConnectsStructuralActivity extending IfcRelConnects {
        link RelatingElement -> IfcStructuralActivityAssignmentSelect;
        link RelatedStructuralActivity -> IfcStructuralActivity;
    }

    type IfcRelConnectsStructuralMember extending IfcRelConnects {
        link RelatingStructuralMember -> IfcStructuralMember;
        link RelatedStructuralConnection -> IfcStructuralConnection;
        required link AppliedCondition -> IfcBoundaryCondition;
        required link AdditionalConditions -> IfcStructuralConnectionCondition;
        required property SupportedLength -> float64;
        required link ConditionCoordinateSystem -> IfcAxis2Placement3D;
    }

    type IfcRelConnectsWithRealizingElements extending IfcRelConnectsElements {
        link RealizingElements -> IfcElement;
        required property ConnectionType -> str;
    }

    type IfcResourceApprovalRelationship extending IfcResourceLevelRelationship {
        link RelatedResourceObjects -> IfcResourceObjectSelect;
        link RelatingApproval -> IfcApproval;
    }

    type IfcResourceConstraintRelationship extending IfcResourceLevelRelationship {
        link RelatingConstraint -> IfcConstraint;
        link RelatedResourceObjects -> IfcResourceObjectSelect;
    }

    type IfcRoof extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('BARREL_ROOF','BUTTERFLY_ROOF','DOME_ROOF','FLAT_ROOF','FREEFORM','GABLE_ROOF','GAMBREL_ROOF','HIPPED_GABLE_ROOF','HIP_ROOF','MANSARD_ROOF','NOTDEFINED','PAVILION_ROOF','RAINBOW_ROOF','SHED_ROOF','USERDEFINED');
        };
    }

    type IfcShadingDevice extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('AWNING','JALOUSIE','NOTDEFINED','SHUTTER','USERDEFINED');
        };
    }

    type IfcSite extending IfcSpatialStructureElement {
        required property RefLatitude -> int64;
        required property RefLongitude -> int64;
        required property RefElevation -> float64;
        required property LandTitleNumber -> str;
        required link SiteAddress -> IfcPostalAddress;
    }

    type IfcSlab extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('BASESLAB','FLOOR','LANDING','NOTDEFINED','ROOF','USERDEFINED');
        };
    }

    type IfcSpace extending IfcSpatialStructureElement {
        required property PredefinedType -> str {
            constraint one_of ('EXTERNAL','GFA','INTERNAL','NOTDEFINED','PARKING','SPACE','USERDEFINED');
        };
        required property ElevationWithFlooring -> float64;
    }

    abstract type IfcSpatialStructureElementType extending IfcSpatialElementType {
    }

    type IfcSpatialZoneType extending IfcSpatialElementType {
        property PredefinedType -> str {
            constraint one_of ('CONSTRUCTION','FIRESAFETY','LIGHTING','NOTDEFINED','OCCUPANCY','SECURITY','THERMAL','TRANSPORT','USERDEFINED','VENTILATION');
        };
        required property LongName -> str;
    }

    type IfcStair extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('CURVED_RUN_STAIR','DOUBLE_RETURN_STAIR','HALF_TURN_STAIR','HALF_WINDING_STAIR','NOTDEFINED','QUARTER_TURN_STAIR','QUARTER_WINDING_STAIR','SPIRAL_STAIR','STRAIGHT_RUN_STAIR','THREE_QUARTER_TURN_STAIR','THREE_QUARTER_WINDING_STAIR','TWO_CURVED_RUN_STAIR','TWO_QUARTER_TURN_STAIR','TWO_QUARTER_WINDING_STAIR','TWO_STRAIGHT_RUN_STAIR','USERDEFINED');
        };
    }

    type IfcStairFlight extending IfcBuildingElement {
        required property NumberOfRisers -> int64;
        required property NumberOfTreads -> int64;
        required property RiserHeight -> float64;
        required property TreadLength -> float64;
        required property PredefinedType -> str {
            constraint one_of ('CURVED','FREEFORM','NOTDEFINED','SPIRAL','STRAIGHT','USERDEFINED','WINDER');
        };
    }

    type IfcStructuralAnalysisModel extending IfcSystem {
        property PredefinedType -> str {
            constraint one_of ('IN_PLANE_LOADING_2D','LOADING_3D','NOTDEFINED','OUT_PLANE_LOADING_2D','USERDEFINED');
        };
        required link OrientationOf2DPlane -> IfcAxis2Placement3D;
        required link LoadedBy -> IfcStructuralLoadGroup;
        required link HasResults -> IfcStructuralResultGroup;
        required link SharedPlacement -> IfcObjectPlacement;
    }

    type IfcStructuralCurveAction extending IfcStructuralAction {
        required property ProjectedOrTrue -> str {
            constraint one_of ('PROJECTED_LENGTH','TRUE_LENGTH');
        };
        property PredefinedType -> str {
            constraint one_of ('CONST','DISCRETE','EQUIDISTANT','LINEAR','NOTDEFINED','PARABOLA','POLYGONAL','SINUS','USERDEFINED');
        };
    }

    type IfcStructuralCurveConnection extending IfcStructuralConnection {
        link Axis -> IfcDirection;
    }

    type IfcStructuralCurveMember extending IfcStructuralMember {
        property PredefinedType -> str {
            constraint one_of ('CABLE','COMPRESSION_MEMBER','NOTDEFINED','PIN_JOINED_MEMBER','RIGID_JOINED_MEMBER','TENSION_MEMBER','USERDEFINED');
        };
        link Axis -> IfcDirection;
    }

    type IfcStructuralCurveReaction extending IfcStructuralReaction {
        property PredefinedType -> str {
            constraint one_of ('CONST','DISCRETE','EQUIDISTANT','LINEAR','NOTDEFINED','PARABOLA','POLYGONAL','SINUS','USERDEFINED');
        };
    }

    type IfcStructuralPointAction extending IfcStructuralAction {
    }

    type IfcStructuralPointConnection extending IfcStructuralConnection {
        required link ConditionCoordinateSystem -> IfcAxis2Placement3D;
    }

    type IfcStructuralPointReaction extending IfcStructuralReaction {
    }

    type IfcStructuralSurfaceAction extending IfcStructuralAction {
        required property ProjectedOrTrue -> str {
            constraint one_of ('PROJECTED_LENGTH','TRUE_LENGTH');
        };
        property PredefinedType -> str {
            constraint one_of ('BILINEAR','CONST','DISCRETE','ISOCONTOUR','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcStructuralSurfaceConnection extending IfcStructuralConnection {
    }

    type IfcStructuralSurfaceMember extending IfcStructuralMember {
        property PredefinedType -> str {
            constraint one_of ('BENDING_ELEMENT','MEMBRANE_ELEMENT','NOTDEFINED','SHELL','USERDEFINED');
        };
        required property Thickness -> float64;
    }

    type IfcStructuralSurfaceReaction extending IfcStructuralReaction {
        property PredefinedType -> str {
            constraint one_of ('BILINEAR','CONST','DISCRETE','ISOCONTOUR','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcSubContractResourceType extending IfcConstructionResourceType {
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','PURCHASE','USERDEFINED','WORK');
        };
    }

    type IfcSurfaceFeature extending IfcFeatureElement {
        required property PredefinedType -> str {
            constraint one_of ('MARK','NOTDEFINED','TAG','TREATMENT','USERDEFINED');
        };
    }

    type IfcSystemFurnitureElement extending IfcFurnishingElement {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','PANEL','USERDEFINED','WORKSURFACE');
        };
    }

    type IfcTransportElementType extending IfcElementType {
        property PredefinedType -> str {
            constraint one_of ('CRANEWAY','ELEVATOR','ESCALATOR','LIFTINGGEAR','MOVINGWALKWAY','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcVibrationIsolator extending IfcElementComponent {
        required property PredefinedType -> str {
            constraint one_of ('COMPRESSION','NOTDEFINED','SPRING','USERDEFINED');
        };
    }

    type IfcWall extending IfcBuildingElement {
        required property PredefinedType -> str {
            constraint one_of ('ELEMENTEDWALL','MOVABLE','NOTDEFINED','PARAPET','PARTITIONING','PLUMBINGWALL','POLYGONAL','SHEAR','SOLIDWALL','STANDARD','USERDEFINED');
        };
    }

    type IfcWindow extending IfcBuildingElement {
        required property OverallHeight -> float64;
        required property OverallWidth -> float64;
        required property PredefinedType -> str {
            constraint one_of ('LIGHTDOME','NOTDEFINED','SKYLIGHT','USERDEFINED','WINDOW');
        };
        required property PartitioningType -> str {
            constraint one_of ('DOUBLE_PANEL_HORIZONTAL','DOUBLE_PANEL_VERTICAL','NOTDEFINED','SINGLE_PANEL','TRIPLE_PANEL_BOTTOM','TRIPLE_PANEL_HORIZONTAL','TRIPLE_PANEL_LEFT','TRIPLE_PANEL_RIGHT','TRIPLE_PANEL_TOP','TRIPLE_PANEL_VERTICAL','USERDEFINED');
        };
        required property UserDefinedPartitioningType -> str;
    }

    type IfcActuator extending IfcDistributionControlElement {
        required property PredefinedType -> str {
            constraint one_of ('ELECTRICACTUATOR','HANDOPERATEDACTUATOR','HYDRAULICACTUATOR','NOTDEFINED','PNEUMATICACTUATOR','THERMOSTATICACTUATOR','USERDEFINED');
        };
    }

    type IfcAlarm extending IfcDistributionControlElement {
        required property PredefinedType -> str {
            constraint one_of ('BELL','BREAKGLASSBUTTON','LIGHT','MANUALPULLBOX','NOTDEFINED','SIREN','USERDEFINED','WHISTLE');
        };
    }

    type IfcBeamStandardCase extending IfcBeam {
    }

    type IfcBeamType extending IfcBuildingElementType {
        property PredefinedType -> str {
            constraint one_of ('BEAM','HOLLOWCORE','JOIST','LINTEL','NOTDEFINED','SPANDREL','T_BEAM','USERDEFINED');
        };
    }

    type IfcBuildingElementPartType extending IfcElementComponentType {
        property PredefinedType -> str {
            constraint one_of ('INSULATION','NOTDEFINED','PRECASTPANEL','USERDEFINED');
        };
    }

    type IfcBuildingElementProxyType extending IfcBuildingElementType {
        property PredefinedType -> str {
            constraint one_of ('COMPLEX','ELEMENT','NOTDEFINED','PARTIAL','PROVISIONFORSPACE','PROVISIONFORVOID','USERDEFINED');
        };
    }

    type IfcChimneyType extending IfcBuildingElementType {
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcColumnStandardCase extending IfcColumn {
    }

    type IfcColumnType extending IfcBuildingElementType {
        property PredefinedType -> str {
            constraint one_of ('COLUMN','NOTDEFINED','PILASTER','USERDEFINED');
        };
    }

    type IfcController extending IfcDistributionControlElement {
        required property PredefinedType -> str {
            constraint one_of ('FLOATING','MULTIPOSITION','NOTDEFINED','PROGRAMMABLE','PROPORTIONAL','TWOPOSITION','USERDEFINED');
        };
    }

    type IfcCoveringType extending IfcBuildingElementType {
        property PredefinedType -> str {
            constraint one_of ('CEILING','CLADDING','FLOORING','INSULATION','MEMBRANE','MOLDING','NOTDEFINED','ROOFING','SKIRTINGBOARD','SLEEVING','USERDEFINED','WRAPPING');
        };
    }

    type IfcCurtainWallType extending IfcBuildingElementType {
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcDiscreteAccessoryType extending IfcElementComponentType {
        property PredefinedType -> str {
            constraint one_of ('ANCHORPLATE','BRACKET','NOTDEFINED','SHOE','USERDEFINED');
        };
    }

    type IfcDistributionChamberElement extending IfcDistributionFlowElement {
        required property PredefinedType -> str {
            constraint one_of ('FORMEDDUCT','INSPECTIONCHAMBER','INSPECTIONPIT','MANHOLE','METERCHAMBER','NOTDEFINED','SUMP','TRENCH','USERDEFINED','VALVECHAMBER');
        };
    }

    abstract type IfcDistributionControlElementType extending IfcDistributionElementType {
    }

    abstract type IfcDistributionFlowElementType extending IfcDistributionElementType {
    }

    type IfcDoorStandardCase extending IfcDoor {
    }

    type IfcDoorType extending IfcBuildingElementType {
        property PredefinedType -> str {
            constraint one_of ('DOOR','GATE','NOTDEFINED','TRAPDOOR','USERDEFINED');
        };
        property OperationType -> str {
            constraint one_of ('DOUBLE_DOOR_DOUBLE_SWING','DOUBLE_DOOR_FOLDING','DOUBLE_DOOR_SINGLE_SWING','DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_LEFT','DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_RIGHT','DOUBLE_DOOR_SLIDING','DOUBLE_SWING_LEFT','DOUBLE_SWING_RIGHT','FOLDING_TO_LEFT','FOLDING_TO_RIGHT','NOTDEFINED','REVOLVING','ROLLINGUP','SINGLE_SWING_LEFT','SINGLE_SWING_RIGHT','SLIDING_TO_LEFT','SLIDING_TO_RIGHT','SWING_FIXED_LEFT','SWING_FIXED_RIGHT','USERDEFINED');
        };
        required property ParameterTakesPrecedence -> bool;
        required property UserDefinedOperationType -> str;
    }

    type IfcEnergyConversionDevice extending IfcDistributionFlowElement {
    }

    type IfcFastenerType extending IfcElementComponentType {
        property PredefinedType -> str {
            constraint one_of ('GLUE','MORTAR','NOTDEFINED','USERDEFINED','WELD');
        };
    }

    type IfcFlowController extending IfcDistributionFlowElement {
    }

    type IfcFlowFitting extending IfcDistributionFlowElement {
    }

    type IfcFlowInstrument extending IfcDistributionControlElement {
        required property PredefinedType -> str {
            constraint one_of ('AMMETER','FREQUENCYMETER','NOTDEFINED','PHASEANGLEMETER','POWERFACTORMETER','PRESSUREGAUGE','THERMOMETER','USERDEFINED','VOLTMETER_PEAK','VOLTMETER_RMS');
        };
    }

    type IfcFlowMovingDevice extending IfcDistributionFlowElement {
    }

    type IfcFlowSegment extending IfcDistributionFlowElement {
    }

    type IfcFlowStorageDevice extending IfcDistributionFlowElement {
    }

    type IfcFlowTerminal extending IfcDistributionFlowElement {
    }

    type IfcFlowTreatmentDevice extending IfcDistributionFlowElement {
    }

    type IfcFootingType extending IfcBuildingElementType {
        property PredefinedType -> str {
            constraint one_of ('CAISSON_FOUNDATION','FOOTING_BEAM','NOTDEFINED','PAD_FOOTING','PILE_CAP','STRIP_FOOTING','USERDEFINED');
        };
    }

    type IfcFurnitureType extending IfcFurnishingElementType {
        property AssemblyPlace -> str {
            constraint one_of ('FACTORY','NOTDEFINED','SITE');
        };
        required property PredefinedType -> str {
            constraint one_of ('BED','CHAIR','DESK','FILECABINET','NOTDEFINED','SHELF','SOFA','TABLE','USERDEFINED');
        };
    }

    type IfcMechanicalFastenerType extending IfcElementComponentType {
        property PredefinedType -> str {
            constraint one_of ('ANCHORBOLT','BOLT','DOWEL','NAIL','NAILPLATE','NOTDEFINED','RIVET','SCREW','SHEARCONNECTOR','STAPLE','STUDSHEARCONNECTOR','USERDEFINED');
        };
        required property NominalDiameter -> float64;
        required property NominalLength -> float64;
    }

    type IfcMemberStandardCase extending IfcMember {
    }

    type IfcMemberType extending IfcBuildingElementType {
        property PredefinedType -> str {
            constraint one_of ('BRACE','CHORD','COLLAR','MEMBER','MULLION','NOTDEFINED','PLATE','POST','PURLIN','RAFTER','STRINGER','STRUT','STUD','USERDEFINED');
        };
    }

    type IfcOpeningElement extending IfcFeatureElementSubtraction {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','OPENING','RECESS','USERDEFINED');
        };
    }

    type IfcPileType extending IfcBuildingElementType {
        property PredefinedType -> str {
            constraint one_of ('BORED','COHESION','DRIVEN','FRICTION','JETGROUTING','NOTDEFINED','SUPPORT','USERDEFINED');
        };
    }

    type IfcPlateStandardCase extending IfcPlate {
    }

    type IfcPlateType extending IfcBuildingElementType {
        property PredefinedType -> str {
            constraint one_of ('CURTAIN_PANEL','NOTDEFINED','SHEET','USERDEFINED');
        };
    }

    type IfcProjectionElement extending IfcFeatureElementAddition {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcProtectiveDeviceTrippingUnit extending IfcDistributionControlElement {
        required property PredefinedType -> str {
            constraint one_of ('ELECTROMAGNETIC','ELECTRONIC','NOTDEFINED','RESIDUALCURRENT','THERMAL','USERDEFINED');
        };
    }

    type IfcRailingType extending IfcBuildingElementType {
        property PredefinedType -> str {
            constraint one_of ('BALUSTRADE','GUARDRAIL','HANDRAIL','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcRampFlightType extending IfcBuildingElementType {
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','SPIRAL','STRAIGHT','USERDEFINED');
        };
    }

    type IfcRampType extending IfcBuildingElementType {
        property PredefinedType -> str {
            constraint one_of ('HALF_TURN_RAMP','NOTDEFINED','QUARTER_TURN_RAMP','SPIRAL_RAMP','STRAIGHT_RUN_RAMP','TWO_QUARTER_TURN_RAMP','TWO_STRAIGHT_RUN_RAMP','USERDEFINED');
        };
    }

    type IfcReinforcingBar extending IfcReinforcingElement {
        required property NominalDiameter -> float64;
        required property CrossSectionArea -> float64;
        required property BarLength -> float64;
        required property PredefinedType -> str {
            constraint one_of ('ANCHORING','EDGE','LIGATURE','MAIN','NOTDEFINED','PUNCHING','RING','SHEAR','STUD','USERDEFINED');
        };
        required property BarSurface -> str {
            constraint one_of ('PLAIN','TEXTURED');
        };
    }

    abstract type IfcReinforcingElementType extending IfcElementComponentType {
    }

    type IfcReinforcingMesh extending IfcReinforcingElement {
        required property MeshLength -> float64;
        required property MeshWidth -> float64;
        required property LongitudinalBarNominalDiameter -> float64;
        required property TransverseBarNominalDiameter -> float64;
        required property LongitudinalBarCrossSectionArea -> float64;
        required property TransverseBarCrossSectionArea -> float64;
        required property LongitudinalBarSpacing -> float64;
        required property TransverseBarSpacing -> float64;
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcRelConnectsWithEccentricity extending IfcRelConnectsStructuralMember {
        link ConnectionConstraint -> IfcConnectionGeometry;
    }

    type IfcRelCoversBldgElements extending IfcRelConnects {
        link RelatingBuildingElement -> IfcElement;
        link RelatedCoverings -> IfcCovering;
    }

    type IfcRelCoversSpaces extending IfcRelConnects {
        link RelatingSpace -> IfcSpace;
        link RelatedCoverings -> IfcCovering;
    }

    type IfcRelFlowControlElements extending IfcRelConnects {
        link RelatedControlElements -> IfcDistributionControlElement;
        link RelatingFlowElement -> IfcDistributionFlowElement;
    }

    type IfcRelProjectsElement extending IfcRelDecomposes {
        link RelatingElement -> IfcElement;
        link RelatedFeatureElement -> IfcFeatureElementAddition;
    }

    type IfcRelVoidsElement extending IfcRelDecomposes {
        link RelatingBuildingElement -> IfcElement;
        link RelatedOpeningElement -> IfcFeatureElementSubtraction;
    }

    type IfcRoofType extending IfcBuildingElementType {
        property PredefinedType -> str {
            constraint one_of ('BARREL_ROOF','BUTTERFLY_ROOF','DOME_ROOF','FLAT_ROOF','FREEFORM','GABLE_ROOF','GAMBREL_ROOF','HIPPED_GABLE_ROOF','HIP_ROOF','MANSARD_ROOF','NOTDEFINED','PAVILION_ROOF','RAINBOW_ROOF','SHED_ROOF','USERDEFINED');
        };
    }

    type IfcSensor extending IfcDistributionControlElement {
        required property PredefinedType -> str {
            constraint one_of ('CO2SENSOR','CONDUCTANCESENSOR','CONTACTSENSOR','COSENSOR','FIRESENSOR','FLOWSENSOR','FROSTSENSOR','GASSENSOR','HEATSENSOR','HUMIDITYSENSOR','IDENTIFIERSENSOR','IONCONCENTRATIONSENSOR','LEVELSENSOR','LIGHTSENSOR','MOISTURESENSOR','MOVEMENTSENSOR','NOTDEFINED','PHSENSOR','PRESSURESENSOR','RADIATIONSENSOR','RADIOACTIVITYSENSOR','SMOKESENSOR','SOUNDSENSOR','TEMPERATURESENSOR','USERDEFINED','WINDSENSOR');
        };
    }

    type IfcShadingDeviceType extending IfcBuildingElementType {
        property PredefinedType -> str {
            constraint one_of ('AWNING','JALOUSIE','NOTDEFINED','SHUTTER','USERDEFINED');
        };
    }

    type IfcSlabElementedCase extending IfcSlab {
    }

    type IfcSlabStandardCase extending IfcSlab {
    }

    type IfcSlabType extending IfcBuildingElementType {
        property PredefinedType -> str {
            constraint one_of ('BASESLAB','FLOOR','LANDING','NOTDEFINED','ROOF','USERDEFINED');
        };
    }

    type IfcSpaceBoundarySelect {
        link IfcSpaceBoundarySelect -> IfcExternalSpatialElement | IfcSpace;
    }

    type IfcSpaceType extending IfcSpatialStructureElementType {
        property PredefinedType -> str {
            constraint one_of ('EXTERNAL','GFA','INTERNAL','NOTDEFINED','PARKING','SPACE','USERDEFINED');
        };
        required property LongName -> str;
    }

    type IfcStairFlightType extending IfcBuildingElementType {
        property PredefinedType -> str {
            constraint one_of ('CURVED','FREEFORM','NOTDEFINED','SPIRAL','STRAIGHT','USERDEFINED','WINDER');
        };
    }

    type IfcStairType extending IfcBuildingElementType {
        property PredefinedType -> str {
            constraint one_of ('CURVED_RUN_STAIR','DOUBLE_RETURN_STAIR','HALF_TURN_STAIR','HALF_WINDING_STAIR','NOTDEFINED','QUARTER_TURN_STAIR','QUARTER_WINDING_STAIR','SPIRAL_STAIR','STRAIGHT_RUN_STAIR','THREE_QUARTER_TURN_STAIR','THREE_QUARTER_WINDING_STAIR','TWO_CURVED_RUN_STAIR','TWO_QUARTER_TURN_STAIR','TWO_QUARTER_WINDING_STAIR','TWO_STRAIGHT_RUN_STAIR','USERDEFINED');
        };
    }

    type IfcStructuralCurveMemberVarying extending IfcStructuralCurveMember {
    }

    type IfcStructuralLinearAction extending IfcStructuralCurveAction {
    }

    type IfcStructuralPlanarAction extending IfcStructuralSurfaceAction {
    }

    type IfcStructuralSurfaceMemberVarying extending IfcStructuralSurfaceMember {
    }

    type IfcStyleAssignmentSelect {
        link IfcStyleAssignmentSelect -> IfcPresentationStyle | IfcPresentationStyleAssignment;
    }

    type IfcSystemFurnitureElementType extending IfcFurnishingElementType {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','PANEL','USERDEFINED','WORKSURFACE');
        };
    }

    type IfcTendon extending IfcReinforcingElement {
        required property PredefinedType -> str {
            constraint one_of ('BAR','COATED','NOTDEFINED','STRAND','USERDEFINED','WIRE');
        };
        required property NominalDiameter -> float64;
        required property CrossSectionArea -> float64;
        required property TensionForce -> float64;
        required property PreStress -> float64;
        required property FrictionCoefficient -> float64;
        required property AnchorageSlip -> float64;
        required property MinCurvatureRadius -> float64;
    }

    type IfcTendonAnchor extending IfcReinforcingElement {
        required property PredefinedType -> str {
            constraint one_of ('COUPLER','FIXED_END','NOTDEFINED','TENSIONING_END','USERDEFINED');
        };
    }

    type IfcUnitaryControlElement extending IfcDistributionControlElement {
        required property PredefinedType -> str {
            constraint one_of ('ALARMPANEL','CONTROLPANEL','GASDETECTIONPANEL','HUMIDISTAT','INDICATORPANEL','MIMICPANEL','NOTDEFINED','THERMOSTAT','USERDEFINED','WEATHERSTATION');
        };
    }

    type IfcVibrationIsolatorType extending IfcElementComponentType {
        property PredefinedType -> str {
            constraint one_of ('COMPRESSION','NOTDEFINED','SPRING','USERDEFINED');
        };
    }

    type IfcVoidingFeature extending IfcFeatureElementSubtraction {
        required property PredefinedType -> str {
            constraint one_of ('CHAMFER','CUTOUT','EDGE','HOLE','MITER','NOTCH','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcWallElementedCase extending IfcWall {
    }

    type IfcWallStandardCase extending IfcWall {
    }

    type IfcWallType extending IfcBuildingElementType {
        property PredefinedType -> str {
            constraint one_of ('ELEMENTEDWALL','MOVABLE','NOTDEFINED','PARAPET','PARTITIONING','PLUMBINGWALL','POLYGONAL','SHEAR','SOLIDWALL','STANDARD','USERDEFINED');
        };
    }

    type IfcWindowStandardCase extending IfcWindow {
    }

    type IfcWindowType extending IfcBuildingElementType {
        property PredefinedType -> str {
            constraint one_of ('LIGHTDOME','NOTDEFINED','SKYLIGHT','USERDEFINED','WINDOW');
        };
        property PartitioningType -> str {
            constraint one_of ('DOUBLE_PANEL_HORIZONTAL','DOUBLE_PANEL_VERTICAL','NOTDEFINED','SINGLE_PANEL','TRIPLE_PANEL_BOTTOM','TRIPLE_PANEL_HORIZONTAL','TRIPLE_PANEL_LEFT','TRIPLE_PANEL_RIGHT','TRIPLE_PANEL_TOP','TRIPLE_PANEL_VERTICAL','USERDEFINED');
        };
        required property ParameterTakesPrecedence -> bool;
        required property UserDefinedPartitioningType -> str;
    }

    type IfcActuatorType extending IfcDistributionControlElementType {
        property PredefinedType -> str {
            constraint one_of ('ELECTRICACTUATOR','HANDOPERATEDACTUATOR','HYDRAULICACTUATOR','NOTDEFINED','PNEUMATICACTUATOR','THERMOSTATICACTUATOR','USERDEFINED');
        };
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

    type IfcAirToAirHeatRecovery extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('FIXEDPLATECOUNTERFLOWEXCHANGER','FIXEDPLATECROSSFLOWEXCHANGER','FIXEDPLATEPARALLELFLOWEXCHANGER','HEATPIPE','NOTDEFINED','ROTARYWHEEL','RUNAROUNDCOILLOOP','THERMOSIPHONCOILTYPEHEATEXCHANGERS','THERMOSIPHONSEALEDTUBEHEATEXCHANGERS','TWINTOWERENTHALPYRECOVERYLOOPS','USERDEFINED');
        };
    }

    type IfcAlarmType extending IfcDistributionControlElementType {
        property PredefinedType -> str {
            constraint one_of ('BELL','BREAKGLASSBUTTON','LIGHT','MANUALPULLBOX','NOTDEFINED','SIREN','USERDEFINED','WHISTLE');
        };
    }

    type IfcAudioVisualAppliance extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('AMPLIFIER','CAMERA','DISPLAY','MICROPHONE','NOTDEFINED','PLAYER','PROJECTOR','RECEIVER','SPEAKER','SWITCHER','TELEPHONE','TUNER','USERDEFINED');
        };
    }

    type IfcBoiler extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','STEAM','USERDEFINED','WATER');
        };
    }

    type IfcBurner extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcCableCarrierFitting extending IfcFlowFitting {
        required property PredefinedType -> str {
            constraint one_of ('BEND','CROSS','NOTDEFINED','REDUCER','TEE','USERDEFINED');
        };
    }

    type IfcCableCarrierSegment extending IfcFlowSegment {
        required property PredefinedType -> str {
            constraint one_of ('CABLELADDERSEGMENT','CABLETRAYSEGMENT','CABLETRUNKINGSEGMENT','CONDUITSEGMENT','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcCableFitting extending IfcFlowFitting {
        required property PredefinedType -> str {
            constraint one_of ('CONNECTOR','ENTRY','EXIT','JUNCTION','NOTDEFINED','TRANSITION','USERDEFINED');
        };
    }

    type IfcCableSegment extending IfcFlowSegment {
        required property PredefinedType -> str {
            constraint one_of ('BUSBARSEGMENT','CABLESEGMENT','CONDUCTORSEGMENT','CORESEGMENT','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcChiller extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('AIRCOOLED','HEATRECOVERY','NOTDEFINED','USERDEFINED','WATERCOOLED');
        };
    }

    type IfcCoil extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('DXCOOLINGCOIL','ELECTRICHEATINGCOIL','GASHEATINGCOIL','HYDRONICCOIL','NOTDEFINED','STEAMHEATINGCOIL','USERDEFINED','WATERCOOLINGCOIL','WATERHEATINGCOIL');
        };
    }

    type IfcCommunicationsAppliance extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('ANTENNA','COMPUTER','FAX','GATEWAY','MODEM','NETWORKAPPLIANCE','NETWORKBRIDGE','NETWORKHUB','NOTDEFINED','PRINTER','REPEATER','ROUTER','SCANNER','USERDEFINED');
        };
    }

    type IfcCompressor extending IfcFlowMovingDevice {
        required property PredefinedType -> str {
            constraint one_of ('BOOSTER','DYNAMIC','HERMETIC','NOTDEFINED','OPENTYPE','RECIPROCATING','ROLLINGPISTON','ROTARY','ROTARYVANE','SCROLL','SEMIHERMETIC','SINGLESCREW','SINGLESTAGE','TROCHOIDAL','TWINSCREW','USERDEFINED','WELDEDSHELLHERMETIC');
        };
    }

    type IfcCondenser extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('AIRCOOLED','EVAPORATIVECOOLED','NOTDEFINED','USERDEFINED','WATERCOOLED','WATERCOOLEDBRAZEDPLATE','WATERCOOLEDSHELLCOIL','WATERCOOLEDSHELLTUBE','WATERCOOLEDTUBEINTUBE');
        };
    }

    type IfcControllerType extending IfcDistributionControlElementType {
        property PredefinedType -> str {
            constraint one_of ('FLOATING','MULTIPOSITION','NOTDEFINED','PROGRAMMABLE','PROPORTIONAL','TWOPOSITION','USERDEFINED');
        };
    }

    type IfcCooledBeam extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('ACTIVE','NOTDEFINED','PASSIVE','USERDEFINED');
        };
    }

    type IfcCoolingTower extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('MECHANICALFORCEDDRAFT','MECHANICALINDUCEDDRAFT','NATURALDRAFT','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcDamper extending IfcFlowController {
        required property PredefinedType -> str {
            constraint one_of ('BACKDRAFTDAMPER','BALANCINGDAMPER','BLASTDAMPER','CONTROLDAMPER','FIREDAMPER','FIRESMOKEDAMPER','FUMEHOODEXHAUST','GRAVITYDAMPER','GRAVITYRELIEFDAMPER','NOTDEFINED','RELIEFDAMPER','SMOKEDAMPER','USERDEFINED');
        };
    }

    type IfcDistributionChamberElementType extending IfcDistributionFlowElementType {
        property PredefinedType -> str {
            constraint one_of ('FORMEDDUCT','INSPECTIONCHAMBER','INSPECTIONPIT','MANHOLE','METERCHAMBER','NOTDEFINED','SUMP','TRENCH','USERDEFINED','VALVECHAMBER');
        };
    }

    type IfcDuctFitting extending IfcFlowFitting {
        required property PredefinedType -> str {
            constraint one_of ('BEND','CONNECTOR','ENTRY','EXIT','JUNCTION','NOTDEFINED','OBSTRUCTION','TRANSITION','USERDEFINED');
        };
    }

    type IfcDuctSegment extending IfcFlowSegment {
        required property PredefinedType -> str {
            constraint one_of ('FLEXIBLESEGMENT','NOTDEFINED','RIGIDSEGMENT','USERDEFINED');
        };
    }

    type IfcDuctSilencer extending IfcFlowTreatmentDevice {
        required property PredefinedType -> str {
            constraint one_of ('FLATOVAL','NOTDEFINED','RECTANGULAR','ROUND','USERDEFINED');
        };
    }

    type IfcElectricAppliance extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('DISHWASHER','ELECTRICCOOKER','FREESTANDINGELECTRICHEATER','FREESTANDINGFAN','FREESTANDINGWATERCOOLER','FREESTANDINGWATERHEATER','FREEZER','FRIDGE_FREEZER','HANDDRYER','KITCHENMACHINE','MICROWAVE','NOTDEFINED','PHOTOCOPIER','REFRIGERATOR','TUMBLEDRYER','USERDEFINED','VENDINGMACHINE','WASHINGMACHINE');
        };
    }

    type IfcElectricDistributionBoard extending IfcFlowController {
        required property PredefinedType -> str {
            constraint one_of ('CONSUMERUNIT','DISTRIBUTIONBOARD','MOTORCONTROLCENTRE','NOTDEFINED','SWITCHBOARD','USERDEFINED');
        };
    }

    type IfcElectricFlowStorageDevice extending IfcFlowStorageDevice {
        required property PredefinedType -> str {
            constraint one_of ('BATTERY','CAPACITORBANK','HARMONICFILTER','INDUCTORBANK','NOTDEFINED','UPS','USERDEFINED');
        };
    }

    type IfcElectricGenerator extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('CHP','ENGINEGENERATOR','NOTDEFINED','STANDALONE','USERDEFINED');
        };
    }

    type IfcElectricMotor extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('DC','INDUCTION','NOTDEFINED','POLYPHASE','RELUCTANCESYNCHRONOUS','SYNCHRONOUS','USERDEFINED');
        };
    }

    type IfcElectricTimeControl extending IfcFlowController {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','RELAY','TIMECLOCK','TIMEDELAY','USERDEFINED');
        };
    }

    abstract type IfcEnergyConversionDeviceType extending IfcDistributionFlowElementType {
    }

    type IfcEngine extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('EXTERNALCOMBUSTION','INTERNALCOMBUSTION','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcEvaporativeCooler extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('DIRECTEVAPORATIVEAIRWASHER','DIRECTEVAPORATIVEPACKAGEDROTARYAIRCOOLER','DIRECTEVAPORATIVERANDOMMEDIAAIRCOOLER','DIRECTEVAPORATIVERIGIDMEDIAAIRCOOLER','DIRECTEVAPORATIVESLINGERSPACKAGEDAIRCOOLER','INDIRECTDIRECTCOMBINATION','INDIRECTEVAPORATIVECOOLINGTOWERORCOILCOOLER','INDIRECTEVAPORATIVEPACKAGEAIRCOOLER','INDIRECTEVAPORATIVEWETCOIL','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcEvaporator extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('DIRECTEXPANSION','DIRECTEXPANSIONBRAZEDPLATE','DIRECTEXPANSIONSHELLANDTUBE','DIRECTEXPANSIONTUBEINTUBE','FLOODEDSHELLANDTUBE','NOTDEFINED','SHELLANDCOIL','USERDEFINED');
        };
    }

    type IfcFan extending IfcFlowMovingDevice {
        required property PredefinedType -> str {
            constraint one_of ('CENTRIFUGALAIRFOIL','CENTRIFUGALBACKWARDINCLINEDCURVED','CENTRIFUGALFORWARDCURVED','CENTRIFUGALRADIAL','NOTDEFINED','PROPELLORAXIAL','TUBEAXIAL','USERDEFINED','VANEAXIAL');
        };
    }

    type IfcFilter extending IfcFlowTreatmentDevice {
        required property PredefinedType -> str {
            constraint one_of ('AIRPARTICLEFILTER','COMPRESSEDAIRFILTER','NOTDEFINED','ODORFILTER','OILFILTER','STRAINER','USERDEFINED','WATERFILTER');
        };
    }

    type IfcFireSuppressionTerminal extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('BREECHINGINLET','FIREHYDRANT','HOSEREEL','NOTDEFINED','SPRINKLER','SPRINKLERDEFLECTOR','USERDEFINED');
        };
    }

    abstract type IfcFlowControllerType extending IfcDistributionFlowElementType {
    }

    abstract type IfcFlowFittingType extending IfcDistributionFlowElementType {
    }

    type IfcFlowInstrumentType extending IfcDistributionControlElementType {
        property PredefinedType -> str {
            constraint one_of ('AMMETER','FREQUENCYMETER','NOTDEFINED','PHASEANGLEMETER','POWERFACTORMETER','PRESSUREGAUGE','THERMOMETER','USERDEFINED','VOLTMETER_PEAK','VOLTMETER_RMS');
        };
    }

    type IfcFlowMeter extending IfcFlowController {
        required property PredefinedType -> str {
            constraint one_of ('ENERGYMETER','GASMETER','NOTDEFINED','OILMETER','USERDEFINED','WATERMETER');
        };
    }

    abstract type IfcFlowMovingDeviceType extending IfcDistributionFlowElementType {
    }

    abstract type IfcFlowSegmentType extending IfcDistributionFlowElementType {
    }

    abstract type IfcFlowStorageDeviceType extending IfcDistributionFlowElementType {
    }

    abstract type IfcFlowTerminalType extending IfcDistributionFlowElementType {
    }

    abstract type IfcFlowTreatmentDeviceType extending IfcDistributionFlowElementType {
    }

    type IfcHeatExchanger extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','PLATE','SHELLANDTUBE','USERDEFINED');
        };
    }

    type IfcHumidifier extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('ADIABATICAIRWASHER','ADIABATICATOMIZING','ADIABATICCOMPRESSEDAIRNOZZLE','ADIABATICPAN','ADIABATICRIGIDMEDIA','ADIABATICULTRASONIC','ADIABATICWETTEDELEMENT','ASSISTEDBUTANE','ASSISTEDELECTRIC','ASSISTEDNATURALGAS','ASSISTEDPROPANE','ASSISTEDSTEAM','NOTDEFINED','STEAMINJECTION','USERDEFINED');
        };
    }

    type IfcInterceptor extending IfcFlowTreatmentDevice {
        required property PredefinedType -> str {
            constraint one_of ('CYCLONIC','GREASE','NOTDEFINED','OIL','PETROL','USERDEFINED');
        };
    }

    type IfcJunctionBox extending IfcFlowFitting {
        required property PredefinedType -> str {
            constraint one_of ('DATA','NOTDEFINED','POWER','USERDEFINED');
        };
    }

    type IfcLamp extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('COMPACTFLUORESCENT','FLUORESCENT','HALOGEN','HIGHPRESSUREMERCURY','HIGHPRESSURESODIUM','LED','METALHALIDE','NOTDEFINED','OLED','TUNGSTENFILAMENT','USERDEFINED');
        };
    }

    type IfcLightFixture extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('DIRECTIONSOURCE','NOTDEFINED','POINTSOURCE','SECURITYLIGHTING','USERDEFINED');
        };
    }

    type IfcMedicalDevice extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('AIRSTATION','FEEDAIRUNIT','NOTDEFINED','OXYGENGENERATOR','OXYGENPLANT','USERDEFINED','VACUUMSTATION');
        };
    }

    type IfcMotorConnection extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('BELTDRIVE','COUPLING','DIRECTDRIVE','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcOpeningStandardCase extending IfcOpeningElement {
    }

    type IfcOutlet extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('AUDIOVISUALOUTLET','COMMUNICATIONSOUTLET','DATAOUTLET','NOTDEFINED','POWEROUTLET','TELEPHONEOUTLET','USERDEFINED');
        };
    }

    type IfcPipeFitting extending IfcFlowFitting {
        required property PredefinedType -> str {
            constraint one_of ('BEND','CONNECTOR','ENTRY','EXIT','JUNCTION','NOTDEFINED','OBSTRUCTION','TRANSITION','USERDEFINED');
        };
    }

    type IfcPipeSegment extending IfcFlowSegment {
        required property PredefinedType -> str {
            constraint one_of ('CULVERT','FLEXIBLESEGMENT','GUTTER','NOTDEFINED','RIGIDSEGMENT','SPOOL','USERDEFINED');
        };
    }

    type IfcProtectiveDevice extending IfcFlowController {
        required property PredefinedType -> str {
            constraint one_of ('CIRCUITBREAKER','EARTHINGSWITCH','EARTHLEAKAGECIRCUITBREAKER','FUSEDISCONNECTOR','NOTDEFINED','RESIDUALCURRENTCIRCUITBREAKER','RESIDUALCURRENTSWITCH','USERDEFINED','VARISTOR');
        };
    }

    type IfcProtectiveDeviceTrippingUnitType extending IfcDistributionControlElementType {
        property PredefinedType -> str {
            constraint one_of ('ELECTROMAGNETIC','ELECTRONIC','NOTDEFINED','RESIDUALCURRENT','THERMAL','USERDEFINED');
        };
    }

    type IfcPump extending IfcFlowMovingDevice {
        required property PredefinedType -> str {
            constraint one_of ('CIRCULATOR','ENDSUCTION','NOTDEFINED','SPLITCASE','SUBMERSIBLEPUMP','SUMPPUMP','USERDEFINED','VERTICALINLINE','VERTICALTURBINE');
        };
    }

    type IfcReinforcingBarType extending IfcReinforcingElementType {
        property PredefinedType -> str {
            constraint one_of ('ANCHORING','EDGE','LIGATURE','MAIN','NOTDEFINED','PUNCHING','RING','SHEAR','STUD','USERDEFINED');
        };
        required property NominalDiameter -> float64;
        required property CrossSectionArea -> float64;
        required property BarLength -> float64;
        required property BarSurface -> str {
            constraint one_of ('PLAIN','TEXTURED');
        };
        required property BendingShapeCode -> str;
        required link BendingParameters -> IfcBendingParameterSelect;
    }

    type IfcReinforcingMeshType extending IfcReinforcingElementType {
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
        required property MeshLength -> float64;
        required property MeshWidth -> float64;
        required property LongitudinalBarNominalDiameter -> float64;
        required property TransverseBarNominalDiameter -> float64;
        required property LongitudinalBarCrossSectionArea -> float64;
        required property TransverseBarCrossSectionArea -> float64;
        required property LongitudinalBarSpacing -> float64;
        required property TransverseBarSpacing -> float64;
        required property BendingShapeCode -> str;
        required link BendingParameters -> IfcBendingParameterSelect;
    }

    type IfcRelFillsElement extending IfcRelConnects {
        link RelatingOpeningElement -> IfcOpeningElement;
        link RelatedBuildingElement -> IfcElement;
    }

    type IfcRelSpaceBoundary extending IfcRelConnects {
        link RelatingSpace -> IfcSpaceBoundarySelect;
        link RelatedBuildingElement -> IfcElement;
        required link ConnectionGeometry -> IfcConnectionGeometry;
        property PhysicalOrVirtualBoundary -> str {
            constraint one_of ('NOTDEFINED','PHYSICAL','VIRTUAL');
        };
        property InternalOrExternalBoundary -> str {
            constraint one_of ('EXTERNAL','EXTERNAL_EARTH','EXTERNAL_FIRE','EXTERNAL_WATER','INTERNAL','NOTDEFINED');
        };
    }

    type IfcSanitaryTerminal extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('BATH','BIDET','CISTERN','NOTDEFINED','SANITARYFOUNTAIN','SHOWER','SINK','TOILETPAN','URINAL','USERDEFINED','WASHHANDBASIN','WCSEAT');
        };
    }

    type IfcSensorType extending IfcDistributionControlElementType {
        property PredefinedType -> str {
            constraint one_of ('CO2SENSOR','CONDUCTANCESENSOR','CONTACTSENSOR','COSENSOR','FIRESENSOR','FLOWSENSOR','FROSTSENSOR','GASSENSOR','HEATSENSOR','HUMIDITYSENSOR','IDENTIFIERSENSOR','IONCONCENTRATIONSENSOR','LEVELSENSOR','LIGHTSENSOR','MOISTURESENSOR','MOVEMENTSENSOR','NOTDEFINED','PHSENSOR','PRESSURESENSOR','RADIATIONSENSOR','RADIOACTIVITYSENSOR','SMOKESENSOR','SOUNDSENSOR','TEMPERATURESENSOR','USERDEFINED','WINDSENSOR');
        };
    }

    type IfcSolarDevice extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','SOLARCOLLECTOR','SOLARPANEL','USERDEFINED');
        };
    }

    type IfcSpaceHeater extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('CONVECTOR','NOTDEFINED','RADIATOR','USERDEFINED');
        };
    }

    type IfcStackTerminal extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('BIRDCAGE','COWL','NOTDEFINED','RAINWATERHOPPER','USERDEFINED');
        };
    }

    type IfcStyledItem extending IfcRepresentationItem {
        required link Item -> IfcRepresentationItem;
        link Styles -> IfcStyleAssignmentSelect;
        required property Name -> str;
    }

    type IfcSwitchingDevice extending IfcFlowController {
        required property PredefinedType -> str {
            constraint one_of ('CONTACTOR','DIMMERSWITCH','EMERGENCYSTOP','KEYPAD','MOMENTARYSWITCH','NOTDEFINED','SELECTORSWITCH','STARTER','SWITCHDISCONNECTOR','TOGGLESWITCH','USERDEFINED');
        };
    }

    type IfcTank extending IfcFlowStorageDevice {
        required property PredefinedType -> str {
            constraint one_of ('BASIN','BREAKPRESSURE','EXPANSION','FEEDANDEXPANSION','NOTDEFINED','PRESSUREVESSEL','STORAGE','USERDEFINED','VESSEL');
        };
    }

    type IfcTendonAnchorType extending IfcReinforcingElementType {
        property PredefinedType -> str {
            constraint one_of ('COUPLER','FIXED_END','NOTDEFINED','TENSIONING_END','USERDEFINED');
        };
    }

    type IfcTendonType extending IfcReinforcingElementType {
        property PredefinedType -> str {
            constraint one_of ('BAR','COATED','NOTDEFINED','STRAND','USERDEFINED','WIRE');
        };
        required property NominalDiameter -> float64;
        required property CrossSectionArea -> float64;
        required property SheathDiameter -> float64;
    }

    type IfcTransformer extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('CURRENT','FREQUENCY','INVERTER','NOTDEFINED','RECTIFIER','USERDEFINED','VOLTAGE');
        };
    }

    type IfcTubeBundle extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('FINNED','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcUnitaryControlElementType extending IfcDistributionControlElementType {
        property PredefinedType -> str {
            constraint one_of ('ALARMPANEL','CONTROLPANEL','GASDETECTIONPANEL','HUMIDISTAT','INDICATORPANEL','MIMICPANEL','NOTDEFINED','THERMOSTAT','USERDEFINED','WEATHERSTATION');
        };
    }

    type IfcUnitaryEquipment extending IfcEnergyConversionDevice {
        required property PredefinedType -> str {
            constraint one_of ('AIRCONDITIONINGUNIT','AIRHANDLER','DEHUMIDIFIER','NOTDEFINED','ROOFTOPUNIT','SPLITSYSTEM','USERDEFINED');
        };
    }

    type IfcValve extending IfcFlowController {
        required property PredefinedType -> str {
            constraint one_of ('AIRRELEASE','ANTIVACUUM','CHANGEOVER','CHECK','COMMISSIONING','DIVERTING','DOUBLECHECK','DOUBLEREGULATING','DRAWOFFCOCK','FAUCET','FLUSHING','GASCOCK','GASTAP','ISOLATING','MIXING','NOTDEFINED','PRESSUREREDUCING','PRESSURERELIEF','REGULATING','SAFETYCUTOFF','STEAMTRAP','STOPCOCK','USERDEFINED');
        };
    }

    type IfcWasteTerminal extending IfcFlowTerminal {
        required property PredefinedType -> str {
            constraint one_of ('FLOORTRAP','FLOORWASTE','GULLYSUMP','GULLYTRAP','NOTDEFINED','ROOFDRAIN','USERDEFINED','WASTEDISPOSALUNIT','WASTETRAP');
        };
    }

    type IfcAirTerminalBoxType extending IfcFlowControllerType {
        property PredefinedType -> str {
            constraint one_of ('CONSTANTFLOW','NOTDEFINED','USERDEFINED','VARIABLEFLOWPRESSUREDEPENDANT','VARIABLEFLOWPRESSUREINDEPENDANT');
        };
    }

    type IfcAirTerminalType extending IfcFlowTerminalType {
        property PredefinedType -> str {
            constraint one_of ('DIFFUSER','GRILLE','LOUVRE','NOTDEFINED','REGISTER','USERDEFINED');
        };
    }

    type IfcAirToAirHeatRecoveryType extending IfcEnergyConversionDeviceType {
        property PredefinedType -> str {
            constraint one_of ('FIXEDPLATECOUNTERFLOWEXCHANGER','FIXEDPLATECROSSFLOWEXCHANGER','FIXEDPLATEPARALLELFLOWEXCHANGER','HEATPIPE','NOTDEFINED','ROTARYWHEEL','RUNAROUNDCOILLOOP','THERMOSIPHONCOILTYPEHEATEXCHANGERS','THERMOSIPHONSEALEDTUBEHEATEXCHANGERS','TWINTOWERENTHALPYRECOVERYLOOPS','USERDEFINED');
        };
    }

    type IfcAudioVisualApplianceType extending IfcFlowTerminalType {
        property PredefinedType -> str {
            constraint one_of ('AMPLIFIER','CAMERA','DISPLAY','MICROPHONE','NOTDEFINED','PLAYER','PROJECTOR','RECEIVER','SPEAKER','SWITCHER','TELEPHONE','TUNER','USERDEFINED');
        };
    }

    type IfcBoilerType extending IfcEnergyConversionDeviceType {
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','STEAM','USERDEFINED','WATER');
        };
    }

    type IfcBurnerType extending IfcEnergyConversionDeviceType {
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcCableCarrierFittingType extending IfcFlowFittingType {
        property PredefinedType -> str {
            constraint one_of ('BEND','CROSS','NOTDEFINED','REDUCER','TEE','USERDEFINED');
        };
    }

    type IfcCableCarrierSegmentType extending IfcFlowSegmentType {
        property PredefinedType -> str {
            constraint one_of ('CABLELADDERSEGMENT','CABLETRAYSEGMENT','CABLETRUNKINGSEGMENT','CONDUITSEGMENT','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcCableFittingType extending IfcFlowFittingType {
        property PredefinedType -> str {
            constraint one_of ('CONNECTOR','ENTRY','EXIT','JUNCTION','NOTDEFINED','TRANSITION','USERDEFINED');
        };
    }

    type IfcCableSegmentType extending IfcFlowSegmentType {
        property PredefinedType -> str {
            constraint one_of ('BUSBARSEGMENT','CABLESEGMENT','CONDUCTORSEGMENT','CORESEGMENT','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcChillerType extending IfcEnergyConversionDeviceType {
        property PredefinedType -> str {
            constraint one_of ('AIRCOOLED','HEATRECOVERY','NOTDEFINED','USERDEFINED','WATERCOOLED');
        };
    }

    type IfcCoilType extending IfcEnergyConversionDeviceType {
        property PredefinedType -> str {
            constraint one_of ('DXCOOLINGCOIL','ELECTRICHEATINGCOIL','GASHEATINGCOIL','HYDRONICCOIL','NOTDEFINED','STEAMHEATINGCOIL','USERDEFINED','WATERCOOLINGCOIL','WATERHEATINGCOIL');
        };
    }

    type IfcCommunicationsApplianceType extending IfcFlowTerminalType {
        property PredefinedType -> str {
            constraint one_of ('ANTENNA','COMPUTER','FAX','GATEWAY','MODEM','NETWORKAPPLIANCE','NETWORKBRIDGE','NETWORKHUB','NOTDEFINED','PRINTER','REPEATER','ROUTER','SCANNER','USERDEFINED');
        };
    }

    type IfcCompressorType extending IfcFlowMovingDeviceType {
        property PredefinedType -> str {
            constraint one_of ('BOOSTER','DYNAMIC','HERMETIC','NOTDEFINED','OPENTYPE','RECIPROCATING','ROLLINGPISTON','ROTARY','ROTARYVANE','SCROLL','SEMIHERMETIC','SINGLESCREW','SINGLESTAGE','TROCHOIDAL','TWINSCREW','USERDEFINED','WELDEDSHELLHERMETIC');
        };
    }

    type IfcCondenserType extending IfcEnergyConversionDeviceType {
        property PredefinedType -> str {
            constraint one_of ('AIRCOOLED','EVAPORATIVECOOLED','NOTDEFINED','USERDEFINED','WATERCOOLED','WATERCOOLEDBRAZEDPLATE','WATERCOOLEDSHELLCOIL','WATERCOOLEDSHELLTUBE','WATERCOOLEDTUBEINTUBE');
        };
    }

    type IfcCooledBeamType extending IfcEnergyConversionDeviceType {
        property PredefinedType -> str {
            constraint one_of ('ACTIVE','NOTDEFINED','PASSIVE','USERDEFINED');
        };
    }

    type IfcCoolingTowerType extending IfcEnergyConversionDeviceType {
        property PredefinedType -> str {
            constraint one_of ('MECHANICALFORCEDDRAFT','MECHANICALINDUCEDDRAFT','NATURALDRAFT','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcDamperType extending IfcFlowControllerType {
        property PredefinedType -> str {
            constraint one_of ('BACKDRAFTDAMPER','BALANCINGDAMPER','BLASTDAMPER','CONTROLDAMPER','FIREDAMPER','FIRESMOKEDAMPER','FUMEHOODEXHAUST','GRAVITYDAMPER','GRAVITYRELIEFDAMPER','NOTDEFINED','RELIEFDAMPER','SMOKEDAMPER','USERDEFINED');
        };
    }

    type IfcDuctFittingType extending IfcFlowFittingType {
        property PredefinedType -> str {
            constraint one_of ('BEND','CONNECTOR','ENTRY','EXIT','JUNCTION','NOTDEFINED','OBSTRUCTION','TRANSITION','USERDEFINED');
        };
    }

    type IfcDuctSegmentType extending IfcFlowSegmentType {
        property PredefinedType -> str {
            constraint one_of ('FLEXIBLESEGMENT','NOTDEFINED','RIGIDSEGMENT','USERDEFINED');
        };
    }

    type IfcDuctSilencerType extending IfcFlowTreatmentDeviceType {
        property PredefinedType -> str {
            constraint one_of ('FLATOVAL','NOTDEFINED','RECTANGULAR','ROUND','USERDEFINED');
        };
    }

    type IfcElectricApplianceType extending IfcFlowTerminalType {
        property PredefinedType -> str {
            constraint one_of ('DISHWASHER','ELECTRICCOOKER','FREESTANDINGELECTRICHEATER','FREESTANDINGFAN','FREESTANDINGWATERCOOLER','FREESTANDINGWATERHEATER','FREEZER','FRIDGE_FREEZER','HANDDRYER','KITCHENMACHINE','MICROWAVE','NOTDEFINED','PHOTOCOPIER','REFRIGERATOR','TUMBLEDRYER','USERDEFINED','VENDINGMACHINE','WASHINGMACHINE');
        };
    }

    type IfcElectricDistributionBoardType extending IfcFlowControllerType {
        property PredefinedType -> str {
            constraint one_of ('CONSUMERUNIT','DISTRIBUTIONBOARD','MOTORCONTROLCENTRE','NOTDEFINED','SWITCHBOARD','USERDEFINED');
        };
    }

    type IfcElectricFlowStorageDeviceType extending IfcFlowStorageDeviceType {
        property PredefinedType -> str {
            constraint one_of ('BATTERY','CAPACITORBANK','HARMONICFILTER','INDUCTORBANK','NOTDEFINED','UPS','USERDEFINED');
        };
    }

    type IfcElectricGeneratorType extending IfcEnergyConversionDeviceType {
        property PredefinedType -> str {
            constraint one_of ('CHP','ENGINEGENERATOR','NOTDEFINED','STANDALONE','USERDEFINED');
        };
    }

    type IfcElectricMotorType extending IfcEnergyConversionDeviceType {
        property PredefinedType -> str {
            constraint one_of ('DC','INDUCTION','NOTDEFINED','POLYPHASE','RELUCTANCESYNCHRONOUS','SYNCHRONOUS','USERDEFINED');
        };
    }

    type IfcElectricTimeControlType extending IfcFlowControllerType {
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','RELAY','TIMECLOCK','TIMEDELAY','USERDEFINED');
        };
    }

    type IfcEngineType extending IfcEnergyConversionDeviceType {
        property PredefinedType -> str {
            constraint one_of ('EXTERNALCOMBUSTION','INTERNALCOMBUSTION','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcEvaporativeCoolerType extending IfcEnergyConversionDeviceType {
        property PredefinedType -> str {
            constraint one_of ('DIRECTEVAPORATIVEAIRWASHER','DIRECTEVAPORATIVEPACKAGEDROTARYAIRCOOLER','DIRECTEVAPORATIVERANDOMMEDIAAIRCOOLER','DIRECTEVAPORATIVERIGIDMEDIAAIRCOOLER','DIRECTEVAPORATIVESLINGERSPACKAGEDAIRCOOLER','INDIRECTDIRECTCOMBINATION','INDIRECTEVAPORATIVECOOLINGTOWERORCOILCOOLER','INDIRECTEVAPORATIVEPACKAGEAIRCOOLER','INDIRECTEVAPORATIVEWETCOIL','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcEvaporatorType extending IfcEnergyConversionDeviceType {
        property PredefinedType -> str {
            constraint one_of ('DIRECTEXPANSION','DIRECTEXPANSIONBRAZEDPLATE','DIRECTEXPANSIONSHELLANDTUBE','DIRECTEXPANSIONTUBEINTUBE','FLOODEDSHELLANDTUBE','NOTDEFINED','SHELLANDCOIL','USERDEFINED');
        };
    }

    type IfcFanType extending IfcFlowMovingDeviceType {
        property PredefinedType -> str {
            constraint one_of ('CENTRIFUGALAIRFOIL','CENTRIFUGALBACKWARDINCLINEDCURVED','CENTRIFUGALFORWARDCURVED','CENTRIFUGALRADIAL','NOTDEFINED','PROPELLORAXIAL','TUBEAXIAL','USERDEFINED','VANEAXIAL');
        };
    }

    type IfcFilterType extending IfcFlowTreatmentDeviceType {
        property PredefinedType -> str {
            constraint one_of ('AIRPARTICLEFILTER','COMPRESSEDAIRFILTER','NOTDEFINED','ODORFILTER','OILFILTER','STRAINER','USERDEFINED','WATERFILTER');
        };
    }

    type IfcFireSuppressionTerminalType extending IfcFlowTerminalType {
        property PredefinedType -> str {
            constraint one_of ('BREECHINGINLET','FIREHYDRANT','HOSEREEL','NOTDEFINED','SPRINKLER','SPRINKLERDEFLECTOR','USERDEFINED');
        };
    }

    type IfcFlowMeterType extending IfcFlowControllerType {
        property PredefinedType -> str {
            constraint one_of ('ENERGYMETER','GASMETER','NOTDEFINED','OILMETER','USERDEFINED','WATERMETER');
        };
    }

    type IfcHeatExchangerType extending IfcEnergyConversionDeviceType {
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','PLATE','SHELLANDTUBE','USERDEFINED');
        };
    }

    type IfcHumidifierType extending IfcEnergyConversionDeviceType {
        property PredefinedType -> str {
            constraint one_of ('ADIABATICAIRWASHER','ADIABATICATOMIZING','ADIABATICCOMPRESSEDAIRNOZZLE','ADIABATICPAN','ADIABATICRIGIDMEDIA','ADIABATICULTRASONIC','ADIABATICWETTEDELEMENT','ASSISTEDBUTANE','ASSISTEDELECTRIC','ASSISTEDNATURALGAS','ASSISTEDPROPANE','ASSISTEDSTEAM','NOTDEFINED','STEAMINJECTION','USERDEFINED');
        };
    }

    type IfcInterceptorType extending IfcFlowTreatmentDeviceType {
        property PredefinedType -> str {
            constraint one_of ('CYCLONIC','GREASE','NOTDEFINED','OIL','PETROL','USERDEFINED');
        };
    }

    type IfcJunctionBoxType extending IfcFlowFittingType {
        property PredefinedType -> str {
            constraint one_of ('DATA','NOTDEFINED','POWER','USERDEFINED');
        };
    }

    type IfcLampType extending IfcFlowTerminalType {
        property PredefinedType -> str {
            constraint one_of ('COMPACTFLUORESCENT','FLUORESCENT','HALOGEN','HIGHPRESSUREMERCURY','HIGHPRESSURESODIUM','LED','METALHALIDE','NOTDEFINED','OLED','TUNGSTENFILAMENT','USERDEFINED');
        };
    }

    type IfcLightFixtureType extending IfcFlowTerminalType {
        property PredefinedType -> str {
            constraint one_of ('DIRECTIONSOURCE','NOTDEFINED','POINTSOURCE','SECURITYLIGHTING','USERDEFINED');
        };
    }

    type IfcMedicalDeviceType extending IfcFlowTerminalType {
        property PredefinedType -> str {
            constraint one_of ('AIRSTATION','FEEDAIRUNIT','NOTDEFINED','OXYGENGENERATOR','OXYGENPLANT','USERDEFINED','VACUUMSTATION');
        };
    }

    type IfcMotorConnectionType extending IfcEnergyConversionDeviceType {
        property PredefinedType -> str {
            constraint one_of ('BELTDRIVE','COUPLING','DIRECTDRIVE','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcOutletType extending IfcFlowTerminalType {
        property PredefinedType -> str {
            constraint one_of ('AUDIOVISUALOUTLET','COMMUNICATIONSOUTLET','DATAOUTLET','NOTDEFINED','POWEROUTLET','TELEPHONEOUTLET','USERDEFINED');
        };
    }

    type IfcPipeFittingType extending IfcFlowFittingType {
        property PredefinedType -> str {
            constraint one_of ('BEND','CONNECTOR','ENTRY','EXIT','JUNCTION','NOTDEFINED','OBSTRUCTION','TRANSITION','USERDEFINED');
        };
    }

    type IfcPipeSegmentType extending IfcFlowSegmentType {
        property PredefinedType -> str {
            constraint one_of ('CULVERT','FLEXIBLESEGMENT','GUTTER','NOTDEFINED','RIGIDSEGMENT','SPOOL','USERDEFINED');
        };
    }

    type IfcProtectiveDeviceType extending IfcFlowControllerType {
        property PredefinedType -> str {
            constraint one_of ('CIRCUITBREAKER','EARTHINGSWITCH','EARTHLEAKAGECIRCUITBREAKER','FUSEDISCONNECTOR','NOTDEFINED','RESIDUALCURRENTCIRCUITBREAKER','RESIDUALCURRENTSWITCH','USERDEFINED','VARISTOR');
        };
    }

    type IfcPumpType extending IfcFlowMovingDeviceType {
        property PredefinedType -> str {
            constraint one_of ('CIRCULATOR','ENDSUCTION','NOTDEFINED','SPLITCASE','SUBMERSIBLEPUMP','SUMPPUMP','USERDEFINED','VERTICALINLINE','VERTICALTURBINE');
        };
    }

    type IfcRelSpaceBoundary1stLevel extending IfcRelSpaceBoundary {
        required link ParentBoundary -> IfcRelSpaceBoundary1stLevel;
    }

    type IfcSanitaryTerminalType extending IfcFlowTerminalType {
        property PredefinedType -> str {
            constraint one_of ('BATH','BIDET','CISTERN','NOTDEFINED','SANITARYFOUNTAIN','SHOWER','SINK','TOILETPAN','URINAL','USERDEFINED','WASHHANDBASIN','WCSEAT');
        };
    }

    type IfcSolarDeviceType extending IfcEnergyConversionDeviceType {
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','SOLARCOLLECTOR','SOLARPANEL','USERDEFINED');
        };
    }

    type IfcSpaceHeaterType extending IfcFlowTerminalType {
        property PredefinedType -> str {
            constraint one_of ('CONVECTOR','NOTDEFINED','RADIATOR','USERDEFINED');
        };
    }

    type IfcStackTerminalType extending IfcFlowTerminalType {
        property PredefinedType -> str {
            constraint one_of ('BIRDCAGE','COWL','NOTDEFINED','RAINWATERHOPPER','USERDEFINED');
        };
    }

    type IfcSwitchingDeviceType extending IfcFlowControllerType {
        property PredefinedType -> str {
            constraint one_of ('CONTACTOR','DIMMERSWITCH','EMERGENCYSTOP','KEYPAD','MOMENTARYSWITCH','NOTDEFINED','SELECTORSWITCH','STARTER','SWITCHDISCONNECTOR','TOGGLESWITCH','USERDEFINED');
        };
    }

    type IfcTankType extending IfcFlowStorageDeviceType {
        property PredefinedType -> str {
            constraint one_of ('BASIN','BREAKPRESSURE','EXPANSION','FEEDANDEXPANSION','NOTDEFINED','PRESSUREVESSEL','STORAGE','USERDEFINED','VESSEL');
        };
    }

    type IfcTransformerType extending IfcEnergyConversionDeviceType {
        property PredefinedType -> str {
            constraint one_of ('CURRENT','FREQUENCY','INVERTER','NOTDEFINED','RECTIFIER','USERDEFINED','VOLTAGE');
        };
    }

    type IfcTubeBundleType extending IfcEnergyConversionDeviceType {
        property PredefinedType -> str {
            constraint one_of ('FINNED','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcUnitaryEquipmentType extending IfcEnergyConversionDeviceType {
        property PredefinedType -> str {
            constraint one_of ('AIRCONDITIONINGUNIT','AIRHANDLER','DEHUMIDIFIER','NOTDEFINED','ROOFTOPUNIT','SPLITSYSTEM','USERDEFINED');
        };
    }

    type IfcValveType extending IfcFlowControllerType {
        property PredefinedType -> str {
            constraint one_of ('AIRRELEASE','ANTIVACUUM','CHANGEOVER','CHECK','COMMISSIONING','DIVERTING','DOUBLECHECK','DOUBLEREGULATING','DRAWOFFCOCK','FAUCET','FLUSHING','GASCOCK','GASTAP','ISOLATING','MIXING','NOTDEFINED','PRESSUREREDUCING','PRESSURERELIEF','REGULATING','SAFETYCUTOFF','STEAMTRAP','STOPCOCK','USERDEFINED');
        };
    }

    type IfcWasteTerminalType extending IfcFlowTerminalType {
        property PredefinedType -> str {
            constraint one_of ('FLOORTRAP','FLOORWASTE','GULLYSUMP','GULLYTRAP','NOTDEFINED','ROOFDRAIN','USERDEFINED','WASTEDISPOSALUNIT','WASTETRAP');
        };
    }

    type IfcRelSpaceBoundary2ndLevel extending IfcRelSpaceBoundary1stLevel {
        required link CorrespondingBoundary -> IfcRelSpaceBoundary2ndLevel;
    }
}
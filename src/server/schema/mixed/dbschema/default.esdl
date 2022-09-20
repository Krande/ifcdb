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

    type IfcDescriptiveMeasure {
        required property `IfcDescriptiveMeasure` -> str;
    }

    type IfcDimensionalExponents  {
        required property LengthExponent -> int64;
        required property MassExponent -> int64;
        required property TimeExponent -> int64;
        required property ElectricCurrentExponent -> int64;
        required property ThermodynamicTemperatureExponent -> int64;
        required property AmountOfSubstanceExponent -> int64;
        required property LuminousIntensityExponent -> int64;
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

    abstract type IfcExternalReference  {
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
        required property Currency -> str;
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

    abstract type IfcPresentationItem  {
    }

    abstract type IfcPresentationStyle  {
        property Name -> str;
    }

    type IfcPressureMeasure {
        required property `IfcPressureMeasure` -> float64;
    }

    abstract type IfcPropertyAbstraction  {
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

    abstract type IfcRepresentationContext  {
        property ContextIdentifier -> str;
        property ContextType -> str;
    }

    abstract type IfcRepresentationItem  {
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
        required property Role -> str {
            constraint one_of ('ARCHITECT','BUILDINGOPERATOR','BUILDINGOWNER','CIVILENGINEER','CLIENT','COMMISSIONINGENGINEER','CONSTRUCTIONMANAGER','CONSULTANT','CONTRACTOR','COSTENGINEER','ELECTRICALENGINEER','ENGINEER','FACILITIESMANAGER','FIELDCONSTRUCTIONMANAGER','MANUFACTURER','MECHANICALENGINEER','OWNER','PROJECTMANAGER','RESELLER','STRUCTURALENGINEER','SUBCONTRACTOR','SUPPLIER','USERDEFINED');
        };
        property UserDefinedRole -> str;
        property Description -> str;
    }

    abstract type IfcAddress  {
        property Purpose -> str {
            constraint one_of ('DISTRIBUTIONPOINT','HOME','OFFICE','SITE','USERDEFINED');
        };
        property Description -> str;
        property UserDefinedPurpose -> str;
    }

    type IfcArcIndex {
        required property `IfcArcIndex` -> tuple<int64, int64, int64>;
    }

    abstract type IfcColourSpecification extending IfcPresentationItem {
        property Name -> str;
    }

    type IfcCurveStyleFontPattern extending IfcPresentationItem {
        required property VisibleSegmentLength -> float64;
        required property InvisibleSegmentLength -> float64;
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

    abstract type IfcGeometricRepresentationItem extending IfcRepresentationItem {
    }

    type IfcLineIndex {
        required property `IfcLineIndex` -> tuple<int64, int64>;
    }

    type IfcMaterial extending IfcMaterialDefinition {
        required property Name -> str;
        property Description -> str;
        property Category -> str;
    }

    type IfcMeasureValue {
        link IfcMeasureValue -> IfcAmountOfSubstanceMeasure | IfcAreaMeasure | IfcComplexNumber | IfcContextDependentMeasure | IfcCountMeasure | IfcDescriptiveMeasure | IfcElectricCurrentMeasure | IfcLengthMeasure | IfcLuminousIntensityMeasure | IfcMassMeasure | IfcNonNegativeLengthMeasure | IfcNormalisedRatioMeasure | IfcNumericMeasure | IfcParameterValue | IfcPlaneAngleMeasure | IfcPositiveLengthMeasure | IfcPositivePlaneAngleMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure | IfcSolidAngleMeasure | IfcThermodynamicTemperatureMeasure | IfcTimeMeasure | IfcVolumeMeasure;
    }

    abstract type IfcNamedUnit  {
        link Dimensions -> IfcDimensionalExponents;
        required property UnitType -> str {
            constraint one_of ('ABSORBEDDOSEUNIT','AMOUNTOFSUBSTANCEUNIT','AREAUNIT','DOSEEQUIVALENTUNIT','ELECTRICCAPACITANCEUNIT','ELECTRICCHARGEUNIT','ELECTRICCONDUCTANCEUNIT','ELECTRICCURRENTUNIT','ELECTRICRESISTANCEUNIT','ELECTRICVOLTAGEUNIT','ENERGYUNIT','FORCEUNIT','FREQUENCYUNIT','ILLUMINANCEUNIT','INDUCTANCEUNIT','LENGTHUNIT','LUMINOUSFLUXUNIT','LUMINOUSINTENSITYUNIT','MAGNETICFLUXDENSITYUNIT','MAGNETICFLUXUNIT','MASSUNIT','PLANEANGLEUNIT','POWERUNIT','PRESSUREUNIT','RADIOACTIVITYUNIT','SOLIDANGLEUNIT','THERMODYNAMICTEMPERATUREUNIT','TIMEUNIT','USERDEFINED','VOLUMEUNIT');
        };
    }

    abstract type IfcPreDefinedItem extending IfcPresentationItem {
        required property Name -> str;
    }

    type IfcProfileDef  {
        required property ProfileType -> str {
            constraint one_of ('AREA','CURVE');
        };
        property ProfileName -> str;
    }

    abstract type IfcProperty extending IfcPropertyAbstraction {
        required property Name -> str;
        property Description -> str;
    }

    abstract type IfcRepresentation  {
        required link ContextOfItems -> IfcRepresentationContext;
        property RepresentationIdentifier -> str;
        property RepresentationType -> str;
        required multi link Items -> IfcRepresentationItem;
    }

    type IfcSimpleValue {
        link IfcSimpleValue -> IfcBinary | IfcBoolean | IfcDate | IfcDateTime | IfcDuration | IfcIdentifier | IfcInteger | IfcLabel | IfcLogical | IfcPositiveInteger | IfcReal | IfcText | IfcTime | IfcTimeStamp;
    }

    type IfcSizeSelect {
        link IfcSizeSelect -> IfcDescriptiveMeasure | IfcLengthMeasure | IfcNormalisedRatioMeasure | IfcPositiveLengthMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure;
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
        required multi link Profiles -> IfcProfileDef;
        property Label -> str;
    }

    abstract type IfcCurve extending IfcGeometricRepresentationItem {
    }

    type IfcCurveStyleFont extending IfcPresentationItem {
        property Name -> str;
        required multi link PatternList -> IfcCurveStyleFontPattern;
    }

    type IfcDerivedUnitElement  {
        required link Unit -> IfcNamedUnit;
        required property Exponent -> int64;
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
        link Material -> IfcMaterial;
        required property LayerThickness -> float64;
        property IsVentilated -> bool;
        property Name -> str;
        property Description -> str;
        property Category -> str;
        property Priority -> int64;
    }

    type IfcMaterialList  {
        required multi link Materials -> IfcMaterial;
    }

    type IfcMaterialProfile extending IfcMaterialDefinition {
        property Name -> str;
        property Description -> str;
        link Material -> IfcMaterial;
        required link Profile -> IfcProfileDef;
        property Priority -> int64;
        property Category -> str;
    }

    type IfcOrganization  {
        property Identification -> str;
        required property Name -> str;
        property Description -> str;
        multi link Roles -> IfcActorRole;
        multi link Addresses -> IfcAddress;
    }

    type IfcPerson  {
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

    abstract type IfcProductRepresentation  {
        property Name -> str;
        property Description -> str;
        required multi link Representations -> IfcRepresentation;
    }

    type IfcSIUnit extending IfcNamedUnit {
        property Prefix -> str {
            constraint one_of ('ATTO','CENTI','DECA','DECI','EXA','FEMTO','GIGA','HECTO','KILO','MEGA','MICRO','MILLI','NANO','PETA','PICO','TERA');
        };
        required property Name -> str {
            constraint one_of ('AMPERE','BECQUEREL','CANDELA','COULOMB','CUBIC_METRE','DEGREE_CELSIUS','FARAD','GRAM','GRAY','HENRY','HERTZ','JOULE','KELVIN','LUMEN','LUX','METRE','MOLE','NEWTON','OHM','PASCAL','RADIAN','SECOND','SIEMENS','SIEVERT','SQUARE_METRE','STERADIAN','TESLA','VOLT','WATT','WEBER');
        };
    }

    type IfcSegmentIndexSelect {
        link IfcSegmentIndexSelect -> IfcArcIndex | IfcLineIndex;
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
        link TextIndent -> IfcDescriptiveMeasure | IfcLengthMeasure | IfcNormalisedRatioMeasure | IfcPositiveLengthMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure;
        property TextAlign -> str;
        property TextDecoration -> str;
        link LetterSpacing -> IfcDescriptiveMeasure | IfcLengthMeasure | IfcNormalisedRatioMeasure | IfcPositiveLengthMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure;
        link WordSpacing -> IfcDescriptiveMeasure | IfcLengthMeasure | IfcNormalisedRatioMeasure | IfcPositiveLengthMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure;
        property TextTransform -> str;
        link LineHeight -> IfcDescriptiveMeasure | IfcLengthMeasure | IfcNormalisedRatioMeasure | IfcPositiveLengthMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure;
    }

    type IfcValue {
        link IfcValue -> IfcAbsorbedDoseMeasure | IfcAccelerationMeasure | IfcAngularVelocityMeasure | IfcAreaDensityMeasure | IfcCompoundPlaneAngleMeasure | IfcCurvatureMeasure | IfcDoseEquivalentMeasure | IfcDynamicViscosityMeasure | IfcElectricCapacitanceMeasure | IfcElectricChargeMeasure | IfcElectricConductanceMeasure | IfcElectricResistanceMeasure | IfcElectricVoltageMeasure | IfcEnergyMeasure | IfcForceMeasure | IfcFrequencyMeasure | IfcHeatFluxDensityMeasure | IfcHeatingValueMeasure | IfcIlluminanceMeasure | IfcInductanceMeasure | IfcIntegerCountRateMeasure | IfcIonConcentrationMeasure | IfcIsothermalMoistureCapacityMeasure | IfcKinematicViscosityMeasure | IfcLinearForceMeasure | IfcLinearMomentMeasure | IfcLinearStiffnessMeasure | IfcLinearVelocityMeasure | IfcLuminousFluxMeasure | IfcLuminousIntensityDistributionMeasure | IfcMagneticFluxDensityMeasure | IfcMagneticFluxMeasure | IfcMassDensityMeasure | IfcMassFlowRateMeasure | IfcMassPerLengthMeasure | IfcModulusOfElasticityMeasure | IfcModulusOfLinearSubgradeReactionMeasure | IfcModulusOfRotationalSubgradeReactionMeasure | IfcModulusOfSubgradeReactionMeasure | IfcMoistureDiffusivityMeasure | IfcMolecularWeightMeasure | IfcMomentOfInertiaMeasure | IfcMonetaryMeasure | IfcPHMeasure | IfcPlanarForceMeasure | IfcPowerMeasure | IfcPressureMeasure | IfcRadioActivityMeasure | IfcRotationalFrequencyMeasure | IfcRotationalMassMeasure | IfcRotationalStiffnessMeasure | IfcSectionModulusMeasure | IfcSectionalAreaIntegralMeasure | IfcShearModulusMeasure | IfcSoundPowerLevelMeasure | IfcSoundPowerMeasure | IfcSoundPressureLevelMeasure | IfcSoundPressureMeasure | IfcSpecificHeatCapacityMeasure | IfcTemperatureGradientMeasure | IfcTemperatureRateOfChangeMeasure | IfcThermalAdmittanceMeasure | IfcThermalConductivityMeasure | IfcThermalExpansionCoefficientMeasure | IfcThermalResistanceMeasure | IfcThermalTransmittanceMeasure | IfcTorqueMeasure | IfcVaporPermeabilityMeasure | IfcVolumetricFlowRateMeasure | IfcWarpingConstantMeasure | IfcWarpingMomentMeasure | IfcAmountOfSubstanceMeasure | IfcAreaMeasure | IfcComplexNumber | IfcContextDependentMeasure | IfcCountMeasure | IfcDescriptiveMeasure | IfcElectricCurrentMeasure | IfcLengthMeasure | IfcLuminousIntensityMeasure | IfcMassMeasure | IfcNonNegativeLengthMeasure | IfcNormalisedRatioMeasure | IfcNumericMeasure | IfcParameterValue | IfcPlaneAngleMeasure | IfcPositiveLengthMeasure | IfcPositivePlaneAngleMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure | IfcSolidAngleMeasure | IfcThermodynamicTemperatureMeasure | IfcTimeMeasure | IfcVolumeMeasure | IfcBinary | IfcBoolean | IfcDate | IfcDateTime | IfcDuration | IfcIdentifier | IfcInteger | IfcLabel | IfcLogical | IfcPositiveInteger | IfcReal | IfcText | IfcTime | IfcTimeStamp;
    }

    type IfcVertex extending IfcTopologicalRepresentationItem {
    }

    type IfcApplication  {
        required link ApplicationDeveloper -> IfcOrganization;
        required property Version -> str;
        required property ApplicationFullName -> str;
        required property ApplicationIdentifier -> str;
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
        required property CoordList -> array<tuple<float64, float64>>;
        property TagList -> tuple<str>;
    }

    type IfcCartesianPointList3D extending IfcCartesianPointList {
        required property CoordList -> array<tuple<float64, float64, float64>>;
        property TagList -> tuple<str>;
    }

    type IfcColour {
        link IfcColour -> IfcColourSpecification | IfcPreDefinedColour;
    }

    type IfcCurveStyleFontSelect {
        link IfcCurveStyleFontSelect -> IfcCurveStyleFont | IfcPreDefinedCurveFont;
    }

    type IfcDerivedUnit  {
        required multi link Elements -> IfcDerivedUnitElement;
        required property UnitType -> str {
            constraint one_of ('ACCELERATIONUNIT','ANGULARVELOCITYUNIT','AREADENSITYUNIT','COMPOUNDPLANEANGLEUNIT','CURVATUREUNIT','DYNAMICVISCOSITYUNIT','HEATFLUXDENSITYUNIT','HEATINGVALUEUNIT','INTEGERCOUNTRATEUNIT','IONCONCENTRATIONUNIT','ISOTHERMALMOISTURECAPACITYUNIT','KINEMATICVISCOSITYUNIT','LINEARFORCEUNIT','LINEARMOMENTUNIT','LINEARSTIFFNESSUNIT','LINEARVELOCITYUNIT','LUMINOUSINTENSITYDISTRIBUTIONUNIT','MASSDENSITYUNIT','MASSFLOWRATEUNIT','MASSPERLENGTHUNIT','MODULUSOFELASTICITYUNIT','MODULUSOFLINEARSUBGRADEREACTIONUNIT','MODULUSOFROTATIONALSUBGRADEREACTIONUNIT','MODULUSOFSUBGRADEREACTIONUNIT','MOISTUREDIFFUSIVITYUNIT','MOLECULARWEIGHTUNIT','MOMENTOFINERTIAUNIT','PHUNIT','PLANARFORCEUNIT','ROTATIONALFREQUENCYUNIT','ROTATIONALMASSUNIT','ROTATIONALSTIFFNESSUNIT','SECTIONAREAINTEGRALUNIT','SECTIONMODULUSUNIT','SHEARMODULUSUNIT','SOUNDPOWERLEVELUNIT','SOUNDPOWERUNIT','SOUNDPRESSURELEVELUNIT','SOUNDPRESSUREUNIT','SPECIFICHEATCAPACITYUNIT','TEMPERATUREGRADIENTUNIT','TEMPERATURERATEOFCHANGEUNIT','THERMALADMITTANCEUNIT','THERMALCONDUCTANCEUNIT','THERMALEXPANSIONCOEFFICIENTUNIT','THERMALRESISTANCEUNIT','THERMALTRANSMITTANCEUNIT','TORQUEUNIT','USERDEFINED','VAPORPERMEABILITYUNIT','VOLUMETRICFLOWRATEUNIT','WARPINGCONSTANTUNIT','WARPINGMOMENTUNIT');
        };
        property UserDefinedType -> str;
    }

    type IfcEdge extending IfcTopologicalRepresentationItem {
        link EdgeStart -> IfcVertex;
        link EdgeEnd -> IfcVertex;
    }

    type IfcFaceBound extending IfcTopologicalRepresentationItem {
        required link Bound -> IfcLoop;
        required property Orientation -> bool;
    }

    type IfcGeometricSetSelect {
        link IfcGeometricSetSelect -> IfcCurve | IfcPoint | IfcSurface;
    }

    type IfcIndexedPolygonalFace extending IfcTessellatedItem {
        required property CoordIndex -> tuple<int64, int64, int64>;
    }

    type IfcMaterialLayerSet extending IfcMaterialDefinition {
        required multi link MaterialLayers -> IfcMaterialLayer;
        property LayerSetName -> str;
        property Description -> str;
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
        link IfcMaterialSelect -> IfcMaterialDefinition | IfcMaterialList | IfcMaterialUsageDefinition;
    }

    type IfcPersonAndOrganization  {
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
        required link SurfaceColour -> IfcColourRgb;
        property Transparency -> float64;
    }

    type IfcTextFontSelect {
        link IfcTextFontSelect -> IfcExternallyDefinedTextFont | IfcPreDefinedTextFont;
    }

    type IfcVector extending IfcGeometricRepresentationItem {
        required link Orientation -> IfcDirection;
        required property Magnitude -> float64;
    }

    type IfcVertexPoint extending IfcVertex {
        required link VertexGeometry -> IfcPoint;
    }

    type IfcBoundingBox extending IfcGeometricRepresentationItem {
        required link Corner -> IfcCartesianPoint;
        required property XDim -> float64;
        required property YDim -> float64;
        required property ZDim -> float64;
    }

    abstract type IfcCartesianTransformationOperator extending IfcGeometricRepresentationItem {
        link Axis1 -> IfcDirection;
        link Axis2 -> IfcDirection;
        required link LocalOrigin -> IfcCartesianPoint;
        property Scale -> float64;
    }

    type IfcCurveStyleFontAndScaling extending IfcPresentationItem {
        property Name -> str;
        required link CurveFont -> IfcCurveStyleFont | IfcPreDefinedCurveFont;
        required property CurveFontScaling -> float64;
    }

    type IfcEdgeCurve extending IfcEdge {
        required link EdgeGeometry -> IfcCurve;
        required property SameSense -> bool;
    }

    type IfcFace extending IfcTopologicalRepresentationItem {
        required multi link Bounds -> IfcFaceBound;
    }

    type IfcFaceOuterBound extending IfcFaceBound {
    }

    type IfcFillAreaStyleTiles extending IfcGeometricRepresentationItem {
        required multi link TilingPattern -> IfcVector;
        required property TilingScale -> float64;
    }

    type IfcGeometricSet extending IfcGeometricRepresentationItem {
        required multi link Elements -> IfcGeometricSetSelect;
    }

    type IfcHatchLineDistanceSelect {
        link IfcHatchLineDistanceSelect -> IfcPositiveLengthMeasure | IfcVector;
    }

    type IfcIndexedPolyCurve extending IfcBoundedCurve {
        required link Points -> IfcCartesianPointList;
        multi link Segments -> IfcSegmentIndexSelect;
        property SelfIntersect -> bool;
    }

    type IfcMaterialProfileSetUsage extending IfcMaterialUsageDefinition {
        required link ForProfileSet -> IfcMaterialProfileSet;
        property CardinalPoint -> int64;
        property ReferenceExtent -> float64;
    }

    type IfcOrientedEdge extending IfcEdge {
        required link EdgeElement -> IfcEdge;
        required property Orientation -> bool;
    }

    type IfcOwnerHistory  {
        required link OwningUser -> IfcPersonAndOrganization;
        required link OwningApplication -> IfcApplication;
        property State -> str {
            constraint one_of ('LOCKED','READONLY','READONLYLOCKED','READWRITE','READWRITELOCKED');
        };
        property ChangeAction -> str {
            constraint one_of ('ADDED','DELETED','MODIFIED','NOCHANGE','NOTDEFINED');
        };
        property LastModifiedDate -> int64;
        link LastModifyingUser -> IfcPersonAndOrganization;
        link LastModifyingApplication -> IfcApplication;
        required property CreationDate -> int64;
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
        required link Colour -> IfcColourSpecification | IfcPreDefinedColour;
        link BackgroundColour -> IfcColourSpecification | IfcPreDefinedColour;
    }

    type IfcUnit {
        link IfcUnit -> IfcDerivedUnit | IfcMonetaryUnit | IfcNamedUnit;
    }

    type List_of_IfcCartesianPoint { required multi link IfcCartesianPoints -> IfcCartesianPoint }

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
        required multi link ControlPointsList -> List_of_IfcCartesianPoint;
        required property SurfaceForm -> str {
            constraint one_of ('CONICAL_SURF','CYLINDRICAL_SURF','GENERALISED_CONE','PLANE_SURF','QUADRIC_SURF','RULED_SURF','SPHERICAL_SURF','SURF_OF_LINEAR_EXTRUSION','SURF_OF_REVOLUTION','TOROIDAL_SURF','UNSPECIFIED');
        };
        required property UClosed -> bool;
        required property VClosed -> bool;
        required property SelfIntersect -> bool;
    }

    type IfcCartesianTransformationOperator2D extending IfcCartesianTransformationOperator {
    }

    type IfcConnectedFaceSet extending IfcTopologicalRepresentationItem {
        required multi link CfsFaces -> IfcFace;
    }

    type IfcCurveFontOrScaledCurveFontSelect {
        link IfcCurveFontOrScaledCurveFontSelect -> IfcCurveStyleFontAndScaling | IfcCurveStyleFont | IfcPreDefinedCurveFont;
    }

    type IfcEdgeLoop extending IfcLoop {
        required multi link EdgeList -> IfcOrientedEdge;
    }

    type IfcFaceSurface extending IfcFace {
        required link FaceSurface -> IfcSurface;
        required property SameSense -> bool;
    }

    type IfcGeometricCurveSet extending IfcGeometricSet {
    }

    type IfcMeasureWithUnit  {
        required link ValueComponent -> IfcValue;
        required link UnitComponent -> IfcUnit;
    }

    type IfcPolygonalFaceSet extending IfcTessellatedFaceSet {
        property Closed -> bool;
        required multi link Faces -> IfcIndexedPolygonalFace;
        property PnIndex -> tuple<int64>;
    }

    type IfcPropertySingleValue extending IfcSimpleProperty {
        link NominalValue -> IfcValue;
        link Unit -> IfcUnit;
    }

    abstract type IfcRoot  {
        required property GlobalId -> str;
        link OwnerHistory -> IfcOwnerHistory;
        property Name -> str;
        property Description -> str;
    }

    type IfcTextStyle extending IfcPresentationStyle {
        link TextCharacterAppearance -> IfcTextStyleForDefinedFont;
        link TextStyle -> IfcTextStyleTextModel;
        required link TextFontStyle -> IfcExternallyDefinedTextFont | IfcPreDefinedTextFont;
        property ModelOrDraughting -> bool;
    }

    type IfcTriangulatedFaceSet extending IfcTessellatedFaceSet {
        property Normals -> array<tuple<float64, float64, float64>>;
        property Closed -> bool;
        required property CoordIndex -> array<tuple<int64, int64, int64>>;
        property PnIndex -> tuple<int64>;
    }

    type IfcUnitAssignment  {
        required multi link Units -> IfcUnit;
    }

    type IfcAdvancedFace extending IfcFaceSurface {
    }

    type IfcAxis2Placement {
        link IfcAxis2Placement -> IfcAxis2Placement2D | IfcAxis2Placement3D;
    }

    type IfcBSplineSurfaceWithKnots extending IfcBSplineSurface {
        required property UMultiplicities -> tuple<int64, int64>;
        required property VMultiplicities -> tuple<int64, int64>;
        required property UKnots -> tuple<float64, float64>;
        required property VKnots -> tuple<float64, float64>;
        required property KnotSpec -> str {
            constraint one_of ('PIECEWISE_BEZIER_KNOTS','QUASI_UNIFORM_KNOTS','UNIFORM_KNOTS','UNSPECIFIED');
        };
    }

    type IfcClosedShell extending IfcConnectedFaceSet {
    }

    type IfcConversionBasedUnit extending IfcNamedUnit {
        required property Name -> str;
        required link ConversionFactor -> IfcMeasureWithUnit;
    }

    type IfcCurveStyle extending IfcPresentationStyle {
        link CurveFont -> IfcCurveStyleFontAndScaling | IfcCurveStyleFontSelect;
        link CurveWidth -> IfcDescriptiveMeasure | IfcLengthMeasure | IfcNormalisedRatioMeasure | IfcPositiveLengthMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure;
        link CurveColour -> IfcColourSpecification | IfcPreDefinedColour;
        property ModelOrDraughting -> bool;
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
        link TextureTransform -> IfcCartesianTransformationOperator2D;
        property Parameter -> tuple<str>;
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
        link IfcDefinitionSelect -> IfcObjectDefinition | IfcPropertyDefinition;
    }

    type IfcExtrudedAreaSolid extending IfcSweptAreaSolid {
        required link ExtrudedDirection -> IfcDirection;
        required property Depth -> float64;
    }

    type IfcFillAreaStyleHatching extending IfcGeometricRepresentationItem {
        required link HatchLineAppearance -> IfcCurveStyle;
        required link StartOfNextHatchLine -> IfcPositiveLengthMeasure | IfcVector;
        link PointOfReferenceHatchLine -> IfcCartesianPoint;
        link PatternStart -> IfcCartesianPoint;
        required property HatchLineAngle -> float64;
    }

    type IfcGeometricRepresentationContext extending IfcRepresentationContext {
        property CoordinateSpaceDimension -> int64;
        property Precision -> float64;
        link WorldCoordinateSystem -> IfcAxis2Placement2D | IfcAxis2Placement3D;
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
        required link RelativePlacement -> IfcAxis2Placement2D | IfcAxis2Placement3D;
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

    type IfcRepresentationMap  {
        required link MappingOrigin -> IfcAxis2Placement2D | IfcAxis2Placement3D;
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
        link IfcFillStyleSelect -> IfcColourSpecification | IfcPreDefinedColour | IfcExternallyDefinedHatchStyle | IfcFillAreaStyleHatching | IfcFillAreaStyleTiles;
    }

    type IfcGeometricRepresentationSubContext extending IfcGeometricRepresentationContext {
        required link ParentContext -> IfcGeometricRepresentationContext;
        property TargetScale -> float64;
        required property TargetView -> str {
            constraint one_of ('ELEVATION_VIEW','GRAPH_VIEW','MODEL_VIEW','NOTDEFINED','PLAN_VIEW','REFLECTED_PLAN_VIEW','SECTION_VIEW','SKETCH_VIEW','USERDEFINED');
        };
        property UserDefinedTargetView -> str;
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
        required multi link `IfcPropertySetDefinitionSet` -> IfcPropertySetDefinition;
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
        link IfcSurfaceStyleElementSelect -> IfcExternallyDefinedSurfaceStyle | IfcSurfaceStyleLighting | IfcSurfaceStyleRefraction | IfcSurfaceStyleShading | IfcSurfaceStyleWithTextures;
    }

    type IfcTypeObject extending IfcObjectDefinition {
        property ApplicableOccurrence -> str;
        multi link HasPropertySets -> IfcPropertySetDefinition;
    }

    abstract type IfcElement extending IfcProduct {
        property Tag -> str;
    }

    type IfcFillAreaStyle extending IfcPresentationStyle {
        required multi link FillStyles -> IfcFillStyleSelect;
        property ModelorDraughting -> bool;
    }

    type IfcPropertySetDefinitionSelect {
        link IfcPropertySetDefinitionSelect -> IfcPropertySetDefinition | IfcPropertySetDefinitionSet;
    }

    type IfcRelAssociatesMaterial extending IfcRelAssociates {
        required link RelatingMaterial -> IfcMaterialDefinition | IfcMaterialList | IfcMaterialUsageDefinition;
    }

    type IfcRelDefinesByType extending IfcRelDefines {
        required multi link RelatedObjects -> IfcObject;
        required link RelatingType -> IfcTypeObject;
    }

    abstract type IfcSpatialElement extending IfcProduct {
        property LongName -> str;
    }

    type IfcSurfaceStyle extending IfcPresentationStyle {
        required property Side -> str {
            constraint one_of ('BOTH','NEGATIVE','POSITIVE');
        };
        required multi link Styles -> IfcSurfaceStyleElementSelect;
    }

    type IfcTypeProduct extending IfcTypeObject {
        multi link RepresentationMaps -> IfcRepresentationMap;
        property Tag -> str;
    }

    abstract type IfcBuildingElement extending IfcElement {
    }

    abstract type IfcElementType extending IfcTypeProduct {
        property ElementType -> str;
    }

    abstract type IfcFeatureElement extending IfcElement {
    }

    type IfcPresentationStyleSelect {
        link IfcPresentationStyleSelect -> IfcCurveStyle | IfcFillAreaStyle | IfcNullStyle | IfcSurfaceStyle | IfcTextStyle;
    }

    type IfcRelContainedInSpatialStructure extending IfcRelConnects {
        required multi link RelatedElements -> IfcProduct;
        required link RelatingStructure -> IfcSpatialElement;
    }

    type IfcRelDefinesByProperties extending IfcRelDefines {
        required multi link RelatedObjects -> IfcObjectDefinition;
        required link RelatingPropertyDefinition -> IfcPropertySetDefinition | IfcPropertySetDefinitionSet;
    }

    abstract type IfcSpatialStructureElement extending IfcSpatialElement {
        property CompositionType -> str {
            constraint one_of ('COMPLEX','ELEMENT','PARTIAL');
        };
    }

    type IfcBeam extending IfcBuildingElement {
        property PredefinedType -> str {
            constraint one_of ('BEAM','HOLLOWCORE','JOIST','LINTEL','NOTDEFINED','SPANDREL','T_BEAM','USERDEFINED');
        };
    }

    type IfcBuilding extending IfcSpatialStructureElement {
        property ElevationOfRefHeight -> float64;
        property ElevationOfTerrain -> float64;
        link BuildingAddress -> IfcPostalAddress;
    }

    type IfcBuildingElementProxy extending IfcBuildingElement {
        property PredefinedType -> str {
            constraint one_of ('COMPLEX','ELEMENT','NOTDEFINED','PARTIAL','PROVISIONFORSPACE','PROVISIONFORVOID','USERDEFINED');
        };
    }

    abstract type IfcBuildingElementType extending IfcElementType {
    }

    type IfcBuildingStorey extending IfcSpatialStructureElement {
        property Elevation -> float64;
    }

    type IfcColumn extending IfcBuildingElement {
        property PredefinedType -> str {
            constraint one_of ('COLUMN','NOTDEFINED','PILASTER','USERDEFINED');
        };
    }

    abstract type IfcFeatureElementSubtraction extending IfcFeatureElement {
    }

    type IfcFurnishingElementType extending IfcElementType {
    }

    type IfcMember extending IfcBuildingElement {
        property PredefinedType -> str {
            constraint one_of ('BRACE','CHORD','COLLAR','MEMBER','MULLION','NOTDEFINED','PLATE','POST','PURLIN','RAFTER','STRINGER','STRUT','STUD','USERDEFINED');
        };
    }

    type IfcPresentationStyleAssignment  {
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
        required property PredefinedType -> str {
            constraint one_of ('BEAM','HOLLOWCORE','JOIST','LINTEL','NOTDEFINED','SPANDREL','T_BEAM','USERDEFINED');
        };
    }

    type IfcColumnType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('COLUMN','NOTDEFINED','PILASTER','USERDEFINED');
        };
    }

    type IfcCoveringType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('CEILING','CLADDING','FLOORING','INSULATION','MEMBRANE','MOLDING','NOTDEFINED','ROOFING','SKIRTINGBOARD','SLEEVING','USERDEFINED','WRAPPING');
        };
    }

    type IfcDoorType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('DOOR','GATE','NOTDEFINED','TRAPDOOR','USERDEFINED');
        };
        required property OperationType -> str {
            constraint one_of ('DOUBLE_DOOR_DOUBLE_SWING','DOUBLE_DOOR_FOLDING','DOUBLE_DOOR_SINGLE_SWING','DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_LEFT','DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_RIGHT','DOUBLE_DOOR_SLIDING','DOUBLE_SWING_LEFT','DOUBLE_SWING_RIGHT','FOLDING_TO_LEFT','FOLDING_TO_RIGHT','NOTDEFINED','REVOLVING','ROLLINGUP','SINGLE_SWING_LEFT','SINGLE_SWING_RIGHT','SLIDING_TO_LEFT','SLIDING_TO_RIGHT','SWING_FIXED_LEFT','SWING_FIXED_RIGHT','USERDEFINED');
        };
        property ParameterTakesPrecedence -> bool;
        property UserDefinedOperationType -> str;
    }

    type IfcFurnitureType extending IfcFurnishingElementType {
        required property AssemblyPlace -> str {
            constraint one_of ('FACTORY','NOTDEFINED','SITE');
        };
        property PredefinedType -> str {
            constraint one_of ('BED','CHAIR','DESK','FILECABINET','NOTDEFINED','SHELF','SOFA','TABLE','USERDEFINED');
        };
    }

    type IfcOpeningElement extending IfcFeatureElementSubtraction {
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','OPENING','RECESS','USERDEFINED');
        };
    }

    type IfcPileType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('BORED','COHESION','DRIVEN','FRICTION','JETGROUTING','NOTDEFINED','SUPPORT','USERDEFINED');
        };
    }

    type IfcRampType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('HALF_TURN_RAMP','NOTDEFINED','QUARTER_TURN_RAMP','SPIRAL_RAMP','STRAIGHT_RUN_RAMP','TWO_QUARTER_TURN_RAMP','TWO_STRAIGHT_RUN_RAMP','USERDEFINED');
        };
    }

    type IfcRelVoidsElement extending IfcRelDecomposes {
        required link RelatingBuildingElement -> IfcElement;
        required link RelatedOpeningElement -> IfcFeatureElementSubtraction;
    }

    type IfcSlabType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('BASESLAB','FLOOR','LANDING','NOTDEFINED','ROOF','USERDEFINED');
        };
    }

    type IfcStyleAssignmentSelect {
        link IfcStyleAssignmentSelect -> IfcPresentationStyle | IfcPresentationStyleAssignment;
    }

    type IfcWallType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('ELEMENTEDWALL','MOVABLE','NOTDEFINED','PARAPET','PARTITIONING','PLUMBINGWALL','POLYGONAL','SHEAR','SOLIDWALL','STANDARD','USERDEFINED');
        };
    }

    type IfcWindowType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('LIGHTDOME','NOTDEFINED','SKYLIGHT','USERDEFINED','WINDOW');
        };
        required property PartitioningType -> str {
            constraint one_of ('DOUBLE_PANEL_HORIZONTAL','DOUBLE_PANEL_VERTICAL','NOTDEFINED','SINGLE_PANEL','TRIPLE_PANEL_BOTTOM','TRIPLE_PANEL_HORIZONTAL','TRIPLE_PANEL_LEFT','TRIPLE_PANEL_RIGHT','TRIPLE_PANEL_TOP','TRIPLE_PANEL_VERTICAL','USERDEFINED');
        };
        property ParameterTakesPrecedence -> bool;
        property UserDefinedPartitioningType -> str;
    }

    type IfcStyledItem extending IfcRepresentationItem {
        link Item -> IfcRepresentationItem;
        required multi link Styles -> IfcStyleAssignmentSelect;
        property Name -> str;
    }
}
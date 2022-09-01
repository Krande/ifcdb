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

    type IfcDerivedMeasureValue {
        link IfcDerivedMeasureValue -> IfcAbsorbedDoseMeasure | IfcAccelerationMeasure | IfcAngularVelocityMeasure | IfcAreaDensityMeasure | IfcCompoundPlaneAngleMeasure | IfcCurvatureMeasure | IfcDoseEquivalentMeasure | IfcDynamicViscosityMeasure | IfcElectricCapacitanceMeasure | IfcElectricChargeMeasure | IfcElectricConductanceMeasure | IfcElectricResistanceMeasure | IfcElectricVoltageMeasure | IfcEnergyMeasure | IfcForceMeasure | IfcFrequencyMeasure | IfcHeatFluxDensityMeasure | IfcHeatingValueMeasure | IfcIlluminanceMeasure | IfcInductanceMeasure | IfcIntegerCountRateMeasure | IfcIonConcentrationMeasure | IfcIsothermalMoistureCapacityMeasure | IfcKinematicViscosityMeasure | IfcLinearForceMeasure | IfcLinearMomentMeasure | IfcLinearStiffnessMeasure | IfcLinearVelocityMeasure | IfcLuminousFluxMeasure | IfcLuminousIntensityDistributionMeasure | IfcMagneticFluxDensityMeasure | IfcMagneticFluxMeasure | IfcMassDensityMeasure | IfcMassFlowRateMeasure | IfcMassPerLengthMeasure | IfcModulusOfElasticityMeasure | IfcModulusOfLinearSubgradeReactionMeasure | IfcModulusOfRotationalSubgradeReactionMeasure | IfcModulusOfSubgradeReactionMeasure | IfcMoistureDiffusivityMeasure | IfcMolecularWeightMeasure | IfcMomentOfInertiaMeasure | IfcMonetaryMeasure | IfcPHMeasure | IfcPlanarForceMeasure | IfcPowerMeasure | IfcPressureMeasure | IfcRadioActivityMeasure | IfcRotationalFrequencyMeasure | IfcRotationalMassMeasure | IfcRotationalStiffnessMeasure | IfcSectionModulusMeasure | IfcSectionalAreaIntegralMeasure | IfcShearModulusMeasure | IfcSoundPowerLevelMeasure | IfcSoundPowerMeasure | IfcSoundPressureLevelMeasure | IfcSoundPressureMeasure | IfcSpecificHeatCapacityMeasure | IfcTemperatureGradientMeasure | IfcTemperatureRateOfChangeMeasure | IfcThermalAdmittanceMeasure | IfcThermalConductivityMeasure | IfcThermalExpansionCoefficientMeasure | IfcThermalResistanceMeasure | IfcThermalTransmittanceMeasure | IfcTorqueMeasure | IfcVaporPermeabilityMeasure | IfcVolumetricFlowRateMeasure | IfcWarpingConstantMeasure | IfcWarpingMomentMeasure;
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

    abstract type IfcTopologicalRepresentationItem extending IfcRepresentationItem {
    }

    abstract type IfcCartesianPointList extending IfcGeometricRepresentationItem {
    }

    type IfcCompositeProfileDef extending IfcProfileDef {
        required multi link Profiles -> IfcProfileDef;
        property Label -> str;
    }

    abstract type IfcCurve extending IfcGeometricRepresentationItem {
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
}
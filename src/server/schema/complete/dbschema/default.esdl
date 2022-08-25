module default {


    type IfcAbsorbedDoseMeasure {
        required property `IfcAbsorbedDoseMeasure` -> float64;
    }

    type IfcAccelerationMeasure {
        required property `IfcAccelerationMeasure` -> float64;
    }

    type IfcActionRequest extending IfcControl {
        property PredefinedType -> str {
            constraint one_of ('EMAIL','FAX','NOTDEFINED','PHONE','POST','USERDEFINED','VERBAL');
        };
        property Status -> str;
        property LongDescription -> str;
    }

    type IfcActor extending IfcObject {
        required link TheActor -> IfcActorSelect;
    }

    type IfcActorRole  {
        required property Role -> str {
            constraint one_of ('ARCHITECT','BUILDINGOPERATOR','BUILDINGOWNER','CIVILENGINEER','CLIENT','COMMISSIONINGENGINEER','CONSTRUCTIONMANAGER','CONSULTANT','CONTRACTOR','COSTENGINEER','ELECTRICALENGINEER','ENGINEER','FACILITIESMANAGER','FIELDCONSTRUCTIONMANAGER','MANUFACTURER','MECHANICALENGINEER','OWNER','PROJECTMANAGER','RESELLER','STRUCTURALENGINEER','SUBCONTRACTOR','SUPPLIER','USERDEFINED');
        };
        property UserDefinedRole -> str;
        property Description -> str;
    }

    type IfcActorSelect {
        link IfcActorSelect -> IfcOrganization | IfcPerson | IfcPersonAndOrganization;
    }

    type IfcActuator extending IfcDistributionControlElement {
        property PredefinedType -> str {
            constraint one_of ('ELECTRICACTUATOR','HANDOPERATEDACTUATOR','HYDRAULICACTUATOR','NOTDEFINED','PNEUMATICACTUATOR','THERMOSTATICACTUATOR','USERDEFINED');
        };
    }

    type IfcActuatorType extending IfcDistributionControlElementType {
        required property PredefinedType -> str {
            constraint one_of ('ELECTRICACTUATOR','HANDOPERATEDACTUATOR','HYDRAULICACTUATOR','NOTDEFINED','PNEUMATICACTUATOR','THERMOSTATICACTUATOR','USERDEFINED');
        };
    }

    abstract type IfcAddress  {
        property Purpose -> str {
            constraint one_of ('DISTRIBUTIONPOINT','HOME','OFFICE','SITE','USERDEFINED');
        };
        property Description -> str;
        property UserDefinedPurpose -> str;
    }

    type IfcAdvancedBrep extending IfcManifoldSolidBrep {
    }

    type IfcAdvancedBrepWithVoids extending IfcAdvancedBrep {
        required multi link Voids -> IfcClosedShell;
    }

    type IfcAdvancedFace extending IfcFaceSurface {
    }

    type IfcAirTerminal extending IfcFlowTerminal {
        property PredefinedType -> str {
            constraint one_of ('DIFFUSER','GRILLE','LOUVRE','NOTDEFINED','REGISTER','USERDEFINED');
        };
    }

    type IfcAirTerminalBox extending IfcFlowController {
        property PredefinedType -> str {
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
        property PredefinedType -> str {
            constraint one_of ('FIXEDPLATECOUNTERFLOWEXCHANGER','FIXEDPLATECROSSFLOWEXCHANGER','FIXEDPLATEPARALLELFLOWEXCHANGER','HEATPIPE','NOTDEFINED','ROTARYWHEEL','RUNAROUNDCOILLOOP','THERMOSIPHONCOILTYPEHEATEXCHANGERS','THERMOSIPHONSEALEDTUBEHEATEXCHANGERS','TWINTOWERENTHALPYRECOVERYLOOPS','USERDEFINED');
        };
    }

    type IfcAirToAirHeatRecoveryType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('FIXEDPLATECOUNTERFLOWEXCHANGER','FIXEDPLATECROSSFLOWEXCHANGER','FIXEDPLATEPARALLELFLOWEXCHANGER','HEATPIPE','NOTDEFINED','ROTARYWHEEL','RUNAROUNDCOILLOOP','THERMOSIPHONCOILTYPEHEATEXCHANGERS','THERMOSIPHONSEALEDTUBEHEATEXCHANGERS','TWINTOWERENTHALPYRECOVERYLOOPS','USERDEFINED');
        };
    }

    type IfcAlarm extending IfcDistributionControlElement {
        property PredefinedType -> str {
            constraint one_of ('BELL','BREAKGLASSBUTTON','LIGHT','MANUALPULLBOX','NOTDEFINED','SIREN','USERDEFINED','WHISTLE');
        };
    }

    type IfcAlarmType extending IfcDistributionControlElementType {
        required property PredefinedType -> str {
            constraint one_of ('BELL','BREAKGLASSBUTTON','LIGHT','MANUALPULLBOX','NOTDEFINED','SIREN','USERDEFINED','WHISTLE');
        };
    }

    type IfcAlignment extending IfcLinearPositioningElement {
        property PredefinedType -> str {
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
        required link Horizontal -> IfcAlignment2DHorizontal;
        link Vertical -> IfcAlignment2DVertical;
        property Tag -> str;
    }

    type IfcAmountOfSubstanceMeasure {
        required property `IfcAmountOfSubstanceMeasure` -> float64;
    }

    type IfcAngularVelocityMeasure {
        required property `IfcAngularVelocityMeasure` -> float64;
    }

    type IfcAnnotation extending IfcProduct {
    }

    type IfcAnnotationFillArea extending IfcGeometricRepresentationItem {
        required link OuterBoundary -> IfcCurve;
        multi link InnerBoundaries -> IfcCurve;
    }

    type IfcApplication  {
        required link ApplicationDeveloper -> IfcOrganization;
        required property Version -> str;
        required property ApplicationFullName -> str;
        required property ApplicationIdentifier -> str;
    }

    type IfcAppliedValue  {
        property Name -> str;
        property Description -> str;
        link AppliedValue -> IfcAppliedValueSelect;
        link UnitBasis -> IfcMeasureWithUnit;
        property ApplicableDate -> str;
        property FixedUntilDate -> str;
        property Category -> str;
        property Condition -> str;
        property ArithmeticOperator -> str {
            constraint one_of ('ADD','DIVIDE','MULTIPLY','SUBTRACT');
        };
        multi link Components -> IfcAppliedValue;
    }

    type IfcAppliedValueSelect {
        link IfcAppliedValueSelect -> IfcMeasureWithUnit | IfcReference | IfcAbsorbedDoseMeasure | IfcAccelerationMeasure | IfcAngularVelocityMeasure | IfcAreaDensityMeasure | IfcCompoundPlaneAngleMeasure | IfcCurvatureMeasure | IfcDoseEquivalentMeasure | IfcDynamicViscosityMeasure | IfcElectricCapacitanceMeasure | IfcElectricChargeMeasure | IfcElectricConductanceMeasure | IfcElectricResistanceMeasure | IfcElectricVoltageMeasure | IfcEnergyMeasure | IfcForceMeasure | IfcFrequencyMeasure | IfcHeatFluxDensityMeasure | IfcHeatingValueMeasure | IfcIlluminanceMeasure | IfcInductanceMeasure | IfcIntegerCountRateMeasure | IfcIonConcentrationMeasure | IfcIsothermalMoistureCapacityMeasure | IfcKinematicViscosityMeasure | IfcLinearForceMeasure | IfcLinearMomentMeasure | IfcLinearStiffnessMeasure | IfcLinearVelocityMeasure | IfcLuminousFluxMeasure | IfcLuminousIntensityDistributionMeasure | IfcMagneticFluxDensityMeasure | IfcMagneticFluxMeasure | IfcMassDensityMeasure | IfcMassFlowRateMeasure | IfcMassPerLengthMeasure | IfcModulusOfElasticityMeasure | IfcModulusOfLinearSubgradeReactionMeasure | IfcModulusOfRotationalSubgradeReactionMeasure | IfcModulusOfSubgradeReactionMeasure | IfcMoistureDiffusivityMeasure | IfcMolecularWeightMeasure | IfcMomentOfInertiaMeasure | IfcMonetaryMeasure | IfcPHMeasure | IfcPlanarForceMeasure | IfcPowerMeasure | IfcPressureMeasure | IfcRadioActivityMeasure | IfcRotationalFrequencyMeasure | IfcRotationalMassMeasure | IfcRotationalStiffnessMeasure | IfcSectionModulusMeasure | IfcSectionalAreaIntegralMeasure | IfcShearModulusMeasure | IfcSoundPowerLevelMeasure | IfcSoundPowerMeasure | IfcSoundPressureLevelMeasure | IfcSoundPressureMeasure | IfcSpecificHeatCapacityMeasure | IfcTemperatureGradientMeasure | IfcTemperatureRateOfChangeMeasure | IfcThermalAdmittanceMeasure | IfcThermalConductivityMeasure | IfcThermalExpansionCoefficientMeasure | IfcThermalResistanceMeasure | IfcThermalTransmittanceMeasure | IfcTorqueMeasure | IfcVaporPermeabilityMeasure | IfcVolumetricFlowRateMeasure | IfcWarpingConstantMeasure | IfcWarpingMomentMeasure | IfcAmountOfSubstanceMeasure | IfcAreaMeasure | IfcComplexNumber | IfcContextDependentMeasure | IfcCountMeasure | IfcDescriptiveMeasure | IfcElectricCurrentMeasure | IfcLengthMeasure | IfcLuminousIntensityMeasure | IfcMassMeasure | IfcNonNegativeLengthMeasure | IfcNormalisedRatioMeasure | IfcNumericMeasure | IfcParameterValue | IfcPlaneAngleMeasure | IfcPositiveLengthMeasure | IfcPositivePlaneAngleMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure | IfcSolidAngleMeasure | IfcThermodynamicTemperatureMeasure | IfcTimeMeasure | IfcVolumeMeasure | IfcBinary | IfcBoolean | IfcDate | IfcDateTime | IfcDuration | IfcIdentifier | IfcInteger | IfcLabel | IfcLogical | IfcPositiveInteger | IfcReal | IfcText | IfcTime | IfcTimeStamp;
    }

    type IfcApproval  {
        property Identifier -> str;
        property Name -> str;
        property Description -> str;
        property TimeOfApproval -> str;
        property Status -> str;
        property Level -> str;
        property Qualifier -> str;
        link RequestingApproval -> IfcActorSelect;
        link GivingApproval -> IfcActorSelect;
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

    type IfcArcIndex {
        required property `IfcArcIndex` -> tuple<int64, int64, int64>;
    }

    type IfcAreaDensityMeasure {
        required property `IfcAreaDensityMeasure` -> float64;
    }

    type IfcAreaMeasure {
        required property `IfcAreaMeasure` -> float64;
    }

    type IfcAsset extending IfcGroup {
        property Identification -> str;
        link OriginalValue -> IfcCostValue;
        link CurrentValue -> IfcCostValue;
        link TotalReplacementCost -> IfcCostValue;
        link Owner -> IfcActorSelect;
        link User -> IfcActorSelect;
        link ResponsiblePerson -> IfcPerson;
        property IncorporationDate -> str;
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
        property PredefinedType -> str {
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

    type IfcAxis2Placement {
        link IfcAxis2Placement -> IfcAxis2Placement2D | IfcAxis2Placement3D;
    }

    type IfcAxis2Placement2D extending IfcPlacement {
        link RefDirection -> IfcDirection;
    }

    type IfcAxis2Placement3D extending IfcPlacement {
        link Axis -> IfcDirection;
        link RefDirection -> IfcDirection;
    }

    abstract type IfcBSplineCurve extending IfcBoundedCurve {
        required property Degree -> int64;
        required multi link ControlPointsList -> IfcCartesianPoint;
        required property CurveForm -> str {
            constraint one_of ('CIRCULAR_ARC','ELLIPTIC_ARC','HYPERBOLIC_ARC','PARABOLIC_ARC','POLYLINE_FORM','UNSPECIFIED');
        };
        required property ClosedCurve -> bool;
        required property SelfIntersect -> bool;
    }

    type IfcBSplineCurveWithKnots extending IfcBSplineCurve {
        required property KnotMultiplicities -> tuple<int64, int64>;
        required property Knots -> tuple<float64, float64>;
        required property KnotSpec -> str {
            constraint one_of ('PIECEWISE_BEZIER_KNOTS','QUASI_UNIFORM_KNOTS','UNIFORM_KNOTS','UNSPECIFIED');
        };
    }

    type List_of_IfcCartesianPoint { required multi link IfcCartesianPoints -> IfcCartesianPoint }

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

    type IfcBSplineSurfaceWithKnots extending IfcBSplineSurface {
        required property UMultiplicities -> tuple<int64, int64>;
        required property VMultiplicities -> tuple<int64, int64>;
        required property UKnots -> tuple<float64, float64>;
        required property VKnots -> tuple<float64, float64>;
        required property KnotSpec -> str {
            constraint one_of ('PIECEWISE_BEZIER_KNOTS','QUASI_UNIFORM_KNOTS','UNIFORM_KNOTS','UNSPECIFIED');
        };
    }

    type IfcBeam extending IfcBuildingElement {
        property PredefinedType -> str {
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

    type IfcBendingParameterSelect {
        link IfcBendingParameterSelect -> IfcLengthMeasure | IfcPlaneAngleMeasure;
    }

    type IfcBinary {
        required property `IfcBinary` -> bytes;
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
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','STEAM','USERDEFINED','WATER');
        };
    }

    type IfcBoilerType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','STEAM','USERDEFINED','WATER');
        };
    }

    type IfcBoolean {
        required property `IfcBoolean` -> bool;
    }

    type IfcBooleanClippingResult extending IfcBooleanResult {
    }

    type IfcBooleanOperand {
        link IfcBooleanOperand -> IfcBooleanResult | IfcCsgPrimitive3D | IfcHalfSpaceSolid | IfcSolidModel | IfcTessellatedFaceSet;
    }

    type IfcBooleanResult extending IfcGeometricRepresentationItem {
        required property Operator -> str {
            constraint one_of ('DIFFERENCE','INTERSECTION','UNION');
        };
        required link FirstOperand -> IfcBooleanOperand;
        required link SecondOperand -> IfcBooleanOperand;
    }

    abstract type IfcBoundaryCondition  {
        property Name -> str;
    }

    type IfcBoundaryCurve extending IfcCompositeCurveOnSurface {
    }

    type IfcBoundaryEdgeCondition extending IfcBoundaryCondition {
        link TranslationalStiffnessByLengthX -> IfcModulusOfTranslationalSubgradeReactionSelect;
        link TranslationalStiffnessByLengthY -> IfcModulusOfTranslationalSubgradeReactionSelect;
        link TranslationalStiffnessByLengthZ -> IfcModulusOfTranslationalSubgradeReactionSelect;
        link RotationalStiffnessByLengthX -> IfcModulusOfRotationalSubgradeReactionSelect;
        link RotationalStiffnessByLengthY -> IfcModulusOfRotationalSubgradeReactionSelect;
        link RotationalStiffnessByLengthZ -> IfcModulusOfRotationalSubgradeReactionSelect;
    }

    type IfcBoundaryFaceCondition extending IfcBoundaryCondition {
        link TranslationalStiffnessByAreaX -> IfcModulusOfSubgradeReactionSelect;
        link TranslationalStiffnessByAreaY -> IfcModulusOfSubgradeReactionSelect;
        link TranslationalStiffnessByAreaZ -> IfcModulusOfSubgradeReactionSelect;
    }

    type IfcBoundaryNodeCondition extending IfcBoundaryCondition {
        link TranslationalStiffnessX -> IfcTranslationalStiffnessSelect;
        link TranslationalStiffnessY -> IfcTranslationalStiffnessSelect;
        link TranslationalStiffnessZ -> IfcTranslationalStiffnessSelect;
        link RotationalStiffnessX -> IfcRotationalStiffnessSelect;
        link RotationalStiffnessY -> IfcRotationalStiffnessSelect;
        link RotationalStiffnessZ -> IfcRotationalStiffnessSelect;
    }

    type IfcBoundaryNodeConditionWarping extending IfcBoundaryNodeCondition {
        link WarpingStiffness -> IfcWarpingStiffnessSelect;
    }

    abstract type IfcBoundedCurve extending IfcCurve {
    }

    abstract type IfcBoundedSurface extending IfcSurface {
    }

    type IfcBoundingBox extending IfcGeometricRepresentationItem {
        required link Corner -> IfcCartesianPoint;
        required property XDim -> float64;
        required property YDim -> float64;
        required property ZDim -> float64;
    }

    type IfcBoxAlignment {
        required property `IfcBoxAlignment` -> str;
    }

    type IfcBoxedHalfSpace extending IfcHalfSpaceSolid {
        required link Enclosure -> IfcBoundingBox;
    }

    type IfcBuilding extending IfcSpatialStructureElement {
        property ElevationOfRefHeight -> float64;
        property ElevationOfTerrain -> float64;
        link BuildingAddress -> IfcPostalAddress;
    }

    abstract type IfcBuildingElement extending IfcElement {
    }

    type IfcBuildingElementPart extending IfcElementComponent {
        property PredefinedType -> str {
            constraint one_of ('INSULATION','NOTDEFINED','PRECASTPANEL','USERDEFINED');
        };
    }

    type IfcBuildingElementPartType extending IfcElementComponentType {
        required property PredefinedType -> str {
            constraint one_of ('INSULATION','NOTDEFINED','PRECASTPANEL','USERDEFINED');
        };
    }

    type IfcBuildingElementProxy extending IfcBuildingElement {
        property PredefinedType -> str {
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
        property PredefinedType -> str {
            constraint one_of ('FENESTRATION','FOUNDATION','LOADBEARING','NOTDEFINED','OUTERSHELL','SHADING','TRANSPORT','USERDEFINED');
        };
        property LongName -> str;
    }

    type IfcBurner extending IfcEnergyConversionDevice {
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcBurnerType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcCShapeProfileDef extending IfcParameterizedProfileDef {
        required property Depth -> float64;
        required property Width -> float64;
        required property WallThickness -> float64;
        required property Girth -> float64;
        property InternalFilletRadius -> float64;
    }

    type IfcCableCarrierFitting extending IfcFlowFitting {
        property PredefinedType -> str {
            constraint one_of ('BEND','CROSS','NOTDEFINED','REDUCER','TEE','USERDEFINED');
        };
    }

    type IfcCableCarrierFittingType extending IfcFlowFittingType {
        required property PredefinedType -> str {
            constraint one_of ('BEND','CROSS','NOTDEFINED','REDUCER','TEE','USERDEFINED');
        };
    }

    type IfcCableCarrierSegment extending IfcFlowSegment {
        property PredefinedType -> str {
            constraint one_of ('CABLELADDERSEGMENT','CABLETRAYSEGMENT','CABLETRUNKINGSEGMENT','CONDUITSEGMENT','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcCableCarrierSegmentType extending IfcFlowSegmentType {
        required property PredefinedType -> str {
            constraint one_of ('CABLELADDERSEGMENT','CABLETRAYSEGMENT','CABLETRUNKINGSEGMENT','CONDUITSEGMENT','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcCableFitting extending IfcFlowFitting {
        property PredefinedType -> str {
            constraint one_of ('CONNECTOR','ENTRY','EXIT','JUNCTION','NOTDEFINED','TRANSITION','USERDEFINED');
        };
    }

    type IfcCableFittingType extending IfcFlowFittingType {
        required property PredefinedType -> str {
            constraint one_of ('CONNECTOR','ENTRY','EXIT','JUNCTION','NOTDEFINED','TRANSITION','USERDEFINED');
        };
    }

    type IfcCableSegment extending IfcFlowSegment {
        property PredefinedType -> str {
            constraint one_of ('BUSBARSEGMENT','CABLESEGMENT','CONDUCTORSEGMENT','CORESEGMENT','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcCableSegmentType extending IfcFlowSegmentType {
        required property PredefinedType -> str {
            constraint one_of ('BUSBARSEGMENT','CABLESEGMENT','CONDUCTORSEGMENT','CORESEGMENT','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcCardinalPointReference {
        required property `IfcCardinalPointReference` -> int64;
    }

    type IfcCartesianPoint extending IfcPoint {
        required property Coordinates -> array<float64>{
            constraint expression on (len(__subject__) = 1 or len(__subject__) = 2 or len(__subject__) = 3)
        };
    }

    abstract type IfcCartesianPointList extending IfcGeometricRepresentationItem {
    }

    type IfcCartesianPointList2D extending IfcCartesianPointList {
        required property CoordList -> array<tuple<float64, float64>>;
        property TagList -> tuple<str>;
    }

    type IfcCartesianPointList3D extending IfcCartesianPointList {
        required property CoordList -> array<tuple<float64, float64, float64>>;
        property TagList -> tuple<str>;
    }

    abstract type IfcCartesianTransformationOperator extending IfcGeometricRepresentationItem {
        link Axis1 -> IfcDirection;
        link Axis2 -> IfcDirection;
        required link LocalOrigin -> IfcCartesianPoint;
        property Scale -> float64;
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
        property PredefinedType -> str {
            constraint one_of ('AIRCOOLED','HEATRECOVERY','NOTDEFINED','USERDEFINED','WATERCOOLED');
        };
    }

    type IfcChillerType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('AIRCOOLED','HEATRECOVERY','NOTDEFINED','USERDEFINED','WATERCOOLED');
        };
    }

    type IfcChimney extending IfcBuildingElement {
        property PredefinedType -> str {
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
        link ReferencedSource -> IfcClassificationReferenceSelect;
        property Description -> str;
        property Sort -> str;
    }

    type IfcClassificationReferenceSelect {
        link IfcClassificationReferenceSelect -> IfcClassification | IfcClassificationReference;
    }

    type IfcClassificationSelect {
        link IfcClassificationSelect -> IfcClassification | IfcClassificationReference;
    }

    type IfcClosedShell extending IfcConnectedFaceSet {
    }

    type IfcCoil extending IfcEnergyConversionDevice {
        property PredefinedType -> str {
            constraint one_of ('DXCOOLINGCOIL','ELECTRICHEATINGCOIL','GASHEATINGCOIL','HYDRONICCOIL','NOTDEFINED','STEAMHEATINGCOIL','USERDEFINED','WATERCOOLINGCOIL','WATERHEATINGCOIL');
        };
    }

    type IfcCoilType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('DXCOOLINGCOIL','ELECTRICHEATINGCOIL','GASHEATINGCOIL','HYDRONICCOIL','NOTDEFINED','STEAMHEATINGCOIL','USERDEFINED','WATERCOOLINGCOIL','WATERHEATINGCOIL');
        };
    }

    type IfcColour {
        link IfcColour -> IfcColourSpecification | IfcPreDefinedColour;
    }

    type IfcColourOrFactor {
        link IfcColourOrFactor -> IfcColourRgb | IfcNormalisedRatioMeasure;
    }

    type IfcColourRgb extending IfcColourSpecification {
        required property Red -> float64;
        required property Green -> float64;
        required property Blue -> float64;
    }

    type IfcColourRgbList extending IfcPresentationItem {
        required property ColourList -> array<tuple<float64, float64, float64>>;
    }

    abstract type IfcColourSpecification extending IfcPresentationItem {
        property Name -> str;
    }

    type IfcColumn extending IfcBuildingElement {
        property PredefinedType -> str {
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
        property PredefinedType -> str {
            constraint one_of ('ANTENNA','COMPUTER','FAX','GATEWAY','MODEM','NETWORKAPPLIANCE','NETWORKBRIDGE','NETWORKHUB','NOTDEFINED','PRINTER','REPEATER','ROUTER','SCANNER','USERDEFINED');
        };
    }

    type IfcCommunicationsApplianceType extending IfcFlowTerminalType {
        required property PredefinedType -> str {
            constraint one_of ('ANTENNA','COMPUTER','FAX','GATEWAY','MODEM','NETWORKAPPLIANCE','NETWORKBRIDGE','NETWORKHUB','NOTDEFINED','PRINTER','REPEATER','ROUTER','SCANNER','USERDEFINED');
        };
    }

    type IfcComplexNumber {
        required property `IfcComplexNumber` -> array<float64>{
            constraint expression on (len(__subject__) = 1 or len(__subject__) = 2)
        };
    }

    type IfcComplexProperty extending IfcProperty {
        required property UsageName -> str;
        required multi link HasProperties -> IfcProperty;
    }

    type IfcComplexPropertyTemplate extending IfcPropertyTemplate {
        property UsageName -> str;
        property TemplateType -> str {
            constraint one_of ('P_COMPLEX','Q_COMPLEX');
        };
        multi link HasPropertyTemplates -> IfcPropertyTemplate;
    }

    type IfcCompositeCurve extending IfcBoundedCurve {
        required multi link Segments -> IfcCompositeCurveSegment;
        required property SelfIntersect -> bool;
    }

    type IfcCompositeCurveOnSurface extending IfcCompositeCurve {
    }

    type IfcCompositeCurveSegment extending IfcGeometricRepresentationItem {
        required property Transition -> str {
            constraint one_of ('CONTINUOUS','CONTSAMEGRADIENT','CONTSAMEGRADIENTSAMECURVATURE','DISCONTINUOUS');
        };
        required property SameSense -> bool;
        required link ParentCurve -> IfcCurve;
    }

    type IfcCompositeProfileDef extending IfcProfileDef {
        required multi link Profiles -> IfcProfileDef;
        property Label -> str;
    }

    type IfcCompoundPlaneAngleMeasure {
        required property `IfcCompoundPlaneAngleMeasure` -> array<int64>{
            constraint expression on (len(__subject__) = 3 or len(__subject__) = 4)
        };
    }

    type IfcCompressor extending IfcFlowMovingDevice {
        property PredefinedType -> str {
            constraint one_of ('BOOSTER','DYNAMIC','HERMETIC','NOTDEFINED','OPENTYPE','RECIPROCATING','ROLLINGPISTON','ROTARY','ROTARYVANE','SCROLL','SEMIHERMETIC','SINGLESCREW','SINGLESTAGE','TROCHOIDAL','TWINSCREW','USERDEFINED','WELDEDSHELLHERMETIC');
        };
    }

    type IfcCompressorType extending IfcFlowMovingDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('BOOSTER','DYNAMIC','HERMETIC','NOTDEFINED','OPENTYPE','RECIPROCATING','ROLLINGPISTON','ROTARY','ROTARYVANE','SCROLL','SEMIHERMETIC','SINGLESCREW','SINGLESTAGE','TROCHOIDAL','TWINSCREW','USERDEFINED','WELDEDSHELLHERMETIC');
        };
    }

    type IfcCondenser extending IfcEnergyConversionDevice {
        property PredefinedType -> str {
            constraint one_of ('AIRCOOLED','EVAPORATIVECOOLED','NOTDEFINED','USERDEFINED','WATERCOOLED','WATERCOOLEDBRAZEDPLATE','WATERCOOLEDSHELLCOIL','WATERCOOLEDSHELLTUBE','WATERCOOLEDTUBEINTUBE');
        };
    }

    type IfcCondenserType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('AIRCOOLED','EVAPORATIVECOOLED','NOTDEFINED','USERDEFINED','WATERCOOLED','WATERCOOLEDBRAZEDPLATE','WATERCOOLEDSHELLCOIL','WATERCOOLEDSHELLTUBE','WATERCOOLEDTUBEINTUBE');
        };
    }

    abstract type IfcConic extending IfcCurve {
        required link Position -> IfcAxis2Placement;
    }

    type IfcConnectedFaceSet extending IfcTopologicalRepresentationItem {
        required multi link CfsFaces -> IfcFace;
    }

    type IfcConnectionCurveGeometry extending IfcConnectionGeometry {
        required link CurveOnRelatingElement -> IfcCurveOrEdgeCurve;
        link CurveOnRelatedElement -> IfcCurveOrEdgeCurve;
    }

    abstract type IfcConnectionGeometry  {
    }

    type IfcConnectionPointEccentricity extending IfcConnectionPointGeometry {
        property EccentricityInX -> float64;
        property EccentricityInY -> float64;
        property EccentricityInZ -> float64;
    }

    type IfcConnectionPointGeometry extending IfcConnectionGeometry {
        required link PointOnRelatingElement -> IfcPointOrVertexPoint;
        link PointOnRelatedElement -> IfcPointOrVertexPoint;
    }

    type IfcConnectionSurfaceGeometry extending IfcConnectionGeometry {
        required link SurfaceOnRelatingElement -> IfcSurfaceOrFaceSurface;
        link SurfaceOnRelatedElement -> IfcSurfaceOrFaceSurface;
    }

    type IfcConnectionVolumeGeometry extending IfcConnectionGeometry {
        required link VolumeOnRelatingElement -> IfcSolidOrShell;
        link VolumeOnRelatedElement -> IfcSolidOrShell;
    }

    abstract type IfcConstraint  {
        required property Name -> str;
        property Description -> str;
        required property ConstraintGrade -> str {
            constraint one_of ('ADVISORY','HARD','NOTDEFINED','SOFT','USERDEFINED');
        };
        property ConstraintSource -> str;
        link CreatingActor -> IfcActorSelect;
        property CreationTime -> str;
        property UserDefinedGrade -> str;
    }

    type IfcConstructionEquipmentResource extending IfcConstructionResource {
        property PredefinedType -> str {
            constraint one_of ('DEMOLISHING','EARTHMOVING','ERECTING','HEATING','LIGHTING','NOTDEFINED','PAVING','PUMPING','TRANSPORTING','USERDEFINED');
        };
    }

    type IfcConstructionEquipmentResourceType extending IfcConstructionResourceType {
        required property PredefinedType -> str {
            constraint one_of ('DEMOLISHING','EARTHMOVING','ERECTING','HEATING','LIGHTING','NOTDEFINED','PAVING','PUMPING','TRANSPORTING','USERDEFINED');
        };
    }

    type IfcConstructionMaterialResource extending IfcConstructionResource {
        property PredefinedType -> str {
            constraint one_of ('AGGREGATES','CONCRETE','DRYWALL','FUEL','GYPSUM','MASONRY','METAL','NOTDEFINED','PLASTIC','USERDEFINED','WOOD');
        };
    }

    type IfcConstructionMaterialResourceType extending IfcConstructionResourceType {
        required property PredefinedType -> str {
            constraint one_of ('AGGREGATES','CONCRETE','DRYWALL','FUEL','GYPSUM','MASONRY','METAL','NOTDEFINED','PLASTIC','USERDEFINED','WOOD');
        };
    }

    type IfcConstructionProductResource extending IfcConstructionResource {
        property PredefinedType -> str {
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

    type IfcContextDependentMeasure {
        required property `IfcContextDependentMeasure` -> float64;
    }

    type IfcContextDependentUnit extending IfcNamedUnit {
        required property Name -> str;
    }

    abstract type IfcControl extending IfcObject {
        property Identification -> str;
    }

    type IfcController extending IfcDistributionControlElement {
        property PredefinedType -> str {
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
        property PredefinedType -> str {
            constraint one_of ('ACTIVE','NOTDEFINED','PASSIVE','USERDEFINED');
        };
    }

    type IfcCooledBeamType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('ACTIVE','NOTDEFINED','PASSIVE','USERDEFINED');
        };
    }

    type IfcCoolingTower extending IfcEnergyConversionDevice {
        property PredefinedType -> str {
            constraint one_of ('MECHANICALFORCEDDRAFT','MECHANICALINDUCEDDRAFT','NATURALDRAFT','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcCoolingTowerType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('MECHANICALFORCEDDRAFT','MECHANICALINDUCEDDRAFT','NATURALDRAFT','NOTDEFINED','USERDEFINED');
        };
    }

    abstract type IfcCoordinateOperation  {
        required link SourceCRS -> IfcCoordinateReferenceSystemSelect;
        required link TargetCRS -> IfcCoordinateReferenceSystem;
    }

    abstract type IfcCoordinateReferenceSystem  {
        required property Name -> str;
        property Description -> str;
        property GeodeticDatum -> str;
        property VerticalDatum -> str;
    }

    type IfcCoordinateReferenceSystemSelect {
        link IfcCoordinateReferenceSystemSelect -> IfcCoordinateReferenceSystem | IfcGeometricRepresentationContext;
    }

    type IfcCostItem extending IfcControl {
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
        multi link CostValues -> IfcCostValue;
        multi link CostQuantities -> IfcPhysicalQuantity;
    }

    type IfcCostSchedule extending IfcControl {
        property PredefinedType -> str {
            constraint one_of ('BUDGET','COSTPLAN','ESTIMATE','NOTDEFINED','PRICEDBILLOFQUANTITIES','SCHEDULEOFRATES','TENDER','UNPRICEDBILLOFQUANTITIES','USERDEFINED');
        };
        property Status -> str;
        property SubmittedOn -> str;
        property UpdateDate -> str;
    }

    type IfcCostValue extending IfcAppliedValue {
    }

    type IfcCountMeasure {
        required property `IfcCountMeasure` -> int64;
    }

    type IfcCovering extending IfcBuildingElement {
        property PredefinedType -> str {
            constraint one_of ('CEILING','CLADDING','FLOORING','INSULATION','MEMBRANE','MOLDING','NOTDEFINED','ROOFING','SKIRTINGBOARD','SLEEVING','USERDEFINED','WRAPPING');
        };
    }

    type IfcCoveringType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('CEILING','CLADDING','FLOORING','INSULATION','MEMBRANE','MOLDING','NOTDEFINED','ROOFING','SKIRTINGBOARD','SLEEVING','USERDEFINED','WRAPPING');
        };
    }

    type IfcCrewResource extending IfcConstructionResource {
        property PredefinedType -> str {
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

    type IfcCsgSelect {
        link IfcCsgSelect -> IfcBooleanResult | IfcCsgPrimitive3D;
    }

    type IfcCsgSolid extending IfcSolidModel {
        required link TreeRootExpression -> IfcCsgSelect;
    }

    type IfcCurrencyRelationship extending IfcResourceLevelRelationship {
        required link RelatingMonetaryUnit -> IfcMonetaryUnit;
        required link RelatedMonetaryUnit -> IfcMonetaryUnit;
        required property ExchangeRate -> float64;
        property RateDateTime -> str;
        link RateSource -> IfcLibraryInformation;
    }

    type IfcCurtainWall extending IfcBuildingElement {
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcCurtainWallType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcCurvatureMeasure {
        required property `IfcCurvatureMeasure` -> float64;
    }

    abstract type IfcCurve extending IfcGeometricRepresentationItem {
    }

    type IfcCurveBoundedPlane extending IfcBoundedSurface {
        required link BasisSurface -> IfcPlane;
        required link OuterBoundary -> IfcCurve;
        required multi link InnerBoundaries -> IfcCurve;
    }

    type IfcCurveBoundedSurface extending IfcBoundedSurface {
        required link BasisSurface -> IfcSurface;
        required multi link Boundaries -> IfcBoundaryCurve;
        required property ImplicitOuter -> bool;
    }

    type IfcCurveFontOrScaledCurveFontSelect {
        link IfcCurveFontOrScaledCurveFontSelect -> IfcCurveStyleFontAndScaling | IfcCurveStyleFont | IfcPreDefinedCurveFont;
    }

    type IfcCurveOnSurface {
        link IfcCurveOnSurface -> IfcCompositeCurveOnSurface | IfcPcurve | IfcSurfaceCurve;
    }

    type IfcCurveOrEdgeCurve {
        link IfcCurveOrEdgeCurve -> IfcBoundedCurve | IfcEdgeCurve;
    }

    abstract type IfcCurveSegment2D extending IfcBoundedCurve {
        required link StartPoint -> IfcCartesianPoint;
        required property StartDirection -> float64;
        required property SegmentLength -> float64;
    }

    type IfcCurveStyle extending IfcPresentationStyle {
        link CurveFont -> IfcCurveFontOrScaledCurveFontSelect;
        link CurveWidth -> IfcSizeSelect;
        link CurveColour -> IfcColour;
        property ModelOrDraughting -> bool;
    }

    type IfcCurveStyleFont extending IfcPresentationItem {
        property Name -> str;
        required multi link PatternList -> IfcCurveStyleFontPattern;
    }

    type IfcCurveStyleFontAndScaling extending IfcPresentationItem {
        property Name -> str;
        required link CurveFont -> IfcCurveStyleFontSelect;
        required property CurveFontScaling -> float64;
    }

    type IfcCurveStyleFontPattern extending IfcPresentationItem {
        required property VisibleSegmentLength -> float64;
        required property InvisibleSegmentLength -> float64;
    }

    type IfcCurveStyleFontSelect {
        link IfcCurveStyleFontSelect -> IfcCurveStyleFont | IfcPreDefinedCurveFont;
    }

    type IfcCylindricalSurface extending IfcElementarySurface {
        required property Radius -> float64;
    }

    type IfcDamper extending IfcFlowController {
        property PredefinedType -> str {
            constraint one_of ('BACKDRAFTDAMPER','BALANCINGDAMPER','BLASTDAMPER','CONTROLDAMPER','FIREDAMPER','FIRESMOKEDAMPER','FUMEHOODEXHAUST','GRAVITYDAMPER','GRAVITYRELIEFDAMPER','NOTDEFINED','RELIEFDAMPER','SMOKEDAMPER','USERDEFINED');
        };
    }

    type IfcDamperType extending IfcFlowControllerType {
        required property PredefinedType -> str {
            constraint one_of ('BACKDRAFTDAMPER','BALANCINGDAMPER','BLASTDAMPER','CONTROLDAMPER','FIREDAMPER','FIRESMOKEDAMPER','FUMEHOODEXHAUST','GRAVITYDAMPER','GRAVITYRELIEFDAMPER','NOTDEFINED','RELIEFDAMPER','SMOKEDAMPER','USERDEFINED');
        };
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

    type IfcDefinitionSelect {
        link IfcDefinitionSelect -> IfcObjectDefinition | IfcPropertyDefinition;
    }

    type IfcDerivedMeasureValue {
        link IfcDerivedMeasureValue -> IfcAbsorbedDoseMeasure | IfcAccelerationMeasure | IfcAngularVelocityMeasure | IfcAreaDensityMeasure | IfcCompoundPlaneAngleMeasure | IfcCurvatureMeasure | IfcDoseEquivalentMeasure | IfcDynamicViscosityMeasure | IfcElectricCapacitanceMeasure | IfcElectricChargeMeasure | IfcElectricConductanceMeasure | IfcElectricResistanceMeasure | IfcElectricVoltageMeasure | IfcEnergyMeasure | IfcForceMeasure | IfcFrequencyMeasure | IfcHeatFluxDensityMeasure | IfcHeatingValueMeasure | IfcIlluminanceMeasure | IfcInductanceMeasure | IfcIntegerCountRateMeasure | IfcIonConcentrationMeasure | IfcIsothermalMoistureCapacityMeasure | IfcKinematicViscosityMeasure | IfcLinearForceMeasure | IfcLinearMomentMeasure | IfcLinearStiffnessMeasure | IfcLinearVelocityMeasure | IfcLuminousFluxMeasure | IfcLuminousIntensityDistributionMeasure | IfcMagneticFluxDensityMeasure | IfcMagneticFluxMeasure | IfcMassDensityMeasure | IfcMassFlowRateMeasure | IfcMassPerLengthMeasure | IfcModulusOfElasticityMeasure | IfcModulusOfLinearSubgradeReactionMeasure | IfcModulusOfRotationalSubgradeReactionMeasure | IfcModulusOfSubgradeReactionMeasure | IfcMoistureDiffusivityMeasure | IfcMolecularWeightMeasure | IfcMomentOfInertiaMeasure | IfcMonetaryMeasure | IfcPHMeasure | IfcPlanarForceMeasure | IfcPowerMeasure | IfcPressureMeasure | IfcRadioActivityMeasure | IfcRotationalFrequencyMeasure | IfcRotationalMassMeasure | IfcRotationalStiffnessMeasure | IfcSectionModulusMeasure | IfcSectionalAreaIntegralMeasure | IfcShearModulusMeasure | IfcSoundPowerLevelMeasure | IfcSoundPowerMeasure | IfcSoundPressureLevelMeasure | IfcSoundPressureMeasure | IfcSpecificHeatCapacityMeasure | IfcTemperatureGradientMeasure | IfcTemperatureRateOfChangeMeasure | IfcThermalAdmittanceMeasure | IfcThermalConductivityMeasure | IfcThermalExpansionCoefficientMeasure | IfcThermalResistanceMeasure | IfcThermalTransmittanceMeasure | IfcTorqueMeasure | IfcVaporPermeabilityMeasure | IfcVolumetricFlowRateMeasure | IfcWarpingConstantMeasure | IfcWarpingMomentMeasure;
    }

    type IfcDerivedProfileDef extending IfcProfileDef {
        required link ParentProfile -> IfcProfileDef;
        link Operator -> IfcCartesianTransformationOperator2D;
        property Label -> str;
    }

    type IfcDerivedUnit  {
        required multi link Elements -> IfcDerivedUnitElement;
        required property UnitType -> str {
            constraint one_of ('ACCELERATIONUNIT','ANGULARVELOCITYUNIT','AREADENSITYUNIT','COMPOUNDPLANEANGLEUNIT','CURVATUREUNIT','DYNAMICVISCOSITYUNIT','HEATFLUXDENSITYUNIT','HEATINGVALUEUNIT','INTEGERCOUNTRATEUNIT','IONCONCENTRATIONUNIT','ISOTHERMALMOISTURECAPACITYUNIT','KINEMATICVISCOSITYUNIT','LINEARFORCEUNIT','LINEARMOMENTUNIT','LINEARSTIFFNESSUNIT','LINEARVELOCITYUNIT','LUMINOUSINTENSITYDISTRIBUTIONUNIT','MASSDENSITYUNIT','MASSFLOWRATEUNIT','MASSPERLENGTHUNIT','MODULUSOFELASTICITYUNIT','MODULUSOFLINEARSUBGRADEREACTIONUNIT','MODULUSOFROTATIONALSUBGRADEREACTIONUNIT','MODULUSOFSUBGRADEREACTIONUNIT','MOISTUREDIFFUSIVITYUNIT','MOLECULARWEIGHTUNIT','MOMENTOFINERTIAUNIT','PHUNIT','PLANARFORCEUNIT','ROTATIONALFREQUENCYUNIT','ROTATIONALMASSUNIT','ROTATIONALSTIFFNESSUNIT','SECTIONAREAINTEGRALUNIT','SECTIONMODULUSUNIT','SHEARMODULUSUNIT','SOUNDPOWERLEVELUNIT','SOUNDPOWERUNIT','SOUNDPRESSURELEVELUNIT','SOUNDPRESSUREUNIT','SPECIFICHEATCAPACITYUNIT','TEMPERATUREGRADIENTUNIT','TEMPERATURERATEOFCHANGEUNIT','THERMALADMITTANCEUNIT','THERMALCONDUCTANCEUNIT','THERMALEXPANSIONCOEFFICIENTUNIT','THERMALRESISTANCEUNIT','THERMALTRANSMITTANCEUNIT','TORQUEUNIT','USERDEFINED','VAPORPERMEABILITYUNIT','VOLUMETRICFLOWRATEUNIT','WARPINGCONSTANTUNIT','WARPINGMOMENTUNIT');
        };
        property UserDefinedType -> str;
    }

    type IfcDerivedUnitElement  {
        required link Unit -> IfcNamedUnit;
        required property Exponent -> int64;
    }

    type IfcDescriptiveMeasure {
        required property `IfcDescriptiveMeasure` -> str;
    }

    type IfcDimensionCount {
        required property `IfcDimensionCount` -> int64;
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

    type IfcDirection extending IfcGeometricRepresentationItem {
        required property DirectionRatios -> array<float64>{
            constraint expression on (len(__subject__) = 2 or len(__subject__) = 3)
        };
    }

    type IfcDiscreteAccessory extending IfcElementComponent {
        property PredefinedType -> str {
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
        property PredefinedType -> str {
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
        property FlowDirection -> str {
            constraint one_of ('NOTDEFINED','SINK','SOURCE','SOURCEANDSINK');
        };
        property PredefinedType -> str {
            constraint one_of ('CABLE','CABLECARRIER','DUCT','NOTDEFINED','PIPE','USERDEFINED');
        };
        property SystemType -> str {
            constraint one_of ('AIRCONDITIONING','AUDIOVISUAL','CHEMICAL','CHILLEDWATER','COMMUNICATION','COMPRESSEDAIR','CONDENSERWATER','CONTROL','CONVEYING','DATA','DISPOSAL','DOMESTICCOLDWATER','DOMESTICHOTWATER','DRAINAGE','EARTHING','ELECTRICAL','ELECTROACOUSTIC','EXHAUST','FIREPROTECTION','FUEL','GAS','HAZARDOUS','HEATING','LIGHTING','LIGHTNINGPROTECTION','MUNICIPALSOLIDWASTE','NOTDEFINED','OIL','OPERATIONAL','POWERGENERATION','RAINWATER','REFRIGERATION','SECURITY','SEWAGE','SIGNAL','STORMWATER','TELEPHONE','TV','USERDEFINED','VACUUM','VENT','VENTILATION','WASTEWATER','WATERSUPPLY');
        };
    }

    type IfcDistributionSystem extending IfcSystem {
        property LongName -> str;
        property PredefinedType -> str {
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
        link DocumentOwner -> IfcActorSelect;
        multi link Editors -> IfcActorSelect;
        property CreationTime -> str;
        property LastRevisionTime -> str;
        property ElectronicFormat -> str;
        property ValidFrom -> str;
        property ValidUntil -> str;
        property Confidentiality -> str {
            constraint one_of ('CONFIDENTIAL','NOTDEFINED','PERSONAL','PUBLIC','RESTRICTED','USERDEFINED');
        };
        property Status -> str {
            constraint one_of ('DRAFT','FINAL','FINALDRAFT','NOTDEFINED','REVISION');
        };
    }

    type IfcDocumentInformationRelationship extending IfcResourceLevelRelationship {
        required link RelatingDocument -> IfcDocumentInformation;
        required multi link RelatedDocuments -> IfcDocumentInformation;
        property RelationshipType -> str;
    }

    type IfcDocumentReference extending IfcExternalReference {
        property Description -> str;
        link ReferencedDocument -> IfcDocumentInformation;
    }

    type IfcDocumentSelect {
        link IfcDocumentSelect -> IfcDocumentInformation | IfcDocumentReference;
    }

    type IfcDoor extending IfcBuildingElement {
        property OverallHeight -> float64;
        property OverallWidth -> float64;
        property PredefinedType -> str {
            constraint one_of ('DOOR','GATE','NOTDEFINED','TRAPDOOR','USERDEFINED');
        };
        property OperationType -> str {
            constraint one_of ('DOUBLE_DOOR_DOUBLE_SWING','DOUBLE_DOOR_FOLDING','DOUBLE_DOOR_SINGLE_SWING','DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_LEFT','DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_RIGHT','DOUBLE_DOOR_SLIDING','DOUBLE_SWING_LEFT','DOUBLE_SWING_RIGHT','FOLDING_TO_LEFT','FOLDING_TO_RIGHT','NOTDEFINED','REVOLVING','ROLLINGUP','SINGLE_SWING_LEFT','SINGLE_SWING_RIGHT','SLIDING_TO_LEFT','SLIDING_TO_RIGHT','SWING_FIXED_LEFT','SWING_FIXED_RIGHT','USERDEFINED');
        };
        property UserDefinedOperationType -> str;
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
        link ShapeAspectStyle -> IfcShapeAspect;
        property LiningToPanelOffsetX -> float64;
        property LiningToPanelOffsetY -> float64;
    }

    type IfcDoorPanelProperties extending IfcPreDefinedPropertySet {
        property PanelDepth -> float64;
        required property PanelOperation -> str {
            constraint one_of ('DOUBLE_ACTING','FIXEDPANEL','FOLDING','NOTDEFINED','REVOLVING','ROLLINGUP','SLIDING','SWINGING','USERDEFINED');
        };
        property PanelWidth -> float64;
        required property PanelPosition -> str {
            constraint one_of ('LEFT','MIDDLE','NOTDEFINED','RIGHT');
        };
        link ShapeAspectStyle -> IfcShapeAspect;
    }

    type IfcDoorStandardCase extending IfcDoor {
    }

    type IfcDoorStyle extending IfcTypeProduct {
        required property OperationType -> str {
            constraint one_of ('DOUBLE_DOOR_DOUBLE_SWING','DOUBLE_DOOR_FOLDING','DOUBLE_DOOR_SINGLE_SWING','DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_LEFT','DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_RIGHT','DOUBLE_DOOR_SLIDING','DOUBLE_SWING_LEFT','DOUBLE_SWING_RIGHT','FOLDING_TO_LEFT','FOLDING_TO_RIGHT','NOTDEFINED','REVOLVING','ROLLINGUP','SINGLE_SWING_LEFT','SINGLE_SWING_RIGHT','SLIDING_TO_LEFT','SLIDING_TO_RIGHT','USERDEFINED');
        };
        required property ConstructionType -> str {
            constraint one_of ('ALUMINIUM','ALUMINIUM_PLASTIC','ALUMINIUM_WOOD','HIGH_GRADE_STEEL','NOTDEFINED','PLASTIC','STEEL','USERDEFINED','WOOD');
        };
        required property ParameterTakesPrecedence -> bool;
        required property Sizeable -> bool;
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

    type IfcDoseEquivalentMeasure {
        required property `IfcDoseEquivalentMeasure` -> float64;
    }

    type IfcDraughtingPreDefinedColour extending IfcPreDefinedColour {
    }

    type IfcDraughtingPreDefinedCurveFont extending IfcPreDefinedCurveFont {
    }

    type IfcDuctFitting extending IfcFlowFitting {
        property PredefinedType -> str {
            constraint one_of ('BEND','CONNECTOR','ENTRY','EXIT','JUNCTION','NOTDEFINED','OBSTRUCTION','TRANSITION','USERDEFINED');
        };
    }

    type IfcDuctFittingType extending IfcFlowFittingType {
        required property PredefinedType -> str {
            constraint one_of ('BEND','CONNECTOR','ENTRY','EXIT','JUNCTION','NOTDEFINED','OBSTRUCTION','TRANSITION','USERDEFINED');
        };
    }

    type IfcDuctSegment extending IfcFlowSegment {
        property PredefinedType -> str {
            constraint one_of ('FLEXIBLESEGMENT','NOTDEFINED','RIGIDSEGMENT','USERDEFINED');
        };
    }

    type IfcDuctSegmentType extending IfcFlowSegmentType {
        required property PredefinedType -> str {
            constraint one_of ('FLEXIBLESEGMENT','NOTDEFINED','RIGIDSEGMENT','USERDEFINED');
        };
    }

    type IfcDuctSilencer extending IfcFlowTreatmentDevice {
        property PredefinedType -> str {
            constraint one_of ('FLATOVAL','NOTDEFINED','RECTANGULAR','ROUND','USERDEFINED');
        };
    }

    type IfcDuctSilencerType extending IfcFlowTreatmentDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('FLATOVAL','NOTDEFINED','RECTANGULAR','ROUND','USERDEFINED');
        };
    }

    type IfcDuration {
        required property `IfcDuration` -> str;
    }

    type IfcDynamicViscosityMeasure {
        required property `IfcDynamicViscosityMeasure` -> float64;
    }

    type IfcEdge extending IfcTopologicalRepresentationItem {
        link EdgeStart -> IfcVertex;
        link EdgeEnd -> IfcVertex;
    }

    type IfcEdgeCurve extending IfcEdge {
        required link EdgeGeometry -> IfcCurve;
        required property SameSense -> bool;
    }

    type IfcEdgeLoop extending IfcLoop {
        required multi link EdgeList -> IfcOrientedEdge;
    }

    type IfcElectricAppliance extending IfcFlowTerminal {
        property PredefinedType -> str {
            constraint one_of ('DISHWASHER','ELECTRICCOOKER','FREESTANDINGELECTRICHEATER','FREESTANDINGFAN','FREESTANDINGWATERCOOLER','FREESTANDINGWATERHEATER','FREEZER','FRIDGE_FREEZER','HANDDRYER','KITCHENMACHINE','MICROWAVE','NOTDEFINED','PHOTOCOPIER','REFRIGERATOR','TUMBLEDRYER','USERDEFINED','VENDINGMACHINE','WASHINGMACHINE');
        };
    }

    type IfcElectricApplianceType extending IfcFlowTerminalType {
        required property PredefinedType -> str {
            constraint one_of ('DISHWASHER','ELECTRICCOOKER','FREESTANDINGELECTRICHEATER','FREESTANDINGFAN','FREESTANDINGWATERCOOLER','FREESTANDINGWATERHEATER','FREEZER','FRIDGE_FREEZER','HANDDRYER','KITCHENMACHINE','MICROWAVE','NOTDEFINED','PHOTOCOPIER','REFRIGERATOR','TUMBLEDRYER','USERDEFINED','VENDINGMACHINE','WASHINGMACHINE');
        };
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

    type IfcElectricDistributionBoard extending IfcFlowController {
        property PredefinedType -> str {
            constraint one_of ('CONSUMERUNIT','DISTRIBUTIONBOARD','MOTORCONTROLCENTRE','NOTDEFINED','SWITCHBOARD','USERDEFINED');
        };
    }

    type IfcElectricDistributionBoardType extending IfcFlowControllerType {
        required property PredefinedType -> str {
            constraint one_of ('CONSUMERUNIT','DISTRIBUTIONBOARD','MOTORCONTROLCENTRE','NOTDEFINED','SWITCHBOARD','USERDEFINED');
        };
    }

    type IfcElectricFlowStorageDevice extending IfcFlowStorageDevice {
        property PredefinedType -> str {
            constraint one_of ('BATTERY','CAPACITORBANK','HARMONICFILTER','INDUCTORBANK','NOTDEFINED','UPS','USERDEFINED');
        };
    }

    type IfcElectricFlowStorageDeviceType extending IfcFlowStorageDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('BATTERY','CAPACITORBANK','HARMONICFILTER','INDUCTORBANK','NOTDEFINED','UPS','USERDEFINED');
        };
    }

    type IfcElectricGenerator extending IfcEnergyConversionDevice {
        property PredefinedType -> str {
            constraint one_of ('CHP','ENGINEGENERATOR','NOTDEFINED','STANDALONE','USERDEFINED');
        };
    }

    type IfcElectricGeneratorType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('CHP','ENGINEGENERATOR','NOTDEFINED','STANDALONE','USERDEFINED');
        };
    }

    type IfcElectricMotor extending IfcEnergyConversionDevice {
        property PredefinedType -> str {
            constraint one_of ('DC','INDUCTION','NOTDEFINED','POLYPHASE','RELUCTANCESYNCHRONOUS','SYNCHRONOUS','USERDEFINED');
        };
    }

    type IfcElectricMotorType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('DC','INDUCTION','NOTDEFINED','POLYPHASE','RELUCTANCESYNCHRONOUS','SYNCHRONOUS','USERDEFINED');
        };
    }

    type IfcElectricResistanceMeasure {
        required property `IfcElectricResistanceMeasure` -> float64;
    }

    type IfcElectricTimeControl extending IfcFlowController {
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','RELAY','TIMECLOCK','TIMEDELAY','USERDEFINED');
        };
    }

    type IfcElectricTimeControlType extending IfcFlowControllerType {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','RELAY','TIMECLOCK','TIMEDELAY','USERDEFINED');
        };
    }

    type IfcElectricVoltageMeasure {
        required property `IfcElectricVoltageMeasure` -> float64;
    }

    abstract type IfcElement extending IfcProduct {
        property Tag -> str;
    }

    type IfcElementAssembly extending IfcElement {
        property AssemblyPlace -> str {
            constraint one_of ('FACTORY','NOTDEFINED','SITE');
        };
        property PredefinedType -> str {
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

    abstract type IfcElementarySurface extending IfcSurface {
        required link Position -> IfcAxis2Placement3D;
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

    type IfcEnergyMeasure {
        required property `IfcEnergyMeasure` -> float64;
    }

    type IfcEngine extending IfcEnergyConversionDevice {
        property PredefinedType -> str {
            constraint one_of ('EXTERNALCOMBUSTION','INTERNALCOMBUSTION','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcEngineType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('EXTERNALCOMBUSTION','INTERNALCOMBUSTION','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcEvaporativeCooler extending IfcEnergyConversionDevice {
        property PredefinedType -> str {
            constraint one_of ('DIRECTEVAPORATIVEAIRWASHER','DIRECTEVAPORATIVEPACKAGEDROTARYAIRCOOLER','DIRECTEVAPORATIVERANDOMMEDIAAIRCOOLER','DIRECTEVAPORATIVERIGIDMEDIAAIRCOOLER','DIRECTEVAPORATIVESLINGERSPACKAGEDAIRCOOLER','INDIRECTDIRECTCOMBINATION','INDIRECTEVAPORATIVECOOLINGTOWERORCOILCOOLER','INDIRECTEVAPORATIVEPACKAGEAIRCOOLER','INDIRECTEVAPORATIVEWETCOIL','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcEvaporativeCoolerType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('DIRECTEVAPORATIVEAIRWASHER','DIRECTEVAPORATIVEPACKAGEDROTARYAIRCOOLER','DIRECTEVAPORATIVERANDOMMEDIAAIRCOOLER','DIRECTEVAPORATIVERIGIDMEDIAAIRCOOLER','DIRECTEVAPORATIVESLINGERSPACKAGEDAIRCOOLER','INDIRECTDIRECTCOMBINATION','INDIRECTEVAPORATIVECOOLINGTOWERORCOILCOOLER','INDIRECTEVAPORATIVEPACKAGEAIRCOOLER','INDIRECTEVAPORATIVEWETCOIL','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcEvaporator extending IfcEnergyConversionDevice {
        property PredefinedType -> str {
            constraint one_of ('DIRECTEXPANSION','DIRECTEXPANSIONBRAZEDPLATE','DIRECTEXPANSIONSHELLANDTUBE','DIRECTEXPANSIONTUBEINTUBE','FLOODEDSHELLANDTUBE','NOTDEFINED','SHELLANDCOIL','USERDEFINED');
        };
    }

    type IfcEvaporatorType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('DIRECTEXPANSION','DIRECTEXPANSIONBRAZEDPLATE','DIRECTEXPANSIONSHELLANDTUBE','DIRECTEXPANSIONTUBEINTUBE','FLOODEDSHELLANDTUBE','NOTDEFINED','SHELLANDCOIL','USERDEFINED');
        };
    }

    type IfcEvent extending IfcProcess {
        property PredefinedType -> str {
            constraint one_of ('ENDEVENT','INTERMEDIATEEVENT','NOTDEFINED','STARTEVENT','USERDEFINED');
        };
        property EventTriggerType -> str {
            constraint one_of ('EVENTCOMPLEX','EVENTMESSAGE','EVENTRULE','EVENTTIME','NOTDEFINED','USERDEFINED');
        };
        property UserDefinedEventTriggerType -> str;
        link EventOccurenceTime -> IfcEventTime;
    }

    type IfcEventTime extending IfcSchedulingTime {
        property ActualDate -> str;
        property EarlyDate -> str;
        property LateDate -> str;
        property ScheduleDate -> str;
    }

    type IfcEventType extending IfcTypeProcess {
        required property PredefinedType -> str {
            constraint one_of ('ENDEVENT','INTERMEDIATEEVENT','NOTDEFINED','STARTEVENT','USERDEFINED');
        };
        required property EventTriggerType -> str {
            constraint one_of ('EVENTCOMPLEX','EVENTMESSAGE','EVENTRULE','EVENTTIME','NOTDEFINED','USERDEFINED');
        };
        property UserDefinedEventTriggerType -> str;
    }

    abstract type IfcExtendedProperties extending IfcPropertyAbstraction {
        property Name -> str;
        property Description -> str;
        required multi link Properties -> IfcProperty;
    }

    abstract type IfcExternalInformation  {
    }

    abstract type IfcExternalReference  {
        property Location -> str;
        property Identification -> str;
        property Name -> str;
    }

    type IfcExternalReferenceRelationship extending IfcResourceLevelRelationship {
        required link RelatingReference -> IfcExternalReference;
        required multi link RelatedResourceObjects -> IfcResourceObjectSelect;
    }

    type IfcExternalSpatialElement extending IfcExternalSpatialStructureElement {
        property PredefinedType -> str {
            constraint one_of ('EXTERNAL','EXTERNAL_EARTH','EXTERNAL_FIRE','EXTERNAL_WATER','NOTDEFINED','USERDEFINED');
        };
    }

    abstract type IfcExternalSpatialStructureElement extending IfcSpatialElement {
    }

    type IfcExternallyDefinedHatchStyle extending IfcExternalReference {
    }

    type IfcExternallyDefinedSurfaceStyle extending IfcExternalReference {
    }

    type IfcExternallyDefinedTextFont extending IfcExternalReference {
    }

    type IfcExtrudedAreaSolid extending IfcSweptAreaSolid {
        required link ExtrudedDirection -> IfcDirection;
        required property Depth -> float64;
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
        required link Bound -> IfcLoop;
        required property Orientation -> bool;
    }

    type IfcFaceOuterBound extending IfcFaceBound {
    }

    type IfcFaceSurface extending IfcFace {
        required link FaceSurface -> IfcSurface;
        required property SameSense -> bool;
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
        property PredefinedType -> str {
            constraint one_of ('CENTRIFUGALAIRFOIL','CENTRIFUGALBACKWARDINCLINEDCURVED','CENTRIFUGALFORWARDCURVED','CENTRIFUGALRADIAL','NOTDEFINED','PROPELLORAXIAL','TUBEAXIAL','USERDEFINED','VANEAXIAL');
        };
    }

    type IfcFanType extending IfcFlowMovingDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('CENTRIFUGALAIRFOIL','CENTRIFUGALBACKWARDINCLINEDCURVED','CENTRIFUGALFORWARDCURVED','CENTRIFUGALRADIAL','NOTDEFINED','PROPELLORAXIAL','TUBEAXIAL','USERDEFINED','VANEAXIAL');
        };
    }

    type IfcFastener extending IfcElementComponent {
        property PredefinedType -> str {
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
        required multi link FillStyles -> IfcFillStyleSelect;
        property ModelorDraughting -> bool;
    }

    type IfcFillAreaStyleHatching extending IfcGeometricRepresentationItem {
        required link HatchLineAppearance -> IfcCurveStyle;
        required link StartOfNextHatchLine -> IfcHatchLineDistanceSelect;
        link PointOfReferenceHatchLine -> IfcCartesianPoint;
        link PatternStart -> IfcCartesianPoint;
        required property HatchLineAngle -> float64;
    }

    type IfcFillAreaStyleTiles extending IfcGeometricRepresentationItem {
        required multi link TilingPattern -> IfcVector;
        required multi link Tiles -> IfcStyledItem;
        required property TilingScale -> float64;
    }

    type IfcFillStyleSelect {
        link IfcFillStyleSelect -> IfcColourSpecification | IfcPreDefinedColour | IfcExternallyDefinedHatchStyle | IfcFillAreaStyleHatching | IfcFillAreaStyleTiles;
    }

    type IfcFilter extending IfcFlowTreatmentDevice {
        property PredefinedType -> str {
            constraint one_of ('AIRPARTICLEFILTER','COMPRESSEDAIRFILTER','NOTDEFINED','ODORFILTER','OILFILTER','STRAINER','USERDEFINED','WATERFILTER');
        };
    }

    type IfcFilterType extending IfcFlowTreatmentDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('AIRPARTICLEFILTER','COMPRESSEDAIRFILTER','NOTDEFINED','ODORFILTER','OILFILTER','STRAINER','USERDEFINED','WATERFILTER');
        };
    }

    type IfcFireSuppressionTerminal extending IfcFlowTerminal {
        property PredefinedType -> str {
            constraint one_of ('BREECHINGINLET','FIREHYDRANT','HOSEREEL','NOTDEFINED','SPRINKLER','SPRINKLERDEFLECTOR','USERDEFINED');
        };
    }

    type IfcFireSuppressionTerminalType extending IfcFlowTerminalType {
        required property PredefinedType -> str {
            constraint one_of ('BREECHINGINLET','FIREHYDRANT','HOSEREEL','NOTDEFINED','SPRINKLER','SPRINKLERDEFLECTOR','USERDEFINED');
        };
    }

    type IfcFixedReferenceSweptAreaSolid extending IfcSweptAreaSolid {
        required link Directrix -> IfcCurve;
        property StartParam -> float64;
        property EndParam -> float64;
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
        property PredefinedType -> str {
            constraint one_of ('AMMETER','FREQUENCYMETER','NOTDEFINED','PHASEANGLEMETER','POWERFACTORMETER','PRESSUREGAUGE','THERMOMETER','USERDEFINED','VOLTMETER_PEAK','VOLTMETER_RMS');
        };
    }

    type IfcFlowInstrumentType extending IfcDistributionControlElementType {
        required property PredefinedType -> str {
            constraint one_of ('AMMETER','FREQUENCYMETER','NOTDEFINED','PHASEANGLEMETER','POWERFACTORMETER','PRESSUREGAUGE','THERMOMETER','USERDEFINED','VOLTMETER_PEAK','VOLTMETER_RMS');
        };
    }

    type IfcFlowMeter extending IfcFlowController {
        property PredefinedType -> str {
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

    type IfcFontStyle {
        required property `IfcFontStyle` -> str;
    }

    type IfcFontVariant {
        required property `IfcFontVariant` -> str;
    }

    type IfcFontWeight {
        required property `IfcFontWeight` -> str;
    }

    type IfcFooting extending IfcBuildingElement {
        property PredefinedType -> str {
            constraint one_of ('CAISSON_FOUNDATION','FOOTING_BEAM','NOTDEFINED','PAD_FOOTING','PILE_CAP','STRIP_FOOTING','USERDEFINED');
        };
    }

    type IfcFootingType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('CAISSON_FOUNDATION','FOOTING_BEAM','NOTDEFINED','PAD_FOOTING','PILE_CAP','STRIP_FOOTING','USERDEFINED');
        };
    }

    type IfcForceMeasure {
        required property `IfcForceMeasure` -> float64;
    }

    type IfcFrequencyMeasure {
        required property `IfcFrequencyMeasure` -> float64;
    }

    type IfcFurnishingElement extending IfcElement {
    }

    type IfcFurnishingElementType extending IfcElementType {
    }

    type IfcFurniture extending IfcFurnishingElement {
        property PredefinedType -> str {
            constraint one_of ('BED','CHAIR','DESK','FILECABINET','NOTDEFINED','SHELF','SOFA','TABLE','USERDEFINED');
        };
    }

    type IfcFurnitureType extending IfcFurnishingElementType {
        required property AssemblyPlace -> str {
            constraint one_of ('FACTORY','NOTDEFINED','SITE');
        };
        property PredefinedType -> str {
            constraint one_of ('BED','CHAIR','DESK','FILECABINET','NOTDEFINED','SHELF','SOFA','TABLE','USERDEFINED');
        };
    }

    type IfcGeographicElement extending IfcElement {
        property PredefinedType -> str {
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
        link WorldCoordinateSystem -> IfcAxis2Placement;
        link TrueNorth -> IfcDirection;
    }

    abstract type IfcGeometricRepresentationItem extending IfcRepresentationItem {
    }

    type IfcGeometricRepresentationSubContext extending IfcGeometricRepresentationContext {
        required link ParentContext -> IfcGeometricRepresentationContext;
        property TargetScale -> float64;
        required property TargetView -> str {
            constraint one_of ('ELEVATION_VIEW','GRAPH_VIEW','MODEL_VIEW','NOTDEFINED','PLAN_VIEW','REFLECTED_PLAN_VIEW','SECTION_VIEW','SKETCH_VIEW','USERDEFINED');
        };
        property UserDefinedTargetView -> str;
    }

    type IfcGeometricSet extending IfcGeometricRepresentationItem {
        required multi link Elements -> IfcGeometricSetSelect;
    }

    type IfcGeometricSetSelect {
        link IfcGeometricSetSelect -> IfcCurve | IfcPoint | IfcSurface;
    }

    type IfcGloballyUniqueId {
        required property `IfcGloballyUniqueId` -> str;
    }

    type IfcGrid extending IfcPositioningElement {
        required multi link UAxes -> IfcGridAxis;
        required multi link VAxes -> IfcGridAxis;
        multi link WAxes -> IfcGridAxis;
        property PredefinedType -> str {
            constraint one_of ('IRREGULAR','NOTDEFINED','RADIAL','RECTANGULAR','TRIANGULAR','USERDEFINED');
        };
    }

    type IfcGridAxis  {
        property AxisTag -> str;
        required link AxisCurve -> IfcCurve;
        required property SameSense -> bool;
    }

    type IfcGridPlacement extending IfcObjectPlacement {
        required link PlacementLocation -> IfcVirtualGridIntersection;
        link PlacementRefDirection -> IfcGridPlacementDirectionSelect;
    }

    type IfcGridPlacementDirectionSelect {
        link IfcGridPlacementDirectionSelect -> IfcDirection | IfcVirtualGridIntersection;
    }

    type IfcGroup extending IfcObject {
    }

    type IfcHalfSpaceSolid extending IfcGeometricRepresentationItem {
        required link BaseSurface -> IfcSurface;
        required property AgreementFlag -> bool;
    }

    type IfcHatchLineDistanceSelect {
        link IfcHatchLineDistanceSelect -> IfcPositiveLengthMeasure | IfcVector;
    }

    type IfcHeatExchanger extending IfcEnergyConversionDevice {
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','PLATE','SHELLANDTUBE','USERDEFINED');
        };
    }

    type IfcHeatExchangerType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','PLATE','SHELLANDTUBE','USERDEFINED');
        };
    }

    type IfcHeatFluxDensityMeasure {
        required property `IfcHeatFluxDensityMeasure` -> float64;
    }

    type IfcHeatingValueMeasure {
        required property `IfcHeatingValueMeasure` -> float64;
    }

    type IfcHumidifier extending IfcEnergyConversionDevice {
        property PredefinedType -> str {
            constraint one_of ('ADIABATICAIRWASHER','ADIABATICATOMIZING','ADIABATICCOMPRESSEDAIRNOZZLE','ADIABATICPAN','ADIABATICRIGIDMEDIA','ADIABATICULTRASONIC','ADIABATICWETTEDELEMENT','ASSISTEDBUTANE','ASSISTEDELECTRIC','ASSISTEDNATURALGAS','ASSISTEDPROPANE','ASSISTEDSTEAM','NOTDEFINED','STEAMINJECTION','USERDEFINED');
        };
    }

    type IfcHumidifierType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('ADIABATICAIRWASHER','ADIABATICATOMIZING','ADIABATICCOMPRESSEDAIRNOZZLE','ADIABATICPAN','ADIABATICRIGIDMEDIA','ADIABATICULTRASONIC','ADIABATICWETTEDELEMENT','ASSISTEDBUTANE','ASSISTEDELECTRIC','ASSISTEDNATURALGAS','ASSISTEDPROPANE','ASSISTEDSTEAM','NOTDEFINED','STEAMINJECTION','USERDEFINED');
        };
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

    type IfcIdentifier {
        required property `IfcIdentifier` -> str;
    }

    type IfcIlluminanceMeasure {
        required property `IfcIlluminanceMeasure` -> float64;
    }

    type IfcImageTexture extending IfcSurfaceTexture {
        required property URLReference -> str;
    }

    type IfcIndexedColourMap extending IfcPresentationItem {
        required link MappedTo -> IfcTessellatedFaceSet;
        property Opacity -> float64;
        required link Colours -> IfcColourRgbList;
        required property ColourIndex -> tuple<int64>;
    }

    type IfcIndexedPolyCurve extending IfcBoundedCurve {
        required link Points -> IfcCartesianPointList;
        multi link Segments -> IfcSegmentIndexSelect;
        property SelfIntersect -> bool;
    }

    type IfcIndexedPolygonalFace extending IfcTessellatedItem {
        required property CoordIndex -> tuple<int64, int64, int64>;
    }

    type IfcIndexedPolygonalFaceWithVoids extending IfcIndexedPolygonalFace {
        required property InnerCoordIndices -> array<tuple<int64, int64, int64>>;
    }

    abstract type IfcIndexedTextureMap extending IfcTextureCoordinate {
        required link MappedTo -> IfcTessellatedFaceSet;
        required link TexCoords -> IfcTextureVertexList;
    }

    type IfcIndexedTriangleTextureMap extending IfcIndexedTextureMap {
        property TexCoordIndex -> array<tuple<int64, int64, int64>>;
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

    type IfcInterceptor extending IfcFlowTreatmentDevice {
        property PredefinedType -> str {
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
        property PredefinedType -> str {
            constraint one_of ('ASSETINVENTORY','FURNITUREINVENTORY','NOTDEFINED','SPACEINVENTORY','USERDEFINED');
        };
        link Jurisdiction -> IfcActorSelect;
        multi link ResponsiblePersons -> IfcPerson;
        property LastUpdateDate -> str;
        link CurrentValue -> IfcCostValue;
        link OriginalValue -> IfcCostValue;
    }

    type IfcIonConcentrationMeasure {
        required property `IfcIonConcentrationMeasure` -> float64;
    }

    type IfcIrregularTimeSeries extending IfcTimeSeries {
        required multi link Values -> IfcIrregularTimeSeriesValue;
    }

    type IfcIrregularTimeSeriesValue  {
        required property TimeStamp -> str;
        required multi link ListValues -> IfcValue;
    }

    type IfcIsothermalMoistureCapacityMeasure {
        required property `IfcIsothermalMoistureCapacityMeasure` -> float64;
    }

    type IfcJunctionBox extending IfcFlowFitting {
        property PredefinedType -> str {
            constraint one_of ('DATA','NOTDEFINED','POWER','USERDEFINED');
        };
    }

    type IfcJunctionBoxType extending IfcFlowFittingType {
        required property PredefinedType -> str {
            constraint one_of ('DATA','NOTDEFINED','POWER','USERDEFINED');
        };
    }

    type IfcKinematicViscosityMeasure {
        required property `IfcKinematicViscosityMeasure` -> float64;
    }

    type IfcLShapeProfileDef extending IfcParameterizedProfileDef {
        required property Depth -> float64;
        property Width -> float64;
        required property Thickness -> float64;
        property FilletRadius -> float64;
        property EdgeRadius -> float64;
        property LegSlope -> float64;
    }

    type IfcLabel {
        required property `IfcLabel` -> str;
    }

    type IfcLaborResource extending IfcConstructionResource {
        property PredefinedType -> str {
            constraint one_of ('ADMINISTRATION','CARPENTRY','CLEANING','CONCRETE','DRYWALL','ELECTRIC','FINISHING','FLOORING','GENERAL','HVAC','LANDSCAPING','MASONRY','NOTDEFINED','PAINTING','PAVING','PLUMBING','ROOFING','SITEGRADING','STEELWORK','SURVEYING','USERDEFINED');
        };
    }

    type IfcLaborResourceType extending IfcConstructionResourceType {
        required property PredefinedType -> str {
            constraint one_of ('ADMINISTRATION','CARPENTRY','CLEANING','CONCRETE','DRYWALL','ELECTRIC','FINISHING','FLOORING','GENERAL','HVAC','LANDSCAPING','MASONRY','NOTDEFINED','PAINTING','PAVING','PLUMBING','ROOFING','SITEGRADING','STEELWORK','SURVEYING','USERDEFINED');
        };
    }

    type IfcLagTime extending IfcSchedulingTime {
        required link LagValue -> IfcTimeOrRatioSelect;
        required property DurationType -> str {
            constraint one_of ('ELAPSEDTIME','NOTDEFINED','WORKTIME');
        };
    }

    type IfcLamp extending IfcFlowTerminal {
        property PredefinedType -> str {
            constraint one_of ('COMPACTFLUORESCENT','FLUORESCENT','HALOGEN','HIGHPRESSUREMERCURY','HIGHPRESSURESODIUM','LED','METALHALIDE','NOTDEFINED','OLED','TUNGSTENFILAMENT','USERDEFINED');
        };
    }

    type IfcLampType extending IfcFlowTerminalType {
        required property PredefinedType -> str {
            constraint one_of ('COMPACTFLUORESCENT','FLUORESCENT','HALOGEN','HIGHPRESSUREMERCURY','HIGHPRESSURESODIUM','LED','METALHALIDE','NOTDEFINED','OLED','TUNGSTENFILAMENT','USERDEFINED');
        };
    }

    type IfcLanguageId {
        required property `IfcLanguageId` -> str;
    }

    type IfcLayeredItem {
        link IfcLayeredItem -> IfcRepresentation | IfcRepresentationItem;
    }

    type IfcLengthMeasure {
        required property `IfcLengthMeasure` -> float64;
    }

    type IfcLibraryInformation extending IfcExternalInformation {
        required property Name -> str;
        property Version -> str;
        link Publisher -> IfcActorSelect;
        property VersionDate -> str;
        property Location -> str;
        property Description -> str;
    }

    type IfcLibraryReference extending IfcExternalReference {
        property Description -> str;
        property Language -> str;
        link ReferencedLibrary -> IfcLibraryInformation;
    }

    type IfcLibrarySelect {
        link IfcLibrarySelect -> IfcLibraryInformation | IfcLibraryReference;
    }

    type IfcLightDistributionData  {
        required property MainPlaneAngle -> float64;
        required property SecondaryPlaneAngle -> tuple<float64>;
        required property LuminousIntensity -> tuple<float64>;
    }

    type IfcLightDistributionDataSourceSelect {
        link IfcLightDistributionDataSourceSelect -> IfcExternalReference | IfcLightIntensityDistribution;
    }

    type IfcLightFixture extending IfcFlowTerminal {
        property PredefinedType -> str {
            constraint one_of ('DIRECTIONSOURCE','NOTDEFINED','POINTSOURCE','SECURITYLIGHTING','USERDEFINED');
        };
    }

    type IfcLightFixtureType extending IfcFlowTerminalType {
        required property PredefinedType -> str {
            constraint one_of ('DIRECTIONSOURCE','NOTDEFINED','POINTSOURCE','SECURITYLIGHTING','USERDEFINED');
        };
    }

    type IfcLightIntensityDistribution  {
        required property LightDistributionCurve -> str {
            constraint one_of ('NOTDEFINED','TYPE_A','TYPE_B','TYPE_C');
        };
        required multi link DistributionData -> IfcLightDistributionData;
    }

    abstract type IfcLightSource extending IfcGeometricRepresentationItem {
        property Name -> str;
        required link LightColour -> IfcColourRgb;
        property AmbientIntensity -> float64;
        property Intensity -> float64;
    }

    type IfcLightSourceAmbient extending IfcLightSource {
    }

    type IfcLightSourceDirectional extending IfcLightSource {
        required link Orientation -> IfcDirection;
    }

    type IfcLightSourceGoniometric extending IfcLightSource {
        required link Position -> IfcAxis2Placement3D;
        link ColourAppearance -> IfcColourRgb;
        required property ColourTemperature -> float64;
        required property LuminousFlux -> float64;
        required property LightEmissionSource -> str {
            constraint one_of ('COMPACTFLUORESCENT','FLUORESCENT','HIGHPRESSUREMERCURY','HIGHPRESSURESODIUM','LIGHTEMITTINGDIODE','LOWPRESSURESODIUM','LOWVOLTAGEHALOGEN','MAINVOLTAGEHALOGEN','METALHALIDE','NOTDEFINED','TUNGSTENFILAMENT');
        };
        required link LightDistributionDataSource -> IfcLightDistributionDataSourceSelect;
    }

    type IfcLightSourcePositional extending IfcLightSource {
        required link Position -> IfcCartesianPoint;
        required property Radius -> float64;
        required property ConstantAttenuation -> float64;
        required property DistanceAttenuation -> float64;
        required property QuadricAttenuation -> float64;
    }

    type IfcLightSourceSpot extending IfcLightSourcePositional {
        required link Orientation -> IfcDirection;
        property ConcentrationExponent -> float64;
        required property SpreadAngle -> float64;
        required property BeamWidthAngle -> float64;
    }

    type IfcLine extending IfcCurve {
        required link Pnt -> IfcCartesianPoint;
        required link Dir -> IfcVector;
    }

    type IfcLineIndex {
        required property `IfcLineIndex` -> tuple<int64, int64>;
    }

    type IfcLineSegment2D extending IfcCurveSegment2D {
    }

    type IfcLinearForceMeasure {
        required property `IfcLinearForceMeasure` -> float64;
    }

    type IfcLinearMomentMeasure {
        required property `IfcLinearMomentMeasure` -> float64;
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

    type IfcLinearStiffnessMeasure {
        required property `IfcLinearStiffnessMeasure` -> float64;
    }

    type IfcLinearVelocityMeasure {
        required property `IfcLinearVelocityMeasure` -> float64;
    }

    type IfcLocalPlacement extending IfcObjectPlacement {
        link PlacementRelTo -> IfcObjectPlacement;
        required link RelativePlacement -> IfcAxis2Placement;
    }

    type IfcLogical {
        required property `IfcLogical` -> bool;
    }

    type IfcLoop extending IfcTopologicalRepresentationItem {
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

    type IfcMaterial extending IfcMaterialDefinition {
        required property Name -> str;
        property Description -> str;
        property Category -> str;
    }

    type IfcMaterialClassificationRelationship  {
        required multi link MaterialClassifications -> IfcClassificationSelect;
        required link ClassifiedMaterial -> IfcMaterial;
    }

    type IfcMaterialConstituent extending IfcMaterialDefinition {
        property Name -> str;
        property Description -> str;
        required link Material -> IfcMaterial;
        property Fraction -> float64;
        property Category -> str;
    }

    type IfcMaterialConstituentSet extending IfcMaterialDefinition {
        property Name -> str;
        property Description -> str;
        multi link MaterialConstituents -> IfcMaterialConstituent;
    }

    abstract type IfcMaterialDefinition  {
    }

    type IfcMaterialDefinitionRepresentation extending IfcProductRepresentation {
        required link RepresentedMaterial -> IfcMaterial;
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

    type IfcMaterialLayerSet extending IfcMaterialDefinition {
        required multi link MaterialLayers -> IfcMaterialLayer;
        property LayerSetName -> str;
        property Description -> str;
    }

    type IfcMaterialLayerSetUsage extending IfcMaterialUsageDefinition {
        required link ForLayerSet -> IfcMaterialLayerSet;
        required property LayerSetDirection -> str {
            constraint one_of ('AXIS1','AXIS2','AXIS3');
        };
        required property DirectionSense -> str {
            constraint one_of ('NEGATIVE','POSITIVE');
        };
        required property OffsetFromReferenceLine -> float64;
        property ReferenceExtent -> float64;
    }

    type IfcMaterialLayerWithOffsets extending IfcMaterialLayer {
        required property OffsetDirection -> str {
            constraint one_of ('AXIS1','AXIS2','AXIS3');
        };
        required multi property OffsetValues -> float64;
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

    type IfcMaterialProfileSet extending IfcMaterialDefinition {
        property Name -> str;
        property Description -> str;
        required multi link MaterialProfiles -> IfcMaterialProfile;
        link CompositeProfile -> IfcCompositeProfileDef;
    }

    type IfcMaterialProfileSetUsage extending IfcMaterialUsageDefinition {
        required link ForProfileSet -> IfcMaterialProfileSet;
        property CardinalPoint -> int64;
        property ReferenceExtent -> float64;
    }

    type IfcMaterialProfileSetUsageTapering extending IfcMaterialProfileSetUsage {
        required link ForProfileEndSet -> IfcMaterialProfileSet;
        property CardinalEndPoint -> int64;
    }

    type IfcMaterialProfileWithOffsets extending IfcMaterialProfile {
        required multi property OffsetValues -> float64;
    }

    type IfcMaterialProperties extending IfcExtendedProperties {
        required link Material -> IfcMaterialDefinition;
    }

    type IfcMaterialRelationship extending IfcResourceLevelRelationship {
        required link RelatingMaterial -> IfcMaterial;
        required multi link RelatedMaterials -> IfcMaterial;
        property Expression -> str;
    }

    type IfcMaterialSelect {
        link IfcMaterialSelect -> IfcMaterialDefinition | IfcMaterialList | IfcMaterialUsageDefinition;
    }

    abstract type IfcMaterialUsageDefinition  {
    }

    type IfcMeasureValue {
        link IfcMeasureValue -> IfcAmountOfSubstanceMeasure | IfcAreaMeasure | IfcComplexNumber | IfcContextDependentMeasure | IfcCountMeasure | IfcDescriptiveMeasure | IfcElectricCurrentMeasure | IfcLengthMeasure | IfcLuminousIntensityMeasure | IfcMassMeasure | IfcNonNegativeLengthMeasure | IfcNormalisedRatioMeasure | IfcNumericMeasure | IfcParameterValue | IfcPlaneAngleMeasure | IfcPositiveLengthMeasure | IfcPositivePlaneAngleMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure | IfcSolidAngleMeasure | IfcThermodynamicTemperatureMeasure | IfcTimeMeasure | IfcVolumeMeasure;
    }

    type IfcMeasureWithUnit  {
        required link ValueComponent -> IfcValue;
        required link UnitComponent -> IfcUnit;
    }

    type IfcMechanicalFastener extending IfcElementComponent {
        property NominalDiameter -> float64;
        property NominalLength -> float64;
        property PredefinedType -> str {
            constraint one_of ('ANCHORBOLT','BOLT','DOWEL','NAIL','NAILPLATE','NOTDEFINED','RIVET','SCREW','SHEARCONNECTOR','STAPLE','STUDSHEARCONNECTOR','USERDEFINED');
        };
    }

    type IfcMechanicalFastenerType extending IfcElementComponentType {
        required property PredefinedType -> str {
            constraint one_of ('ANCHORBOLT','BOLT','DOWEL','NAIL','NAILPLATE','NOTDEFINED','RIVET','SCREW','SHEARCONNECTOR','STAPLE','STUDSHEARCONNECTOR','USERDEFINED');
        };
        property NominalDiameter -> float64;
        property NominalLength -> float64;
    }

    type IfcMedicalDevice extending IfcFlowTerminal {
        property PredefinedType -> str {
            constraint one_of ('AIRSTATION','FEEDAIRUNIT','NOTDEFINED','OXYGENGENERATOR','OXYGENPLANT','USERDEFINED','VACUUMSTATION');
        };
    }

    type IfcMedicalDeviceType extending IfcFlowTerminalType {
        required property PredefinedType -> str {
            constraint one_of ('AIRSTATION','FEEDAIRUNIT','NOTDEFINED','OXYGENGENERATOR','OXYGENPLANT','USERDEFINED','VACUUMSTATION');
        };
    }

    type IfcMember extending IfcBuildingElement {
        property PredefinedType -> str {
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
        required property Benchmark -> str {
            constraint one_of ('EQUALTO','GREATERTHAN','GREATERTHANOREQUALTO','INCLUDEDIN','INCLUDES','LESSTHAN','LESSTHANOREQUALTO','NOTEQUALTO','NOTINCLUDEDIN','NOTINCLUDES');
        };
        property ValueSource -> str;
        link DataValue -> IfcMetricValueSelect;
        link ReferencePath -> IfcReference;
    }

    type IfcMetricValueSelect {
        link IfcMetricValueSelect -> IfcAppliedValue | IfcMeasureWithUnit | IfcReference | IfcTable | IfcTimeSeries | IfcAbsorbedDoseMeasure | IfcAccelerationMeasure | IfcAngularVelocityMeasure | IfcAreaDensityMeasure | IfcCompoundPlaneAngleMeasure | IfcCurvatureMeasure | IfcDoseEquivalentMeasure | IfcDynamicViscosityMeasure | IfcElectricCapacitanceMeasure | IfcElectricChargeMeasure | IfcElectricConductanceMeasure | IfcElectricResistanceMeasure | IfcElectricVoltageMeasure | IfcEnergyMeasure | IfcForceMeasure | IfcFrequencyMeasure | IfcHeatFluxDensityMeasure | IfcHeatingValueMeasure | IfcIlluminanceMeasure | IfcInductanceMeasure | IfcIntegerCountRateMeasure | IfcIonConcentrationMeasure | IfcIsothermalMoistureCapacityMeasure | IfcKinematicViscosityMeasure | IfcLinearForceMeasure | IfcLinearMomentMeasure | IfcLinearStiffnessMeasure | IfcLinearVelocityMeasure | IfcLuminousFluxMeasure | IfcLuminousIntensityDistributionMeasure | IfcMagneticFluxDensityMeasure | IfcMagneticFluxMeasure | IfcMassDensityMeasure | IfcMassFlowRateMeasure | IfcMassPerLengthMeasure | IfcModulusOfElasticityMeasure | IfcModulusOfLinearSubgradeReactionMeasure | IfcModulusOfRotationalSubgradeReactionMeasure | IfcModulusOfSubgradeReactionMeasure | IfcMoistureDiffusivityMeasure | IfcMolecularWeightMeasure | IfcMomentOfInertiaMeasure | IfcMonetaryMeasure | IfcPHMeasure | IfcPlanarForceMeasure | IfcPowerMeasure | IfcPressureMeasure | IfcRadioActivityMeasure | IfcRotationalFrequencyMeasure | IfcRotationalMassMeasure | IfcRotationalStiffnessMeasure | IfcSectionModulusMeasure | IfcSectionalAreaIntegralMeasure | IfcShearModulusMeasure | IfcSoundPowerLevelMeasure | IfcSoundPowerMeasure | IfcSoundPressureLevelMeasure | IfcSoundPressureMeasure | IfcSpecificHeatCapacityMeasure | IfcTemperatureGradientMeasure | IfcTemperatureRateOfChangeMeasure | IfcThermalAdmittanceMeasure | IfcThermalConductivityMeasure | IfcThermalExpansionCoefficientMeasure | IfcThermalResistanceMeasure | IfcThermalTransmittanceMeasure | IfcTorqueMeasure | IfcVaporPermeabilityMeasure | IfcVolumetricFlowRateMeasure | IfcWarpingConstantMeasure | IfcWarpingMomentMeasure | IfcAmountOfSubstanceMeasure | IfcAreaMeasure | IfcComplexNumber | IfcContextDependentMeasure | IfcCountMeasure | IfcDescriptiveMeasure | IfcElectricCurrentMeasure | IfcLengthMeasure | IfcLuminousIntensityMeasure | IfcMassMeasure | IfcNonNegativeLengthMeasure | IfcNormalisedRatioMeasure | IfcNumericMeasure | IfcParameterValue | IfcPlaneAngleMeasure | IfcPositiveLengthMeasure | IfcPositivePlaneAngleMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure | IfcSolidAngleMeasure | IfcThermodynamicTemperatureMeasure | IfcTimeMeasure | IfcVolumeMeasure | IfcBinary | IfcBoolean | IfcDate | IfcDateTime | IfcDuration | IfcIdentifier | IfcInteger | IfcLabel | IfcLogical | IfcPositiveInteger | IfcReal | IfcText | IfcTime | IfcTimeStamp;
    }

    type IfcMirroredProfileDef extending IfcDerivedProfileDef {
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

    type IfcModulusOfRotationalSubgradeReactionSelect {
        link IfcModulusOfRotationalSubgradeReactionSelect -> IfcBoolean | IfcModulusOfRotationalSubgradeReactionMeasure;
    }

    type IfcModulusOfSubgradeReactionMeasure {
        required property `IfcModulusOfSubgradeReactionMeasure` -> float64;
    }

    type IfcModulusOfSubgradeReactionSelect {
        link IfcModulusOfSubgradeReactionSelect -> IfcBoolean | IfcModulusOfSubgradeReactionMeasure;
    }

    type IfcModulusOfTranslationalSubgradeReactionSelect {
        link IfcModulusOfTranslationalSubgradeReactionSelect -> IfcBoolean | IfcModulusOfLinearSubgradeReactionMeasure;
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

    type IfcMonthInYearNumber {
        required property `IfcMonthInYearNumber` -> int64;
    }

    type IfcMotorConnection extending IfcEnergyConversionDevice {
        property PredefinedType -> str {
            constraint one_of ('BELTDRIVE','COUPLING','DIRECTDRIVE','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcMotorConnectionType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('BELTDRIVE','COUPLING','DIRECTDRIVE','NOTDEFINED','USERDEFINED');
        };
    }

    abstract type IfcNamedUnit  {
        link Dimensions -> IfcDimensionalExponents;
        required property UnitType -> str {
            constraint one_of ('ABSORBEDDOSEUNIT','AMOUNTOFSUBSTANCEUNIT','AREAUNIT','DOSEEQUIVALENTUNIT','ELECTRICCAPACITANCEUNIT','ELECTRICCHARGEUNIT','ELECTRICCONDUCTANCEUNIT','ELECTRICCURRENTUNIT','ELECTRICRESISTANCEUNIT','ELECTRICVOLTAGEUNIT','ENERGYUNIT','FORCEUNIT','FREQUENCYUNIT','ILLUMINANCEUNIT','INDUCTANCEUNIT','LENGTHUNIT','LUMINOUSFLUXUNIT','LUMINOUSINTENSITYUNIT','MAGNETICFLUXDENSITYUNIT','MAGNETICFLUXUNIT','MASSUNIT','PLANEANGLEUNIT','POWERUNIT','PRESSUREUNIT','RADIOACTIVITYUNIT','SOLIDANGLEUNIT','THERMODYNAMICTEMPERATUREUNIT','TIMEUNIT','USERDEFINED','VOLUMEUNIT');
        };
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

    abstract type IfcObject extending IfcObjectDefinition {
        property ObjectType -> str;
    }

    abstract type IfcObjectDefinition extending IfcRoot {
    }

    abstract type IfcObjectPlacement  {
    }

    type IfcObjectReferenceSelect {
        link IfcObjectReferenceSelect -> IfcAddress | IfcAppliedValue | IfcExternalReference | IfcMaterialDefinition | IfcOrganization | IfcPerson | IfcPersonAndOrganization | IfcTable | IfcTimeSeries;
    }

    type IfcObjective extending IfcConstraint {
        multi link BenchmarkValues -> IfcConstraint;
        property LogicalAggregator -> str {
            constraint one_of ('LOGICALAND','LOGICALNOTAND','LOGICALNOTOR','LOGICALOR','LOGICALXOR');
        };
        required property ObjectiveQualifier -> str {
            constraint one_of ('CODECOMPLIANCE','CODEWAIVER','DESIGNINTENT','EXTERNAL','HEALTHANDSAFETY','MERGECONFLICT','MODELVIEW','NOTDEFINED','PARAMETER','REQUIREMENT','SPECIFICATION','TRIGGERCONDITION','USERDEFINED');
        };
        property UserDefinedQualifier -> str;
    }

    type IfcOccupant extending IfcActor {
        property PredefinedType -> str {
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
        required multi link OffsetValues -> IfcDistanceExpression;
        property Tag -> str;
    }

    type IfcOpenShell extending IfcConnectedFaceSet {
    }

    type IfcOpeningElement extending IfcFeatureElementSubtraction {
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','OPENING','RECESS','USERDEFINED');
        };
    }

    type IfcOpeningStandardCase extending IfcOpeningElement {
    }

    type IfcOrganization  {
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
        required link EdgeElement -> IfcEdge;
        required property Orientation -> bool;
    }

    type IfcOuterBoundaryCurve extending IfcBoundaryCurve {
    }

    type IfcOutlet extending IfcFlowTerminal {
        property PredefinedType -> str {
            constraint one_of ('AUDIOVISUALOUTLET','COMMUNICATIONSOUTLET','DATAOUTLET','NOTDEFINED','POWEROUTLET','TELEPHONEOUTLET','USERDEFINED');
        };
    }

    type IfcOutletType extending IfcFlowTerminalType {
        required property PredefinedType -> str {
            constraint one_of ('AUDIOVISUALOUTLET','COMMUNICATIONSOUTLET','DATAOUTLET','NOTDEFINED','POWEROUTLET','TELEPHONEOUTLET','USERDEFINED');
        };
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

    type IfcPHMeasure {
        required property `IfcPHMeasure` -> float64;
    }

    type IfcParameterValue {
        required property `IfcParameterValue` -> float64;
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
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcPermeableCoveringProperties extending IfcPreDefinedPropertySet {
        required property OperationType -> str {
            constraint one_of ('GRILL','LOUVER','NOTDEFINED','SCREEN','USERDEFINED');
        };
        required property PanelPosition -> str {
            constraint one_of ('BOTTOM','LEFT','MIDDLE','NOTDEFINED','RIGHT','TOP');
        };
        property FrameDepth -> float64;
        property FrameThickness -> float64;
        link ShapeAspectStyle -> IfcShapeAspect;
    }

    type IfcPermit extending IfcControl {
        property PredefinedType -> str {
            constraint one_of ('ACCESS','BUILDING','NOTDEFINED','USERDEFINED','WORK');
        };
        property Status -> str;
        property LongDescription -> str;
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

    type IfcPersonAndOrganization  {
        required link ThePerson -> IfcPerson;
        required link TheOrganization -> IfcOrganization;
        multi link Roles -> IfcActorRole;
    }

    type IfcPhysicalComplexQuantity extending IfcPhysicalQuantity {
        required multi link HasQuantities -> IfcPhysicalQuantity;
        required property Discrimination -> str;
        property Quality -> str;
        property Usage -> str;
    }

    abstract type IfcPhysicalQuantity  {
        required property Name -> str;
        property Description -> str;
    }

    abstract type IfcPhysicalSimpleQuantity extending IfcPhysicalQuantity {
        link Unit -> IfcNamedUnit;
    }

    type IfcPile extending IfcBuildingElement {
        property PredefinedType -> str {
            constraint one_of ('BORED','COHESION','DRIVEN','FRICTION','JETGROUTING','NOTDEFINED','SUPPORT','USERDEFINED');
        };
        property ConstructionType -> str {
            constraint one_of ('CAST_IN_PLACE','COMPOSITE','NOTDEFINED','PRECAST_CONCRETE','PREFAB_STEEL','USERDEFINED');
        };
    }

    type IfcPileType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('BORED','COHESION','DRIVEN','FRICTION','JETGROUTING','NOTDEFINED','SUPPORT','USERDEFINED');
        };
    }

    type IfcPipeFitting extending IfcFlowFitting {
        property PredefinedType -> str {
            constraint one_of ('BEND','CONNECTOR','ENTRY','EXIT','JUNCTION','NOTDEFINED','OBSTRUCTION','TRANSITION','USERDEFINED');
        };
    }

    type IfcPipeFittingType extending IfcFlowFittingType {
        required property PredefinedType -> str {
            constraint one_of ('BEND','CONNECTOR','ENTRY','EXIT','JUNCTION','NOTDEFINED','OBSTRUCTION','TRANSITION','USERDEFINED');
        };
    }

    type IfcPipeSegment extending IfcFlowSegment {
        property PredefinedType -> str {
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
        required link Placement -> IfcAxis2Placement;
    }

    type IfcPlanarExtent extending IfcGeometricRepresentationItem {
        required property SizeInX -> float64;
        required property SizeInY -> float64;
    }

    type IfcPlanarForceMeasure {
        required property `IfcPlanarForceMeasure` -> float64;
    }

    type IfcPlane extending IfcElementarySurface {
    }

    type IfcPlaneAngleMeasure {
        required property `IfcPlaneAngleMeasure` -> float64;
    }

    type IfcPlate extending IfcBuildingElement {
        property PredefinedType -> str {
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
        required link BasisCurve -> IfcCurve;
        required property PointParameter -> float64;
    }

    type IfcPointOnSurface extending IfcPoint {
        required link BasisSurface -> IfcSurface;
        required property PointParameterU -> float64;
        required property PointParameterV -> float64;
    }

    type IfcPointOrVertexPoint {
        link IfcPointOrVertexPoint -> IfcPoint | IfcVertexPoint;
    }

    type IfcPolyLoop extending IfcLoop {
        required multi link Polygon -> IfcCartesianPoint;
    }

    type IfcPolygonalBoundedHalfSpace extending IfcHalfSpaceSolid {
        required link Position -> IfcAxis2Placement3D;
        required link PolygonalBoundary -> IfcBoundedCurve;
    }

    type IfcPolygonalFaceSet extending IfcTessellatedFaceSet {
        property Closed -> bool;
        required multi link Faces -> IfcIndexedPolygonalFace;
        property PnIndex -> tuple<int64>;
    }

    type IfcPolyline extending IfcBoundedCurve {
        required multi link Points -> IfcCartesianPoint;
    }

    abstract type IfcPort extending IfcProduct {
    }

    abstract type IfcPositioningElement extending IfcProduct {
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

    type IfcPostalAddress extending IfcAddress {
        property InternalLocation -> str;
        property AddressLines -> tuple<str>;
        property PostalBox -> str;
        property Town -> str;
        property Region -> str;
        property PostalCode -> str;
        property Country -> str;
    }

    type IfcPowerMeasure {
        required property `IfcPowerMeasure` -> float64;
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

    type IfcPresentableText {
        required property `IfcPresentableText` -> str;
    }

    abstract type IfcPresentationItem  {
    }

    type IfcPresentationLayerAssignment  {
        required property Name -> str;
        property Description -> str;
        required multi link AssignedItems -> IfcLayeredItem;
        property Identifier -> str;
    }

    type IfcPresentationLayerWithStyle extending IfcPresentationLayerAssignment {
        required property LayerOn -> bool;
        required property LayerFrozen -> bool;
        required property LayerBlocked -> bool;
        required multi link LayerStyles -> IfcPresentationStyle;
    }

    abstract type IfcPresentationStyle  {
        property Name -> str;
    }

    type IfcPresentationStyleAssignment  {
        required multi link Styles -> IfcPresentationStyleSelect;
    }

    type IfcPresentationStyleSelect {
        link IfcPresentationStyleSelect -> IfcCurveStyle | IfcFillAreaStyle | IfcNullStyle | IfcSurfaceStyle | IfcTextStyle;
    }

    type IfcPressureMeasure {
        required property `IfcPressureMeasure` -> float64;
    }

    type IfcProcedure extending IfcProcess {
        property PredefinedType -> str {
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

    type IfcProcessSelect {
        link IfcProcessSelect -> IfcProcess | IfcTypeProcess;
    }

    abstract type IfcProduct extending IfcObject {
        link ObjectPlacement -> IfcObjectPlacement;
        link Representation -> IfcProductRepresentation;
    }

    type IfcProductDefinitionShape extending IfcProductRepresentation {
    }

    abstract type IfcProductRepresentation  {
        property Name -> str;
        property Description -> str;
        required multi link Representations -> IfcRepresentation;
    }

    type IfcProductRepresentationSelect {
        link IfcProductRepresentationSelect -> IfcProductDefinitionShape | IfcRepresentationMap;
    }

    type IfcProductSelect {
        link IfcProductSelect -> IfcProduct | IfcTypeProduct;
    }

    type IfcProfileDef  {
        required property ProfileType -> str {
            constraint one_of ('AREA','CURVE');
        };
        property ProfileName -> str;
    }

    type IfcProfileProperties extending IfcExtendedProperties {
        required link ProfileDefinition -> IfcProfileDef;
    }

    type IfcProject extending IfcContext {
    }

    type IfcProjectLibrary extending IfcContext {
    }

    type IfcProjectOrder extending IfcControl {
        property PredefinedType -> str {
            constraint one_of ('CHANGEORDER','MAINTENANCEWORKORDER','MOVEORDER','NOTDEFINED','PURCHASEORDER','USERDEFINED','WORKORDER');
        };
        property Status -> str;
        property LongDescription -> str;
    }

    type IfcProjectedCRS extending IfcCoordinateReferenceSystem {
        property MapProjection -> str;
        property MapZone -> str;
        link MapUnit -> IfcNamedUnit;
    }

    type IfcProjectionElement extending IfcFeatureElementAddition {
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    abstract type IfcProperty extending IfcPropertyAbstraction {
        required property Name -> str;
        property Description -> str;
    }

    abstract type IfcPropertyAbstraction  {
    }

    type IfcPropertyBoundedValue extending IfcSimpleProperty {
        link UpperBoundValue -> IfcValue;
        link LowerBoundValue -> IfcValue;
        link Unit -> IfcUnit;
        link SetPointValue -> IfcValue;
    }

    abstract type IfcPropertyDefinition extending IfcRoot {
    }

    type IfcPropertyDependencyRelationship extending IfcResourceLevelRelationship {
        required link DependingProperty -> IfcProperty;
        required link DependantProperty -> IfcProperty;
        property Expression -> str;
    }

    type IfcPropertyEnumeratedValue extending IfcSimpleProperty {
        multi link EnumerationValues -> IfcValue;
        link EnumerationReference -> IfcPropertyEnumeration;
    }

    type IfcPropertyEnumeration extending IfcPropertyAbstraction {
        required property Name -> str;
        required multi link EnumerationValues -> IfcValue;
        link Unit -> IfcUnit;
    }

    type IfcPropertyListValue extending IfcSimpleProperty {
        multi link ListValues -> IfcValue;
        link Unit -> IfcUnit;
    }

    type IfcPropertyReferenceValue extending IfcSimpleProperty {
        property UsageName -> str;
        link PropertyReference -> IfcObjectReferenceSelect;
    }

    type IfcPropertySet extending IfcPropertySetDefinition {
        required multi link HasProperties -> IfcProperty;
    }

    abstract type IfcPropertySetDefinition extending IfcPropertyDefinition {
    }

    type IfcPropertySetDefinitionSelect {
        link IfcPropertySetDefinitionSelect -> IfcPropertySetDefinition | IfcPropertySetDefinitionSet;
    }

    type IfcPropertySetDefinitionSet {
        required multi link `IfcPropertySetDefinitionSet` -> IfcPropertySetDefinition;
    }

    type IfcPropertySetTemplate extending IfcPropertyTemplateDefinition {
        property TemplateType -> str {
            constraint one_of ('NOTDEFINED','PSET_OCCURRENCEDRIVEN','PSET_PERFORMANCEDRIVEN','PSET_TYPEDRIVENONLY','PSET_TYPEDRIVENOVERRIDE','QTO_OCCURRENCEDRIVEN','QTO_TYPEDRIVENONLY','QTO_TYPEDRIVENOVERRIDE');
        };
        property ApplicableEntity -> str;
        required multi link HasPropertyTemplates -> IfcPropertyTemplate;
    }

    type IfcPropertySingleValue extending IfcSimpleProperty {
        link NominalValue -> IfcValue;
        link Unit -> IfcUnit;
    }

    type IfcPropertyTableValue extending IfcSimpleProperty {
        multi link DefiningValues -> IfcValue;
        multi link DefinedValues -> IfcValue;
        property Expression -> str;
        link DefiningUnit -> IfcUnit;
        link DefinedUnit -> IfcUnit;
        property CurveInterpolation -> str {
            constraint one_of ('LINEAR','LOG_LINEAR','LOG_LOG','NOTDEFINED');
        };
    }

    abstract type IfcPropertyTemplate extending IfcPropertyTemplateDefinition {
    }

    abstract type IfcPropertyTemplateDefinition extending IfcPropertyDefinition {
    }

    type IfcProtectiveDevice extending IfcFlowController {
        property PredefinedType -> str {
            constraint one_of ('CIRCUITBREAKER','EARTHINGSWITCH','EARTHLEAKAGECIRCUITBREAKER','FUSEDISCONNECTOR','NOTDEFINED','RESIDUALCURRENTCIRCUITBREAKER','RESIDUALCURRENTSWITCH','USERDEFINED','VARISTOR');
        };
    }

    type IfcProtectiveDeviceTrippingUnit extending IfcDistributionControlElement {
        property PredefinedType -> str {
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
        required property ProxyType -> str {
            constraint one_of ('ACTOR','CONTROL','GROUP','NOTDEFINED','PROCESS','PRODUCT','PROJECT','RESOURCE');
        };
        property Tag -> str;
    }

    type IfcPump extending IfcFlowMovingDevice {
        property PredefinedType -> str {
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

    type IfcRadioActivityMeasure {
        required property `IfcRadioActivityMeasure` -> float64;
    }

    type IfcRailing extending IfcBuildingElement {
        property PredefinedType -> str {
            constraint one_of ('BALUSTRADE','GUARDRAIL','HANDRAIL','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcRailingType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('BALUSTRADE','GUARDRAIL','HANDRAIL','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcRamp extending IfcBuildingElement {
        property PredefinedType -> str {
            constraint one_of ('HALF_TURN_RAMP','NOTDEFINED','QUARTER_TURN_RAMP','SPIRAL_RAMP','STRAIGHT_RUN_RAMP','TWO_QUARTER_TURN_RAMP','TWO_STRAIGHT_RUN_RAMP','USERDEFINED');
        };
    }

    type IfcRampFlight extending IfcBuildingElement {
        property PredefinedType -> str {
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

    type IfcRatioMeasure {
        required property `IfcRatioMeasure` -> float64;
    }

    type IfcRationalBSplineCurveWithKnots extending IfcBSplineCurveWithKnots {
        required property WeightsData -> tuple<float64, float64>;
    }

    type IfcRationalBSplineSurfaceWithKnots extending IfcBSplineSurfaceWithKnots {
        required property WeightsData -> array<tuple<float64, float64>>;
    }

    type IfcReal {
        required property `IfcReal` -> float64;
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
        required link BasisSurface -> IfcSurface;
        required property U1 -> float64;
        required property V1 -> float64;
        required property U2 -> float64;
        required property V2 -> float64;
        required property Usense -> bool;
        required property Vsense -> bool;
    }

    type IfcRecurrencePattern  {
        required property RecurrenceType -> str {
            constraint one_of ('BY_DAY_COUNT','BY_WEEKDAY_COUNT','DAILY','MONTHLY_BY_DAY_OF_MONTH','MONTHLY_BY_POSITION','WEEKLY','YEARLY_BY_DAY_OF_MONTH','YEARLY_BY_POSITION');
        };
        multi property DayComponent -> int64;
        multi property WeekdayComponent -> int64;
        multi property MonthComponent -> int64;
        property Position -> int64;
        property Interval -> int64;
        property Occurrences -> int64;
        multi link TimePeriods -> IfcTimePeriod;
    }

    type IfcReference  {
        property TypeIdentifier -> str;
        property AttributeIdentifier -> str;
        property InstanceName -> str;
        property ListPositions -> tuple<int64>;
        link InnerReference -> IfcReference;
    }

    type IfcReferent extending IfcPositioningElement {
        property PredefinedType -> str {
            constraint one_of ('KILOPOINT','MILEPOINT','NOTDEFINED','STATION','USERDEFINED');
        };
        property RestartDistance -> float64;
    }

    type IfcRegularTimeSeries extending IfcTimeSeries {
        required property TimeStep -> float64;
        required multi link Values -> IfcTimeSeriesValue;
    }

    type IfcReinforcementBarProperties extending IfcPreDefinedProperties {
        required property TotalCrossSectionArea -> float64;
        required property SteelGrade -> str;
        property BarSurface -> str {
            constraint one_of ('PLAIN','TEXTURED');
        };
        property EffectiveDepth -> float64;
        property NominalBarDiameter -> float64;
        property BarCount -> int64;
    }

    type IfcReinforcementDefinitionProperties extending IfcPreDefinedPropertySet {
        property DefinitionType -> str;
        required multi link ReinforcementSectionDefinitions -> IfcSectionReinforcementProperties;
    }

    type IfcReinforcingBar extending IfcReinforcingElement {
        property NominalDiameter -> float64;
        property CrossSectionArea -> float64;
        property BarLength -> float64;
        property PredefinedType -> str {
            constraint one_of ('ANCHORING','EDGE','LIGATURE','MAIN','NOTDEFINED','PUNCHING','RING','SHEAR','STUD','USERDEFINED');
        };
        property BarSurface -> str {
            constraint one_of ('PLAIN','TEXTURED');
        };
    }

    type IfcReinforcingBarType extending IfcReinforcingElementType {
        required property PredefinedType -> str {
            constraint one_of ('ANCHORING','EDGE','LIGATURE','MAIN','NOTDEFINED','PUNCHING','RING','SHEAR','STUD','USERDEFINED');
        };
        property NominalDiameter -> float64;
        property CrossSectionArea -> float64;
        property BarLength -> float64;
        property BarSurface -> str {
            constraint one_of ('PLAIN','TEXTURED');
        };
        property BendingShapeCode -> str;
        multi link BendingParameters -> IfcBendingParameterSelect;
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
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
    }

    type IfcReinforcingMeshType extending IfcReinforcingElementType {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','USERDEFINED');
        };
        property MeshLength -> float64;
        property MeshWidth -> float64;
        property LongitudinalBarNominalDiameter -> float64;
        property TransverseBarNominalDiameter -> float64;
        property LongitudinalBarCrossSectionArea -> float64;
        property TransverseBarCrossSectionArea -> float64;
        property LongitudinalBarSpacing -> float64;
        property TransverseBarSpacing -> float64;
        property BendingShapeCode -> str;
        multi link BendingParameters -> IfcBendingParameterSelect;
    }

    type IfcRelAggregates extending IfcRelDecomposes {
        required link RelatingObject -> IfcObjectDefinition;
        required multi link RelatedObjects -> IfcObjectDefinition;
    }

    abstract type IfcRelAssigns extending IfcRelationship {
        required multi link RelatedObjects -> IfcObjectDefinition;
        property RelatedObjectsType -> str {
            constraint one_of ('ACTOR','CONTROL','GROUP','NOTDEFINED','PROCESS','PRODUCT','PROJECT','RESOURCE');
        };
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
        required link RelatingProcess -> IfcProcessSelect;
        link QuantityInProcess -> IfcMeasureWithUnit;
    }

    type IfcRelAssignsToProduct extending IfcRelAssigns {
        required link RelatingProduct -> IfcProductSelect;
    }

    type IfcRelAssignsToResource extending IfcRelAssigns {
        required link RelatingResource -> IfcResourceSelect;
    }

    abstract type IfcRelAssociates extending IfcRelationship {
        required multi link RelatedObjects -> IfcDefinitionSelect;
    }

    type IfcRelAssociatesApproval extending IfcRelAssociates {
        required link RelatingApproval -> IfcApproval;
    }

    type IfcRelAssociatesClassification extending IfcRelAssociates {
        required link RelatingClassification -> IfcClassificationSelect;
    }

    type IfcRelAssociatesConstraint extending IfcRelAssociates {
        property Intent -> str;
        required link RelatingConstraint -> IfcConstraint;
    }

    type IfcRelAssociatesDocument extending IfcRelAssociates {
        required link RelatingDocument -> IfcDocumentSelect;
    }

    type IfcRelAssociatesLibrary extending IfcRelAssociates {
        required link RelatingLibrary -> IfcLibrarySelect;
    }

    type IfcRelAssociatesMaterial extending IfcRelAssociates {
        required link RelatingMaterial -> IfcMaterialSelect;
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

    type IfcRelConnectsPortToElement extending IfcRelConnects {
        required link RelatingPort -> IfcPort;
        required link RelatedElement -> IfcDistributionElement;
    }

    type IfcRelConnectsPorts extending IfcRelConnects {
        required link RelatingPort -> IfcPort;
        required link RelatedPort -> IfcPort;
        link RealizingElement -> IfcElement;
    }

    type IfcRelConnectsStructuralActivity extending IfcRelConnects {
        required link RelatingElement -> IfcStructuralActivityAssignmentSelect;
        required link RelatedStructuralActivity -> IfcStructuralActivity;
    }

    type IfcRelConnectsStructuralMember extending IfcRelConnects {
        required link RelatingStructuralMember -> IfcStructuralMember;
        required link RelatedStructuralConnection -> IfcStructuralConnection;
        link AppliedCondition -> IfcBoundaryCondition;
        link AdditionalConditions -> IfcStructuralConnectionCondition;
        property SupportedLength -> float64;
        link ConditionCoordinateSystem -> IfcAxis2Placement3D;
    }

    type IfcRelConnectsWithEccentricity extending IfcRelConnectsStructuralMember {
        required link ConnectionConstraint -> IfcConnectionGeometry;
    }

    type IfcRelConnectsWithRealizingElements extending IfcRelConnectsElements {
        required multi link RealizingElements -> IfcElement;
        property ConnectionType -> str;
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
        required multi link RelatedDefinitions -> IfcDefinitionSelect;
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
        required link RelatingPropertyDefinition -> IfcPropertySetDefinitionSelect;
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
        required link RelatingElement -> IfcElement;
        required link RelatedElement -> IfcElement;
        link InterferenceGeometry -> IfcConnectionGeometry;
        property InterferenceType -> str;
        required property ImpliedOrder -> bool;
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
        required link RelatingProcess -> IfcProcess;
        required link RelatedProcess -> IfcProcess;
        link TimeLag -> IfcLagTime;
        property SequenceType -> str {
            constraint one_of ('FINISH_FINISH','FINISH_START','NOTDEFINED','START_FINISH','START_START','USERDEFINED');
        };
        property UserDefinedSequenceType -> str;
    }

    type IfcRelServicesBuildings extending IfcRelConnects {
        required link RelatingSystem -> IfcSystem;
        required multi link RelatedBuildings -> IfcSpatialElement;
    }

    type IfcRelSpaceBoundary extending IfcRelConnects {
        required link RelatingSpace -> IfcSpaceBoundarySelect;
        required link RelatedBuildingElement -> IfcElement;
        link ConnectionGeometry -> IfcConnectionGeometry;
        required property PhysicalOrVirtualBoundary -> str {
            constraint one_of ('NOTDEFINED','PHYSICAL','VIRTUAL');
        };
        required property InternalOrExternalBoundary -> str {
            constraint one_of ('EXTERNAL','EXTERNAL_EARTH','EXTERNAL_FIRE','EXTERNAL_WATER','INTERNAL','NOTDEFINED');
        };
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

    abstract type IfcRelationship extending IfcRoot {
    }

    type IfcReparametrisedCompositeCurveSegment extending IfcCompositeCurveSegment {
        required property ParamLength -> float64;
    }

    abstract type IfcRepresentation  {
        required link ContextOfItems -> IfcRepresentationContext;
        property RepresentationIdentifier -> str;
        property RepresentationType -> str;
        required multi link Items -> IfcRepresentationItem;
    }

    abstract type IfcRepresentationContext  {
        property ContextIdentifier -> str;
        property ContextType -> str;
    }

    abstract type IfcRepresentationItem  {
    }

    type IfcRepresentationMap  {
        required link MappingOrigin -> IfcAxis2Placement;
        required link MappedRepresentation -> IfcRepresentation;
    }

    abstract type IfcResource extending IfcObject {
        property Identification -> str;
        property LongDescription -> str;
    }

    type IfcResourceApprovalRelationship extending IfcResourceLevelRelationship {
        required multi link RelatedResourceObjects -> IfcResourceObjectSelect;
        required link RelatingApproval -> IfcApproval;
    }

    type IfcResourceConstraintRelationship extending IfcResourceLevelRelationship {
        required link RelatingConstraint -> IfcConstraint;
        required multi link RelatedResourceObjects -> IfcResourceObjectSelect;
    }

    abstract type IfcResourceLevelRelationship  {
        property Name -> str;
        property Description -> str;
    }

    type IfcResourceObjectSelect {
        link IfcResourceObjectSelect -> IfcActorRole | IfcAppliedValue | IfcApproval | IfcConstraint | IfcContextDependentUnit | IfcConversionBasedUnit | IfcExternalInformation | IfcExternalReference | IfcMaterialDefinition | IfcOrganization | IfcPerson | IfcPersonAndOrganization | IfcPhysicalQuantity | IfcProfileDef | IfcPropertyAbstraction | IfcShapeAspect | IfcTimeSeries;
    }

    type IfcResourceSelect {
        link IfcResourceSelect -> IfcResource | IfcTypeResource;
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
        required link Axis -> IfcAxis1Placement;
        required property Angle -> float64;
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
        property PredefinedType -> str {
            constraint one_of ('BARREL_ROOF','BUTTERFLY_ROOF','DOME_ROOF','FLAT_ROOF','FREEFORM','GABLE_ROOF','GAMBREL_ROOF','HIPPED_GABLE_ROOF','HIP_ROOF','MANSARD_ROOF','NOTDEFINED','PAVILION_ROOF','RAINBOW_ROOF','SHED_ROOF','USERDEFINED');
        };
    }

    type IfcRoofType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('BARREL_ROOF','BUTTERFLY_ROOF','DOME_ROOF','FLAT_ROOF','FREEFORM','GABLE_ROOF','GAMBREL_ROOF','HIPPED_GABLE_ROOF','HIP_ROOF','MANSARD_ROOF','NOTDEFINED','PAVILION_ROOF','RAINBOW_ROOF','SHED_ROOF','USERDEFINED');
        };
    }

    abstract type IfcRoot  {
        required property GlobalId -> str;
        link OwnerHistory -> IfcOwnerHistory;
        property Name -> str;
        property Description -> str;
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

    type IfcRotationalStiffnessSelect {
        link IfcRotationalStiffnessSelect -> IfcBoolean | IfcRotationalStiffnessMeasure;
    }

    type IfcRoundedRectangleProfileDef extending IfcRectangleProfileDef {
        required property RoundingRadius -> float64;
    }

    type IfcSIUnit extending IfcNamedUnit {
        property Prefix -> str {
            constraint one_of ('ATTO','CENTI','DECA','DECI','EXA','FEMTO','GIGA','HECTO','KILO','MEGA','MICRO','MILLI','NANO','PETA','PICO','TERA');
        };
        required property Name -> str {
            constraint one_of ('AMPERE','BECQUEREL','CANDELA','COULOMB','CUBIC_METRE','DEGREE_CELSIUS','FARAD','GRAM','GRAY','HENRY','HERTZ','JOULE','KELVIN','LUMEN','LUX','METRE','MOLE','NEWTON','OHM','PASCAL','RADIAN','SECOND','SIEMENS','SIEVERT','SQUARE_METRE','STERADIAN','TESLA','VOLT','WATT','WEBER');
        };
    }

    type IfcSanitaryTerminal extending IfcFlowTerminal {
        property PredefinedType -> str {
            constraint one_of ('BATH','BIDET','CISTERN','NOTDEFINED','SANITARYFOUNTAIN','SHOWER','SINK','TOILETPAN','URINAL','USERDEFINED','WASHHANDBASIN','WCSEAT');
        };
    }

    type IfcSanitaryTerminalType extending IfcFlowTerminalType {
        required property PredefinedType -> str {
            constraint one_of ('BATH','BIDET','CISTERN','NOTDEFINED','SANITARYFOUNTAIN','SHOWER','SINK','TOILETPAN','URINAL','USERDEFINED','WASHHANDBASIN','WCSEAT');
        };
    }

    abstract type IfcSchedulingTime  {
        property Name -> str;
        property DataOrigin -> str {
            constraint one_of ('MEASURED','NOTDEFINED','PREDICTED','SIMULATED','USERDEFINED');
        };
        property UserDefinedDataOrigin -> str;
    }

    type IfcSeamCurve extending IfcSurfaceCurve {
    }

    type IfcSectionModulusMeasure {
        required property `IfcSectionModulusMeasure` -> float64;
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

    type IfcSectionalAreaIntegralMeasure {
        required property `IfcSectionalAreaIntegralMeasure` -> float64;
    }

    abstract type IfcSectionedSolid extending IfcSolidModel {
        required link Directrix -> IfcCurve;
        required multi link CrossSections -> IfcProfileDef;
    }

    type IfcSectionedSolidHorizontal extending IfcSectionedSolid {
        required multi link CrossSectionPositions -> IfcDistanceExpression;
        required property FixedAxisVertical -> bool;
    }

    type IfcSectionedSpine extending IfcGeometricRepresentationItem {
        required link SpineCurve -> IfcCompositeCurve;
        required multi link CrossSections -> IfcProfileDef;
        required multi link CrossSectionPositions -> IfcAxis2Placement3D;
    }

    type IfcSegmentIndexSelect {
        link IfcSegmentIndexSelect -> IfcArcIndex | IfcLineIndex;
    }

    type IfcSensor extending IfcDistributionControlElement {
        property PredefinedType -> str {
            constraint one_of ('CO2SENSOR','CONDUCTANCESENSOR','CONTACTSENSOR','COSENSOR','FIRESENSOR','FLOWSENSOR','FROSTSENSOR','GASSENSOR','HEATSENSOR','HUMIDITYSENSOR','IDENTIFIERSENSOR','IONCONCENTRATIONSENSOR','LEVELSENSOR','LIGHTSENSOR','MOISTURESENSOR','MOVEMENTSENSOR','NOTDEFINED','PHSENSOR','PRESSURESENSOR','RADIATIONSENSOR','RADIOACTIVITYSENSOR','SMOKESENSOR','SOUNDSENSOR','TEMPERATURESENSOR','USERDEFINED','WINDSENSOR');
        };
    }

    type IfcSensorType extending IfcDistributionControlElementType {
        required property PredefinedType -> str {
            constraint one_of ('CO2SENSOR','CONDUCTANCESENSOR','CONTACTSENSOR','COSENSOR','FIRESENSOR','FLOWSENSOR','FROSTSENSOR','GASSENSOR','HEATSENSOR','HUMIDITYSENSOR','IDENTIFIERSENSOR','IONCONCENTRATIONSENSOR','LEVELSENSOR','LIGHTSENSOR','MOISTURESENSOR','MOVEMENTSENSOR','NOTDEFINED','PHSENSOR','PRESSURESENSOR','RADIATIONSENSOR','RADIOACTIVITYSENSOR','SMOKESENSOR','SOUNDSENSOR','TEMPERATURESENSOR','USERDEFINED','WINDSENSOR');
        };
    }

    type IfcShadingDevice extending IfcBuildingElement {
        property PredefinedType -> str {
            constraint one_of ('AWNING','JALOUSIE','NOTDEFINED','SHUTTER','USERDEFINED');
        };
    }

    type IfcShadingDeviceType extending IfcBuildingElementType {
        required property PredefinedType -> str {
            constraint one_of ('AWNING','JALOUSIE','NOTDEFINED','SHUTTER','USERDEFINED');
        };
    }

    type IfcShapeAspect  {
        required multi link ShapeRepresentations -> IfcShapeModel;
        property Name -> str;
        property Description -> str;
        required property ProductDefinitional -> bool;
        link PartOfProductDefinitionShape -> IfcProductRepresentationSelect;
    }

    abstract type IfcShapeModel extending IfcRepresentation {
    }

    type IfcShapeRepresentation extending IfcShapeModel {
    }

    type IfcShearModulusMeasure {
        required property `IfcShearModulusMeasure` -> float64;
    }

    type IfcShell {
        link IfcShell -> IfcClosedShell | IfcOpenShell;
    }

    type IfcShellBasedSurfaceModel extending IfcGeometricRepresentationItem {
        required multi link SbsmBoundary -> IfcShell;
    }

    abstract type IfcSimpleProperty extending IfcProperty {
    }

    type IfcSimplePropertyTemplate extending IfcPropertyTemplate {
        property TemplateType -> str {
            constraint one_of ('P_BOUNDEDVALUE','P_ENUMERATEDVALUE','P_LISTVALUE','P_REFERENCEVALUE','P_SINGLEVALUE','P_TABLEVALUE','Q_AREA','Q_COUNT','Q_LENGTH','Q_TIME','Q_VOLUME','Q_WEIGHT');
        };
        property PrimaryMeasureType -> str;
        property SecondaryMeasureType -> str;
        link Enumerators -> IfcPropertyEnumeration;
        link PrimaryUnit -> IfcUnit;
        link SecondaryUnit -> IfcUnit;
        property Expression -> str;
        property AccessState -> str {
            constraint one_of ('LOCKED','READONLY','READONLYLOCKED','READWRITE','READWRITELOCKED');
        };
    }

    type IfcSimpleValue {
        link IfcSimpleValue -> IfcBinary | IfcBoolean | IfcDate | IfcDateTime | IfcDuration | IfcIdentifier | IfcInteger | IfcLabel | IfcLogical | IfcPositiveInteger | IfcReal | IfcText | IfcTime | IfcTimeStamp;
    }

    type IfcSite extending IfcSpatialStructureElement {
        property RefLatitude -> int64;
        property RefLongitude -> int64;
        property RefElevation -> float64;
        property LandTitleNumber -> str;
        link SiteAddress -> IfcPostalAddress;
    }

    type IfcSizeSelect {
        link IfcSizeSelect -> IfcDescriptiveMeasure | IfcLengthMeasure | IfcNormalisedRatioMeasure | IfcPositiveLengthMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure;
    }

    type IfcSlab extending IfcBuildingElement {
        property PredefinedType -> str {
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
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','SOLARCOLLECTOR','SOLARPANEL','USERDEFINED');
        };
    }

    type IfcSolarDeviceType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','SOLARCOLLECTOR','SOLARPANEL','USERDEFINED');
        };
    }

    type IfcSolidAngleMeasure {
        required property `IfcSolidAngleMeasure` -> float64;
    }

    abstract type IfcSolidModel extending IfcGeometricRepresentationItem {
    }

    type IfcSolidOrShell {
        link IfcSolidOrShell -> IfcClosedShell | IfcSolidModel;
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

    type IfcSpace extending IfcSpatialStructureElement {
        property PredefinedType -> str {
            constraint one_of ('EXTERNAL','GFA','INTERNAL','NOTDEFINED','PARKING','SPACE','USERDEFINED');
        };
        property ElevationWithFlooring -> float64;
    }

    type IfcSpaceBoundarySelect {
        link IfcSpaceBoundarySelect -> IfcExternalSpatialElement | IfcSpace;
    }

    type IfcSpaceHeater extending IfcFlowTerminal {
        property PredefinedType -> str {
            constraint one_of ('CONVECTOR','NOTDEFINED','RADIATOR','USERDEFINED');
        };
    }

    type IfcSpaceHeaterType extending IfcFlowTerminalType {
        required property PredefinedType -> str {
            constraint one_of ('CONVECTOR','NOTDEFINED','RADIATOR','USERDEFINED');
        };
    }

    type IfcSpaceType extending IfcSpatialStructureElementType {
        required property PredefinedType -> str {
            constraint one_of ('EXTERNAL','GFA','INTERNAL','NOTDEFINED','PARKING','SPACE','USERDEFINED');
        };
        property LongName -> str;
    }

    abstract type IfcSpatialElement extending IfcProduct {
        property LongName -> str;
    }

    abstract type IfcSpatialElementType extending IfcTypeProduct {
        property ElementType -> str;
    }

    abstract type IfcSpatialStructureElement extending IfcSpatialElement {
        property CompositionType -> str {
            constraint one_of ('COMPLEX','ELEMENT','PARTIAL');
        };
    }

    abstract type IfcSpatialStructureElementType extending IfcSpatialElementType {
    }

    type IfcSpatialZone extending IfcSpatialElement {
        property PredefinedType -> str {
            constraint one_of ('CONSTRUCTION','FIRESAFETY','LIGHTING','NOTDEFINED','OCCUPANCY','SECURITY','THERMAL','TRANSPORT','USERDEFINED','VENTILATION');
        };
    }

    type IfcSpatialZoneType extending IfcSpatialElementType {
        required property PredefinedType -> str {
            constraint one_of ('CONSTRUCTION','FIRESAFETY','LIGHTING','NOTDEFINED','OCCUPANCY','SECURITY','THERMAL','TRANSPORT','USERDEFINED','VENTILATION');
        };
        property LongName -> str;
    }

    type IfcSpecificHeatCapacityMeasure {
        required property `IfcSpecificHeatCapacityMeasure` -> float64;
    }

    type IfcSpecularExponent {
        required property `IfcSpecularExponent` -> float64;
    }

    type IfcSpecularHighlightSelect {
        link IfcSpecularHighlightSelect -> IfcSpecularExponent | IfcSpecularRoughness;
    }

    type IfcSpecularRoughness {
        required property `IfcSpecularRoughness` -> float64;
    }

    type IfcSphere extending IfcCsgPrimitive3D {
        required property Radius -> float64;
    }

    type IfcSphericalSurface extending IfcElementarySurface {
        required property Radius -> float64;
    }

    type IfcStackTerminal extending IfcFlowTerminal {
        property PredefinedType -> str {
            constraint one_of ('BIRDCAGE','COWL','NOTDEFINED','RAINWATERHOPPER','USERDEFINED');
        };
    }

    type IfcStackTerminalType extending IfcFlowTerminalType {
        required property PredefinedType -> str {
            constraint one_of ('BIRDCAGE','COWL','NOTDEFINED','RAINWATERHOPPER','USERDEFINED');
        };
    }

    type IfcStair extending IfcBuildingElement {
        property PredefinedType -> str {
            constraint one_of ('CURVED_RUN_STAIR','DOUBLE_RETURN_STAIR','HALF_TURN_STAIR','HALF_WINDING_STAIR','NOTDEFINED','QUARTER_TURN_STAIR','QUARTER_WINDING_STAIR','SPIRAL_STAIR','STRAIGHT_RUN_STAIR','THREE_QUARTER_TURN_STAIR','THREE_QUARTER_WINDING_STAIR','TWO_CURVED_RUN_STAIR','TWO_QUARTER_TURN_STAIR','TWO_QUARTER_WINDING_STAIR','TWO_STRAIGHT_RUN_STAIR','USERDEFINED');
        };
    }

    type IfcStairFlight extending IfcBuildingElement {
        property NumberOfRisers -> int64;
        property NumberOfTreads -> int64;
        property RiserHeight -> float64;
        property TreadLength -> float64;
        property PredefinedType -> str {
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
        required link AppliedLoad -> IfcStructuralLoad;
        required property GlobalOrLocal -> str {
            constraint one_of ('GLOBAL_COORDS','LOCAL_COORDS');
        };
    }

    type IfcStructuralActivityAssignmentSelect {
        link IfcStructuralActivityAssignmentSelect -> IfcElement | IfcStructuralItem;
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

    abstract type IfcStructuralConnectionCondition  {
        property Name -> str;
    }

    type IfcStructuralCurveAction extending IfcStructuralAction {
        property ProjectedOrTrue -> str {
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

    abstract type IfcStructuralLoad  {
        property Name -> str;
    }

    type IfcStructuralLoadCase extending IfcStructuralLoadGroup {
        property SelfWeightCoefficients -> tuple<float64, float64, float64>;
    }

    type IfcStructuralLoadConfiguration extending IfcStructuralLoad {
        required multi link Values -> IfcStructuralLoadOrResult;
        property Locations -> array<tuple<float64, float64>>;
    }

    type IfcStructuralLoadGroup extending IfcGroup {
        required property PredefinedType -> str {
            constraint one_of ('LOAD_CASE','LOAD_COMBINATION','LOAD_GROUP','NOTDEFINED','USERDEFINED');
        };
        required property ActionType -> str {
            constraint one_of ('EXTRAORDINARY_A','NOTDEFINED','PERMANENT_G','USERDEFINED','VARIABLE_Q');
        };
        required property ActionSource -> str {
            constraint one_of ('BRAKES','BUOYANCY','COMPLETION_G1','CREEP','CURRENT','DEAD_LOAD_G','EARTHQUAKE_E','ERECTION','FIRE','ICE','IMPACT','IMPULSE','LACK_OF_FIT','LIVE_LOAD_Q','NOTDEFINED','PRESTRESSING_P','PROPPING','RAIN','SETTLEMENT_U','SHRINKAGE','SNOW_S','SYSTEM_IMPERFECTION','TEMPERATURE_T','TRANSPORT','USERDEFINED','WAVE','WIND_W');
        };
        property Coefficient -> float64;
        property Purpose -> str;
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
        required property TheoryType -> str {
            constraint one_of ('FIRST_ORDER_THEORY','FULL_NONLINEAR_THEORY','NOTDEFINED','SECOND_ORDER_THEORY','THIRD_ORDER_THEORY','USERDEFINED');
        };
        link ResultForLoadGroup -> IfcStructuralLoadGroup;
        required property IsLinear -> bool;
    }

    type IfcStructuralSurfaceAction extending IfcStructuralAction {
        property ProjectedOrTrue -> str {
            constraint one_of ('PROJECTED_LENGTH','TRUE_LENGTH');
        };
        required property PredefinedType -> str {
            constraint one_of ('BILINEAR','CONST','DISCRETE','ISOCONTOUR','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcStructuralSurfaceConnection extending IfcStructuralConnection {
    }

    type IfcStructuralSurfaceMember extending IfcStructuralMember {
        required property PredefinedType -> str {
            constraint one_of ('BENDING_ELEMENT','MEMBRANE_ELEMENT','NOTDEFINED','SHELL','USERDEFINED');
        };
        property Thickness -> float64;
    }

    type IfcStructuralSurfaceMemberVarying extending IfcStructuralSurfaceMember {
    }

    type IfcStructuralSurfaceReaction extending IfcStructuralReaction {
        required property PredefinedType -> str {
            constraint one_of ('BILINEAR','CONST','DISCRETE','ISOCONTOUR','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcStyleAssignmentSelect {
        link IfcStyleAssignmentSelect -> IfcPresentationStyle | IfcPresentationStyleAssignment;
    }

    abstract type IfcStyleModel extending IfcRepresentation {
    }

    type IfcStyledItem extending IfcRepresentationItem {
        link Item -> IfcRepresentationItem;
        required multi link Styles -> IfcStyleAssignmentSelect;
        property Name -> str;
    }

    type IfcStyledRepresentation extending IfcStyleModel {
    }

    type IfcSubContractResource extending IfcConstructionResource {
        property PredefinedType -> str {
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
        required link Curve3D -> IfcCurve;
        required multi link AssociatedGeometry -> IfcPcurve;
        required property MasterRepresentation -> str {
            constraint one_of ('CURVE3D','PCURVE_S1','PCURVE_S2');
        };
    }

    type IfcSurfaceCurveSweptAreaSolid extending IfcSweptAreaSolid {
        required link Directrix -> IfcCurve;
        property StartParam -> float64;
        property EndParam -> float64;
        required link ReferenceSurface -> IfcSurface;
    }

    type IfcSurfaceFeature extending IfcFeatureElement {
        property PredefinedType -> str {
            constraint one_of ('MARK','NOTDEFINED','TAG','TREATMENT','USERDEFINED');
        };
    }

    type IfcSurfaceOfLinearExtrusion extending IfcSweptSurface {
        required link ExtrudedDirection -> IfcDirection;
        required property Depth -> float64;
    }

    type IfcSurfaceOfRevolution extending IfcSweptSurface {
        required link AxisPosition -> IfcAxis1Placement;
    }

    type IfcSurfaceOrFaceSurface {
        link IfcSurfaceOrFaceSurface -> IfcFaceBasedSurfaceModel | IfcFaceSurface | IfcSurface;
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
        required multi link Styles -> IfcSurfaceStyleElementSelect;
    }

    type IfcSurfaceStyleElementSelect {
        link IfcSurfaceStyleElementSelect -> IfcExternallyDefinedSurfaceStyle | IfcSurfaceStyleLighting | IfcSurfaceStyleRefraction | IfcSurfaceStyleShading | IfcSurfaceStyleWithTextures;
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
        link DiffuseColour -> IfcColourOrFactor;
        link TransmissionColour -> IfcColourOrFactor;
        link DiffuseTransmissionColour -> IfcColourOrFactor;
        link ReflectionColour -> IfcColourOrFactor;
        link SpecularColour -> IfcColourOrFactor;
        link SpecularHighlight -> IfcSpecularHighlightSelect;
        required property ReflectanceMethod -> str {
            constraint one_of ('BLINN','FLAT','GLASS','MATT','METAL','MIRROR','NOTDEFINED','PHONG','PLASTIC','STRAUSS');
        };
    }

    type IfcSurfaceStyleShading extending IfcPresentationItem {
        required link SurfaceColour -> IfcColourRgb;
        property Transparency -> float64;
    }

    type IfcSurfaceStyleWithTextures extending IfcPresentationItem {
        required multi link Textures -> IfcSurfaceTexture;
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

    type IfcSweptDiskSolid extending IfcSolidModel {
        required link Directrix -> IfcCurve;
        required property Radius -> float64;
        property InnerRadius -> float64;
        property StartParam -> float64;
        property EndParam -> float64;
    }

    type IfcSweptDiskSolidPolygonal extending IfcSweptDiskSolid {
        property FilletRadius -> float64;
    }

    abstract type IfcSweptSurface extending IfcSurface {
        required link SweptCurve -> IfcProfileDef;
        link Position -> IfcAxis2Placement3D;
    }

    type IfcSwitchingDevice extending IfcFlowController {
        property PredefinedType -> str {
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
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','PANEL','USERDEFINED','WORKSURFACE');
        };
    }

    type IfcSystemFurnitureElementType extending IfcFurnishingElementType {
        property PredefinedType -> str {
            constraint one_of ('NOTDEFINED','PANEL','USERDEFINED','WORKSURFACE');
        };
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

    type IfcTable  {
        property Name -> str;
        multi link Rows -> IfcTableRow;
        multi link Columns -> IfcTableColumn;
    }

    type IfcTableColumn  {
        property Identifier -> str;
        property Name -> str;
        property Description -> str;
        link Unit -> IfcUnit;
        link ReferencePath -> IfcReference;
    }

    type IfcTableRow  {
        multi link RowCells -> IfcValue;
        property IsHeading -> bool;
    }

    type IfcTank extending IfcFlowStorageDevice {
        property PredefinedType -> str {
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
        link TaskTime -> IfcTaskTime;
        property PredefinedType -> str {
            constraint one_of ('ATTENDANCE','CONSTRUCTION','DEMOLITION','DISMANTLE','DISPOSAL','INSTALLATION','LOGISTIC','MAINTENANCE','MOVE','NOTDEFINED','OPERATION','REMOVAL','RENOVATION','USERDEFINED');
        };
    }

    type IfcTaskTime extending IfcSchedulingTime {
        property DurationType -> str {
            constraint one_of ('ELAPSEDTIME','NOTDEFINED','WORKTIME');
        };
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
    }

    type IfcTaskTimeRecurring extending IfcTaskTime {
        required link Recurrence -> IfcRecurrencePattern;
    }

    type IfcTaskType extending IfcTypeProcess {
        required property PredefinedType -> str {
            constraint one_of ('ATTENDANCE','CONSTRUCTION','DEMOLITION','DISMANTLE','DISPOSAL','INSTALLATION','LOGISTIC','MAINTENANCE','MOVE','NOTDEFINED','OPERATION','REMOVAL','RENOVATION','USERDEFINED');
        };
        property WorkMethod -> str;
    }

    type IfcTelecomAddress extending IfcAddress {
        property TelephoneNumbers -> tuple<str>;
        property FacsimileNumbers -> tuple<str>;
        property PagerNumber -> str;
        property ElectronicMailAddresses -> tuple<str>;
        property WWWHomePageURL -> str;
        property MessagingIDs -> tuple<str>;
    }

    type IfcTemperatureGradientMeasure {
        required property `IfcTemperatureGradientMeasure` -> float64;
    }

    type IfcTemperatureRateOfChangeMeasure {
        required property `IfcTemperatureRateOfChangeMeasure` -> float64;
    }

    type IfcTendon extending IfcReinforcingElement {
        property PredefinedType -> str {
            constraint one_of ('BAR','COATED','NOTDEFINED','STRAND','USERDEFINED','WIRE');
        };
        property NominalDiameter -> float64;
        property CrossSectionArea -> float64;
        property TensionForce -> float64;
        property PreStress -> float64;
        property FrictionCoefficient -> float64;
        property AnchorageSlip -> float64;
        property MinCurvatureRadius -> float64;
    }

    type IfcTendonAnchor extending IfcReinforcingElement {
        property PredefinedType -> str {
            constraint one_of ('COUPLER','FIXED_END','NOTDEFINED','TENSIONING_END','USERDEFINED');
        };
    }

    type IfcTendonAnchorType extending IfcReinforcingElementType {
        required property PredefinedType -> str {
            constraint one_of ('COUPLER','FIXED_END','NOTDEFINED','TENSIONING_END','USERDEFINED');
        };
    }

    type IfcTendonType extending IfcReinforcingElementType {
        required property PredefinedType -> str {
            constraint one_of ('BAR','COATED','NOTDEFINED','STRAND','USERDEFINED','WIRE');
        };
        property NominalDiameter -> float64;
        property CrossSectionArea -> float64;
        property SheathDiameter -> float64;
    }

    abstract type IfcTessellatedFaceSet extending IfcTessellatedItem {
        required link Coordinates -> IfcCartesianPointList3D;
    }

    abstract type IfcTessellatedItem extending IfcGeometricRepresentationItem {
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

    type IfcTextFontSelect {
        link IfcTextFontSelect -> IfcExternallyDefinedTextFont | IfcPreDefinedTextFont;
    }

    type IfcTextLiteral extending IfcGeometricRepresentationItem {
        required property Literal -> str;
        required link Placement -> IfcAxis2Placement;
        required property Path -> str {
            constraint one_of ('DOWN','LEFT','RIGHT','UP');
        };
    }

    type IfcTextLiteralWithExtent extending IfcTextLiteral {
        required link Extent -> IfcPlanarExtent;
        required property BoxAlignment -> str;
    }

    type IfcTextStyle extending IfcPresentationStyle {
        link TextCharacterAppearance -> IfcTextStyleForDefinedFont;
        link TextStyle -> IfcTextStyleTextModel;
        required link TextFontStyle -> IfcTextFontSelect;
        property ModelOrDraughting -> bool;
    }

    type IfcTextStyleFontModel extending IfcPreDefinedTextFont {
        required property FontFamily -> tuple<str>;
        property FontStyle -> str;
        property FontVariant -> str;
        property FontWeight -> str;
        required link FontSize -> IfcSizeSelect;
    }

    type IfcTextStyleForDefinedFont extending IfcPresentationItem {
        required link Colour -> IfcColour;
        link BackgroundColour -> IfcColour;
    }

    type IfcTextStyleTextModel extending IfcPresentationItem {
        link TextIndent -> IfcSizeSelect;
        property TextAlign -> str;
        property TextDecoration -> str;
        link LetterSpacing -> IfcSizeSelect;
        link WordSpacing -> IfcSizeSelect;
        property TextTransform -> str;
        link LineHeight -> IfcSizeSelect;
    }

    type IfcTextTransformation {
        required property `IfcTextTransformation` -> str;
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
        required property Coordinates -> tuple<float64, float64>;
    }

    type IfcTextureVertexList extending IfcPresentationItem {
        required property TexCoordsList -> array<tuple<float64, float64>>;
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

    type IfcTimeOrRatioSelect {
        link IfcTimeOrRatioSelect -> IfcDuration | IfcRatioMeasure;
    }

    type IfcTimePeriod  {
        required property StartTime -> str;
        required property EndTime -> str;
    }

    abstract type IfcTimeSeries  {
        required property Name -> str;
        property Description -> str;
        required property StartTime -> str;
        required property EndTime -> str;
        required property TimeSeriesDataType -> str {
            constraint one_of ('CONTINUOUS','DISCRETE','DISCRETEBINARY','NOTDEFINED','PIECEWISEBINARY','PIECEWISECONSTANT','PIECEWISECONTINUOUS');
        };
        required property DataOrigin -> str {
            constraint one_of ('MEASURED','NOTDEFINED','PREDICTED','SIMULATED','USERDEFINED');
        };
        property UserDefinedDataOrigin -> str;
        link Unit -> IfcUnit;
    }

    type IfcTimeSeriesValue  {
        required multi link ListValues -> IfcValue;
    }

    type IfcTimeStamp {
        required property `IfcTimeStamp` -> int64;
    }

    abstract type IfcTopologicalRepresentationItem extending IfcRepresentationItem {
    }

    type IfcTopologyRepresentation extending IfcShapeModel {
    }

    type IfcToroidalSurface extending IfcElementarySurface {
        required property MajorRadius -> float64;
        required property MinorRadius -> float64;
    }

    type IfcTorqueMeasure {
        required property `IfcTorqueMeasure` -> float64;
    }

    type IfcTransformer extending IfcEnergyConversionDevice {
        property PredefinedType -> str {
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

    type IfcTranslationalStiffnessSelect {
        link IfcTranslationalStiffnessSelect -> IfcBoolean | IfcLinearStiffnessMeasure;
    }

    type IfcTransportElement extending IfcElement {
        property PredefinedType -> str {
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
        property Normals -> array<tuple<float64, float64, float64>>;
        property Closed -> bool;
        required property CoordIndex -> array<tuple<int64, int64, int64>>;
        property PnIndex -> tuple<int64>;
    }

    type IfcTriangulatedIrregularNetwork extending IfcTriangulatedFaceSet {
        required property Flags -> tuple<int64>;
    }

    type IfcTrimmedCurve extending IfcBoundedCurve {
        required link BasisCurve -> IfcCurve;
        required multi link Trim1 -> IfcTrimmingSelect;
        required multi link Trim2 -> IfcTrimmingSelect;
        required property SenseAgreement -> bool;
        required property MasterRepresentation -> str {
            constraint one_of ('CARTESIAN','PARAMETER','UNSPECIFIED');
        };
    }

    type IfcTrimmingSelect {
        link IfcTrimmingSelect -> IfcCartesianPoint | IfcParameterValue;
    }

    type IfcTubeBundle extending IfcEnergyConversionDevice {
        property PredefinedType -> str {
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
        multi link RepresentationMaps -> IfcRepresentationMap;
        property Tag -> str;
    }

    abstract type IfcTypeResource extending IfcTypeObject {
        property Identification -> str;
        property LongDescription -> str;
        property ResourceType -> str;
    }

    type IfcURIReference {
        required property `IfcURIReference` -> str;
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

    type IfcUnit {
        link IfcUnit -> IfcDerivedUnit | IfcMonetaryUnit | IfcNamedUnit;
    }

    type IfcUnitAssignment  {
        required multi link Units -> IfcUnit;
    }

    type IfcUnitaryControlElement extending IfcDistributionControlElement {
        property PredefinedType -> str {
            constraint one_of ('ALARMPANEL','CONTROLPANEL','GASDETECTIONPANEL','HUMIDISTAT','INDICATORPANEL','MIMICPANEL','NOTDEFINED','THERMOSTAT','USERDEFINED','WEATHERSTATION');
        };
    }

    type IfcUnitaryControlElementType extending IfcDistributionControlElementType {
        required property PredefinedType -> str {
            constraint one_of ('ALARMPANEL','CONTROLPANEL','GASDETECTIONPANEL','HUMIDISTAT','INDICATORPANEL','MIMICPANEL','NOTDEFINED','THERMOSTAT','USERDEFINED','WEATHERSTATION');
        };
    }

    type IfcUnitaryEquipment extending IfcEnergyConversionDevice {
        property PredefinedType -> str {
            constraint one_of ('AIRCONDITIONINGUNIT','AIRHANDLER','DEHUMIDIFIER','NOTDEFINED','ROOFTOPUNIT','SPLITSYSTEM','USERDEFINED');
        };
    }

    type IfcUnitaryEquipmentType extending IfcEnergyConversionDeviceType {
        required property PredefinedType -> str {
            constraint one_of ('AIRCONDITIONINGUNIT','AIRHANDLER','DEHUMIDIFIER','NOTDEFINED','ROOFTOPUNIT','SPLITSYSTEM','USERDEFINED');
        };
    }

    type IfcValue {
        link IfcValue -> IfcAbsorbedDoseMeasure | IfcAccelerationMeasure | IfcAngularVelocityMeasure | IfcAreaDensityMeasure | IfcCompoundPlaneAngleMeasure | IfcCurvatureMeasure | IfcDoseEquivalentMeasure | IfcDynamicViscosityMeasure | IfcElectricCapacitanceMeasure | IfcElectricChargeMeasure | IfcElectricConductanceMeasure | IfcElectricResistanceMeasure | IfcElectricVoltageMeasure | IfcEnergyMeasure | IfcForceMeasure | IfcFrequencyMeasure | IfcHeatFluxDensityMeasure | IfcHeatingValueMeasure | IfcIlluminanceMeasure | IfcInductanceMeasure | IfcIntegerCountRateMeasure | IfcIonConcentrationMeasure | IfcIsothermalMoistureCapacityMeasure | IfcKinematicViscosityMeasure | IfcLinearForceMeasure | IfcLinearMomentMeasure | IfcLinearStiffnessMeasure | IfcLinearVelocityMeasure | IfcLuminousFluxMeasure | IfcLuminousIntensityDistributionMeasure | IfcMagneticFluxDensityMeasure | IfcMagneticFluxMeasure | IfcMassDensityMeasure | IfcMassFlowRateMeasure | IfcMassPerLengthMeasure | IfcModulusOfElasticityMeasure | IfcModulusOfLinearSubgradeReactionMeasure | IfcModulusOfRotationalSubgradeReactionMeasure | IfcModulusOfSubgradeReactionMeasure | IfcMoistureDiffusivityMeasure | IfcMolecularWeightMeasure | IfcMomentOfInertiaMeasure | IfcMonetaryMeasure | IfcPHMeasure | IfcPlanarForceMeasure | IfcPowerMeasure | IfcPressureMeasure | IfcRadioActivityMeasure | IfcRotationalFrequencyMeasure | IfcRotationalMassMeasure | IfcRotationalStiffnessMeasure | IfcSectionModulusMeasure | IfcSectionalAreaIntegralMeasure | IfcShearModulusMeasure | IfcSoundPowerLevelMeasure | IfcSoundPowerMeasure | IfcSoundPressureLevelMeasure | IfcSoundPressureMeasure | IfcSpecificHeatCapacityMeasure | IfcTemperatureGradientMeasure | IfcTemperatureRateOfChangeMeasure | IfcThermalAdmittanceMeasure | IfcThermalConductivityMeasure | IfcThermalExpansionCoefficientMeasure | IfcThermalResistanceMeasure | IfcThermalTransmittanceMeasure | IfcTorqueMeasure | IfcVaporPermeabilityMeasure | IfcVolumetricFlowRateMeasure | IfcWarpingConstantMeasure | IfcWarpingMomentMeasure | IfcAmountOfSubstanceMeasure | IfcAreaMeasure | IfcComplexNumber | IfcContextDependentMeasure | IfcCountMeasure | IfcDescriptiveMeasure | IfcElectricCurrentMeasure | IfcLengthMeasure | IfcLuminousIntensityMeasure | IfcMassMeasure | IfcNonNegativeLengthMeasure | IfcNormalisedRatioMeasure | IfcNumericMeasure | IfcParameterValue | IfcPlaneAngleMeasure | IfcPositiveLengthMeasure | IfcPositivePlaneAngleMeasure | IfcPositiveRatioMeasure | IfcRatioMeasure | IfcSolidAngleMeasure | IfcThermodynamicTemperatureMeasure | IfcTimeMeasure | IfcVolumeMeasure | IfcBinary | IfcBoolean | IfcDate | IfcDateTime | IfcDuration | IfcIdentifier | IfcInteger | IfcLabel | IfcLogical | IfcPositiveInteger | IfcReal | IfcText | IfcTime | IfcTimeStamp;
    }

    type IfcValve extending IfcFlowController {
        property PredefinedType -> str {
            constraint one_of ('AIRRELEASE','ANTIVACUUM','CHANGEOVER','CHECK','COMMISSIONING','DIVERTING','DOUBLECHECK','DOUBLEREGULATING','DRAWOFFCOCK','FAUCET','FLUSHING','GASCOCK','GASTAP','ISOLATING','MIXING','NOTDEFINED','PRESSUREREDUCING','PRESSURERELIEF','REGULATING','SAFETYCUTOFF','STEAMTRAP','STOPCOCK','USERDEFINED');
        };
    }

    type IfcValveType extending IfcFlowControllerType {
        required property PredefinedType -> str {
            constraint one_of ('AIRRELEASE','ANTIVACUUM','CHANGEOVER','CHECK','COMMISSIONING','DIVERTING','DOUBLECHECK','DOUBLEREGULATING','DRAWOFFCOCK','FAUCET','FLUSHING','GASCOCK','GASTAP','ISOLATING','MIXING','NOTDEFINED','PRESSUREREDUCING','PRESSURERELIEF','REGULATING','SAFETYCUTOFF','STEAMTRAP','STOPCOCK','USERDEFINED');
        };
    }

    type IfcVaporPermeabilityMeasure {
        required property `IfcVaporPermeabilityMeasure` -> float64;
    }

    type IfcVector extending IfcGeometricRepresentationItem {
        required link Orientation -> IfcDirection;
        required property Magnitude -> float64;
    }

    type IfcVectorOrDirection {
        link IfcVectorOrDirection -> IfcDirection | IfcVector;
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
        property PredefinedType -> str {
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

    type IfcVirtualGridIntersection  {
        required multi link IntersectingAxes -> IfcGridAxis;
        required property OffsetDistances -> array<float64>{
            constraint expression on (len(__subject__) = 2 or len(__subject__) = 3)
        };
    }

    type IfcVoidingFeature extending IfcFeatureElementSubtraction {
        property PredefinedType -> str {
            constraint one_of ('CHAMFER','CUTOUT','EDGE','HOLE','MITER','NOTCH','NOTDEFINED','USERDEFINED');
        };
    }

    type IfcVolumeMeasure {
        required property `IfcVolumeMeasure` -> float64;
    }

    type IfcVolumetricFlowRateMeasure {
        required property `IfcVolumetricFlowRateMeasure` -> float64;
    }

    type IfcWall extending IfcBuildingElement {
        property PredefinedType -> str {
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

    type IfcWarpingConstantMeasure {
        required property `IfcWarpingConstantMeasure` -> float64;
    }

    type IfcWarpingMomentMeasure {
        required property `IfcWarpingMomentMeasure` -> float64;
    }

    type IfcWarpingStiffnessSelect {
        link IfcWarpingStiffnessSelect -> IfcBoolean | IfcWarpingMomentMeasure;
    }

    type IfcWasteTerminal extending IfcFlowTerminal {
        property PredefinedType -> str {
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
        property PredefinedType -> str {
            constraint one_of ('LIGHTDOME','NOTDEFINED','SKYLIGHT','USERDEFINED','WINDOW');
        };
        property PartitioningType -> str {
            constraint one_of ('DOUBLE_PANEL_HORIZONTAL','DOUBLE_PANEL_VERTICAL','NOTDEFINED','SINGLE_PANEL','TRIPLE_PANEL_BOTTOM','TRIPLE_PANEL_HORIZONTAL','TRIPLE_PANEL_LEFT','TRIPLE_PANEL_RIGHT','TRIPLE_PANEL_TOP','TRIPLE_PANEL_VERTICAL','USERDEFINED');
        };
        property UserDefinedPartitioningType -> str;
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
        link ShapeAspectStyle -> IfcShapeAspect;
        property LiningOffset -> float64;
        property LiningToPanelOffsetX -> float64;
        property LiningToPanelOffsetY -> float64;
    }

    type IfcWindowPanelProperties extending IfcPreDefinedPropertySet {
        required property OperationType -> str {
            constraint one_of ('BOTTOMHUNG','FIXEDCASEMENT','NOTDEFINED','OTHEROPERATION','PIVOTHORIZONTAL','PIVOTVERTICAL','REMOVABLECASEMENT','SIDEHUNGLEFTHAND','SIDEHUNGRIGHTHAND','SLIDINGHORIZONTAL','SLIDINGVERTICAL','TILTANDTURNLEFTHAND','TILTANDTURNRIGHTHAND','TOPHUNG');
        };
        required property PanelPosition -> str {
            constraint one_of ('BOTTOM','LEFT','MIDDLE','NOTDEFINED','RIGHT','TOP');
        };
        property FrameDepth -> float64;
        property FrameThickness -> float64;
        link ShapeAspectStyle -> IfcShapeAspect;
    }

    type IfcWindowStandardCase extending IfcWindow {
    }

    type IfcWindowStyle extending IfcTypeProduct {
        required property ConstructionType -> str {
            constraint one_of ('ALUMINIUM','ALUMINIUM_WOOD','HIGH_GRADE_STEEL','NOTDEFINED','OTHER_CONSTRUCTION','PLASTIC','STEEL','WOOD');
        };
        required property OperationType -> str {
            constraint one_of ('DOUBLE_PANEL_HORIZONTAL','DOUBLE_PANEL_VERTICAL','NOTDEFINED','SINGLE_PANEL','TRIPLE_PANEL_BOTTOM','TRIPLE_PANEL_HORIZONTAL','TRIPLE_PANEL_LEFT','TRIPLE_PANEL_RIGHT','TRIPLE_PANEL_TOP','TRIPLE_PANEL_VERTICAL','USERDEFINED');
        };
        required property ParameterTakesPrecedence -> bool;
        required property Sizeable -> bool;
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

    type IfcWorkCalendar extending IfcControl {
        multi link WorkingTimes -> IfcWorkTime;
        multi link ExceptionTimes -> IfcWorkTime;
        property PredefinedType -> str {
            constraint one_of ('FIRSTSHIFT','NOTDEFINED','SECONDSHIFT','THIRDSHIFT','USERDEFINED');
        };
    }

    abstract type IfcWorkControl extending IfcControl {
        required property CreationDate -> str;
        multi link Creators -> IfcPerson;
        property Purpose -> str;
        property Duration -> str;
        property TotalFloat -> str;
        required property StartTime -> str;
        property FinishTime -> str;
    }

    type IfcWorkPlan extending IfcWorkControl {
        property PredefinedType -> str {
            constraint one_of ('ACTUAL','BASELINE','NOTDEFINED','PLANNED','USERDEFINED');
        };
    }

    type IfcWorkSchedule extending IfcWorkControl {
        property PredefinedType -> str {
            constraint one_of ('ACTUAL','BASELINE','NOTDEFINED','PLANNED','USERDEFINED');
        };
    }

    type IfcWorkTime extending IfcSchedulingTime {
        link RecurrencePattern -> IfcRecurrencePattern;
        property `Start` -> str;
        property Finish -> str;
    }

    type IfcZShapeProfileDef extending IfcParameterizedProfileDef {
        required property Depth -> float64;
        required property FlangeWidth -> float64;
        required property WebThickness -> float64;
        required property FlangeThickness -> float64;
        property FilletRadius -> float64;
        property EdgeRadius -> float64;
    }

    type IfcZone extending IfcSystem {
        property LongName -> str;
    }
}
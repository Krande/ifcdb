CREATE MIGRATION m1r3vhmuc62evtjttzu6wtwsopiixflzaayedewwzgevxz7kag3g3q
    ONTO m13fxqjijilthemv2ymqi7tzvj2xslffcswwuqvqmkl53baeyaazoq
{
  CREATE TYPE default::IfcSpaceBoundarySelect {
      CREATE LINK IfcSpaceBoundarySelect -> (default::IfcSpace | default::IfcExternalSpatialElement);
  };
  CREATE TYPE default::IfcStyleAssignmentSelect {
      CREATE LINK IfcStyleAssignmentSelect -> (default::IfcPresentationStyle | default::IfcPresentationStyleAssignment);
  };
  CREATE ABSTRACT TYPE default::IfcDistributionControlElementType EXTENDING default::IfcDistributionElementType;
  CREATE TYPE default::IfcActuatorType EXTENDING default::IfcDistributionControlElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ELECTRICACTUATOR', 'HANDOPERATEDACTUATOR', 'HYDRAULICACTUATOR', 'NOTDEFINED', 'PNEUMATICACTUATOR', 'THERMOSTATICACTUATOR', 'USERDEFINED');
      };
  };
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
  CREATE TYPE default::IfcEnergyConversionDevice EXTENDING default::IfcDistributionFlowElement;
  CREATE TYPE default::IfcAirToAirHeatRecovery EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FIXEDPLATECOUNTERFLOWEXCHANGER', 'FIXEDPLATECROSSFLOWEXCHANGER', 'FIXEDPLATEPARALLELFLOWEXCHANGER', 'HEATPIPE', 'NOTDEFINED', 'ROTARYWHEEL', 'RUNAROUNDCOILLOOP', 'THERMOSIPHONCOILTYPEHEATEXCHANGERS', 'THERMOSIPHONSEALEDTUBEHEATEXCHANGERS', 'TWINTOWERENTHALPYRECOVERYLOOPS', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcAlarmType EXTENDING default::IfcDistributionControlElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BELL', 'BREAKGLASSBUTTON', 'LIGHT', 'MANUALPULLBOX', 'NOTDEFINED', 'SIREN', 'USERDEFINED', 'WHISTLE');
      };
  };
  CREATE TYPE default::IfcAudioVisualAppliance EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AMPLIFIER', 'CAMERA', 'DISPLAY', 'MICROPHONE', 'NOTDEFINED', 'PLAYER', 'PROJECTOR', 'RECEIVER', 'SPEAKER', 'SWITCHER', 'TELEPHONE', 'TUNER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcBoiler EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'STEAM', 'USERDEFINED', 'WATER');
      };
  };
  CREATE TYPE default::IfcBurner EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcFlowFitting EXTENDING default::IfcDistributionFlowElement;
  CREATE TYPE default::IfcCableCarrierFitting EXTENDING default::IfcFlowFitting {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BEND', 'CROSS', 'NOTDEFINED', 'REDUCER', 'TEE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcFlowSegment EXTENDING default::IfcDistributionFlowElement;
  CREATE TYPE default::IfcCableCarrierSegment EXTENDING default::IfcFlowSegment {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CABLELADDERSEGMENT', 'CABLETRAYSEGMENT', 'CABLETRUNKINGSEGMENT', 'CONDUITSEGMENT', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCableFitting EXTENDING default::IfcFlowFitting {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONNECTOR', 'ENTRY', 'EXIT', 'JUNCTION', 'NOTDEFINED', 'TRANSITION', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCableSegment EXTENDING default::IfcFlowSegment {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BUSBARSEGMENT', 'CABLESEGMENT', 'CONDUCTORSEGMENT', 'CORESEGMENT', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcChiller EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRCOOLED', 'HEATRECOVERY', 'NOTDEFINED', 'USERDEFINED', 'WATERCOOLED');
      };
  };
  CREATE TYPE default::IfcCoil EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DXCOOLINGCOIL', 'ELECTRICHEATINGCOIL', 'GASHEATINGCOIL', 'HYDRONICCOIL', 'NOTDEFINED', 'STEAMHEATINGCOIL', 'USERDEFINED', 'WATERCOOLINGCOIL', 'WATERHEATINGCOIL');
      };
  };
  CREATE TYPE default::IfcCommunicationsAppliance EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ANTENNA', 'COMPUTER', 'FAX', 'GATEWAY', 'MODEM', 'NETWORKAPPLIANCE', 'NETWORKBRIDGE', 'NETWORKHUB', 'NOTDEFINED', 'PRINTER', 'REPEATER', 'ROUTER', 'SCANNER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcFlowMovingDevice EXTENDING default::IfcDistributionFlowElement;
  CREATE TYPE default::IfcCompressor EXTENDING default::IfcFlowMovingDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BOOSTER', 'DYNAMIC', 'HERMETIC', 'NOTDEFINED', 'OPENTYPE', 'RECIPROCATING', 'ROLLINGPISTON', 'ROTARY', 'ROTARYVANE', 'SCROLL', 'SEMIHERMETIC', 'SINGLESCREW', 'SINGLESTAGE', 'TROCHOIDAL', 'TWINSCREW', 'USERDEFINED', 'WELDEDSHELLHERMETIC');
      };
  };
  CREATE TYPE default::IfcCondenser EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRCOOLED', 'EVAPORATIVECOOLED', 'NOTDEFINED', 'USERDEFINED', 'WATERCOOLED', 'WATERCOOLEDBRAZEDPLATE', 'WATERCOOLEDSHELLCOIL', 'WATERCOOLEDSHELLTUBE', 'WATERCOOLEDTUBEINTUBE');
      };
  };
  CREATE TYPE default::IfcControllerType EXTENDING default::IfcDistributionControlElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FLOATING', 'MULTIPOSITION', 'NOTDEFINED', 'PROGRAMMABLE', 'PROPORTIONAL', 'TWOPOSITION', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCooledBeam EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ACTIVE', 'NOTDEFINED', 'PASSIVE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCoolingTower EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('MECHANICALFORCEDDRAFT', 'MECHANICALINDUCEDDRAFT', 'NATURALDRAFT', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcDamper EXTENDING default::IfcFlowController {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BACKDRAFTDAMPER', 'BALANCINGDAMPER', 'BLASTDAMPER', 'CONTROLDAMPER', 'FIREDAMPER', 'FIRESMOKEDAMPER', 'FUMEHOODEXHAUST', 'GRAVITYDAMPER', 'GRAVITYRELIEFDAMPER', 'NOTDEFINED', 'RELIEFDAMPER', 'SMOKEDAMPER', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcDistributionFlowElementType EXTENDING default::IfcDistributionElementType;
  CREATE TYPE default::IfcDistributionChamberElementType EXTENDING default::IfcDistributionFlowElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FORMEDDUCT', 'INSPECTIONCHAMBER', 'INSPECTIONPIT', 'MANHOLE', 'METERCHAMBER', 'NOTDEFINED', 'SUMP', 'TRENCH', 'USERDEFINED', 'VALVECHAMBER');
      };
  };
  CREATE ABSTRACT TYPE default::IfcEnergyConversionDeviceType EXTENDING default::IfcDistributionFlowElementType;
  CREATE TYPE default::IfcDoorStandardCase EXTENDING default::IfcDoor;
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
  CREATE TYPE default::IfcDuctFitting EXTENDING default::IfcFlowFitting {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BEND', 'CONNECTOR', 'ENTRY', 'EXIT', 'JUNCTION', 'NOTDEFINED', 'OBSTRUCTION', 'TRANSITION', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcDuctSegment EXTENDING default::IfcFlowSegment {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FLEXIBLESEGMENT', 'NOTDEFINED', 'RIGIDSEGMENT', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcFlowTreatmentDevice EXTENDING default::IfcDistributionFlowElement;
  CREATE TYPE default::IfcDuctSilencer EXTENDING default::IfcFlowTreatmentDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FLATOVAL', 'NOTDEFINED', 'RECTANGULAR', 'ROUND', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcElectricAppliance EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DISHWASHER', 'ELECTRICCOOKER', 'FREESTANDINGELECTRICHEATER', 'FREESTANDINGFAN', 'FREESTANDINGWATERCOOLER', 'FREESTANDINGWATERHEATER', 'FREEZER', 'FRIDGE_FREEZER', 'HANDDRYER', 'KITCHENMACHINE', 'MICROWAVE', 'NOTDEFINED', 'PHOTOCOPIER', 'REFRIGERATOR', 'TUMBLEDRYER', 'USERDEFINED', 'VENDINGMACHINE', 'WASHINGMACHINE');
      };
  };
  CREATE TYPE default::IfcElectricDistributionBoard EXTENDING default::IfcFlowController {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONSUMERUNIT', 'DISTRIBUTIONBOARD', 'MOTORCONTROLCENTRE', 'NOTDEFINED', 'SWITCHBOARD', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcFlowStorageDevice EXTENDING default::IfcDistributionFlowElement;
  CREATE TYPE default::IfcElectricFlowStorageDevice EXTENDING default::IfcFlowStorageDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BATTERY', 'CAPACITORBANK', 'HARMONICFILTER', 'INDUCTORBANK', 'NOTDEFINED', 'UPS', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcElectricGenerator EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CHP', 'ENGINEGENERATOR', 'NOTDEFINED', 'STANDALONE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcElectricMotor EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DC', 'INDUCTION', 'NOTDEFINED', 'POLYPHASE', 'RELUCTANCESYNCHRONOUS', 'SYNCHRONOUS', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcElectricTimeControl EXTENDING default::IfcFlowController {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'RELAY', 'TIMECLOCK', 'TIMEDELAY', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcEngine EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('EXTERNALCOMBUSTION', 'INTERNALCOMBUSTION', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcEvaporativeCooler EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DIRECTEVAPORATIVEAIRWASHER', 'DIRECTEVAPORATIVEPACKAGEDROTARYAIRCOOLER', 'DIRECTEVAPORATIVERANDOMMEDIAAIRCOOLER', 'DIRECTEVAPORATIVERIGIDMEDIAAIRCOOLER', 'DIRECTEVAPORATIVESLINGERSPACKAGEDAIRCOOLER', 'INDIRECTDIRECTCOMBINATION', 'INDIRECTEVAPORATIVECOOLINGTOWERORCOILCOOLER', 'INDIRECTEVAPORATIVEPACKAGEAIRCOOLER', 'INDIRECTEVAPORATIVEWETCOIL', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcEvaporator EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DIRECTEXPANSION', 'DIRECTEXPANSIONBRAZEDPLATE', 'DIRECTEXPANSIONSHELLANDTUBE', 'DIRECTEXPANSIONTUBEINTUBE', 'FLOODEDSHELLANDTUBE', 'NOTDEFINED', 'SHELLANDCOIL', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcFan EXTENDING default::IfcFlowMovingDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CENTRIFUGALAIRFOIL', 'CENTRIFUGALBACKWARDINCLINEDCURVED', 'CENTRIFUGALFORWARDCURVED', 'CENTRIFUGALRADIAL', 'NOTDEFINED', 'PROPELLORAXIAL', 'TUBEAXIAL', 'USERDEFINED', 'VANEAXIAL');
      };
  };
  CREATE TYPE default::IfcFastenerType EXTENDING default::IfcElementComponentType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('GLUE', 'MORTAR', 'NOTDEFINED', 'USERDEFINED', 'WELD');
      };
  };
  CREATE TYPE default::IfcFilter EXTENDING default::IfcFlowTreatmentDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRPARTICLEFILTER', 'COMPRESSEDAIRFILTER', 'NOTDEFINED', 'ODORFILTER', 'OILFILTER', 'STRAINER', 'USERDEFINED', 'WATERFILTER');
      };
  };
  CREATE TYPE default::IfcFlowInstrument EXTENDING default::IfcDistributionControlElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AMMETER', 'FREQUENCYMETER', 'NOTDEFINED', 'PHASEANGLEMETER', 'POWERFACTORMETER', 'PRESSUREGAUGE', 'THERMOMETER', 'USERDEFINED', 'VOLTMETER_PEAK', 'VOLTMETER_RMS');
      };
  };
  CREATE TYPE default::IfcFootingType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CAISSON_FOUNDATION', 'FOOTING_BEAM', 'NOTDEFINED', 'PAD_FOOTING', 'PILE_CAP', 'STRIP_FOOTING', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcFurnitureType EXTENDING default::IfcFurnishingElementType {
      CREATE REQUIRED PROPERTY AssemblyPlace -> std::str {
          CREATE CONSTRAINT std::one_of('FACTORY', 'NOTDEFINED', 'SITE');
      };
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BED', 'CHAIR', 'DESK', 'FILECABINET', 'NOTDEFINED', 'SHELF', 'SOFA', 'TABLE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcMechanicalFastenerType EXTENDING default::IfcElementComponentType {
      CREATE PROPERTY NominalDiameter -> std::float64;
      CREATE PROPERTY NominalLength -> std::float64;
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ANCHORBOLT', 'BOLT', 'DOWEL', 'NAIL', 'NAILPLATE', 'NOTDEFINED', 'RIVET', 'SCREW', 'SHEARCONNECTOR', 'STAPLE', 'STUDSHEARCONNECTOR', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcMemberStandardCase EXTENDING default::IfcMember;
  CREATE TYPE default::IfcMemberType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BRACE', 'CHORD', 'COLLAR', 'MEMBER', 'MULLION', 'NOTDEFINED', 'PLATE', 'POST', 'PURLIN', 'RAFTER', 'STRINGER', 'STRUT', 'STUD', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcOpeningElement EXTENDING default::IfcFeatureElementSubtraction {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'OPENING', 'RECESS', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcPileType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BORED', 'COHESION', 'DRIVEN', 'FRICTION', 'JETGROUTING', 'NOTDEFINED', 'SUPPORT', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcPlateStandardCase EXTENDING default::IfcPlate;
  CREATE TYPE default::IfcPlateType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CURTAIN_PANEL', 'NOTDEFINED', 'SHEET', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcProjectionElement EXTENDING default::IfcFeatureElementAddition {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcProtectiveDeviceTrippingUnit EXTENDING default::IfcDistributionControlElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ELECTROMAGNETIC', 'ELECTRONIC', 'NOTDEFINED', 'RESIDUALCURRENT', 'THERMAL', 'USERDEFINED');
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
  CREATE ABSTRACT TYPE default::IfcReinforcingElementType EXTENDING default::IfcElementComponentType;
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
  CREATE TYPE default::IfcRelConnectsWithEccentricity EXTENDING default::IfcRelConnectsStructuralMember {
      CREATE REQUIRED LINK ConnectionConstraint -> default::IfcConnectionGeometry;
  };
  CREATE TYPE default::IfcRelCoversBldgElements EXTENDING default::IfcRelConnects {
      CREATE REQUIRED MULTI LINK RelatedCoverings -> default::IfcCovering;
      CREATE REQUIRED LINK RelatingBuildingElement -> default::IfcElement;
  };
  CREATE TYPE default::IfcRelCoversSpaces EXTENDING default::IfcRelConnects {
      CREATE REQUIRED MULTI LINK RelatedCoverings -> default::IfcCovering;
      CREATE REQUIRED LINK RelatingSpace -> default::IfcSpace;
  };
  CREATE TYPE default::IfcRelFlowControlElements EXTENDING default::IfcRelConnects {
      CREATE REQUIRED MULTI LINK RelatedControlElements -> default::IfcDistributionControlElement;
      CREATE REQUIRED LINK RelatingFlowElement -> default::IfcDistributionFlowElement;
  };
  CREATE TYPE default::IfcRelProjectsElement EXTENDING default::IfcRelDecomposes {
      CREATE REQUIRED LINK RelatedFeatureElement -> default::IfcFeatureElementAddition;
      CREATE REQUIRED LINK RelatingElement -> default::IfcElement;
  };
  CREATE TYPE default::IfcRelVoidsElement EXTENDING default::IfcRelDecomposes {
      CREATE REQUIRED LINK RelatedOpeningElement -> default::IfcFeatureElementSubtraction;
      CREATE REQUIRED LINK RelatingBuildingElement -> default::IfcElement;
  };
  CREATE TYPE default::IfcRoofType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BARREL_ROOF', 'BUTTERFLY_ROOF', 'DOME_ROOF', 'FLAT_ROOF', 'FREEFORM', 'GABLE_ROOF', 'GAMBREL_ROOF', 'HIPPED_GABLE_ROOF', 'HIP_ROOF', 'MANSARD_ROOF', 'NOTDEFINED', 'PAVILION_ROOF', 'RAINBOW_ROOF', 'SHED_ROOF', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSensor EXTENDING default::IfcDistributionControlElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CO2SENSOR', 'CONDUCTANCESENSOR', 'CONTACTSENSOR', 'COSENSOR', 'FIRESENSOR', 'FLOWSENSOR', 'FROSTSENSOR', 'GASSENSOR', 'HEATSENSOR', 'HUMIDITYSENSOR', 'IDENTIFIERSENSOR', 'IONCONCENTRATIONSENSOR', 'LEVELSENSOR', 'LIGHTSENSOR', 'MOISTURESENSOR', 'MOVEMENTSENSOR', 'NOTDEFINED', 'PHSENSOR', 'PRESSURESENSOR', 'RADIATIONSENSOR', 'RADIOACTIVITYSENSOR', 'SMOKESENSOR', 'SOUNDSENSOR', 'TEMPERATURESENSOR', 'USERDEFINED', 'WINDSENSOR');
      };
  };
  CREATE TYPE default::IfcShadingDeviceType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AWNING', 'JALOUSIE', 'NOTDEFINED', 'SHUTTER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSlabElementedCase EXTENDING default::IfcSlab;
  CREATE TYPE default::IfcSlabStandardCase EXTENDING default::IfcSlab;
  CREATE TYPE default::IfcSlabType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BASESLAB', 'FLOOR', 'LANDING', 'NOTDEFINED', 'ROOF', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSpaceType EXTENDING default::IfcSpatialStructureElementType {
      CREATE PROPERTY LongName -> std::str;
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('EXTERNAL', 'GFA', 'INTERNAL', 'NOTDEFINED', 'PARKING', 'SPACE', 'USERDEFINED');
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
  CREATE TYPE default::IfcStructuralCurveMemberVarying EXTENDING default::IfcStructuralCurveMember;
  CREATE TYPE default::IfcStructuralLinearAction EXTENDING default::IfcStructuralCurveAction;
  CREATE TYPE default::IfcStructuralPlanarAction EXTENDING default::IfcStructuralSurfaceAction;
  CREATE TYPE default::IfcStructuralSurfaceMemberVarying EXTENDING default::IfcStructuralSurfaceMember;
  CREATE TYPE default::IfcSystemFurnitureElementType EXTENDING default::IfcFurnishingElementType {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'PANEL', 'USERDEFINED', 'WORKSURFACE');
      };
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
  CREATE TYPE default::IfcTendonAnchor EXTENDING default::IfcReinforcingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('COUPLER', 'FIXED_END', 'NOTDEFINED', 'TENSIONING_END', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcUnitaryControlElement EXTENDING default::IfcDistributionControlElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ALARMPANEL', 'CONTROLPANEL', 'GASDETECTIONPANEL', 'HUMIDISTAT', 'INDICATORPANEL', 'MIMICPANEL', 'NOTDEFINED', 'THERMOSTAT', 'USERDEFINED', 'WEATHERSTATION');
      };
  };
  CREATE TYPE default::IfcVibrationIsolatorType EXTENDING default::IfcElementComponentType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('COMPRESSION', 'NOTDEFINED', 'SPRING', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcVoidingFeature EXTENDING default::IfcFeatureElementSubtraction {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CHAMFER', 'CUTOUT', 'EDGE', 'HOLE', 'MITER', 'NOTCH', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcWallElementedCase EXTENDING default::IfcWall;
  CREATE TYPE default::IfcWallStandardCase EXTENDING default::IfcWall;
  CREATE TYPE default::IfcWallType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ELEMENTEDWALL', 'MOVABLE', 'NOTDEFINED', 'PARAPET', 'PARTITIONING', 'PLUMBINGWALL', 'POLYGONAL', 'SHEAR', 'SOLIDWALL', 'STANDARD', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcWindowStandardCase EXTENDING default::IfcWindow;
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
};

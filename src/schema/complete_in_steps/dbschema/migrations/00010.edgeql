CREATE MIGRATION m16cgwtnlxcw6ofq5djalmpiucssvm6xe6wusbo2wubnfds6latt3q
    ONTO m1r3vhmuc62evtjttzu6wtwsopiixflzaayedewwzgevxz7kag3g3q
{
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
  CREATE TYPE default::IfcAirToAirHeatRecoveryType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FIXEDPLATECOUNTERFLOWEXCHANGER', 'FIXEDPLATECROSSFLOWEXCHANGER', 'FIXEDPLATEPARALLELFLOWEXCHANGER', 'HEATPIPE', 'NOTDEFINED', 'ROTARYWHEEL', 'RUNAROUNDCOILLOOP', 'THERMOSIPHONCOILTYPEHEATEXCHANGERS', 'THERMOSIPHONSEALEDTUBEHEATEXCHANGERS', 'TWINTOWERENTHALPYRECOVERYLOOPS', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcAudioVisualApplianceType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AMPLIFIER', 'CAMERA', 'DISPLAY', 'MICROPHONE', 'NOTDEFINED', 'PLAYER', 'PROJECTOR', 'RECEIVER', 'SPEAKER', 'SWITCHER', 'TELEPHONE', 'TUNER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcBoilerType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'STEAM', 'USERDEFINED', 'WATER');
      };
  };
  CREATE TYPE default::IfcBurnerType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcFlowFittingType EXTENDING default::IfcDistributionFlowElementType;
  CREATE TYPE default::IfcCableCarrierFittingType EXTENDING default::IfcFlowFittingType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BEND', 'CROSS', 'NOTDEFINED', 'REDUCER', 'TEE', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcFlowSegmentType EXTENDING default::IfcDistributionFlowElementType;
  CREATE TYPE default::IfcCableCarrierSegmentType EXTENDING default::IfcFlowSegmentType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CABLELADDERSEGMENT', 'CABLETRAYSEGMENT', 'CABLETRUNKINGSEGMENT', 'CONDUITSEGMENT', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCableFittingType EXTENDING default::IfcFlowFittingType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONNECTOR', 'ENTRY', 'EXIT', 'JUNCTION', 'NOTDEFINED', 'TRANSITION', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCableSegmentType EXTENDING default::IfcFlowSegmentType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BUSBARSEGMENT', 'CABLESEGMENT', 'CONDUCTORSEGMENT', 'CORESEGMENT', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcChillerType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRCOOLED', 'HEATRECOVERY', 'NOTDEFINED', 'USERDEFINED', 'WATERCOOLED');
      };
  };
  CREATE TYPE default::IfcCoilType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DXCOOLINGCOIL', 'ELECTRICHEATINGCOIL', 'GASHEATINGCOIL', 'HYDRONICCOIL', 'NOTDEFINED', 'STEAMHEATINGCOIL', 'USERDEFINED', 'WATERCOOLINGCOIL', 'WATERHEATINGCOIL');
      };
  };
  CREATE TYPE default::IfcCommunicationsApplianceType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ANTENNA', 'COMPUTER', 'FAX', 'GATEWAY', 'MODEM', 'NETWORKAPPLIANCE', 'NETWORKBRIDGE', 'NETWORKHUB', 'NOTDEFINED', 'PRINTER', 'REPEATER', 'ROUTER', 'SCANNER', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcFlowMovingDeviceType EXTENDING default::IfcDistributionFlowElementType;
  CREATE TYPE default::IfcCompressorType EXTENDING default::IfcFlowMovingDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BOOSTER', 'DYNAMIC', 'HERMETIC', 'NOTDEFINED', 'OPENTYPE', 'RECIPROCATING', 'ROLLINGPISTON', 'ROTARY', 'ROTARYVANE', 'SCROLL', 'SEMIHERMETIC', 'SINGLESCREW', 'SINGLESTAGE', 'TROCHOIDAL', 'TWINSCREW', 'USERDEFINED', 'WELDEDSHELLHERMETIC');
      };
  };
  CREATE TYPE default::IfcCondenserType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRCOOLED', 'EVAPORATIVECOOLED', 'NOTDEFINED', 'USERDEFINED', 'WATERCOOLED', 'WATERCOOLEDBRAZEDPLATE', 'WATERCOOLEDSHELLCOIL', 'WATERCOOLEDSHELLTUBE', 'WATERCOOLEDTUBEINTUBE');
      };
  };
  CREATE TYPE default::IfcCooledBeamType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ACTIVE', 'NOTDEFINED', 'PASSIVE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCoolingTowerType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('MECHANICALFORCEDDRAFT', 'MECHANICALINDUCEDDRAFT', 'NATURALDRAFT', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcDamperType EXTENDING default::IfcFlowControllerType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BACKDRAFTDAMPER', 'BALANCINGDAMPER', 'BLASTDAMPER', 'CONTROLDAMPER', 'FIREDAMPER', 'FIRESMOKEDAMPER', 'FUMEHOODEXHAUST', 'GRAVITYDAMPER', 'GRAVITYRELIEFDAMPER', 'NOTDEFINED', 'RELIEFDAMPER', 'SMOKEDAMPER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcDuctFittingType EXTENDING default::IfcFlowFittingType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BEND', 'CONNECTOR', 'ENTRY', 'EXIT', 'JUNCTION', 'NOTDEFINED', 'OBSTRUCTION', 'TRANSITION', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcDuctSegmentType EXTENDING default::IfcFlowSegmentType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FLEXIBLESEGMENT', 'NOTDEFINED', 'RIGIDSEGMENT', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcFlowTreatmentDeviceType EXTENDING default::IfcDistributionFlowElementType;
  CREATE TYPE default::IfcDuctSilencerType EXTENDING default::IfcFlowTreatmentDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FLATOVAL', 'NOTDEFINED', 'RECTANGULAR', 'ROUND', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcElectricApplianceType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DISHWASHER', 'ELECTRICCOOKER', 'FREESTANDINGELECTRICHEATER', 'FREESTANDINGFAN', 'FREESTANDINGWATERCOOLER', 'FREESTANDINGWATERHEATER', 'FREEZER', 'FRIDGE_FREEZER', 'HANDDRYER', 'KITCHENMACHINE', 'MICROWAVE', 'NOTDEFINED', 'PHOTOCOPIER', 'REFRIGERATOR', 'TUMBLEDRYER', 'USERDEFINED', 'VENDINGMACHINE', 'WASHINGMACHINE');
      };
  };
  CREATE TYPE default::IfcElectricDistributionBoardType EXTENDING default::IfcFlowControllerType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONSUMERUNIT', 'DISTRIBUTIONBOARD', 'MOTORCONTROLCENTRE', 'NOTDEFINED', 'SWITCHBOARD', 'USERDEFINED');
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
  CREATE TYPE default::IfcElectricMotorType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DC', 'INDUCTION', 'NOTDEFINED', 'POLYPHASE', 'RELUCTANCESYNCHRONOUS', 'SYNCHRONOUS', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcElectricTimeControlType EXTENDING default::IfcFlowControllerType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'RELAY', 'TIMECLOCK', 'TIMEDELAY', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcEngineType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('EXTERNALCOMBUSTION', 'INTERNALCOMBUSTION', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcEvaporativeCoolerType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DIRECTEVAPORATIVEAIRWASHER', 'DIRECTEVAPORATIVEPACKAGEDROTARYAIRCOOLER', 'DIRECTEVAPORATIVERANDOMMEDIAAIRCOOLER', 'DIRECTEVAPORATIVERIGIDMEDIAAIRCOOLER', 'DIRECTEVAPORATIVESLINGERSPACKAGEDAIRCOOLER', 'INDIRECTDIRECTCOMBINATION', 'INDIRECTEVAPORATIVECOOLINGTOWERORCOILCOOLER', 'INDIRECTEVAPORATIVEPACKAGEAIRCOOLER', 'INDIRECTEVAPORATIVEWETCOIL', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcEvaporatorType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DIRECTEXPANSION', 'DIRECTEXPANSIONBRAZEDPLATE', 'DIRECTEXPANSIONSHELLANDTUBE', 'DIRECTEXPANSIONTUBEINTUBE', 'FLOODEDSHELLANDTUBE', 'NOTDEFINED', 'SHELLANDCOIL', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcFanType EXTENDING default::IfcFlowMovingDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CENTRIFUGALAIRFOIL', 'CENTRIFUGALBACKWARDINCLINEDCURVED', 'CENTRIFUGALFORWARDCURVED', 'CENTRIFUGALRADIAL', 'NOTDEFINED', 'PROPELLORAXIAL', 'TUBEAXIAL', 'USERDEFINED', 'VANEAXIAL');
      };
  };
  CREATE TYPE default::IfcFilterType EXTENDING default::IfcFlowTreatmentDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRPARTICLEFILTER', 'COMPRESSEDAIRFILTER', 'NOTDEFINED', 'ODORFILTER', 'OILFILTER', 'STRAINER', 'USERDEFINED', 'WATERFILTER');
      };
  };
  CREATE TYPE default::IfcFireSuppressionTerminal EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BREECHINGINLET', 'FIREHYDRANT', 'HOSEREEL', 'NOTDEFINED', 'SPRINKLER', 'SPRINKLERDEFLECTOR', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcFireSuppressionTerminalType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BREECHINGINLET', 'FIREHYDRANT', 'HOSEREEL', 'NOTDEFINED', 'SPRINKLER', 'SPRINKLERDEFLECTOR', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcFlowMeterType EXTENDING default::IfcFlowControllerType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ENERGYMETER', 'GASMETER', 'NOTDEFINED', 'OILMETER', 'USERDEFINED', 'WATERMETER');
      };
  };
  CREATE TYPE default::IfcProtectiveDeviceType EXTENDING default::IfcFlowControllerType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CIRCUITBREAKER', 'EARTHINGSWITCH', 'EARTHLEAKAGECIRCUITBREAKER', 'FUSEDISCONNECTOR', 'NOTDEFINED', 'RESIDUALCURRENTCIRCUITBREAKER', 'RESIDUALCURRENTSWITCH', 'USERDEFINED', 'VARISTOR');
      };
  };
  CREATE TYPE default::IfcSwitchingDeviceType EXTENDING default::IfcFlowControllerType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONTACTOR', 'DIMMERSWITCH', 'EMERGENCYSTOP', 'KEYPAD', 'MOMENTARYSWITCH', 'NOTDEFINED', 'SELECTORSWITCH', 'STARTER', 'SWITCHDISCONNECTOR', 'TOGGLESWITCH', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcJunctionBoxType EXTENDING default::IfcFlowFittingType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DATA', 'NOTDEFINED', 'POWER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcPipeFittingType EXTENDING default::IfcFlowFittingType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BEND', 'CONNECTOR', 'ENTRY', 'EXIT', 'JUNCTION', 'NOTDEFINED', 'OBSTRUCTION', 'TRANSITION', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcFlowInstrumentType EXTENDING default::IfcDistributionControlElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AMMETER', 'FREQUENCYMETER', 'NOTDEFINED', 'PHASEANGLEMETER', 'POWERFACTORMETER', 'PRESSUREGAUGE', 'THERMOMETER', 'USERDEFINED', 'VOLTMETER_PEAK', 'VOLTMETER_RMS');
      };
  };
  CREATE TYPE default::IfcFlowMeter EXTENDING default::IfcFlowController {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ENERGYMETER', 'GASMETER', 'NOTDEFINED', 'OILMETER', 'USERDEFINED', 'WATERMETER');
      };
  };
  CREATE TYPE default::IfcPumpType EXTENDING default::IfcFlowMovingDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CIRCULATOR', 'ENDSUCTION', 'NOTDEFINED', 'SPLITCASE', 'SUBMERSIBLEPUMP', 'SUMPPUMP', 'USERDEFINED', 'VERTICALINLINE', 'VERTICALTURBINE');
      };
  };
  CREATE TYPE default::IfcPipeSegmentType EXTENDING default::IfcFlowSegmentType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CULVERT', 'FLEXIBLESEGMENT', 'GUTTER', 'NOTDEFINED', 'RIGIDSEGMENT', 'SPOOL', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcTankType EXTENDING default::IfcFlowStorageDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BASIN', 'BREAKPRESSURE', 'EXPANSION', 'FEEDANDEXPANSION', 'NOTDEFINED', 'PRESSUREVESSEL', 'STORAGE', 'USERDEFINED', 'VESSEL');
      };
  };
  CREATE TYPE default::IfcLampType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('COMPACTFLUORESCENT', 'FLUORESCENT', 'HALOGEN', 'HIGHPRESSUREMERCURY', 'HIGHPRESSURESODIUM', 'LED', 'METALHALIDE', 'NOTDEFINED', 'OLED', 'TUNGSTENFILAMENT', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcLightFixtureType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DIRECTIONSOURCE', 'NOTDEFINED', 'POINTSOURCE', 'SECURITYLIGHTING', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcMedicalDeviceType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRSTATION', 'FEEDAIRUNIT', 'NOTDEFINED', 'OXYGENGENERATOR', 'OXYGENPLANT', 'USERDEFINED', 'VACUUMSTATION');
      };
  };
  CREATE TYPE default::IfcOutletType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AUDIOVISUALOUTLET', 'COMMUNICATIONSOUTLET', 'DATAOUTLET', 'NOTDEFINED', 'POWEROUTLET', 'TELEPHONEOUTLET', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSanitaryTerminalType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BATH', 'BIDET', 'CISTERN', 'NOTDEFINED', 'SANITARYFOUNTAIN', 'SHOWER', 'SINK', 'TOILETPAN', 'URINAL', 'USERDEFINED', 'WASHHANDBASIN', 'WCSEAT');
      };
  };
  CREATE TYPE default::IfcSpaceHeaterType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONVECTOR', 'NOTDEFINED', 'RADIATOR', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcStackTerminalType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BIRDCAGE', 'COWL', 'NOTDEFINED', 'RAINWATERHOPPER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcInterceptorType EXTENDING default::IfcFlowTreatmentDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CYCLONIC', 'GREASE', 'NOTDEFINED', 'OIL', 'PETROL', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcHeatExchanger EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'PLATE', 'SHELLANDTUBE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcHeatExchangerType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'PLATE', 'SHELLANDTUBE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcHumidifier EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ADIABATICAIRWASHER', 'ADIABATICATOMIZING', 'ADIABATICCOMPRESSEDAIRNOZZLE', 'ADIABATICPAN', 'ADIABATICRIGIDMEDIA', 'ADIABATICULTRASONIC', 'ADIABATICWETTEDELEMENT', 'ASSISTEDBUTANE', 'ASSISTEDELECTRIC', 'ASSISTEDNATURALGAS', 'ASSISTEDPROPANE', 'ASSISTEDSTEAM', 'NOTDEFINED', 'STEAMINJECTION', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcHumidifierType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ADIABATICAIRWASHER', 'ADIABATICATOMIZING', 'ADIABATICCOMPRESSEDAIRNOZZLE', 'ADIABATICPAN', 'ADIABATICRIGIDMEDIA', 'ADIABATICULTRASONIC', 'ADIABATICWETTEDELEMENT', 'ASSISTEDBUTANE', 'ASSISTEDELECTRIC', 'ASSISTEDNATURALGAS', 'ASSISTEDPROPANE', 'ASSISTEDSTEAM', 'NOTDEFINED', 'STEAMINJECTION', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcInterceptor EXTENDING default::IfcFlowTreatmentDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CYCLONIC', 'GREASE', 'NOTDEFINED', 'OIL', 'PETROL', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcJunctionBox EXTENDING default::IfcFlowFitting {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DATA', 'NOTDEFINED', 'POWER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcLamp EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('COMPACTFLUORESCENT', 'FLUORESCENT', 'HALOGEN', 'HIGHPRESSUREMERCURY', 'HIGHPRESSURESODIUM', 'LED', 'METALHALIDE', 'NOTDEFINED', 'OLED', 'TUNGSTENFILAMENT', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcLightFixture EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DIRECTIONSOURCE', 'NOTDEFINED', 'POINTSOURCE', 'SECURITYLIGHTING', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcMedicalDevice EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRSTATION', 'FEEDAIRUNIT', 'NOTDEFINED', 'OXYGENGENERATOR', 'OXYGENPLANT', 'USERDEFINED', 'VACUUMSTATION');
      };
  };
  CREATE TYPE default::IfcMotorConnection EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BELTDRIVE', 'COUPLING', 'DIRECTDRIVE', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcMotorConnectionType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BELTDRIVE', 'COUPLING', 'DIRECTDRIVE', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcOpeningStandardCase EXTENDING default::IfcOpeningElement;
  CREATE TYPE default::IfcOutlet EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AUDIOVISUALOUTLET', 'COMMUNICATIONSOUTLET', 'DATAOUTLET', 'NOTDEFINED', 'POWEROUTLET', 'TELEPHONEOUTLET', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcPipeFitting EXTENDING default::IfcFlowFitting {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BEND', 'CONNECTOR', 'ENTRY', 'EXIT', 'JUNCTION', 'NOTDEFINED', 'OBSTRUCTION', 'TRANSITION', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcPipeSegment EXTENDING default::IfcFlowSegment {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CULVERT', 'FLEXIBLESEGMENT', 'GUTTER', 'NOTDEFINED', 'RIGIDSEGMENT', 'SPOOL', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcProtectiveDevice EXTENDING default::IfcFlowController {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CIRCUITBREAKER', 'EARTHINGSWITCH', 'EARTHLEAKAGECIRCUITBREAKER', 'FUSEDISCONNECTOR', 'NOTDEFINED', 'RESIDUALCURRENTCIRCUITBREAKER', 'RESIDUALCURRENTSWITCH', 'USERDEFINED', 'VARISTOR');
      };
  };
  CREATE TYPE default::IfcProtectiveDeviceTrippingUnitType EXTENDING default::IfcDistributionControlElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ELECTROMAGNETIC', 'ELECTRONIC', 'NOTDEFINED', 'RESIDUALCURRENT', 'THERMAL', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcPump EXTENDING default::IfcFlowMovingDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CIRCULATOR', 'ENDSUCTION', 'NOTDEFINED', 'SPLITCASE', 'SUBMERSIBLEPUMP', 'SUMPPUMP', 'USERDEFINED', 'VERTICALINLINE', 'VERTICALTURBINE');
      };
  };
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
  CREATE TYPE default::IfcRelFillsElement EXTENDING default::IfcRelConnects {
      CREATE REQUIRED LINK RelatedBuildingElement -> default::IfcElement;
      CREATE REQUIRED LINK RelatingOpeningElement -> default::IfcOpeningElement;
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
  CREATE TYPE default::IfcSanitaryTerminal EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BATH', 'BIDET', 'CISTERN', 'NOTDEFINED', 'SANITARYFOUNTAIN', 'SHOWER', 'SINK', 'TOILETPAN', 'URINAL', 'USERDEFINED', 'WASHHANDBASIN', 'WCSEAT');
      };
  };
  CREATE TYPE default::IfcSensorType EXTENDING default::IfcDistributionControlElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CO2SENSOR', 'CONDUCTANCESENSOR', 'CONTACTSENSOR', 'COSENSOR', 'FIRESENSOR', 'FLOWSENSOR', 'FROSTSENSOR', 'GASSENSOR', 'HEATSENSOR', 'HUMIDITYSENSOR', 'IDENTIFIERSENSOR', 'IONCONCENTRATIONSENSOR', 'LEVELSENSOR', 'LIGHTSENSOR', 'MOISTURESENSOR', 'MOVEMENTSENSOR', 'NOTDEFINED', 'PHSENSOR', 'PRESSURESENSOR', 'RADIATIONSENSOR', 'RADIOACTIVITYSENSOR', 'SMOKESENSOR', 'SOUNDSENSOR', 'TEMPERATURESENSOR', 'USERDEFINED', 'WINDSENSOR');
      };
  };
  CREATE TYPE default::IfcSolarDevice EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'SOLARCOLLECTOR', 'SOLARPANEL', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSolarDeviceType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'SOLARCOLLECTOR', 'SOLARPANEL', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSpaceHeater EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONVECTOR', 'NOTDEFINED', 'RADIATOR', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcStackTerminal EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BIRDCAGE', 'COWL', 'NOTDEFINED', 'RAINWATERHOPPER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcStyledItem EXTENDING default::IfcRepresentationItem {
      CREATE LINK Item -> default::IfcRepresentationItem;
      CREATE REQUIRED MULTI LINK Styles -> default::IfcStyleAssignmentSelect;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcSwitchingDevice EXTENDING default::IfcFlowController {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONTACTOR', 'DIMMERSWITCH', 'EMERGENCYSTOP', 'KEYPAD', 'MOMENTARYSWITCH', 'NOTDEFINED', 'SELECTORSWITCH', 'STARTER', 'SWITCHDISCONNECTOR', 'TOGGLESWITCH', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcTank EXTENDING default::IfcFlowStorageDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BASIN', 'BREAKPRESSURE', 'EXPANSION', 'FEEDANDEXPANSION', 'NOTDEFINED', 'PRESSUREVESSEL', 'STORAGE', 'USERDEFINED', 'VESSEL');
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
  CREATE TYPE default::IfcTransformer EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CURRENT', 'FREQUENCY', 'INVERTER', 'NOTDEFINED', 'RECTIFIER', 'USERDEFINED', 'VOLTAGE');
      };
  };
  CREATE TYPE default::IfcTransformerType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CURRENT', 'FREQUENCY', 'INVERTER', 'NOTDEFINED', 'RECTIFIER', 'USERDEFINED', 'VOLTAGE');
      };
  };
  CREATE TYPE default::IfcTubeBundle EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FINNED', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcUnitaryControlElementType EXTENDING default::IfcDistributionControlElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ALARMPANEL', 'CONTROLPANEL', 'GASDETECTIONPANEL', 'HUMIDISTAT', 'INDICATORPANEL', 'MIMICPANEL', 'NOTDEFINED', 'THERMOSTAT', 'USERDEFINED', 'WEATHERSTATION');
      };
  };
  CREATE TYPE default::IfcUnitaryEquipment EXTENDING default::IfcEnergyConversionDevice {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRCONDITIONINGUNIT', 'AIRHANDLER', 'DEHUMIDIFIER', 'NOTDEFINED', 'ROOFTOPUNIT', 'SPLITSYSTEM', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcValve EXTENDING default::IfcFlowController {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRRELEASE', 'ANTIVACUUM', 'CHANGEOVER', 'CHECK', 'COMMISSIONING', 'DIVERTING', 'DOUBLECHECK', 'DOUBLEREGULATING', 'DRAWOFFCOCK', 'FAUCET', 'FLUSHING', 'GASCOCK', 'GASTAP', 'ISOLATING', 'MIXING', 'NOTDEFINED', 'PRESSUREREDUCING', 'PRESSURERELIEF', 'REGULATING', 'SAFETYCUTOFF', 'STEAMTRAP', 'STOPCOCK', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcWasteTerminal EXTENDING default::IfcFlowTerminal {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FLOORTRAP', 'FLOORWASTE', 'GULLYSUMP', 'GULLYTRAP', 'NOTDEFINED', 'ROOFDRAIN', 'USERDEFINED', 'WASTEDISPOSALUNIT', 'WASTETRAP');
      };
  };
};

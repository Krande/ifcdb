CREATE MIGRATION m1dht6xohm6q7x55hxa7t3q3pc7zcp2vbalqlkpfl2w4hfryt2ziwa
    ONTO m16cgwtnlxcw6ofq5djalmpiucssvm6xe6wusbo2wubnfds6latt3q
{
  CREATE TYPE default::IfcRelSpaceBoundary2ndLevel EXTENDING default::IfcRelSpaceBoundary1stLevel {
      CREATE LINK CorrespondingBoundary -> default::IfcRelSpaceBoundary2ndLevel;
  };
  CREATE TYPE default::IfcTubeBundleType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FINNED', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcUnitaryEquipmentType EXTENDING default::IfcEnergyConversionDeviceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRCONDITIONINGUNIT', 'AIRHANDLER', 'DEHUMIDIFIER', 'NOTDEFINED', 'ROOFTOPUNIT', 'SPLITSYSTEM', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcValveType EXTENDING default::IfcFlowControllerType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRRELEASE', 'ANTIVACUUM', 'CHANGEOVER', 'CHECK', 'COMMISSIONING', 'DIVERTING', 'DOUBLECHECK', 'DOUBLEREGULATING', 'DRAWOFFCOCK', 'FAUCET', 'FLUSHING', 'GASCOCK', 'GASTAP', 'ISOLATING', 'MIXING', 'NOTDEFINED', 'PRESSUREREDUCING', 'PRESSURERELIEF', 'REGULATING', 'SAFETYCUTOFF', 'STEAMTRAP', 'STOPCOCK', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcWasteTerminalType EXTENDING default::IfcFlowTerminalType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FLOORTRAP', 'FLOORWASTE', 'GULLYSUMP', 'GULLYTRAP', 'NOTDEFINED', 'ROOFDRAIN', 'USERDEFINED', 'WASTEDISPOSALUNIT', 'WASTETRAP');
      };
  };
};

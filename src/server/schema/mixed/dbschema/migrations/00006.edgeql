CREATE MIGRATION m1kszvkfutk36oxvj5qctxlnl3fr7yq6ttlzqknzisddaljidyyyiq
    ONTO m1tvht3fnv2szubp74qjjgzz7dcphg4mhi24ujrqsyykubexwrke7a
{
  CREATE ABSTRACT TYPE default::IfcBuildingElementType EXTENDING default::IfcElementType;
  CREATE TYPE default::IfcBeamType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BEAM', 'HOLLOWCORE', 'JOIST', 'LINTEL', 'NOTDEFINED', 'SPANDREL', 'T_BEAM', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcBuildingStorey EXTENDING default::IfcSpatialStructureElement {
      CREATE PROPERTY Elevation -> std::float64;
  };
  CREATE TYPE default::IfcColumn EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('COLUMN', 'NOTDEFINED', 'PILASTER', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcFeatureElementSubtraction EXTENDING default::IfcFeatureElement;
  CREATE TYPE default::IfcOpeningElement EXTENDING default::IfcFeatureElementSubtraction {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'OPENING', 'RECESS', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcRelVoidsElement EXTENDING default::IfcRelDecomposes {
      CREATE REQUIRED LINK RelatedOpeningElement -> default::IfcFeatureElementSubtraction;
      CREATE REQUIRED LINK RelatingBuildingElement -> default::IfcElement;
  };
  CREATE TYPE default::IfcMember EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BRACE', 'CHORD', 'COLLAR', 'MEMBER', 'MULLION', 'NOTDEFINED', 'PLATE', 'POST', 'PURLIN', 'RAFTER', 'STRINGER', 'STRUT', 'STUD', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSite EXTENDING default::IfcSpatialStructureElement {
      CREATE LINK SiteAddress -> default::IfcPostalAddress;
      CREATE PROPERTY LandTitleNumber -> std::str;
      CREATE PROPERTY RefElevation -> std::float64;
      CREATE PROPERTY RefLatitude -> std::int64;
      CREATE PROPERTY RefLongitude -> std::int64;
  };
};
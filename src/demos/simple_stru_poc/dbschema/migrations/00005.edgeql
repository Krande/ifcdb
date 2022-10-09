CREATE MIGRATION m15e3ji4rkt5muidxnyzrvrprdcxgag7mzw2o6zsn3hn3bzofnnega
    ONTO m1epyhqgburlntfsxcq465coxnysxie3vh2wafu6lqb7ii3rbrszka
{
  CREATE ABSTRACT TYPE default::IfcBuildingElement EXTENDING default::IfcElement;
  CREATE TYPE default::IfcBeam EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BEAM', 'HOLLOWCORE', 'JOIST', 'LINTEL', 'NOTDEFINED', 'SPANDREL', 'T_BEAM', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcTypeProduct EXTENDING default::IfcTypeObject {
      CREATE MULTI LINK RepresentationMaps -> default::IfcRepresentationMap;
      CREATE PROPERTY Tag -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcElementType EXTENDING default::IfcTypeProduct {
      CREATE PROPERTY ElementType -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcBuildingElementType EXTENDING default::IfcElementType;
  CREATE TYPE default::IfcBeamType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BEAM', 'HOLLOWCORE', 'JOIST', 'LINTEL', 'NOTDEFINED', 'SPANDREL', 'T_BEAM', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcBuildingElementProxy EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('COMPLEX', 'ELEMENT', 'NOTDEFINED', 'PARTIAL', 'PROVISIONFORSPACE', 'PROVISIONFORVOID', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcPlate EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CURTAIN_PANEL', 'NOTDEFINED', 'SHEET', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcSpatialElement EXTENDING default::IfcProduct {
      CREATE PROPERTY LongName -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcSpatialStructureElement EXTENDING default::IfcSpatialElement {
      CREATE PROPERTY CompositionType -> std::str {
          CREATE CONSTRAINT std::one_of('COMPLEX', 'ELEMENT', 'PARTIAL');
      };
  };
  CREATE TYPE default::IfcBuildingStorey EXTENDING default::IfcSpatialStructureElement {
      CREATE PROPERTY Elevation -> std::float64;
  };
  CREATE TYPE default::IfcDistributionElement EXTENDING default::IfcElement;
  CREATE TYPE default::IfcDistributionFlowElement EXTENDING default::IfcDistributionElement;
  CREATE TYPE default::IfcFlowFitting EXTENDING default::IfcDistributionFlowElement;
  CREATE TYPE default::IfcFlowSegment EXTENDING default::IfcDistributionFlowElement;
  CREATE TYPE default::IfcPipeSegment EXTENDING default::IfcFlowSegment {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CULVERT', 'FLEXIBLESEGMENT', 'GUTTER', 'NOTDEFINED', 'RIGIDSEGMENT', 'SPOOL', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcPipeFitting EXTENDING default::IfcFlowFitting {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BEND', 'CONNECTOR', 'ENTRY', 'EXIT', 'JUNCTION', 'NOTDEFINED', 'OBSTRUCTION', 'TRANSITION', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcFeatureElement EXTENDING default::IfcElement;
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
  CREATE TYPE default::IfcRelContainedInSpatialStructure EXTENDING default::IfcRelConnects {
      CREATE REQUIRED MULTI LINK RelatedElements -> default::IfcProduct;
      CREATE REQUIRED LINK RelatingStructure -> default::IfcSpatialElement;
  };
  CREATE TYPE default::IfcRelDefinesByType EXTENDING default::IfcRelDefines {
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcObject;
      CREATE REQUIRED LINK RelatingType -> default::IfcTypeObject;
  };
  CREATE TYPE default::IfcSite EXTENDING default::IfcSpatialStructureElement {
      CREATE LINK SiteAddress -> default::IfcPostalAddress;
      CREATE PROPERTY LandTitleNumber -> std::str;
      CREATE PROPERTY RefElevation -> std::float64;
      CREATE PROPERTY RefLatitude -> std::int64;
      CREATE PROPERTY RefLongitude -> std::int64;
  };
  CREATE TYPE default::IfcSpatialZone EXTENDING default::IfcSpatialElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONSTRUCTION', 'FIRESAFETY', 'LIGHTING', 'NOTDEFINED', 'OCCUPANCY', 'SECURITY', 'THERMAL', 'TRANSPORT', 'USERDEFINED', 'VENTILATION');
      };
  };
};

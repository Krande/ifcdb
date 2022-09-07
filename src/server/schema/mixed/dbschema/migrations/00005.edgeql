CREATE MIGRATION m1w2ygugn54cnr7mfuk76mjgddmbmaick3wvtat52i475wvoecxwcq
    ONTO m1f7rcycsakxiakx64fysodle6pp4exot7rqrhepltmkzijvuqdmia
{
  CREATE TYPE default::IfcAxis2Placement {
      CREATE LINK IfcAxis2Placement -> (default::IfcAxis2Placement3D | default::IfcAxis2Placement2D);
  };
  CREATE ABSTRACT TYPE default::IfcObjectDefinition EXTENDING default::IfcRoot;
  CREATE ABSTRACT TYPE default::IfcPropertyDefinition EXTENDING default::IfcRoot;
  CREATE TYPE default::IfcDefinitionSelect {
      CREATE LINK IfcDefinitionSelect -> (default::IfcPropertyDefinition | default::IfcObjectDefinition);
  };
  CREATE ABSTRACT TYPE default::IfcPropertySetDefinition EXTENDING default::IfcPropertyDefinition;
  CREATE TYPE default::IfcPropertySetDefinitionSet {
      CREATE REQUIRED MULTI LINK IfcPropertySetDefinitionSet -> default::IfcPropertySetDefinition;
  };
  CREATE TYPE default::IfcPropertySetDefinitionSelect {
      CREATE LINK IfcPropertySetDefinitionSelect -> (default::IfcPropertySetDefinition | default::IfcPropertySetDefinitionSet);
  };
  CREATE TYPE default::IfcClosedShell EXTENDING default::IfcConnectedFaceSet;
  CREATE ABSTRACT TYPE default::IfcManifoldSolidBrep EXTENDING default::IfcSolidModel {
      CREATE REQUIRED LINK Outer -> default::IfcClosedShell;
  };
  CREATE TYPE default::IfcAdvancedBrep EXTENDING default::IfcManifoldSolidBrep;
  CREATE TYPE default::IfcRepresentationMap {
      CREATE REQUIRED LINK MappingOrigin -> default::IfcAxis2Placement;
      CREATE REQUIRED LINK MappedRepresentation -> default::IfcRepresentation;
  };
  CREATE TYPE default::IfcLocalPlacement EXTENDING default::IfcObjectPlacement {
      CREATE REQUIRED LINK RelativePlacement -> default::IfcAxis2Placement;
      CREATE LINK PlacementRelTo -> default::IfcObjectPlacement;
  };
  CREATE TYPE default::IfcGeometricRepresentationContext EXTENDING default::IfcRepresentationContext {
      CREATE LINK WorldCoordinateSystem -> default::IfcAxis2Placement;
      CREATE LINK TrueNorth -> default::IfcDirection;
      CREATE PROPERTY CoordinateSpaceDimension -> std::int64;
      CREATE PROPERTY Precision -> std::float64;
  };
  CREATE TYPE default::IfcGeometricRepresentationSubContext EXTENDING default::IfcGeometricRepresentationContext {
      CREATE REQUIRED LINK ParentContext -> default::IfcGeometricRepresentationContext;
      CREATE PROPERTY TargetScale -> std::float64;
      CREATE REQUIRED PROPERTY TargetView -> std::str {
          CREATE CONSTRAINT std::one_of('ELEVATION_VIEW', 'GRAPH_VIEW', 'MODEL_VIEW', 'NOTDEFINED', 'PLAN_VIEW', 'REFLECTED_PLAN_VIEW', 'SECTION_VIEW', 'SKETCH_VIEW', 'USERDEFINED');
      };
      CREATE PROPERTY UserDefinedTargetView -> std::str;
  };
  CREATE TYPE default::IfcBSplineSurfaceWithKnots EXTENDING default::IfcBSplineSurface {
      CREATE REQUIRED PROPERTY KnotSpec -> std::str {
          CREATE CONSTRAINT std::one_of('PIECEWISE_BEZIER_KNOTS', 'QUASI_UNIFORM_KNOTS', 'UNIFORM_KNOTS', 'UNSPECIFIED');
      };
      CREATE REQUIRED PROPERTY UKnots -> tuple<std::float64, std::float64>;
      CREATE REQUIRED PROPERTY UMultiplicities -> tuple<std::int64, std::int64>;
      CREATE REQUIRED PROPERTY VKnots -> tuple<std::float64, std::float64>;
      CREATE REQUIRED PROPERTY VMultiplicities -> tuple<std::int64, std::int64>;
  };
  CREATE ABSTRACT TYPE default::IfcObject EXTENDING default::IfcObjectDefinition {
      CREATE PROPERTY ObjectType -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcProduct EXTENDING default::IfcObject {
      CREATE LINK ObjectPlacement -> default::IfcObjectPlacement;
      CREATE LINK Representation -> default::IfcProductRepresentation;
  };
  CREATE ABSTRACT TYPE default::IfcElement EXTENDING default::IfcProduct {
      CREATE PROPERTY Tag -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcBuildingElement EXTENDING default::IfcElement;
  CREATE TYPE default::IfcBeam EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BEAM', 'HOLLOWCORE', 'JOIST', 'LINTEL', 'NOTDEFINED', 'SPANDREL', 'T_BEAM', 'USERDEFINED');
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
  CREATE TYPE default::IfcBuilding EXTENDING default::IfcSpatialStructureElement {
      CREATE LINK BuildingAddress -> default::IfcPostalAddress;
      CREATE PROPERTY ElevationOfRefHeight -> std::float64;
      CREATE PROPERTY ElevationOfTerrain -> std::float64;
  };
  CREATE TYPE default::IfcBuildingElementProxy EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('COMPLEX', 'ELEMENT', 'NOTDEFINED', 'PARTIAL', 'PROVISIONFORSPACE', 'PROVISIONFORVOID', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcParameterizedProfileDef EXTENDING default::IfcProfileDef {
      CREATE LINK Position -> default::IfcAxis2Placement2D;
  };
  CREATE TYPE default::IfcCircleProfileDef EXTENDING default::IfcParameterizedProfileDef {
      CREATE REQUIRED PROPERTY Radius -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcContext EXTENDING default::IfcObjectDefinition {
      CREATE MULTI LINK RepresentationContexts -> default::IfcRepresentationContext;
      CREATE LINK UnitsInContext -> default::IfcUnitAssignment;
      CREATE PROPERTY LongName -> std::str;
      CREATE PROPERTY ObjectType -> std::str;
      CREATE PROPERTY Phase -> std::str;
  };
  CREATE TYPE default::IfcProject EXTENDING default::IfcContext;
  CREATE TYPE default::IfcConversionBasedUnit EXTENDING default::IfcNamedUnit {
      CREATE REQUIRED LINK ConversionFactor -> default::IfcMeasureWithUnit;
      CREATE REQUIRED PROPERTY Name -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcRelationship EXTENDING default::IfcRoot;
  CREATE ABSTRACT TYPE default::IfcRelAssociates EXTENDING default::IfcRelationship {
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcDefinitionSelect;
  };
  CREATE TYPE default::IfcRelAssociatesMaterial EXTENDING default::IfcRelAssociates {
      CREATE REQUIRED LINK RelatingMaterial -> default::IfcMaterialSelect;
  };
  CREATE ABSTRACT TYPE default::IfcFeatureElement EXTENDING default::IfcElement;
  CREATE TYPE default::IfcTypeObject EXTENDING default::IfcObjectDefinition {
      CREATE MULTI LINK HasPropertySets -> default::IfcPropertySetDefinition;
      CREATE PROPERTY ApplicableOccurrence -> std::str;
  };
  CREATE TYPE default::IfcTypeProduct EXTENDING default::IfcTypeObject {
      CREATE MULTI LINK RepresentationMaps -> default::IfcRepresentationMap;
      CREATE PROPERTY Tag -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcElementType EXTENDING default::IfcTypeProduct {
      CREATE PROPERTY ElementType -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcElementarySurface EXTENDING default::IfcSurface {
      CREATE REQUIRED LINK Position -> default::IfcAxis2Placement3D;
  };
  CREATE TYPE default::IfcPlane EXTENDING default::IfcElementarySurface;
  CREATE ABSTRACT TYPE default::IfcSweptAreaSolid EXTENDING default::IfcSolidModel {
      CREATE LINK Position -> default::IfcAxis2Placement3D;
      CREATE REQUIRED LINK SweptArea -> default::IfcProfileDef;
  };
  CREATE TYPE default::IfcExtrudedAreaSolid EXTENDING default::IfcSweptAreaSolid {
      CREATE REQUIRED LINK ExtrudedDirection -> default::IfcDirection;
      CREATE REQUIRED PROPERTY Depth -> std::float64;
  };
  CREATE TYPE default::IfcIShapeProfileDef EXTENDING default::IfcParameterizedProfileDef {
      CREATE PROPERTY FilletRadius -> std::float64;
      CREATE PROPERTY FlangeEdgeRadius -> std::float64;
      CREATE PROPERTY FlangeSlope -> std::float64;
      CREATE REQUIRED PROPERTY FlangeThickness -> std::float64;
      CREATE REQUIRED PROPERTY OverallDepth -> std::float64;
      CREATE REQUIRED PROPERTY OverallWidth -> std::float64;
      CREATE REQUIRED PROPERTY WebThickness -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcRelDefines EXTENDING default::IfcRelationship;
  CREATE TYPE default::IfcRelDefinesByType EXTENDING default::IfcRelDefines {
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcObject;
      CREATE REQUIRED LINK RelatingType -> default::IfcTypeObject;
  };
  CREATE ABSTRACT TYPE default::IfcRelDecomposes EXTENDING default::IfcRelationship;
  CREATE TYPE default::IfcRelAggregates EXTENDING default::IfcRelDecomposes {
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcObjectDefinition;
      CREATE REQUIRED LINK RelatingObject -> default::IfcObjectDefinition;
  };
  CREATE TYPE default::IfcRelDefinesByProperties EXTENDING default::IfcRelDefines {
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcObjectDefinition;
      CREATE REQUIRED LINK RelatingPropertyDefinition -> default::IfcPropertySetDefinitionSelect;
  };
  CREATE TYPE default::IfcRectangleProfileDef EXTENDING default::IfcParameterizedProfileDef {
      CREATE REQUIRED PROPERTY XDim -> std::float64;
      CREATE REQUIRED PROPERTY YDim -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcRelConnects EXTENDING default::IfcRelationship;
  CREATE TYPE default::IfcRelContainedInSpatialStructure EXTENDING default::IfcRelConnects {
      CREATE REQUIRED MULTI LINK RelatedElements -> default::IfcProduct;
      CREATE REQUIRED LINK RelatingStructure -> default::IfcSpatialElement;
  };
  CREATE TYPE default::IfcPropertySet EXTENDING default::IfcPropertySetDefinition {
      CREATE REQUIRED MULTI LINK HasProperties -> default::IfcProperty;
  };
};

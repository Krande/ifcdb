CREATE MIGRATION m12xyia6j36obprpjxfq2ujaxqs6qog5aizraqj4i4ycmlhjqrzleq
    ONTO m1nm6pttipmjy5zdjxgsz7mkhg3jghylsjgwuovpd6p236peghqfwa
{
  CREATE TYPE default::IfcIndexedPolygonalFaceWithVoids EXTENDING default::IfcIndexedPolygonalFace {
      CREATE REQUIRED PROPERTY InnerCoordIndices -> array<tuple<std::int64, std::int64, std::int64>>;
  };
  CREATE TYPE default::IfcTrimmingSelect {
      CREATE LINK IfcTrimmingSelect -> (default::IfcCartesianPoint | default::IfcParameterValue);
  };
  CREATE TYPE default::IfcUnit {
      CREATE LINK IfcUnit -> ((default::IfcNamedUnit | default::IfcDerivedUnit) | default::IfcMonetaryUnit);
  };
  CREATE TYPE default::IfcVector EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED LINK Orientation -> default::IfcDirection;
      CREATE REQUIRED PROPERTY Magnitude -> std::float64;
  };
  CREATE TYPE default::IfcVectorOrDirection {
      CREATE LINK IfcVectorOrDirection -> (default::IfcVector | default::IfcDirection);
  };
  CREATE TYPE default::IfcTextFontSelect {
      CREATE LINK IfcTextFontSelect -> (default::IfcPreDefinedTextFont | default::IfcExternallyDefinedTextFont);
  };
  CREATE TYPE default::IfcMaterialSelect {
      CREATE LINK IfcMaterialSelect -> ((default::IfcMaterialList | default::IfcMaterialDefinition) | default::IfcMaterialUsageDefinition);
  };
  CREATE TYPE default::IfcPersonAndOrganization {
      CREATE MULTI LINK Roles -> default::IfcActorRole;
      CREATE REQUIRED LINK TheOrganization -> default::IfcOrganization;
      CREATE REQUIRED LINK ThePerson -> default::IfcPerson;
  };
  CREATE TYPE default::IfcActorSelect {
      CREATE LINK IfcActorSelect -> ((default::IfcOrganization | default::IfcPerson) | default::IfcPersonAndOrganization);
  };
  CREATE TYPE default::IfcVertexPoint EXTENDING default::IfcVertex {
      CREATE REQUIRED LINK VertexGeometry -> default::IfcPoint;
  };
  CREATE TYPE default::IfcPointOrVertexPoint {
      CREATE LINK IfcPointOrVertexPoint -> (default::IfcVertexPoint | default::IfcPoint);
  };
  CREATE TYPE default::IfcHatchLineDistanceSelect {
      CREATE LINK IfcHatchLineDistanceSelect -> (default::IfcVector | default::IfcPositiveLengthMeasure);
  };
  CREATE TYPE default::IfcApproval {
      CREATE LINK GivingApproval -> default::IfcActorSelect;
      CREATE LINK RequestingApproval -> default::IfcActorSelect;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Identifier -> std::str;
      CREATE PROPERTY Level -> std::str;
      CREATE PROPERTY Name -> std::str;
      CREATE PROPERTY Qualifier -> std::str;
      CREATE PROPERTY Status -> std::str;
      CREATE PROPERTY TimeOfApproval -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcCurveSegment2D EXTENDING default::IfcBoundedCurve {
      CREATE REQUIRED LINK StartPoint -> default::IfcCartesianPoint;
      CREATE REQUIRED PROPERTY SegmentLength -> std::float64;
      CREATE REQUIRED PROPERTY StartDirection -> std::float64;
  };
  CREATE TYPE default::IfcAlignment2DHorizontalSegment EXTENDING default::IfcAlignment2DSegment {
      CREATE REQUIRED LINK CurveGeometry -> default::IfcCurveSegment2D;
  };
  CREATE TYPE default::IfcAlignment2DVerSegCircularArc EXTENDING default::IfcAlignment2DVerticalSegment {
      CREATE REQUIRED PROPERTY IsConvex -> std::bool;
      CREATE REQUIRED PROPERTY Radius -> std::float64;
  };
  CREATE TYPE default::IfcAlignment2DVerSegLine EXTENDING default::IfcAlignment2DVerticalSegment;
  CREATE TYPE default::IfcAlignment2DVerSegParabolicArc EXTENDING default::IfcAlignment2DVerticalSegment {
      CREATE REQUIRED PROPERTY IsConvex -> std::bool;
      CREATE REQUIRED PROPERTY ParabolaConstant -> std::float64;
  };
  CREATE TYPE default::IfcAlignment2DVertical EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED MULTI LINK Segments -> default::IfcAlignment2DVerticalSegment;
  };
  CREATE TYPE default::IfcArbitraryOpenProfileDef EXTENDING default::IfcProfileDef {
      CREATE REQUIRED LINK Curve -> default::IfcBoundedCurve;
  };
  CREATE TYPE default::IfcArbitraryProfileDefWithVoids EXTENDING default::IfcArbitraryClosedProfileDef {
      CREATE REQUIRED MULTI LINK InnerCurves -> default::IfcCurve;
  };
  CREATE ABSTRACT TYPE default::IfcPlacement EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED LINK Location -> default::IfcCartesianPoint;
  };
  CREATE TYPE default::IfcAxis1Placement EXTENDING default::IfcPlacement {
      CREATE LINK Axis -> default::IfcDirection;
  };
  CREATE TYPE default::IfcAxis2Placement2D EXTENDING default::IfcPlacement {
      CREATE LINK RefDirection -> default::IfcDirection;
  };
  CREATE TYPE default::IfcAxis2Placement3D EXTENDING default::IfcPlacement {
      CREATE LINK Axis -> default::IfcDirection;
      CREATE LINK RefDirection -> default::IfcDirection;
  };
  CREATE ABSTRACT TYPE default::IfcBSplineCurve EXTENDING default::IfcBoundedCurve {
      CREATE REQUIRED MULTI LINK ControlPointsList -> default::IfcCartesianPoint;
      CREATE REQUIRED PROPERTY ClosedCurve -> std::bool;
      CREATE REQUIRED PROPERTY CurveForm -> std::str {
          CREATE CONSTRAINT std::one_of('CIRCULAR_ARC', 'ELLIPTIC_ARC', 'HYPERBOLIC_ARC', 'PARABOLIC_ARC', 'POLYLINE_FORM', 'UNSPECIFIED');
      };
      CREATE REQUIRED PROPERTY Degree -> std::int64;
      CREATE REQUIRED PROPERTY SelfIntersect -> std::bool;
  };
  CREATE TYPE default::IfcBSplineCurveWithKnots EXTENDING default::IfcBSplineCurve {
      CREATE REQUIRED PROPERTY KnotMultiplicities -> tuple<std::int64, std::int64>;
      CREATE REQUIRED PROPERTY KnotSpec -> std::str {
          CREATE CONSTRAINT std::one_of('PIECEWISE_BEZIER_KNOTS', 'QUASI_UNIFORM_KNOTS', 'UNIFORM_KNOTS', 'UNSPECIFIED');
      };
      CREATE REQUIRED PROPERTY Knots -> tuple<std::float64, std::float64>;
  };
  CREATE TYPE default::List_of_IfcCartesianPoint {
      CREATE REQUIRED MULTI LINK IfcCartesianPoints -> default::IfcCartesianPoint;
  };
  CREATE ABSTRACT TYPE default::IfcBSplineSurface EXTENDING default::IfcBoundedSurface {
      CREATE REQUIRED MULTI LINK ControlPointsList -> default::List_of_IfcCartesianPoint;
      CREATE REQUIRED PROPERTY SelfIntersect -> std::bool;
      CREATE REQUIRED PROPERTY SurfaceForm -> std::str {
          CREATE CONSTRAINT std::one_of('CONICAL_SURF', 'CYLINDRICAL_SURF', 'GENERALISED_CONE', 'PLANE_SURF', 'QUADRIC_SURF', 'RULED_SURF', 'SPHERICAL_SURF', 'SURF_OF_LINEAR_EXTRUSION', 'SURF_OF_REVOLUTION', 'TOROIDAL_SURF', 'UNSPECIFIED');
      };
      CREATE REQUIRED PROPERTY UClosed -> std::bool;
      CREATE REQUIRED PROPERTY UDegree -> std::int64;
      CREATE REQUIRED PROPERTY VClosed -> std::bool;
      CREATE REQUIRED PROPERTY VDegree -> std::int64;
  };
  CREATE TYPE default::IfcBoundingBox EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED LINK Corner -> default::IfcCartesianPoint;
      CREATE REQUIRED PROPERTY XDim -> std::float64;
      CREATE REQUIRED PROPERTY YDim -> std::float64;
      CREATE REQUIRED PROPERTY ZDim -> std::float64;
  };
  CREATE TYPE default::IfcBoxedHalfSpace EXTENDING default::IfcHalfSpaceSolid {
      CREATE REQUIRED LINK Enclosure -> default::IfcBoundingBox;
  };
  CREATE ABSTRACT TYPE default::IfcCartesianTransformationOperator EXTENDING default::IfcGeometricRepresentationItem {
      CREATE LINK Axis1 -> default::IfcDirection;
      CREATE LINK Axis2 -> default::IfcDirection;
      CREATE REQUIRED LINK LocalOrigin -> default::IfcCartesianPoint;
      CREATE PROPERTY Scale -> std::float64;
  };
  CREATE TYPE default::IfcCartesianTransformationOperator2D EXTENDING default::IfcCartesianTransformationOperator;
  CREATE TYPE default::IfcCompositeCurve EXTENDING default::IfcBoundedCurve {
      CREATE REQUIRED MULTI LINK Segments -> default::IfcCompositeCurveSegment;
      CREATE REQUIRED PROPERTY SelfIntersect -> std::bool;
  };
  CREATE TYPE default::IfcCurveStyleFontAndScaling EXTENDING default::IfcPresentationItem {
      CREATE REQUIRED LINK CurveFont -> default::IfcCurveStyleFontSelect;
      CREATE REQUIRED PROPERTY CurveFontScaling -> std::float64;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcEdgeCurve EXTENDING default::IfcEdge {
      CREATE REQUIRED LINK EdgeGeometry -> default::IfcCurve;
      CREATE REQUIRED PROPERTY SameSense -> std::bool;
  };
  CREATE TYPE default::IfcFace EXTENDING default::IfcTopologicalRepresentationItem {
      CREATE REQUIRED MULTI LINK Bounds -> default::IfcFaceBound;
  };
  CREATE TYPE default::IfcFaceOuterBound EXTENDING default::IfcFaceBound;
  CREATE TYPE default::IfcFillAreaStyleTiles EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED MULTI LINK TilingPattern -> default::IfcVector;
      CREATE REQUIRED PROPERTY TilingScale -> std::float64;
  };
  CREATE TYPE default::IfcGeometricSet EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED MULTI LINK Elements -> default::IfcGeometricSetSelect;
  };
  CREATE TYPE default::IfcIndexedPolyCurve EXTENDING default::IfcBoundedCurve {
      CREATE REQUIRED LINK Points -> default::IfcCartesianPointList;
      CREATE MULTI LINK Segments -> default::IfcSegmentIndexSelect;
      CREATE PROPERTY SelfIntersect -> std::bool;
  };
  CREATE TYPE default::IfcLightSourceAmbient EXTENDING default::IfcLightSource;
  CREATE TYPE default::IfcLightSourceDirectional EXTENDING default::IfcLightSource {
      CREATE REQUIRED LINK Orientation -> default::IfcDirection;
  };
  CREATE TYPE default::IfcLightSourcePositional EXTENDING default::IfcLightSource {
      CREATE REQUIRED LINK Position -> default::IfcCartesianPoint;
      CREATE REQUIRED PROPERTY ConstantAttenuation -> std::float64;
      CREATE REQUIRED PROPERTY DistanceAttenuation -> std::float64;
      CREATE REQUIRED PROPERTY QuadricAttenuation -> std::float64;
      CREATE REQUIRED PROPERTY Radius -> std::float64;
  };
  CREATE TYPE default::IfcLine EXTENDING default::IfcCurve {
      CREATE REQUIRED LINK Dir -> default::IfcVector;
      CREATE REQUIRED LINK Pnt -> default::IfcCartesianPoint;
  };
  CREATE TYPE default::IfcMaterialLayerSetUsage EXTENDING default::IfcMaterialUsageDefinition {
      CREATE REQUIRED LINK ForLayerSet -> default::IfcMaterialLayerSet;
      CREATE REQUIRED PROPERTY DirectionSense -> std::str {
          CREATE CONSTRAINT std::one_of('NEGATIVE', 'POSITIVE');
      };
      CREATE REQUIRED PROPERTY LayerSetDirection -> std::str {
          CREATE CONSTRAINT std::one_of('AXIS1', 'AXIS2', 'AXIS3');
      };
      CREATE REQUIRED PROPERTY OffsetFromReferenceLine -> std::float64;
      CREATE PROPERTY ReferenceExtent -> std::float64;
  };
  CREATE TYPE default::IfcMaterialProfileSetUsage EXTENDING default::IfcMaterialUsageDefinition {
      CREATE REQUIRED LINK ForProfileSet -> default::IfcMaterialProfileSet;
      CREATE PROPERTY CardinalPoint -> std::int64;
      CREATE PROPERTY ReferenceExtent -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcOffsetCurve EXTENDING default::IfcCurve {
      CREATE REQUIRED LINK BasisCurve -> default::IfcCurve;
  };
  CREATE TYPE default::IfcOffsetCurve2D EXTENDING default::IfcOffsetCurve {
      CREATE REQUIRED PROPERTY Distance -> std::float64;
      CREATE REQUIRED PROPERTY SelfIntersect -> std::bool;
  };
  CREATE TYPE default::IfcOffsetCurve3D EXTENDING default::IfcOffsetCurve {
      CREATE REQUIRED LINK RefDirection -> default::IfcDirection;
      CREATE REQUIRED PROPERTY Distance -> std::float64;
      CREATE REQUIRED PROPERTY SelfIntersect -> std::bool;
  };
  CREATE TYPE default::IfcOffsetCurveByDistances EXTENDING default::IfcOffsetCurve {
      CREATE REQUIRED MULTI LINK OffsetValues -> default::IfcDistanceExpression;
      CREATE PROPERTY Tag -> std::str;
  };
  CREATE TYPE default::IfcOrganizationRelationship EXTENDING default::IfcResourceLevelRelationship {
      CREATE REQUIRED MULTI LINK RelatedOrganizations -> default::IfcOrganization;
      CREATE REQUIRED LINK RelatingOrganization -> default::IfcOrganization;
  };
  CREATE TYPE default::IfcOrientationExpression EXTENDING default::IfcGeometricRepresentationItem {
      CREATE REQUIRED LINK LateralAxisDirection -> default::IfcDirection;
      CREATE REQUIRED LINK VerticalAxisDirection -> default::IfcDirection;
  };
  CREATE TYPE default::IfcOrientedEdge EXTENDING default::IfcEdge {
      CREATE REQUIRED LINK EdgeElement -> default::IfcEdge;
      CREATE REQUIRED PROPERTY Orientation -> std::bool;
  };
  CREATE TYPE default::IfcOwnerHistory {
      CREATE LINK LastModifyingApplication -> default::IfcApplication;
      CREATE LINK LastModifyingUser -> default::IfcPersonAndOrganization;
      CREATE REQUIRED LINK OwningApplication -> default::IfcApplication;
      CREATE REQUIRED LINK OwningUser -> default::IfcPersonAndOrganization;
      CREATE PROPERTY ChangeAction -> std::str {
          CREATE CONSTRAINT std::one_of('ADDED', 'DELETED', 'MODIFIED', 'NOCHANGE', 'NOTDEFINED');
      };
      CREATE REQUIRED PROPERTY CreationDate -> std::int64;
      CREATE PROPERTY LastModifiedDate -> std::int64;
      CREATE PROPERTY State -> std::str {
          CREATE CONSTRAINT std::one_of('LOCKED', 'READONLY', 'READONLYLOCKED', 'READWRITE', 'READWRITELOCKED');
      };
  };
  CREATE TYPE default::IfcPcurve EXTENDING default::IfcCurve {
      CREATE REQUIRED LINK BasisSurface -> default::IfcSurface;
      CREATE REQUIRED LINK ReferenceCurve -> default::IfcCurve;
  };
  CREATE TYPE default::IfcSurfaceCurve EXTENDING default::IfcCurve {
      CREATE REQUIRED MULTI LINK AssociatedGeometry -> default::IfcPcurve;
      CREATE REQUIRED LINK Curve3D -> default::IfcCurve;
      CREATE REQUIRED PROPERTY MasterRepresentation -> std::str {
          CREATE CONSTRAINT std::one_of('CURVE3D', 'PCURVE_S1', 'PCURVE_S2');
      };
  };
  CREATE TYPE default::IfcPointOnCurve EXTENDING default::IfcPoint {
      CREATE REQUIRED LINK BasisCurve -> default::IfcCurve;
      CREATE REQUIRED PROPERTY PointParameter -> std::float64;
  };
  CREATE TYPE default::IfcPointOnSurface EXTENDING default::IfcPoint {
      CREATE REQUIRED LINK BasisSurface -> default::IfcSurface;
      CREATE REQUIRED PROPERTY PointParameterU -> std::float64;
      CREATE REQUIRED PROPERTY PointParameterV -> std::float64;
  };
  CREATE TYPE default::IfcPolyLoop EXTENDING default::IfcLoop {
      CREATE REQUIRED MULTI LINK Polygon -> default::IfcCartesianPoint;
  };
  CREATE TYPE default::IfcPolyline EXTENDING default::IfcBoundedCurve {
      CREATE REQUIRED MULTI LINK Points -> default::IfcCartesianPoint;
  };
  CREATE TYPE default::IfcPresentationLayerAssignment {
      CREATE REQUIRED MULTI LINK AssignedItems -> default::IfcLayeredItem;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Identifier -> std::str;
      CREATE REQUIRED PROPERTY Name -> std::str;
  };
  CREATE TYPE default::IfcPresentationLayerWithStyle EXTENDING default::IfcPresentationLayerAssignment {
      CREATE REQUIRED MULTI LINK LayerStyles -> default::IfcPresentationStyle;
      CREATE REQUIRED PROPERTY LayerBlocked -> std::bool;
      CREATE REQUIRED PROPERTY LayerFrozen -> std::bool;
      CREATE REQUIRED PROPERTY LayerOn -> std::bool;
  };
  CREATE TYPE default::IfcProductDefinitionShape EXTENDING default::IfcProductRepresentation;
  CREATE TYPE default::IfcProfileProperties EXTENDING default::IfcExtendedProperties {
      CREATE REQUIRED LINK ProfileDefinition -> default::IfcProfileDef;
  };
  CREATE TYPE default::IfcQuantityArea EXTENDING default::IfcPhysicalSimpleQuantity {
      CREATE REQUIRED PROPERTY AreaValue -> std::float64;
      CREATE PROPERTY Formula -> std::str;
  };
  CREATE TYPE default::IfcQuantityCount EXTENDING default::IfcPhysicalSimpleQuantity {
      CREATE REQUIRED PROPERTY CountValue -> std::int64;
      CREATE PROPERTY Formula -> std::str;
  };
  CREATE TYPE default::IfcQuantityLength EXTENDING default::IfcPhysicalSimpleQuantity {
      CREATE PROPERTY Formula -> std::str;
      CREATE REQUIRED PROPERTY LengthValue -> std::float64;
  };
  CREATE TYPE default::IfcQuantityTime EXTENDING default::IfcPhysicalSimpleQuantity {
      CREATE PROPERTY Formula -> std::str;
      CREATE REQUIRED PROPERTY TimeValue -> std::float64;
  };
  CREATE TYPE default::IfcQuantityVolume EXTENDING default::IfcPhysicalSimpleQuantity {
      CREATE PROPERTY Formula -> std::str;
      CREATE REQUIRED PROPERTY VolumeValue -> std::float64;
  };
  CREATE TYPE default::IfcQuantityWeight EXTENDING default::IfcPhysicalSimpleQuantity {
      CREATE PROPERTY Formula -> std::str;
      CREATE REQUIRED PROPERTY WeightValue -> std::float64;
  };
  CREATE TYPE default::IfcRectangularTrimmedSurface EXTENDING default::IfcBoundedSurface {
      CREATE REQUIRED LINK BasisSurface -> default::IfcSurface;
      CREATE REQUIRED PROPERTY U1 -> std::float64;
      CREATE REQUIRED PROPERTY U2 -> std::float64;
      CREATE REQUIRED PROPERTY Usense -> std::bool;
      CREATE REQUIRED PROPERTY V1 -> std::float64;
      CREATE REQUIRED PROPERTY V2 -> std::float64;
      CREATE REQUIRED PROPERTY Vsense -> std::bool;
  };
  CREATE TYPE default::IfcReparametrisedCompositeCurveSegment EXTENDING default::IfcCompositeCurveSegment {
      CREATE REQUIRED PROPERTY ParamLength -> std::float64;
  };
  CREATE TYPE default::IfcSectionReinforcementProperties EXTENDING default::IfcPreDefinedProperties {
      CREATE REQUIRED MULTI LINK CrossSectionReinforcementDefinitions -> default::IfcReinforcementBarProperties;
      CREATE REQUIRED LINK SectionDefinition -> default::IfcSectionProperties;
      CREATE REQUIRED PROPERTY LongitudinalEndPosition -> std::float64;
      CREATE REQUIRED PROPERTY LongitudinalStartPosition -> std::float64;
      CREATE REQUIRED PROPERTY ReinforcementRole -> std::str {
          CREATE CONSTRAINT std::one_of('ANCHORING', 'EDGE', 'LIGATURE', 'MAIN', 'NOTDEFINED', 'PUNCHING', 'RING', 'SHEAR', 'STUD', 'USERDEFINED');
      };
      CREATE PROPERTY TransversePosition -> std::float64;
  };
  CREATE ABSTRACT TYPE default::IfcSectionedSolid EXTENDING default::IfcSolidModel {
      CREATE REQUIRED MULTI LINK CrossSections -> default::IfcProfileDef;
      CREATE REQUIRED LINK Directrix -> default::IfcCurve;
  };
  CREATE TYPE default::IfcSectionedSolidHorizontal EXTENDING default::IfcSectionedSolid {
      CREATE REQUIRED MULTI LINK CrossSectionPositions -> default::IfcDistanceExpression;
      CREATE REQUIRED PROPERTY FixedAxisVertical -> std::bool;
  };
  CREATE TYPE default::IfcShapeRepresentation EXTENDING default::IfcShapeModel;
  CREATE TYPE default::IfcStructuralLoadLinearForce EXTENDING default::IfcStructuralLoadStatic {
      CREATE PROPERTY LinearForceX -> std::float64;
      CREATE PROPERTY LinearForceY -> std::float64;
      CREATE PROPERTY LinearForceZ -> std::float64;
      CREATE PROPERTY LinearMomentX -> std::float64;
      CREATE PROPERTY LinearMomentY -> std::float64;
      CREATE PROPERTY LinearMomentZ -> std::float64;
  };
  CREATE TYPE default::IfcStructuralLoadPlanarForce EXTENDING default::IfcStructuralLoadStatic {
      CREATE PROPERTY PlanarForceX -> std::float64;
      CREATE PROPERTY PlanarForceY -> std::float64;
      CREATE PROPERTY PlanarForceZ -> std::float64;
  };
  CREATE TYPE default::IfcStructuralLoadSingleDisplacement EXTENDING default::IfcStructuralLoadStatic {
      CREATE PROPERTY DisplacementX -> std::float64;
      CREATE PROPERTY DisplacementY -> std::float64;
      CREATE PROPERTY DisplacementZ -> std::float64;
      CREATE PROPERTY RotationalDisplacementRX -> std::float64;
      CREATE PROPERTY RotationalDisplacementRY -> std::float64;
      CREATE PROPERTY RotationalDisplacementRZ -> std::float64;
  };
  CREATE TYPE default::IfcStructuralLoadSingleDisplacementDistortion EXTENDING default::IfcStructuralLoadSingleDisplacement {
      CREATE PROPERTY Distortion -> std::float64;
  };
  CREATE TYPE default::IfcStructuralLoadSingleForce EXTENDING default::IfcStructuralLoadStatic {
      CREATE PROPERTY ForceX -> std::float64;
      CREATE PROPERTY ForceY -> std::float64;
      CREATE PROPERTY ForceZ -> std::float64;
      CREATE PROPERTY MomentX -> std::float64;
      CREATE PROPERTY MomentY -> std::float64;
      CREATE PROPERTY MomentZ -> std::float64;
  };
  CREATE TYPE default::IfcStructuralLoadSingleForceWarping EXTENDING default::IfcStructuralLoadSingleForce {
      CREATE PROPERTY WarpingMoment -> std::float64;
  };
  CREATE TYPE default::IfcStructuralLoadTemperature EXTENDING default::IfcStructuralLoadStatic {
      CREATE PROPERTY DeltaTConstant -> std::float64;
      CREATE PROPERTY DeltaTY -> std::float64;
      CREATE PROPERTY DeltaTZ -> std::float64;
  };
  CREATE TYPE default::IfcStyledRepresentation EXTENDING default::IfcStyleModel;
  CREATE TYPE default::IfcSubedge EXTENDING default::IfcEdge {
      CREATE REQUIRED LINK ParentEdge -> default::IfcEdge;
  };
  CREATE TYPE default::IfcSurfaceStyleLighting EXTENDING default::IfcPresentationItem {
      CREATE REQUIRED LINK DiffuseReflectionColour -> default::IfcColourRgb;
      CREATE REQUIRED LINK DiffuseTransmissionColour -> default::IfcColourRgb;
      CREATE REQUIRED LINK ReflectanceColour -> default::IfcColourRgb;
      CREATE REQUIRED LINK TransmissionColour -> default::IfcColourRgb;
  };
  CREATE TYPE default::IfcSurfaceStyleShading EXTENDING default::IfcPresentationItem {
      CREATE REQUIRED LINK SurfaceColour -> default::IfcColourRgb;
      CREATE PROPERTY Transparency -> std::float64;
  };
  CREATE TYPE default::IfcSurfaceStyleRendering EXTENDING default::IfcSurfaceStyleShading {
      CREATE LINK DiffuseColour -> default::IfcColourOrFactor;
      CREATE LINK DiffuseTransmissionColour -> default::IfcColourOrFactor;
      CREATE LINK ReflectionColour -> default::IfcColourOrFactor;
      CREATE LINK SpecularColour -> default::IfcColourOrFactor;
      CREATE LINK SpecularHighlight -> default::IfcSpecularHighlightSelect;
      CREATE LINK TransmissionColour -> default::IfcColourOrFactor;
      CREATE REQUIRED PROPERTY ReflectanceMethod -> std::str {
          CREATE CONSTRAINT std::one_of('BLINN', 'FLAT', 'GLASS', 'MATT', 'METAL', 'MIRROR', 'NOTDEFINED', 'PHONG', 'PLASTIC', 'STRAUSS');
      };
  };
  CREATE TYPE default::IfcSweptDiskSolid EXTENDING default::IfcSolidModel {
      CREATE REQUIRED LINK Directrix -> default::IfcCurve;
      CREATE PROPERTY EndParam -> std::float64;
      CREATE PROPERTY InnerRadius -> std::float64;
      CREATE REQUIRED PROPERTY Radius -> std::float64;
      CREATE PROPERTY StartParam -> std::float64;
  };
  CREATE TYPE default::IfcSweptDiskSolidPolygonal EXTENDING default::IfcSweptDiskSolid {
      CREATE PROPERTY FilletRadius -> std::float64;
  };
  CREATE TYPE default::IfcTableRow {
      CREATE MULTI LINK RowCells -> default::IfcValue;
      CREATE PROPERTY IsHeading -> std::bool;
  };
  CREATE TYPE default::IfcTaskTimeRecurring EXTENDING default::IfcTaskTime {
      CREATE REQUIRED LINK Recurrence -> default::IfcRecurrencePattern;
  };
  CREATE ABSTRACT TYPE default::IfcTessellatedFaceSet EXTENDING default::IfcTessellatedItem {
      CREATE REQUIRED LINK Coordinates -> default::IfcCartesianPointList3D;
  };
  CREATE TYPE default::IfcTextStyleFontModel EXTENDING default::IfcPreDefinedTextFont {
      CREATE REQUIRED LINK FontSize -> default::IfcSizeSelect;
      CREATE REQUIRED PROPERTY FontFamily -> tuple<std::str>;
      CREATE PROPERTY FontStyle -> std::str;
      CREATE PROPERTY FontVariant -> std::str;
      CREATE PROPERTY FontWeight -> std::str;
  };
  CREATE TYPE default::IfcTextStyleForDefinedFont EXTENDING default::IfcPresentationItem {
      CREATE LINK BackgroundColour -> default::IfcColour;
      CREATE REQUIRED LINK Colour -> default::IfcColour;
  };
  CREATE TYPE default::IfcTimeSeriesValue {
      CREATE REQUIRED MULTI LINK ListValues -> default::IfcValue;
  };
  CREATE TYPE default::IfcTopologyRepresentation EXTENDING default::IfcShapeModel;
  CREATE TYPE default::IfcVertexLoop EXTENDING default::IfcLoop {
      CREATE REQUIRED LINK LoopVertex -> default::IfcVertex;
  };
  CREATE TYPE default::IfcVirtualGridIntersection {
      CREATE REQUIRED MULTI LINK IntersectingAxes -> default::IfcGridAxis;
      CREATE REQUIRED PROPERTY OffsetDistances -> array<std::float64> {
          CREATE CONSTRAINT std::expression ON (((std::len(__subject__) = 2) OR (std::len(__subject__) = 3)));
      };
  };
};

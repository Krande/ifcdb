CREATE MIGRATION m13fxqjijilthemv2ymqi7tzvj2xslffcswwuqvqmkl53baeyaazoq
    ONTO m1hx2hetjpjnst3guqtzsv7q5uquy6sk6gz4k6nequxa7y63s36rwa
{
  CREATE TYPE default::IfcDistributionControlElement EXTENDING default::IfcDistributionElement;
  CREATE TYPE default::IfcActuator EXTENDING default::IfcDistributionControlElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ELECTRICACTUATOR', 'HANDOPERATEDACTUATOR', 'HYDRAULICACTUATOR', 'NOTDEFINED', 'PNEUMATICACTUATOR', 'THERMOSTATICACTUATOR', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcAlarm EXTENDING default::IfcDistributionControlElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BELL', 'BREAKGLASSBUTTON', 'LIGHT', 'MANUALPULLBOX', 'NOTDEFINED', 'SIREN', 'USERDEFINED', 'WHISTLE');
      };
  };
  CREATE TYPE default::IfcAlignment EXTENDING default::IfcLinearPositioningElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcBeam EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BEAM', 'HOLLOWCORE', 'JOIST', 'LINTEL', 'NOTDEFINED', 'SPANDREL', 'T_BEAM', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcBeamStandardCase EXTENDING default::IfcBeam;
  CREATE ABSTRACT TYPE default::IfcBuildingElementType EXTENDING default::IfcElementType;
  CREATE TYPE default::IfcBeamType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BEAM', 'HOLLOWCORE', 'JOIST', 'LINTEL', 'NOTDEFINED', 'SPANDREL', 'T_BEAM', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcBuilding EXTENDING default::IfcSpatialStructureElement {
      CREATE LINK BuildingAddress -> default::IfcPostalAddress;
      CREATE PROPERTY ElevationOfRefHeight -> std::float64;
      CREATE PROPERTY ElevationOfTerrain -> std::float64;
  };
  CREATE TYPE default::IfcBuildingElementPart EXTENDING default::IfcElementComponent {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('INSULATION', 'NOTDEFINED', 'PRECASTPANEL', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcElementComponentType EXTENDING default::IfcElementType;
  CREATE TYPE default::IfcBuildingElementPartType EXTENDING default::IfcElementComponentType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('INSULATION', 'NOTDEFINED', 'PRECASTPANEL', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcBuildingElementProxy EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('COMPLEX', 'ELEMENT', 'NOTDEFINED', 'PARTIAL', 'PROVISIONFORSPACE', 'PROVISIONFORVOID', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcBuildingElementProxyType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('COMPLEX', 'ELEMENT', 'NOTDEFINED', 'PARTIAL', 'PROVISIONFORSPACE', 'PROVISIONFORVOID', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcChimneyType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcColumnType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('COLUMN', 'NOTDEFINED', 'PILASTER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCoveringType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CEILING', 'CLADDING', 'FLOORING', 'INSULATION', 'MEMBRANE', 'MOLDING', 'NOTDEFINED', 'ROOFING', 'SKIRTINGBOARD', 'SLEEVING', 'USERDEFINED', 'WRAPPING');
      };
  };
  CREATE TYPE default::IfcCurtainWallType EXTENDING default::IfcBuildingElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcBuildingStorey EXTENDING default::IfcSpatialStructureElement {
      CREATE PROPERTY Elevation -> std::float64;
  };
  CREATE TYPE default::IfcChimney EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCivilElementType EXTENDING default::IfcElementType;
  CREATE TYPE default::IfcColumn EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('COLUMN', 'NOTDEFINED', 'PILASTER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcColumnStandardCase EXTENDING default::IfcColumn;
  CREATE TYPE default::IfcConstructionEquipmentResourceType EXTENDING default::IfcConstructionResourceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DEMOLISHING', 'EARTHMOVING', 'ERECTING', 'HEATING', 'LIGHTING', 'NOTDEFINED', 'PAVING', 'PUMPING', 'TRANSPORTING', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcConstructionMaterialResourceType EXTENDING default::IfcConstructionResourceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AGGREGATES', 'CONCRETE', 'DRYWALL', 'FUEL', 'GYPSUM', 'MASONRY', 'METAL', 'NOTDEFINED', 'PLASTIC', 'USERDEFINED', 'WOOD');
      };
  };
  CREATE TYPE default::IfcConstructionProductResourceType EXTENDING default::IfcConstructionResourceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ASSEMBLY', 'FORMWORK', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcController EXTENDING default::IfcDistributionControlElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FLOATING', 'MULTIPOSITION', 'NOTDEFINED', 'PROGRAMMABLE', 'PROPORTIONAL', 'TWOPOSITION', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCovering EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CEILING', 'CLADDING', 'FLOORING', 'INSULATION', 'MEMBRANE', 'MOLDING', 'NOTDEFINED', 'ROOFING', 'SKIRTINGBOARD', 'SLEEVING', 'USERDEFINED', 'WRAPPING');
      };
  };
  CREATE TYPE default::IfcCrewResourceType EXTENDING default::IfcConstructionResourceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'OFFICE', 'SITE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCurtainWall EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcDiscreteAccessory EXTENDING default::IfcElementComponent {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ANCHORPLATE', 'BRACKET', 'NOTDEFINED', 'SHOE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcDiscreteAccessoryType EXTENDING default::IfcElementComponentType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ANCHORPLATE', 'BRACKET', 'NOTDEFINED', 'SHOE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcDistributionFlowElement EXTENDING default::IfcDistributionElement;
  CREATE TYPE default::IfcDistributionChamberElement EXTENDING default::IfcDistributionFlowElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FORMEDDUCT', 'INSPECTIONCHAMBER', 'INSPECTIONPIT', 'MANHOLE', 'METERCHAMBER', 'NOTDEFINED', 'SUMP', 'TRENCH', 'USERDEFINED', 'VALVECHAMBER');
      };
  };
  CREATE TYPE default::IfcDistributionCircuit EXTENDING default::IfcDistributionSystem;
  CREATE TYPE default::IfcDistributionElementType EXTENDING default::IfcElementType;
  CREATE TYPE default::IfcDoor EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY OperationType -> std::str {
          CREATE CONSTRAINT std::one_of('DOUBLE_DOOR_DOUBLE_SWING', 'DOUBLE_DOOR_FOLDING', 'DOUBLE_DOOR_SINGLE_SWING', 'DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_LEFT', 'DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_RIGHT', 'DOUBLE_DOOR_SLIDING', 'DOUBLE_SWING_LEFT', 'DOUBLE_SWING_RIGHT', 'FOLDING_TO_LEFT', 'FOLDING_TO_RIGHT', 'NOTDEFINED', 'REVOLVING', 'ROLLINGUP', 'SINGLE_SWING_LEFT', 'SINGLE_SWING_RIGHT', 'SLIDING_TO_LEFT', 'SLIDING_TO_RIGHT', 'SWING_FIXED_LEFT', 'SWING_FIXED_RIGHT', 'USERDEFINED');
      };
      CREATE PROPERTY OverallHeight -> std::float64;
      CREATE PROPERTY OverallWidth -> std::float64;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DOOR', 'GATE', 'NOTDEFINED', 'TRAPDOOR', 'USERDEFINED');
      };
      CREATE PROPERTY UserDefinedOperationType -> std::str;
  };
  CREATE TYPE default::IfcElementAssemblyType EXTENDING default::IfcElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ACCESSORY_ASSEMBLY', 'ARCH', 'BEAM_GRID', 'BRACED_FRAME', 'GIRDER', 'NOTDEFINED', 'REINFORCEMENT_UNIT', 'RIGID_FRAME', 'SLAB_FIELD', 'TRUSS', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcExternalReferenceRelationship EXTENDING default::IfcResourceLevelRelationship {
      CREATE REQUIRED MULTI LINK RelatedResourceObjects -> default::IfcResourceObjectSelect;
      CREATE REQUIRED LINK RelatingReference -> default::IfcExternalReference;
  };
  CREATE TYPE default::IfcExternalSpatialElement EXTENDING default::IfcExternalSpatialStructureElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('EXTERNAL', 'EXTERNAL_EARTH', 'EXTERNAL_FIRE', 'EXTERNAL_WATER', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcFastener EXTENDING default::IfcElementComponent {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('GLUE', 'MORTAR', 'NOTDEFINED', 'USERDEFINED', 'WELD');
      };
  };
  CREATE ABSTRACT TYPE default::IfcFeatureElementAddition EXTENDING default::IfcFeatureElement;
  CREATE ABSTRACT TYPE default::IfcFeatureElementSubtraction EXTENDING default::IfcFeatureElement;
  CREATE TYPE default::IfcFooting EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CAISSON_FOUNDATION', 'FOOTING_BEAM', 'NOTDEFINED', 'PAD_FOOTING', 'PILE_CAP', 'STRIP_FOOTING', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcFurnishingElementType EXTENDING default::IfcElementType;
  CREATE TYPE default::IfcFurniture EXTENDING default::IfcFurnishingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BED', 'CHAIR', 'DESK', 'FILECABINET', 'NOTDEFINED', 'SHELF', 'SOFA', 'TABLE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcGeographicElementType EXTENDING default::IfcElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'TERRAIN', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcLaborResourceType EXTENDING default::IfcConstructionResourceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ADMINISTRATION', 'CARPENTRY', 'CLEANING', 'CONCRETE', 'DRYWALL', 'ELECTRIC', 'FINISHING', 'FLOORING', 'GENERAL', 'HVAC', 'LANDSCAPING', 'MASONRY', 'NOTDEFINED', 'PAINTING', 'PAVING', 'PLUMBING', 'ROOFING', 'SITEGRADING', 'STEELWORK', 'SURVEYING', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcMechanicalFastener EXTENDING default::IfcElementComponent {
      CREATE PROPERTY NominalDiameter -> std::float64;
      CREATE PROPERTY NominalLength -> std::float64;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ANCHORBOLT', 'BOLT', 'DOWEL', 'NAIL', 'NAILPLATE', 'NOTDEFINED', 'RIVET', 'SCREW', 'SHEARCONNECTOR', 'STAPLE', 'STUDSHEARCONNECTOR', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcMember EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BRACE', 'CHORD', 'COLLAR', 'MEMBER', 'MULLION', 'NOTDEFINED', 'PLATE', 'POST', 'PURLIN', 'RAFTER', 'STRINGER', 'STRUT', 'STUD', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcPile EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY ConstructionType -> std::str {
          CREATE CONSTRAINT std::one_of('CAST_IN_PLACE', 'COMPOSITE', 'NOTDEFINED', 'PRECAST_CONCRETE', 'PREFAB_STEEL', 'USERDEFINED');
      };
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BORED', 'COHESION', 'DRIVEN', 'FRICTION', 'JETGROUTING', 'NOTDEFINED', 'SUPPORT', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcPlate EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CURTAIN_PANEL', 'NOTDEFINED', 'SHEET', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcPresentationStyleAssignment {
      CREATE REQUIRED MULTI LINK Styles -> default::IfcPresentationStyleSelect;
  };
  CREATE TYPE default::IfcRailing EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BALUSTRADE', 'GUARDRAIL', 'HANDRAIL', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcRamp EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('HALF_TURN_RAMP', 'NOTDEFINED', 'QUARTER_TURN_RAMP', 'SPIRAL_RAMP', 'STRAIGHT_RUN_RAMP', 'TWO_QUARTER_TURN_RAMP', 'TWO_STRAIGHT_RUN_RAMP', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcRampFlight EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'SPIRAL', 'STRAIGHT', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcReinforcingElement EXTENDING default::IfcElementComponent {
      CREATE PROPERTY SteelGrade -> std::str;
  };
  CREATE TYPE default::IfcRelAssignsToProcess EXTENDING default::IfcRelAssigns {
      CREATE LINK QuantityInProcess -> default::IfcMeasureWithUnit;
      CREATE REQUIRED LINK RelatingProcess -> default::IfcProcessSelect;
  };
  CREATE TYPE default::IfcRelAssignsToProduct EXTENDING default::IfcRelAssigns {
      CREATE REQUIRED LINK RelatingProduct -> default::IfcProductSelect;
  };
  CREATE TYPE default::IfcRelAssignsToResource EXTENDING default::IfcRelAssigns {
      CREATE REQUIRED LINK RelatingResource -> default::IfcResourceSelect;
  };
  CREATE TYPE default::IfcRelConnectsPathElements EXTENDING default::IfcRelConnectsElements {
      CREATE REQUIRED PROPERTY RelatedConnectionType -> std::str {
          CREATE CONSTRAINT std::one_of('ATEND', 'ATPATH', 'ATSTART', 'NOTDEFINED');
      };
      CREATE REQUIRED PROPERTY RelatedPriorities -> tuple<std::int64>;
      CREATE REQUIRED PROPERTY RelatingConnectionType -> std::str {
          CREATE CONSTRAINT std::one_of('ATEND', 'ATPATH', 'ATSTART', 'NOTDEFINED');
      };
      CREATE REQUIRED PROPERTY RelatingPriorities -> tuple<std::int64>;
  };
  CREATE TYPE default::IfcRelConnectsPortToElement EXTENDING default::IfcRelConnects {
      CREATE REQUIRED LINK RelatedElement -> default::IfcDistributionElement;
      CREATE REQUIRED LINK RelatingPort -> default::IfcPort;
  };
  CREATE TYPE default::IfcRelConnectsStructuralActivity EXTENDING default::IfcRelConnects {
      CREATE REQUIRED LINK RelatedStructuralActivity -> default::IfcStructuralActivity;
      CREATE REQUIRED LINK RelatingElement -> default::IfcStructuralActivityAssignmentSelect;
  };
  CREATE TYPE default::IfcRelConnectsStructuralMember EXTENDING default::IfcRelConnects {
      CREATE LINK AdditionalConditions -> default::IfcStructuralConnectionCondition;
      CREATE LINK AppliedCondition -> default::IfcBoundaryCondition;
      CREATE LINK ConditionCoordinateSystem -> default::IfcAxis2Placement3D;
      CREATE REQUIRED LINK RelatedStructuralConnection -> default::IfcStructuralConnection;
      CREATE REQUIRED LINK RelatingStructuralMember -> default::IfcStructuralMember;
      CREATE PROPERTY SupportedLength -> std::float64;
  };
  CREATE TYPE default::IfcRelConnectsWithRealizingElements EXTENDING default::IfcRelConnectsElements {
      CREATE REQUIRED MULTI LINK RealizingElements -> default::IfcElement;
      CREATE PROPERTY ConnectionType -> std::str;
  };
  CREATE TYPE default::IfcResourceApprovalRelationship EXTENDING default::IfcResourceLevelRelationship {
      CREATE REQUIRED MULTI LINK RelatedResourceObjects -> default::IfcResourceObjectSelect;
      CREATE REQUIRED LINK RelatingApproval -> default::IfcApproval;
  };
  CREATE TYPE default::IfcResourceConstraintRelationship EXTENDING default::IfcResourceLevelRelationship {
      CREATE REQUIRED MULTI LINK RelatedResourceObjects -> default::IfcResourceObjectSelect;
      CREATE REQUIRED LINK RelatingConstraint -> default::IfcConstraint;
  };
  CREATE TYPE default::IfcRoof EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BARREL_ROOF', 'BUTTERFLY_ROOF', 'DOME_ROOF', 'FLAT_ROOF', 'FREEFORM', 'GABLE_ROOF', 'GAMBREL_ROOF', 'HIPPED_GABLE_ROOF', 'HIP_ROOF', 'MANSARD_ROOF', 'NOTDEFINED', 'PAVILION_ROOF', 'RAINBOW_ROOF', 'SHED_ROOF', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcShadingDevice EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AWNING', 'JALOUSIE', 'NOTDEFINED', 'SHUTTER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSite EXTENDING default::IfcSpatialStructureElement {
      CREATE LINK SiteAddress -> default::IfcPostalAddress;
      CREATE PROPERTY LandTitleNumber -> std::str;
      CREATE PROPERTY RefElevation -> std::float64;
      CREATE PROPERTY RefLatitude -> std::int64;
      CREATE PROPERTY RefLongitude -> std::int64;
  };
  CREATE TYPE default::IfcSlab EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BASESLAB', 'FLOOR', 'LANDING', 'NOTDEFINED', 'ROOF', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSpace EXTENDING default::IfcSpatialStructureElement {
      CREATE PROPERTY ElevationWithFlooring -> std::float64;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('EXTERNAL', 'GFA', 'INTERNAL', 'NOTDEFINED', 'PARKING', 'SPACE', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcSpatialStructureElementType EXTENDING default::IfcSpatialElementType;
  CREATE TYPE default::IfcSpatialZoneType EXTENDING default::IfcSpatialElementType {
      CREATE PROPERTY LongName -> std::str;
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONSTRUCTION', 'FIRESAFETY', 'LIGHTING', 'NOTDEFINED', 'OCCUPANCY', 'SECURITY', 'THERMAL', 'TRANSPORT', 'USERDEFINED', 'VENTILATION');
      };
  };
  CREATE TYPE default::IfcStair EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CURVED_RUN_STAIR', 'DOUBLE_RETURN_STAIR', 'HALF_TURN_STAIR', 'HALF_WINDING_STAIR', 'NOTDEFINED', 'QUARTER_TURN_STAIR', 'QUARTER_WINDING_STAIR', 'SPIRAL_STAIR', 'STRAIGHT_RUN_STAIR', 'THREE_QUARTER_TURN_STAIR', 'THREE_QUARTER_WINDING_STAIR', 'TWO_CURVED_RUN_STAIR', 'TWO_QUARTER_TURN_STAIR', 'TWO_QUARTER_WINDING_STAIR', 'TWO_STRAIGHT_RUN_STAIR', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcStairFlight EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY NumberOfRisers -> std::int64;
      CREATE PROPERTY NumberOfTreads -> std::int64;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CURVED', 'FREEFORM', 'NOTDEFINED', 'SPIRAL', 'STRAIGHT', 'USERDEFINED', 'WINDER');
      };
      CREATE PROPERTY RiserHeight -> std::float64;
      CREATE PROPERTY TreadLength -> std::float64;
  };
  CREATE TYPE default::IfcStructuralAnalysisModel EXTENDING default::IfcSystem {
      CREATE MULTI LINK HasResults -> default::IfcStructuralResultGroup;
      CREATE MULTI LINK LoadedBy -> default::IfcStructuralLoadGroup;
      CREATE LINK OrientationOf2DPlane -> default::IfcAxis2Placement3D;
      CREATE LINK SharedPlacement -> default::IfcObjectPlacement;
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('IN_PLANE_LOADING_2D', 'LOADING_3D', 'NOTDEFINED', 'OUT_PLANE_LOADING_2D', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcStructuralCurveAction EXTENDING default::IfcStructuralAction {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONST', 'DISCRETE', 'EQUIDISTANT', 'LINEAR', 'NOTDEFINED', 'PARABOLA', 'POLYGONAL', 'SINUS', 'USERDEFINED');
      };
      CREATE PROPERTY ProjectedOrTrue -> std::str {
          CREATE CONSTRAINT std::one_of('PROJECTED_LENGTH', 'TRUE_LENGTH');
      };
  };
  CREATE TYPE default::IfcStructuralCurveConnection EXTENDING default::IfcStructuralConnection {
      CREATE REQUIRED LINK Axis -> default::IfcDirection;
  };
  CREATE TYPE default::IfcStructuralCurveMember EXTENDING default::IfcStructuralMember {
      CREATE REQUIRED LINK Axis -> default::IfcDirection;
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CABLE', 'COMPRESSION_MEMBER', 'NOTDEFINED', 'PIN_JOINED_MEMBER', 'RIGID_JOINED_MEMBER', 'TENSION_MEMBER', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcStructuralCurveReaction EXTENDING default::IfcStructuralReaction {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONST', 'DISCRETE', 'EQUIDISTANT', 'LINEAR', 'NOTDEFINED', 'PARABOLA', 'POLYGONAL', 'SINUS', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcStructuralPointAction EXTENDING default::IfcStructuralAction;
  CREATE TYPE default::IfcStructuralPointConnection EXTENDING default::IfcStructuralConnection {
      CREATE LINK ConditionCoordinateSystem -> default::IfcAxis2Placement3D;
  };
  CREATE TYPE default::IfcStructuralPointReaction EXTENDING default::IfcStructuralReaction;
  CREATE TYPE default::IfcStructuralSurfaceAction EXTENDING default::IfcStructuralAction {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BILINEAR', 'CONST', 'DISCRETE', 'ISOCONTOUR', 'NOTDEFINED', 'USERDEFINED');
      };
      CREATE PROPERTY ProjectedOrTrue -> std::str {
          CREATE CONSTRAINT std::one_of('PROJECTED_LENGTH', 'TRUE_LENGTH');
      };
  };
  CREATE TYPE default::IfcStructuralSurfaceConnection EXTENDING default::IfcStructuralConnection;
  CREATE TYPE default::IfcStructuralSurfaceMember EXTENDING default::IfcStructuralMember {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BENDING_ELEMENT', 'MEMBRANE_ELEMENT', 'NOTDEFINED', 'SHELL', 'USERDEFINED');
      };
      CREATE PROPERTY Thickness -> std::float64;
  };
  CREATE TYPE default::IfcStructuralSurfaceReaction EXTENDING default::IfcStructuralReaction {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('BILINEAR', 'CONST', 'DISCRETE', 'ISOCONTOUR', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSubContractResourceType EXTENDING default::IfcConstructionResourceType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'PURCHASE', 'USERDEFINED', 'WORK');
      };
  };
  CREATE TYPE default::IfcSurfaceFeature EXTENDING default::IfcFeatureElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('MARK', 'NOTDEFINED', 'TAG', 'TREATMENT', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSystemFurnitureElement EXTENDING default::IfcFurnishingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'PANEL', 'USERDEFINED', 'WORKSURFACE');
      };
  };
  CREATE TYPE default::IfcTransportElementType EXTENDING default::IfcElementType {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CRANEWAY', 'ELEVATOR', 'ESCALATOR', 'LIFTINGGEAR', 'MOVINGWALKWAY', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcVibrationIsolator EXTENDING default::IfcElementComponent {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('COMPRESSION', 'NOTDEFINED', 'SPRING', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcWall EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ELEMENTEDWALL', 'MOVABLE', 'NOTDEFINED', 'PARAPET', 'PARTITIONING', 'PLUMBINGWALL', 'POLYGONAL', 'SHEAR', 'SOLIDWALL', 'STANDARD', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcWindow EXTENDING default::IfcBuildingElement {
      CREATE PROPERTY OverallHeight -> std::float64;
      CREATE PROPERTY OverallWidth -> std::float64;
      CREATE PROPERTY PartitioningType -> std::str {
          CREATE CONSTRAINT std::one_of('DOUBLE_PANEL_HORIZONTAL', 'DOUBLE_PANEL_VERTICAL', 'NOTDEFINED', 'SINGLE_PANEL', 'TRIPLE_PANEL_BOTTOM', 'TRIPLE_PANEL_HORIZONTAL', 'TRIPLE_PANEL_LEFT', 'TRIPLE_PANEL_RIGHT', 'TRIPLE_PANEL_TOP', 'TRIPLE_PANEL_VERTICAL', 'USERDEFINED');
      };
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('LIGHTDOME', 'NOTDEFINED', 'SKYLIGHT', 'USERDEFINED', 'WINDOW');
      };
      CREATE PROPERTY UserDefinedPartitioningType -> std::str;
  };
  CREATE TYPE default::IfcWindowPanelProperties EXTENDING default::IfcPreDefinedPropertySet {
      CREATE LINK ShapeAspectStyle -> default::IfcShapeAspect;
      CREATE PROPERTY FrameDepth -> std::float64;
      CREATE PROPERTY FrameThickness -> std::float64;
      CREATE REQUIRED PROPERTY OperationType -> std::str {
          CREATE CONSTRAINT std::one_of('BOTTOMHUNG', 'FIXEDCASEMENT', 'NOTDEFINED', 'OTHEROPERATION', 'PIVOTHORIZONTAL', 'PIVOTVERTICAL', 'REMOVABLECASEMENT', 'SIDEHUNGLEFTHAND', 'SIDEHUNGRIGHTHAND', 'SLIDINGHORIZONTAL', 'SLIDINGVERTICAL', 'TILTANDTURNLEFTHAND', 'TILTANDTURNRIGHTHAND', 'TOPHUNG');
      };
      CREATE REQUIRED PROPERTY PanelPosition -> std::str {
          CREATE CONSTRAINT std::one_of('BOTTOM', 'LEFT', 'MIDDLE', 'NOTDEFINED', 'RIGHT', 'TOP');
      };
  };
  CREATE TYPE default::IfcWindowStyle EXTENDING default::IfcTypeProduct {
      CREATE REQUIRED PROPERTY ConstructionType -> std::str {
          CREATE CONSTRAINT std::one_of('ALUMINIUM', 'ALUMINIUM_WOOD', 'HIGH_GRADE_STEEL', 'NOTDEFINED', 'OTHER_CONSTRUCTION', 'PLASTIC', 'STEEL', 'WOOD');
      };
      CREATE REQUIRED PROPERTY OperationType -> std::str {
          CREATE CONSTRAINT std::one_of('DOUBLE_PANEL_HORIZONTAL', 'DOUBLE_PANEL_VERTICAL', 'NOTDEFINED', 'SINGLE_PANEL', 'TRIPLE_PANEL_BOTTOM', 'TRIPLE_PANEL_HORIZONTAL', 'TRIPLE_PANEL_LEFT', 'TRIPLE_PANEL_RIGHT', 'TRIPLE_PANEL_TOP', 'TRIPLE_PANEL_VERTICAL', 'USERDEFINED');
      };
      CREATE REQUIRED PROPERTY ParameterTakesPrecedence -> std::bool;
      CREATE REQUIRED PROPERTY Sizeable -> std::bool;
  };
  CREATE TYPE default::IfcWorkPlan EXTENDING default::IfcWorkControl {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ACTUAL', 'BASELINE', 'NOTDEFINED', 'PLANNED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcWorkSchedule EXTENDING default::IfcWorkControl {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ACTUAL', 'BASELINE', 'NOTDEFINED', 'PLANNED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcZone EXTENDING default::IfcSystem {
      CREATE PROPERTY LongName -> std::str;
  };
};

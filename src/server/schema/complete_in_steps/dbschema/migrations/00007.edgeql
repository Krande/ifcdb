CREATE MIGRATION m1hx2hetjpjnst3guqtzsv7q5uquy6sk6gz4k6nequxa7y63s36rwa
    ONTO m1xzibi2wr6oqfp64ffuxwg3ypyats7fl4ip4avmtnimsns5hozf6q
{
  CREATE TYPE default::IfcShapeAspect {
      CREATE LINK PartOfProductDefinitionShape -> default::IfcProductRepresentationSelect;
      CREATE REQUIRED MULTI LINK ShapeRepresentations -> default::IfcShapeModel;
      CREATE PROPERTY Description -> std::str;
      CREATE PROPERTY Name -> std::str;
      CREATE REQUIRED PROPERTY ProductDefinitional -> std::bool;
  };
  CREATE TYPE default::IfcResourceObjectSelect {
      CREATE LINK IfcResourceObjectSelect -> ((((((((((((((((default::IfcConstraint | default::IfcMaterialDefinition) | default::IfcExternalInformation) | default::IfcPhysicalQuantity) | default::IfcOrganization) | default::IfcPropertyAbstraction) | default::IfcActorRole) | default::IfcConversionBasedUnit) | default::IfcPersonAndOrganization) | default::IfcContextDependentUnit) | default::IfcShapeAspect) | default::IfcTimeSeries) | default::IfcPerson) | default::IfcExternalReference) | default::IfcApproval) | default::IfcProfileDef) | default::IfcAppliedValue);
  };
  CREATE TYPE default::IfcFillAreaStyle EXTENDING default::IfcPresentationStyle {
      CREATE REQUIRED MULTI LINK FillStyles -> default::IfcFillStyleSelect;
      CREATE PROPERTY ModelorDraughting -> std::bool;
  };
  CREATE TYPE default::IfcSurfaceStyle EXTENDING default::IfcPresentationStyle {
      CREATE REQUIRED MULTI LINK Styles -> default::IfcSurfaceStyleElementSelect;
      CREATE REQUIRED PROPERTY Side -> std::str {
          CREATE CONSTRAINT std::one_of('BOTH', 'NEGATIVE', 'POSITIVE');
      };
  };
  CREATE TYPE default::IfcPresentationStyleSelect {
      CREATE LINK IfcPresentationStyleSelect -> ((((default::IfcNullStyle | default::IfcSurfaceStyle) | default::IfcCurveStyle) | default::IfcFillAreaStyle) | default::IfcTextStyle);
  };
  CREATE ABSTRACT TYPE default::IfcStructuralItem EXTENDING default::IfcProduct;
  CREATE TYPE default::IfcStructuralActivityAssignmentSelect {
      CREATE LINK IfcStructuralActivityAssignmentSelect -> (default::IfcStructuralItem | default::IfcElement);
  };
  CREATE ABSTRACT TYPE default::IfcTypeProcess EXTENDING default::IfcTypeObject {
      CREATE PROPERTY Identification -> std::str;
      CREATE PROPERTY LongDescription -> std::str;
      CREATE PROPERTY ProcessType -> std::str;
  };
  CREATE TYPE default::IfcProcessSelect {
      CREATE LINK IfcProcessSelect -> (default::IfcTypeProcess | default::IfcProcess);
  };
  CREATE TYPE default::IfcTypeProduct EXTENDING default::IfcTypeObject {
      CREATE MULTI LINK RepresentationMaps -> default::IfcRepresentationMap;
      CREATE PROPERTY Tag -> std::str;
  };
  CREATE TYPE default::IfcProductSelect {
      CREATE LINK IfcProductSelect -> (default::IfcTypeProduct | default::IfcProduct);
  };
  CREATE TYPE default::IfcPropertySetDefinitionSelect {
      CREATE LINK IfcPropertySetDefinitionSelect -> (default::IfcPropertySetDefinitionSet | default::IfcPropertySetDefinition);
  };
  CREATE ABSTRACT TYPE default::IfcTypeResource EXTENDING default::IfcTypeObject {
      CREATE PROPERTY Identification -> std::str;
      CREATE PROPERTY LongDescription -> std::str;
      CREATE PROPERTY ResourceType -> std::str;
  };
  CREATE TYPE default::IfcResourceSelect {
      CREATE LINK IfcResourceSelect -> (default::IfcResource | default::IfcTypeResource);
  };
  CREATE ABSTRACT TYPE default::IfcBuildingElement EXTENDING default::IfcElement;
  CREATE TYPE default::IfcSystem EXTENDING default::IfcGroup;
  CREATE TYPE default::IfcBuildingSystem EXTENDING default::IfcSystem {
      CREATE PROPERTY LongName -> std::str;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FENESTRATION', 'FOUNDATION', 'LOADBEARING', 'NOTDEFINED', 'OUTERSHELL', 'SHADING', 'TRANSPORT', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcCivilElement EXTENDING default::IfcElement;
  CREATE TYPE default::IfcConstructionEquipmentResource EXTENDING default::IfcConstructionResource {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('DEMOLISHING', 'EARTHMOVING', 'ERECTING', 'HEATING', 'LIGHTING', 'NOTDEFINED', 'PAVING', 'PUMPING', 'TRANSPORTING', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcConstructionMaterialResource EXTENDING default::IfcConstructionResource {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AGGREGATES', 'CONCRETE', 'DRYWALL', 'FUEL', 'GYPSUM', 'MASONRY', 'METAL', 'NOTDEFINED', 'PLASTIC', 'USERDEFINED', 'WOOD');
      };
  };
  CREATE TYPE default::IfcConstructionProductResource EXTENDING default::IfcConstructionResource {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ASSEMBLY', 'FORMWORK', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcConstructionResourceType EXTENDING default::IfcTypeResource {
      CREATE MULTI LINK BaseCosts -> default::IfcAppliedValue;
      CREATE LINK BaseQuantity -> default::IfcPhysicalQuantity;
  };
  CREATE TYPE default::IfcCrewResource EXTENDING default::IfcConstructionResource {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'OFFICE', 'SITE', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcDistributionElement EXTENDING default::IfcElement;
  CREATE ABSTRACT TYPE default::IfcPort EXTENDING default::IfcProduct;
  CREATE TYPE default::IfcDistributionPort EXTENDING default::IfcPort {
      CREATE PROPERTY FlowDirection -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'SINK', 'SOURCE', 'SOURCEANDSINK');
      };
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CABLE', 'CABLECARRIER', 'DUCT', 'NOTDEFINED', 'PIPE', 'USERDEFINED');
      };
      CREATE PROPERTY SystemType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRCONDITIONING', 'AUDIOVISUAL', 'CHEMICAL', 'CHILLEDWATER', 'COMMUNICATION', 'COMPRESSEDAIR', 'CONDENSERWATER', 'CONTROL', 'CONVEYING', 'DATA', 'DISPOSAL', 'DOMESTICCOLDWATER', 'DOMESTICHOTWATER', 'DRAINAGE', 'EARTHING', 'ELECTRICAL', 'ELECTROACOUSTIC', 'EXHAUST', 'FIREPROTECTION', 'FUEL', 'GAS', 'HAZARDOUS', 'HEATING', 'LIGHTING', 'LIGHTNINGPROTECTION', 'MUNICIPALSOLIDWASTE', 'NOTDEFINED', 'OIL', 'OPERATIONAL', 'POWERGENERATION', 'RAINWATER', 'REFRIGERATION', 'SECURITY', 'SEWAGE', 'SIGNAL', 'STORMWATER', 'TELEPHONE', 'TV', 'USERDEFINED', 'VACUUM', 'VENT', 'VENTILATION', 'WASTEWATER', 'WATERSUPPLY');
      };
  };
  CREATE TYPE default::IfcDistributionSystem EXTENDING default::IfcSystem {
      CREATE PROPERTY LongName -> std::str;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('AIRCONDITIONING', 'AUDIOVISUAL', 'CHEMICAL', 'CHILLEDWATER', 'COMMUNICATION', 'COMPRESSEDAIR', 'CONDENSERWATER', 'CONTROL', 'CONVEYING', 'DATA', 'DISPOSAL', 'DOMESTICCOLDWATER', 'DOMESTICHOTWATER', 'DRAINAGE', 'EARTHING', 'ELECTRICAL', 'ELECTROACOUSTIC', 'EXHAUST', 'FIREPROTECTION', 'FUEL', 'GAS', 'HAZARDOUS', 'HEATING', 'LIGHTING', 'LIGHTNINGPROTECTION', 'MUNICIPALSOLIDWASTE', 'NOTDEFINED', 'OIL', 'OPERATIONAL', 'POWERGENERATION', 'RAINWATER', 'REFRIGERATION', 'SECURITY', 'SEWAGE', 'SIGNAL', 'STORMWATER', 'TELEPHONE', 'TV', 'USERDEFINED', 'VACUUM', 'VENT', 'VENTILATION', 'WASTEWATER', 'WATERSUPPLY');
      };
  };
  CREATE TYPE default::IfcDoorLiningProperties EXTENDING default::IfcPreDefinedPropertySet {
      CREATE LINK ShapeAspectStyle -> default::IfcShapeAspect;
      CREATE PROPERTY CasingDepth -> std::float64;
      CREATE PROPERTY CasingThickness -> std::float64;
      CREATE PROPERTY LiningDepth -> std::float64;
      CREATE PROPERTY LiningOffset -> std::float64;
      CREATE PROPERTY LiningThickness -> std::float64;
      CREATE PROPERTY LiningToPanelOffsetX -> std::float64;
      CREATE PROPERTY LiningToPanelOffsetY -> std::float64;
      CREATE PROPERTY ThresholdDepth -> std::float64;
      CREATE PROPERTY ThresholdOffset -> std::float64;
      CREATE PROPERTY ThresholdThickness -> std::float64;
      CREATE PROPERTY TransomOffset -> std::float64;
      CREATE PROPERTY TransomThickness -> std::float64;
  };
  CREATE TYPE default::IfcDoorPanelProperties EXTENDING default::IfcPreDefinedPropertySet {
      CREATE LINK ShapeAspectStyle -> default::IfcShapeAspect;
      CREATE PROPERTY PanelDepth -> std::float64;
      CREATE REQUIRED PROPERTY PanelOperation -> std::str {
          CREATE CONSTRAINT std::one_of('DOUBLE_ACTING', 'FIXEDPANEL', 'FOLDING', 'NOTDEFINED', 'REVOLVING', 'ROLLINGUP', 'SLIDING', 'SWINGING', 'USERDEFINED');
      };
      CREATE REQUIRED PROPERTY PanelPosition -> std::str {
          CREATE CONSTRAINT std::one_of('LEFT', 'MIDDLE', 'NOTDEFINED', 'RIGHT');
      };
      CREATE PROPERTY PanelWidth -> std::float64;
  };
  CREATE TYPE default::IfcDoorStyle EXTENDING default::IfcTypeProduct {
      CREATE REQUIRED PROPERTY ConstructionType -> std::str {
          CREATE CONSTRAINT std::one_of('ALUMINIUM', 'ALUMINIUM_PLASTIC', 'ALUMINIUM_WOOD', 'HIGH_GRADE_STEEL', 'NOTDEFINED', 'PLASTIC', 'STEEL', 'USERDEFINED', 'WOOD');
      };
      CREATE REQUIRED PROPERTY OperationType -> std::str {
          CREATE CONSTRAINT std::one_of('DOUBLE_DOOR_DOUBLE_SWING', 'DOUBLE_DOOR_FOLDING', 'DOUBLE_DOOR_SINGLE_SWING', 'DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_LEFT', 'DOUBLE_DOOR_SINGLE_SWING_OPPOSITE_RIGHT', 'DOUBLE_DOOR_SLIDING', 'DOUBLE_SWING_LEFT', 'DOUBLE_SWING_RIGHT', 'FOLDING_TO_LEFT', 'FOLDING_TO_RIGHT', 'NOTDEFINED', 'REVOLVING', 'ROLLINGUP', 'SINGLE_SWING_LEFT', 'SINGLE_SWING_RIGHT', 'SLIDING_TO_LEFT', 'SLIDING_TO_RIGHT', 'USERDEFINED');
      };
      CREATE REQUIRED PROPERTY ParameterTakesPrecedence -> std::bool;
      CREATE REQUIRED PROPERTY Sizeable -> std::bool;
  };
  CREATE TYPE default::IfcElementAssembly EXTENDING default::IfcElement {
      CREATE PROPERTY AssemblyPlace -> std::str {
          CREATE CONSTRAINT std::one_of('FACTORY', 'NOTDEFINED', 'SITE');
      };
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ACCESSORY_ASSEMBLY', 'ARCH', 'BEAM_GRID', 'BRACED_FRAME', 'GIRDER', 'NOTDEFINED', 'REINFORCEMENT_UNIT', 'RIGID_FRAME', 'SLAB_FIELD', 'TRUSS', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcElementComponent EXTENDING default::IfcElement;
  CREATE ABSTRACT TYPE default::IfcElementType EXTENDING default::IfcTypeProduct {
      CREATE PROPERTY ElementType -> std::str;
  };
  CREATE TYPE default::IfcEventType EXTENDING default::IfcTypeProcess {
      CREATE REQUIRED PROPERTY EventTriggerType -> std::str {
          CREATE CONSTRAINT std::one_of('EVENTCOMPLEX', 'EVENTMESSAGE', 'EVENTRULE', 'EVENTTIME', 'NOTDEFINED', 'USERDEFINED');
      };
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ENDEVENT', 'INTERMEDIATEEVENT', 'NOTDEFINED', 'STARTEVENT', 'USERDEFINED');
      };
      CREATE PROPERTY UserDefinedEventTriggerType -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcSpatialElement EXTENDING default::IfcProduct {
      CREATE PROPERTY LongName -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcExternalSpatialStructureElement EXTENDING default::IfcSpatialElement;
  CREATE TYPE default::IfcFacetedBrepWithVoids EXTENDING default::IfcFacetedBrep {
      CREATE REQUIRED MULTI LINK Voids -> default::IfcClosedShell;
  };
  CREATE ABSTRACT TYPE default::IfcFeatureElement EXTENDING default::IfcElement;
  CREATE TYPE default::IfcFurnishingElement EXTENDING default::IfcElement;
  CREATE TYPE default::IfcGeographicElement EXTENDING default::IfcElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'TERRAIN', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcPositioningElement EXTENDING default::IfcProduct;
  CREATE TYPE default::IfcGrid EXTENDING default::IfcPositioningElement {
      CREATE REQUIRED MULTI LINK UAxes -> default::IfcGridAxis;
      CREATE REQUIRED MULTI LINK VAxes -> default::IfcGridAxis;
      CREATE MULTI LINK WAxes -> default::IfcGridAxis;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('IRREGULAR', 'NOTDEFINED', 'RADIAL', 'RECTANGULAR', 'TRIANGULAR', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcIndexedTriangleTextureMap EXTENDING default::IfcIndexedTextureMap {
      CREATE PROPERTY TexCoordIndex -> array<tuple<std::int64, std::int64, std::int64>>;
  };
  CREATE TYPE default::IfcInventory EXTENDING default::IfcGroup {
      CREATE LINK CurrentValue -> default::IfcCostValue;
      CREATE LINK Jurisdiction -> default::IfcActorSelect;
      CREATE LINK OriginalValue -> default::IfcCostValue;
      CREATE MULTI LINK ResponsiblePersons -> default::IfcPerson;
      CREATE PROPERTY LastUpdateDate -> std::str;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ASSETINVENTORY', 'FURNITUREINVENTORY', 'NOTDEFINED', 'SPACEINVENTORY', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcLaborResource EXTENDING default::IfcConstructionResource {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ADMINISTRATION', 'CARPENTRY', 'CLEANING', 'CONCRETE', 'DRYWALL', 'ELECTRIC', 'FINISHING', 'FLOORING', 'GENERAL', 'HVAC', 'LANDSCAPING', 'MASONRY', 'NOTDEFINED', 'PAINTING', 'PAVING', 'PLUMBING', 'ROOFING', 'SITEGRADING', 'STEELWORK', 'SURVEYING', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcLinearPositioningElement EXTENDING default::IfcPositioningElement {
      CREATE REQUIRED LINK Axis -> default::IfcCurve;
  };
  CREATE TYPE default::IfcMapConversion EXTENDING default::IfcCoordinateOperation {
      CREATE REQUIRED PROPERTY Eastings -> std::float64;
      CREATE REQUIRED PROPERTY Northings -> std::float64;
      CREATE REQUIRED PROPERTY OrthogonalHeight -> std::float64;
      CREATE PROPERTY Scale -> std::float64;
      CREATE PROPERTY XAxisAbscissa -> std::float64;
      CREATE PROPERTY XAxisOrdinate -> std::float64;
  };
  CREATE TYPE default::IfcMetric EXTENDING default::IfcConstraint {
      CREATE LINK DataValue -> default::IfcMetricValueSelect;
      CREATE LINK ReferencePath -> default::IfcReference;
      CREATE REQUIRED PROPERTY Benchmark -> std::str {
          CREATE CONSTRAINT std::one_of('EQUALTO', 'GREATERTHAN', 'GREATERTHANOREQUALTO', 'INCLUDEDIN', 'INCLUDES', 'LESSTHAN', 'LESSTHANOREQUALTO', 'NOTEQUALTO', 'NOTINCLUDEDIN', 'NOTINCLUDES');
      };
      CREATE PROPERTY ValueSource -> std::str;
  };
  CREATE TYPE default::IfcOccupant EXTENDING default::IfcActor {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ASSIGNEE', 'ASSIGNOR', 'LESSEE', 'LESSOR', 'LETTINGAGENT', 'NOTDEFINED', 'OWNER', 'TENANT', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcPerformanceHistory EXTENDING default::IfcControl {
      CREATE REQUIRED PROPERTY LifeCyclePhase -> std::str;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcPermeableCoveringProperties EXTENDING default::IfcPreDefinedPropertySet {
      CREATE LINK ShapeAspectStyle -> default::IfcShapeAspect;
      CREATE PROPERTY FrameDepth -> std::float64;
      CREATE PROPERTY FrameThickness -> std::float64;
      CREATE REQUIRED PROPERTY OperationType -> std::str {
          CREATE CONSTRAINT std::one_of('GRILL', 'LOUVER', 'NOTDEFINED', 'SCREEN', 'USERDEFINED');
      };
      CREATE REQUIRED PROPERTY PanelPosition -> std::str {
          CREATE CONSTRAINT std::one_of('BOTTOM', 'LEFT', 'MIDDLE', 'NOTDEFINED', 'RIGHT', 'TOP');
      };
  };
  CREATE TYPE default::IfcPermit EXTENDING default::IfcControl {
      CREATE PROPERTY LongDescription -> std::str;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ACCESS', 'BUILDING', 'NOTDEFINED', 'USERDEFINED', 'WORK');
      };
      CREATE PROPERTY Status -> std::str;
  };
  CREATE TYPE default::IfcRelConnectsPorts EXTENDING default::IfcRelConnects {
      CREATE REQUIRED LINK RelatedPort -> default::IfcPort;
      CREATE REQUIRED LINK RelatingPort -> default::IfcPort;
      CREATE LINK RealizingElement -> default::IfcElement;
  };
  CREATE TYPE default::IfcReferent EXTENDING default::IfcPositioningElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('KILOPOINT', 'MILEPOINT', 'NOTDEFINED', 'STATION', 'USERDEFINED');
      };
      CREATE PROPERTY RestartDistance -> std::float64;
  };
  CREATE TYPE default::IfcProcedure EXTENDING default::IfcProcess {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ADVICE_CAUTION', 'ADVICE_NOTE', 'ADVICE_WARNING', 'CALIBRATION', 'DIAGNOSTIC', 'NOTDEFINED', 'SHUTDOWN', 'STARTUP', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcProcedureType EXTENDING default::IfcTypeProcess {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ADVICE_CAUTION', 'ADVICE_NOTE', 'ADVICE_WARNING', 'CALIBRATION', 'DIAGNOSTIC', 'NOTDEFINED', 'SHUTDOWN', 'STARTUP', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcProjectOrder EXTENDING default::IfcControl {
      CREATE PROPERTY LongDescription -> std::str;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CHANGEORDER', 'MAINTENANCEWORKORDER', 'MOVEORDER', 'NOTDEFINED', 'PURCHASEORDER', 'USERDEFINED', 'WORKORDER');
      };
      CREATE PROPERTY Status -> std::str;
  };
  CREATE TYPE default::IfcPropertyReferenceValue EXTENDING default::IfcSimpleProperty {
      CREATE LINK PropertyReference -> default::IfcObjectReferenceSelect;
      CREATE PROPERTY UsageName -> std::str;
  };
  CREATE TYPE default::IfcRelDefinesByProperties EXTENDING default::IfcRelDefines {
      CREATE REQUIRED LINK RelatingPropertyDefinition -> default::IfcPropertySetDefinitionSelect;
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcObjectDefinition;
  };
  CREATE TYPE default::IfcPropertySetTemplate EXTENDING default::IfcPropertyTemplateDefinition {
      CREATE REQUIRED MULTI LINK HasPropertyTemplates -> default::IfcPropertyTemplate;
      CREATE PROPERTY ApplicableEntity -> std::str;
      CREATE PROPERTY TemplateType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'PSET_OCCURRENCEDRIVEN', 'PSET_PERFORMANCEDRIVEN', 'PSET_TYPEDRIVENONLY', 'PSET_TYPEDRIVENOVERRIDE', 'QTO_OCCURRENCEDRIVEN', 'QTO_TYPEDRIVENONLY', 'QTO_TYPEDRIVENOVERRIDE');
      };
  };
  CREATE TYPE default::IfcRelDefinesByTemplate EXTENDING default::IfcRelDefines {
      CREATE REQUIRED LINK RelatingTemplate -> default::IfcPropertySetTemplate;
      CREATE REQUIRED MULTI LINK RelatedPropertySets -> default::IfcPropertySetDefinition;
  };
  CREATE TYPE default::IfcProxy EXTENDING default::IfcProduct {
      CREATE REQUIRED PROPERTY ProxyType -> std::str {
          CREATE CONSTRAINT std::one_of('ACTOR', 'CONTROL', 'GROUP', 'NOTDEFINED', 'PROCESS', 'PRODUCT', 'PROJECT', 'RESOURCE');
      };
      CREATE PROPERTY Tag -> std::str;
  };
  CREATE TYPE default::IfcReinforcementDefinitionProperties EXTENDING default::IfcPreDefinedPropertySet {
      CREATE REQUIRED MULTI LINK ReinforcementSectionDefinitions -> default::IfcSectionReinforcementProperties;
      CREATE PROPERTY DefinitionType -> std::str;
  };
  CREATE TYPE default::IfcRelAssignsToActor EXTENDING default::IfcRelAssigns {
      CREATE LINK ActingRole -> default::IfcActorRole;
      CREATE REQUIRED LINK RelatingActor -> default::IfcActor;
  };
  CREATE TYPE default::IfcRelAssignsToControl EXTENDING default::IfcRelAssigns {
      CREATE REQUIRED LINK RelatingControl -> default::IfcControl;
  };
  CREATE TYPE default::IfcRelAssignsToGroup EXTENDING default::IfcRelAssigns {
      CREATE REQUIRED LINK RelatingGroup -> default::IfcGroup;
  };
  CREATE TYPE default::IfcRelAssignsToGroupByFactor EXTENDING default::IfcRelAssignsToGroup {
      CREATE REQUIRED PROPERTY Factor -> std::float64;
  };
  CREATE TYPE default::IfcRelAssociatesApproval EXTENDING default::IfcRelAssociates {
      CREATE REQUIRED LINK RelatingApproval -> default::IfcApproval;
  };
  CREATE TYPE default::IfcRelAssociatesClassification EXTENDING default::IfcRelAssociates {
      CREATE REQUIRED LINK RelatingClassification -> default::IfcClassificationSelect;
  };
  CREATE TYPE default::IfcRelAssociatesConstraint EXTENDING default::IfcRelAssociates {
      CREATE REQUIRED LINK RelatingConstraint -> default::IfcConstraint;
      CREATE PROPERTY Intent -> std::str;
  };
  CREATE TYPE default::IfcRelAssociatesDocument EXTENDING default::IfcRelAssociates {
      CREATE REQUIRED LINK RelatingDocument -> default::IfcDocumentSelect;
  };
  CREATE TYPE default::IfcRelAssociatesLibrary EXTENDING default::IfcRelAssociates {
      CREATE REQUIRED LINK RelatingLibrary -> default::IfcLibrarySelect;
  };
  CREATE TYPE default::IfcRelAssociatesMaterial EXTENDING default::IfcRelAssociates {
      CREATE REQUIRED LINK RelatingMaterial -> default::IfcMaterialSelect;
  };
  CREATE TYPE default::IfcRelConnectsElements EXTENDING default::IfcRelConnects {
      CREATE LINK ConnectionGeometry -> default::IfcConnectionGeometry;
      CREATE REQUIRED LINK RelatedElement -> default::IfcElement;
      CREATE REQUIRED LINK RelatingElement -> default::IfcElement;
  };
  CREATE TYPE default::IfcRelContainedInSpatialStructure EXTENDING default::IfcRelConnects {
      CREATE REQUIRED MULTI LINK RelatedElements -> default::IfcProduct;
      CREATE REQUIRED LINK RelatingStructure -> default::IfcSpatialElement;
  };
  CREATE TYPE default::IfcRelDefinesByType EXTENDING default::IfcRelDefines {
      CREATE REQUIRED MULTI LINK RelatedObjects -> default::IfcObject;
      CREATE REQUIRED LINK RelatingType -> default::IfcTypeObject;
  };
  CREATE TYPE default::IfcRelInterferesElements EXTENDING default::IfcRelConnects {
      CREATE LINK InterferenceGeometry -> default::IfcConnectionGeometry;
      CREATE REQUIRED LINK RelatedElement -> default::IfcElement;
      CREATE REQUIRED LINK RelatingElement -> default::IfcElement;
      CREATE REQUIRED PROPERTY ImpliedOrder -> std::bool;
      CREATE PROPERTY InterferenceType -> std::str;
  };
  CREATE TYPE default::IfcRelReferencedInSpatialStructure EXTENDING default::IfcRelConnects {
      CREATE REQUIRED MULTI LINK RelatedElements -> default::IfcProduct;
      CREATE REQUIRED LINK RelatingStructure -> default::IfcSpatialElement;
  };
  CREATE TYPE default::IfcRelSequence EXTENDING default::IfcRelConnects {
      CREATE REQUIRED LINK RelatedProcess -> default::IfcProcess;
      CREATE REQUIRED LINK RelatingProcess -> default::IfcProcess;
      CREATE LINK TimeLag -> default::IfcLagTime;
      CREATE PROPERTY SequenceType -> std::str {
          CREATE CONSTRAINT std::one_of('FINISH_FINISH', 'FINISH_START', 'NOTDEFINED', 'START_FINISH', 'START_START', 'USERDEFINED');
      };
      CREATE PROPERTY UserDefinedSequenceType -> std::str;
  };
  CREATE TYPE default::IfcRelServicesBuildings EXTENDING default::IfcRelConnects {
      CREATE REQUIRED MULTI LINK RelatedBuildings -> default::IfcSpatialElement;
      CREATE REQUIRED LINK RelatingSystem -> default::IfcSystem;
  };
  CREATE TYPE default::IfcWindowLiningProperties EXTENDING default::IfcPreDefinedPropertySet {
      CREATE LINK ShapeAspectStyle -> default::IfcShapeAspect;
      CREATE PROPERTY FirstMullionOffset -> std::float64;
      CREATE PROPERTY FirstTransomOffset -> std::float64;
      CREATE PROPERTY LiningDepth -> std::float64;
      CREATE PROPERTY LiningOffset -> std::float64;
      CREATE PROPERTY LiningThickness -> std::float64;
      CREATE PROPERTY LiningToPanelOffsetX -> std::float64;
      CREATE PROPERTY LiningToPanelOffsetY -> std::float64;
      CREATE PROPERTY MullionThickness -> std::float64;
      CREATE PROPERTY SecondMullionOffset -> std::float64;
      CREATE PROPERTY SecondTransomOffset -> std::float64;
      CREATE PROPERTY TransomThickness -> std::float64;
  };
  CREATE TYPE default::IfcSimplePropertyTemplate EXTENDING default::IfcPropertyTemplate {
      CREATE LINK Enumerators -> default::IfcPropertyEnumeration;
      CREATE LINK PrimaryUnit -> default::IfcUnit;
      CREATE LINK SecondaryUnit -> default::IfcUnit;
      CREATE PROPERTY AccessState -> std::str {
          CREATE CONSTRAINT std::one_of('LOCKED', 'READONLY', 'READONLYLOCKED', 'READWRITE', 'READWRITELOCKED');
      };
      CREATE PROPERTY Expression -> std::str;
      CREATE PROPERTY PrimaryMeasureType -> std::str;
      CREATE PROPERTY SecondaryMeasureType -> std::str;
      CREATE PROPERTY TemplateType -> std::str {
          CREATE CONSTRAINT std::one_of('P_BOUNDEDVALUE', 'P_ENUMERATEDVALUE', 'P_LISTVALUE', 'P_REFERENCEVALUE', 'P_SINGLEVALUE', 'P_TABLEVALUE', 'Q_AREA', 'Q_COUNT', 'Q_LENGTH', 'Q_TIME', 'Q_VOLUME', 'Q_WEIGHT');
      };
  };
  CREATE ABSTRACT TYPE default::IfcSpatialStructureElement EXTENDING default::IfcSpatialElement {
      CREATE PROPERTY CompositionType -> std::str {
          CREATE CONSTRAINT std::one_of('COMPLEX', 'ELEMENT', 'PARTIAL');
      };
  };
  CREATE TYPE default::IfcSpatialZone EXTENDING default::IfcSpatialElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CONSTRUCTION', 'FIRESAFETY', 'LIGHTING', 'NOTDEFINED', 'OCCUPANCY', 'SECURITY', 'THERMAL', 'TRANSPORT', 'USERDEFINED', 'VENTILATION');
      };
  };
  CREATE ABSTRACT TYPE default::IfcSpatialElementType EXTENDING default::IfcTypeProduct {
      CREATE PROPERTY ElementType -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcStructuralActivity EXTENDING default::IfcProduct {
      CREATE REQUIRED LINK AppliedLoad -> default::IfcStructuralLoad;
      CREATE REQUIRED PROPERTY GlobalOrLocal -> std::str {
          CREATE CONSTRAINT std::one_of('GLOBAL_COORDS', 'LOCAL_COORDS');
      };
  };
  CREATE ABSTRACT TYPE default::IfcStructuralAction EXTENDING default::IfcStructuralActivity {
      CREATE PROPERTY DestabilizingLoad -> std::bool;
  };
  CREATE ABSTRACT TYPE default::IfcStructuralReaction EXTENDING default::IfcStructuralActivity;
  CREATE ABSTRACT TYPE default::IfcStructuralConnection EXTENDING default::IfcStructuralItem {
      CREATE LINK AppliedCondition -> default::IfcBoundaryCondition;
  };
  CREATE ABSTRACT TYPE default::IfcStructuralMember EXTENDING default::IfcStructuralItem;
  CREATE TYPE default::IfcStructuralLoadGroup EXTENDING default::IfcGroup {
      CREATE REQUIRED PROPERTY ActionSource -> std::str {
          CREATE CONSTRAINT std::one_of('BRAKES', 'BUOYANCY', 'COMPLETION_G1', 'CREEP', 'CURRENT', 'DEAD_LOAD_G', 'EARTHQUAKE_E', 'ERECTION', 'FIRE', 'ICE', 'IMPACT', 'IMPULSE', 'LACK_OF_FIT', 'LIVE_LOAD_Q', 'NOTDEFINED', 'PRESTRESSING_P', 'PROPPING', 'RAIN', 'SETTLEMENT_U', 'SHRINKAGE', 'SNOW_S', 'SYSTEM_IMPERFECTION', 'TEMPERATURE_T', 'TRANSPORT', 'USERDEFINED', 'WAVE', 'WIND_W');
      };
      CREATE REQUIRED PROPERTY ActionType -> std::str {
          CREATE CONSTRAINT std::one_of('EXTRAORDINARY_A', 'NOTDEFINED', 'PERMANENT_G', 'USERDEFINED', 'VARIABLE_Q');
      };
      CREATE PROPERTY Coefficient -> std::float64;
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('LOAD_CASE', 'LOAD_COMBINATION', 'LOAD_GROUP', 'NOTDEFINED', 'USERDEFINED');
      };
      CREATE PROPERTY Purpose -> std::str;
  };
  CREATE TYPE default::IfcStructuralLoadCase EXTENDING default::IfcStructuralLoadGroup {
      CREATE PROPERTY SelfWeightCoefficients -> tuple<std::float64, std::float64, std::float64>;
  };
  CREATE TYPE default::IfcStructuralResultGroup EXTENDING default::IfcGroup {
      CREATE LINK ResultForLoadGroup -> default::IfcStructuralLoadGroup;
      CREATE REQUIRED PROPERTY IsLinear -> std::bool;
      CREATE REQUIRED PROPERTY TheoryType -> std::str {
          CREATE CONSTRAINT std::one_of('FIRST_ORDER_THEORY', 'FULL_NONLINEAR_THEORY', 'NOTDEFINED', 'SECOND_ORDER_THEORY', 'THIRD_ORDER_THEORY', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcSubContractResource EXTENDING default::IfcConstructionResource {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('NOTDEFINED', 'PURCHASE', 'USERDEFINED', 'WORK');
      };
  };
  CREATE TYPE default::IfcTask EXTENDING default::IfcProcess {
      CREATE LINK TaskTime -> default::IfcTaskTime;
      CREATE REQUIRED PROPERTY IsMilestone -> std::bool;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ATTENDANCE', 'CONSTRUCTION', 'DEMOLITION', 'DISMANTLE', 'DISPOSAL', 'INSTALLATION', 'LOGISTIC', 'MAINTENANCE', 'MOVE', 'NOTDEFINED', 'OPERATION', 'REMOVAL', 'RENOVATION', 'USERDEFINED');
      };
      CREATE PROPERTY Priority -> std::int64;
      CREATE PROPERTY Status -> std::str;
      CREATE PROPERTY WorkMethod -> std::str;
  };
  CREATE TYPE default::IfcTaskType EXTENDING default::IfcTypeProcess {
      CREATE REQUIRED PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('ATTENDANCE', 'CONSTRUCTION', 'DEMOLITION', 'DISMANTLE', 'DISPOSAL', 'INSTALLATION', 'LOGISTIC', 'MAINTENANCE', 'MOVE', 'NOTDEFINED', 'OPERATION', 'REMOVAL', 'RENOVATION', 'USERDEFINED');
      };
      CREATE PROPERTY WorkMethod -> std::str;
  };
  CREATE TYPE default::IfcTransportElement EXTENDING default::IfcElement {
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('CRANEWAY', 'ELEVATOR', 'ESCALATOR', 'LIFTINGGEAR', 'MOVINGWALKWAY', 'NOTDEFINED', 'USERDEFINED');
      };
  };
  CREATE TYPE default::IfcVirtualElement EXTENDING default::IfcElement;
  CREATE TYPE default::IfcWorkCalendar EXTENDING default::IfcControl {
      CREATE MULTI LINK ExceptionTimes -> default::IfcWorkTime;
      CREATE MULTI LINK WorkingTimes -> default::IfcWorkTime;
      CREATE PROPERTY PredefinedType -> std::str {
          CREATE CONSTRAINT std::one_of('FIRSTSHIFT', 'NOTDEFINED', 'SECONDSHIFT', 'THIRDSHIFT', 'USERDEFINED');
      };
  };
  CREATE ABSTRACT TYPE default::IfcWorkControl EXTENDING default::IfcControl {
      CREATE MULTI LINK Creators -> default::IfcPerson;
      CREATE REQUIRED PROPERTY CreationDate -> std::str;
      CREATE PROPERTY Duration -> std::str;
      CREATE PROPERTY FinishTime -> std::str;
      CREATE PROPERTY Purpose -> std::str;
      CREATE REQUIRED PROPERTY StartTime -> std::str;
      CREATE PROPERTY TotalFloat -> std::str;
  };
};

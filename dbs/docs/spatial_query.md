## Spatial Query


I made an arbitrary IFC file of some IfcBeam elements and a spatial hierarchy and insert it into an EdgeDB instance. 

`The goal:` I want to return all elements below the specific spatial element named `Sublevel_1_a` in the 
spatial hierarchy and create a new IFC file from it. 

![Spatial Query Example in Blender](spatial_query_example_blender.png)


As of now I do the spatial query in 2 separate queries to the EdgeDB database 
(which maybe isn't that bad all things considered ) 

With the following query, I get the entire spatial hierarchy where it returns all the elements with 
their respective name (Name), EdgeDB uuid (id) and class name (__type__ : { name }).

```
SELECT {
    spatial_stru := (
        SELECT IfcRelContainedInSpatialStructure {
            id,
            RelatingStructure : { Name, id, __type__ : { name } },
            RelatedElements : { Name, id, __type__ : { name } }
        }
    ),
    rel_aggs := (
        SELECT IfcRelAggregates {
            id,
            RelatingObject : { Name, id, __type__ : { name } },
            RelatedObjects : { Name, id, __type__ : { name } }
        }
    ) 
}
```

which returns the following (fyi: I shortened the results json for the sake of compactness):

```
{
  'spatial_stru': [
    {
      'id': 'fb6d6d2a-f2be-11ec-ac74-23608326f6e7',
      'RelatingStructure': {
        'Name': 'Sublevel_1a_2a',
        'id': 'f6980fd0-f2be-11ec-ac74-abe5fe6aa302',
        '__type__': {
          'name': 'default::IfcBuildingStorey'
        }
      },
      'RelatedElements': [
        {
          'Name': 'bm1_1',
          'id': 'f96474a6-f2be-11ec-ac74-e796fcfa53d3',
          '__type__': {
            'name': 'default::IfcBeam'
          }
        },
        {
          'Name': 'bm2_1',
          'id': 'f9835114-f2be-11ec-ac74-d7a2757c5f6b',
          '__type__': {
            'name': 'default::IfcBeam'
          }
        }
      ]
    },
... 
'rel_aggs': [
    {
      'id': 'f64d4aea-f2be-11ec-ac74-4bd25461394f',
      'RelatingObject': {
        'Name': 'AdaProject',
        'id': 'f2ef5848-f2be-11ec-ac74-d764e1155ac1',
        '__type__': {
          'name': 'default::IfcProject'
        }
      },
      'RelatedObjects': [
        {
          'Name': 'SpatialHierarchy1',
          'id': 'eebd84e8-f2be-11ec-ac74-e7851f987412',
          '__type__': {
            'name': 'default::IfcSite'
          }
        }
      ]
    },
...
```

Then I just use regular python to find parent/children relationships of the spatial hierarchy and slice out all 
sub-elements of the `Sublevel_1_a` element. 

I also include the parent elements to "form a straight line of to the top level". 
This is so that I have "anchored" the sublevel in the total spatial tree. 

For the next query I have all the EdgeDB object references (uuid's) and their respective class types.
Which I can use together with the baked in IfcOpenShell schema to find all the related classes hiding in the nested 
chain of properties on the different IFC object types. 


Relevant Schema References

```
type IfcRelContainedInSpatialStructure extending IfcRelConnects {
    required multi link RelatedElements -> IfcProduct;
    required link RelatingStructure -> IfcSpatialElement;
}

type IfcRelAggregates extending IfcRelDecomposes {
    required link RelatingObject -> IfcObjectDefinition;
    required multi link RelatedObjects -> IfcObjectDefinition;
}

abstract type IfcRelConnects extending IfcRelationship {
}

abstract type IfcRelationship extending IfcRoot {
}


type IfcBuildingStorey extending IfcSpatialStructureElement {
    property Elevation -> float64;
}

type IfcSite extending IfcSpatialStructureElement {
    property RefLatitude -> int64;
    property RefLongitude -> int64;
    property RefElevation -> float64;
    property LandTitleNumber -> str;
    link SiteAddress -> IfcPostalAddress;
}

abstract type IfcSpatialElement extending IfcProduct {
    property LongName -> str;
}


type IfcBeam extending IfcBuildingElement {
    property PredefinedType -> str {
        constraint one_of ('BEAM','HOLLOWCORE','JOIST','LINTEL','NOTDEFINED','SPANDREL','T_BEAM','USERDEFINED');
    };
}

abstract type IfcBuildingElement extending IfcElement {
}

abstract type IfcElement extending IfcProduct {
    property Tag -> str;
}

# General Base classes

abstract type IfcObjectDefinition extending IfcRoot {
}

abstract type IfcProduct extending IfcObject {
    link ObjectPlacement -> IfcObjectPlacement;
    link Representation -> IfcProductRepresentation;
}

abstract type IfcObject extending IfcObjectDefinition {
    property ObjectType -> str;
}

abstract type IfcRoot  {
    required property GlobalId -> str;
    link OwnerHistory -> IfcOwnerHistory;
    property Name -> str;
    property Description -> str;
}

type IfcProject extending IfcContext {
}
```
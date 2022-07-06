# IFC Insert Strategies

The following insert strategies currently exists or are planned

* SEQUENCE
* BULK (planned)
* PARALLEL

## SEQUENCE Strategy

The `SEQUENCE` strategy inserts every IFC element 1 by 1. Meaning it is the least performant,
but ideal for debugging insert statements individually.

Below is a snippet from the printouts during insert of the `MyBeam.ifc` file using the `SEQUENCE` insert strategy


```text
inserting ifc item (1 of 84) "#1=IfcPerson('AdaUser',$,$,$,$,$,$,$)"
SELECT (INSERT IfcPerson {
    Identification := 'AdaUser'
   }
)
```

```text
inserting ifc item (2 of 84) "#2=IfcOrganization('Assembly For Design and Analysis','Assembly For Design and Analysis',$,$,$)"
SELECT (INSERT IfcOrganization {
    Identification := 'Assembly For Design and Analysis',
    Name := 'Assembly For Design and Analysis'
   }
)
```

```text
inserting ifc item (31 of 84) "#3=IfcPersonAndOrganization(#1,#2,$)"
WITH
    ifc_1 := (SELECT IfcPerson filter .id = <uuid>"68b74946-fd00-11ec-a5ed-b371333a38a3"),
    ifc_2 := (SELECT IfcOrganization filter .id = <uuid>"68c1068e-fd00-11ec-a5ed-1b36f1090f9c"),
SELECT (INSERT IfcPersonAndOrganization {
    ThePerson := ifc_1,
    TheOrganization := ifc_2
   }
)
```


## BULK Strategy

```{note}
Not yet started on this strategy.
``` 

Using sequential processing, group all similar IFC element types together and use for loops to insert
items using lists of dictionary data and using with statements for all related properties that are not in use by other  


## PARALLEL Strategy

```{note}
Not yet started on this strategy.
``` 

Using multiple threads to insert unrelated groups of IFC elements to the EdgeDB instance 
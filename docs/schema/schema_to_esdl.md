# Converting IFC schema to EdgeDB schema (ESDL)

The EdgeIO class uses the built-in IFC-schema in IfcOpenShell to construct .esdl files which represents the EdgeDB 
schema.

The following sections describes how to construct the IFC schema using python and the `EdgeIO` class.


## EdgeDB using partial IFC Schema
Choose to base your EdgeDB instance on IFC elements only relevant to a specific IFC file 
(useful during development of the EdgeDB schema generator)

```python
import pathlib
from ifcdb import EdgeIO


ifc_path = pathlib.Path("files/tessellated-item.ifc")

with EdgeIO(db_schema_dir="db/dbschema", database="testdb") as io:  
    io.create_schema(from_ifc_file=ifc_path)
    io.setup_database(delete_existing_migrations=True)
```

## EdgeDB using the entire IFC Schema

To set up an EdgeDB instance using the complete IFC schema you will need to specify `ifc_schema` to define which
version of the IFC schema you want the database schema to represent.

```{literalinclude} resources/complete_schema.py
:language: python
```

## EdgeDB using specific IFC entities

To create a schema using only specific IFC entities (and all related entities) it is possible to do the following.

```python
from ifcdb import EdgeIO

with EdgeIO(db_schema_dir="db/dbschema", ifc_schema="IFC4X1", database="testdb") as io:
    io.create_schema(from_ifc_entities=["IfcQuantityArea"])
    io.setup_database(delete_existing_migrations=True)
```
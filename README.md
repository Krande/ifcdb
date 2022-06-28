# IFC as a database
Various experiments of IFC as a database

See [ifcdb.md](docs/ifcdb.md) for a more in-depth exploration of how the EdgeDB schema currently is being used.

## EdgeDB (EdgeIO)

The following pattern for EdgeDB allows you to roundtrip your IFC file

````python
import os
import pathlib
from ifcdb import EdgeIO


ifc_path = pathlib.Path("files/tessellated-item.ifc")

with EdgeIO(ifc_file=ifc_path, db_schema_dir="db/dbschema", ifc_schema="IFC4x1", database="testdb") as io:
    # Use `from_ifc_file=True` if you want to limit number of IFC schema elements to what's contained in your IFC file    
    io.create_schema(from_ifc_file=True)
    io.setup_database(delete_existing_migrations=True)
    io.insert_ifc()
    # Do all kinds of query experiments here
    
    # Or just read the entire EdgeDB IFC content into an IFC file str using ifcopenshell like this
    res = io.to_ifc_str()

os.makedirs("temp", exist_ok=True)
with open(f"temp/{ifc_path.stem}-roundtripped.ifc", "w") as f:
    f.write(res)
````



## Resources

This repo was created as a result from a discussion here -> https://github.com/IfcOpenShell/IfcOpenShell/issues/2025.

Here are some relevant resources I came across when I was searching online

* https://technical.buildingsmart.org/standards/ifc/ifc-schema-specifications/
* https://github.com/buildingSMART/IFC4.3.x-development
* https://github.com/gsimon75/IFC_parser
* https://rdflib.readthedocs.io/en/stable/intro_to_parsing.html [for reading TTL IFC from the IfcOWL project]
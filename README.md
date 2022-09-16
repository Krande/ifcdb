# IFC as a database
Various experiments of IFC as a database

See the [docs](https://krande.github.io/ifcdb) for a more in-depth exploration of how 
the EdgeDB schema currently is being used.

## EdgeDB (EdgeIO)

The following pattern for EdgeDB allows you to roundtrip your IFC file

````python
import pathlib
from ifcdb import EdgeIO

ifc_path = pathlib.Path("files/tessellated-item.ifc")

with EdgeIO(db_schema_dir="db/dbschema", database_name="testdb") as io:
    io.create_schema_from_ifc_file(ifc_path=ifc_path)
    io.setup_database(delete_existing_migrations=True)
    io.insert_ifc(ifc_path)
    # Do all kinds of query experiments here

    # When you are done just read the entire EdgeDB IFC content into an IFC file str using ifcopenshell like this
    res = io.to_ifc_file(f"temp/{ifc_path.stem}-roundtripped.ifc")
````



## Resources

This repo was created as a result from a discussion here -> https://github.com/IfcOpenShell/IfcOpenShell/issues/2025.

Here are some relevant resources I came across when I was searching online

* https://technical.buildingsmart.org/standards/ifc/ifc-schema-specifications/
* https://github.com/buildingSMART/IFC4.3.x-development
* https://github.com/gsimon75/IFC_parser
* https://rdflib.readthedocs.io/en/stable/intro_to_parsing.html [for reading TTL IFC from the IfcOWL project]
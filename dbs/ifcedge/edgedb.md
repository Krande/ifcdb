# IFC in EdgeDB

An experiment with storing IFC elements in EdgeDB

## Manual

Here are the steps (that at least worked last time I tried):

* Install EdgeDB CLI using Powershell `iwr https://ps1.edgedb.com -useb | iex` or use `make cli-install`
* Make sure docker is running (f.ex. start Docker Desktop)
* start docker-compose by `docker-compose up` from this dir (or `make up` if you prefer makefiles)

Migrate schema using cmd 
* run `make migrate-init` to initiate schema migration
* run `make migrate` to complete migration of schema
* Open main.py and run python script

Migrate using python


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
    res = io.to_ifc_str()

os.makedirs("temp", exist_ok=True)
with open(f"temp/{ifc_path.stem}-roundtripped.ifc", "w") as f:
    f.write(res)
````

## Pro's and Con's

### Pro's

* The Object-oriented schema of EdgeDB makes it very easy to port the IFC schema
* The flexibility of the constraints and computed properties makes EdgeDB a good fit with the IFC schema

### Con's

* Traversing and returning objects and properties from a nested chain of properties needs explicitly defining all 
objects and property names in the query itself. This makes the query very verbose.

## Resources

* https://github.com/edgedb/edgedb
* https://www.edgedb.com/
* 
# Query by element name(s)/GlobalId(s)

[Back to Main Page](../index.md)

Query by element name(s)/GlobalId(s) and get back list of elements with all nested/related properties

Using the EdgeIO python class to query for specific elements based on GlobalId or Name can be done like so: 

```python
from ifcdb import EdgeIO

with EdgeIO(database="name_of_edgedb_db_instance") as io:
    result_name = io.get_by_name("<name_of_element>")
    result_id = io.get_by_global_id("<GlobalId_of_element>")
```
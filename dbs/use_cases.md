# IFC database scenarios 

* [Spatial Query](docs/spatial_query.md)
* [Large Queries](docs/large_queries.md)

## Query by element name(s)/GlobalId(s)

Query by element name(s)/GlobalId(s) and get back list of elements with all nested/related properties


## Updating elements 
Ideally there should be a good `diffing` mechanism on local IFC content. So that whatever you have modified on your local IFC content is what you send back to the database and check for differences. 
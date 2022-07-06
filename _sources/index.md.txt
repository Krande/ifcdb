# IFC as a database 

Various experiments of storing IFC as an [EdgeDB](https://edgedb.com) Database. 
See the [GitHub repo](https://github.com/Krande/ifcdb) for the source code for the docs and all related code


```{note}
I am writing this document primarily to organize my thoughts. 

Consequently, this document will be randomly updated and for the most part appear chaotic and inconsistent.    
``` 

```{toctree}
:maxdepth: 2
:glob:
:caption: Schema Conversion

schema/schema_to_esdl.md
schema/modifications.md
```

```{toctree}
:maxdepth: 2
:glob:
:caption: Inserting Elements

inserts/insert_strategies
```

```{toctree}
:maxdepth: 2
:glob:
:caption: Querying Elements

queries/query_building
queries/by_id
queries/nested_object_links.md
queries/spatial_query
queries/large_queries
```

```{toctree}
:maxdepth: 2
:glob:
:caption: Updating Elements

updating/diffing
```

```{toctree}
:maxdepth: 2
:glob:
:caption: Validation

validation/validation_intro.md
validation/cube-advanced-brep.md
```

```{toctree}
:maxdepth: 2
:glob:
:caption: CI/CD

ci/unittesting
```

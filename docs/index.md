# IFC as a database 

A document describing the exploration of IFC as a Database.

## Queries

* [Query Building](queries/query_building.md)

Various query scenarios are explored

* [Spatial Queries](queries/spatial_query.md)
* [Large Queries](queries/large_queries.md)
* [Simple Queries by GlobalID/Name](queries/by_id.md)

## Updates

Different update strategies are considered here

* [Updating an IFC db](updating/diffing.md)

## Continuous Integration

Work on continuous integration is covered in this section

* [CI/CD](ci/unittesting.md)

```{toctree}
:hidden:
:maxdepth: 2
:glob:
:caption: Queries

queries/query_building
queries/spatial_query
queries/large_queries
queries/by_id
```

```{toctree}
:hidden:
:maxdepth: 2
:glob:
:caption: Updating

updating/diffing
```


```{toctree}
:hidden:
:maxdepth: 2
:glob:
:caption: CI/CD

ci/unittesting
```
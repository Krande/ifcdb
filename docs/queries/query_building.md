# Query Building

[Back to Main Page](../index.md)

IfcOpenShell schema is used to build the EdgeDB schema.

Once the EdgeDB schema is created, [introspection](https://www.edgedb.com/docs/guides/introspection/index#introspection) 
is employed to read the created schema and use that as a source for constructing queries that are required to 
explicitly define all related classes hiding in the nested chain of properties on the different IFC object types.


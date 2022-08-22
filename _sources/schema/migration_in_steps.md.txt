# Migrating the entire IFC schema into EdgeDB

As a consequence of the issue raised in https://github.com/edgedb/edgedb/issues/3946 a solution
was proposed to split the schema into chunks and run the EdgeDB migrations in steps.

The following migration increments are subject to testing

- [x]: 600 -> Memory Alloc error
- [x]: 300 -> Memory Alloc error
- []: 100
- []: 50


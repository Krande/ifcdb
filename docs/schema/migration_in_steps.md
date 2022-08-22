# Migrating the entire IFC schema into EdgeDB

As a consequence of the issue raised in https://github.com/edgedb/edgedb/issues/3946 a solution
was proposed to split the schema into chunks and run the EdgeDB migrations in steps.

The following migration increments are subject to testing

- [x]: 600 -> Memory Alloc error
- [x]: 300 -> Memory Alloc error
- []: 100
- []: 50

# Memory Alloc error

This is the most common error 

```
edgedb error: InternalServerError: invalid memory alloc request size 1073741824
  Hint: This is most likely a bug in EdgeDB. Please consider opening an issue ticket at https://github.com/edgedb/edgedb/issues/new?template=bug_report.md
  Server traceback:
      edb.errors.InternalServerError: invalid memory alloc request size 1073741824
```

Docker logs:

```
edgedb_1 | INFO 204 2022-08-18T16:44:07.160 postgres:       UNION ALL
edgedb_1 | INFO 204 2022-08-18T16:44:07.160 postgres:                   (SELECT
edgedb_1 | INFO 204 2022-08-18T16:44:07.160 postgres:                      "7bbf54bd-1f10-11ed-93d8-852933d4ec89".target AS target,
edgedb_1 | INFO 204 2022-08-18T16:44:07.160 postgres:       "7bbf54bd-1f10-11ed-93d8-852933d4ec89".source AS source
edgedb_1 | INFO 204 2022-08-18T16:44:07.160 postgres:                    FROM
edgedb_1 | INFO 204 2022-08-18T16:44:07.160 postgres:                      edgedbpub."7bbf54bd-1f10-11ed-93d8-852933d4ec89" AS "7bbf54bd-1f10-11ed-93d8-852933d4ec89"
edgedb_1 | INFO 204 2022-08-18T16:44:07.160 postgres:                   )
edgedb_1 | INFO 204 2022-08-18T16:44:07.160 postgres: 
edgedb_1 | INFO 204 2022-08-18T16:44:07.160 postgres:       UNION ALL
edgedb_1 | INFO 204 2022-08-18T16:44:07.160 postgres:                   (SELECT
edgedb_1 | INFO 204 2022-08-18T16:44:07.161 postgres:                      "7c326fbf-1f10-11ed-bee8-c1006d193598".target AS target,
edgedb_1 | INFO 204 2022-08-18T16:44:07.161 postgres:       "7c326fbf-1f10-11ed-bee8-c1006d193598".source AS source
edgedb_1 | INFO 204 2022-08-18T16:44:07.161 postgres:                    FROM
edgedb_1 | INFO 204 2022-08-18T16:44:07.161 postgres:                      edgedbpub."7c326fbf-1f10-11ed-bee8-c1006d193598" AS "7c326fbf-1f10-11ed-bee8-c1006d193598"
edgedb_1 | INFO 204 2022-08-18T16:44:07.161 postgres:                   )
edgedb_1 | INFO 204 2022-08-18T16:44:07.161 postgres: 
edgedb_1 | INFO 204 2022-08-18T16:44:07.161 postgres:       UNION ALL
```
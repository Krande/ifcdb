# Large queries

[Back to Main Page](../index.md)

A typical use case is for users to download the entire content of the IFC database and work locally on that content. 

## EdgeDB "Pagination" 

Using [Pagination](https://www.edgedb.com/docs/edgeql/select#pagination) to `limit` and `offset` each returned block
of select results.
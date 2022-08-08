# Unittesting EdgeDB schemas

[Back to Main Page](../index.md)

A github actions workflow [ci-edgedb.yml](../../.github/workflows/ci-edgedb.yml) has been created to test different
IFC schema's and relevant inserts/queries based on specific IFC files. 

At the time of writing the GitHub actions workflow fails on 2 of 3 IFC files on the "fingerprint assertion". The 
"cube-advanced-brep.ifc" is the only IFC file that currently passes. 

Here is the complete pytest setup for roundtrip testing of IFC files

```{literalinclude} ../../tests/edge_model/server/test_ifc_file_roundtripping.py
:language: python
```
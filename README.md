# IFC as a database
Various experiments of IFC as a database

## Plan
* First get familiar with the EXPRESS syntax and how the schema is defined.
* Work towards extracting a minimum number of classes in order to represent a minimum IFC sample.
* Before attempting to convert to database, it would help to first convert the IFC classes to python 
  dataclasses. This would help uncover simple mistakes in linking of data. And a strongly typed dataclass 
  representation of IFC could perhaps have some use cases?
* Export to ESDL schema to test IFC schema in a EdgeDB database.

## Resources

This repo was created as a result from a discussion here -> https://github.com/IfcOpenShell/IfcOpenShell/issues/2025.

Here are some relevant resources I came across when I was searching online

* https://technical.buildingsmart.org/standards/ifc/ifc-schema-specifications/
* https://github.com/buildingSMART/IFC4.3.x-development
* https://github.com/gsimon75/IFC_parser
* https://rdflib.readthedocs.io/en/stable/intro_to_parsing.html [for reading TTL IFC from the IfcOWL project]
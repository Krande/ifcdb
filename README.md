# IFC as a database
Various experiments of IFC as a database

## Plan
* First get familiar with the EXPRESS syntax and how the schema is defined.

* Work towards extracting a minimum number of classes in order to represent a minimum IFC sample.
* Before attempting to convert to database, it would be beneficial to first simply convert the IFC classes to python 
  dataclasses.
* Export to ESDL schema to test IFC schema in a EdgeDB database.

## Resources

This repo was created as a result from a discussion here -> https://github.com/IfcOpenShell/IfcOpenShell/issues/2025.

Here are some related projects I came across when I was searching online for similar projects

* https://github.com/buildingSMART/IFC4.3.x-development
* https://github.com/gsimon75/IFC_parser
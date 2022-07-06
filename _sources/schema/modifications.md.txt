# Necessary modifications to the IFC schema

In order for the IFC schema to work with EdgeDB, a few modifications were made to certain element types and 
specific elements/relationships of elements. 

## Base Types

All IFC schema objects that are wrapping base types only (i.e. string, float, integers, etc..) are replaced by their
respective base types. I.e. IfcLabel is never instantiated, rather it is stored as a string. 


```{note}
For any constraints associated with these base IFC classes, it is possible to assert them directly to the 
ESDL property statements.   
```





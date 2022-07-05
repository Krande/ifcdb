# Nested Object links

A manual investigation of the complex nested object property links is necessary as a stepping stone towards building an 
automatic query generator for IFC in EdgeDB.

```{note}
The intention is that the query builder will in fact work on any EdgeDB schema, not only for IFC.
```

The rooted IFC element `IfcBeam` is used as a source for further investigation.

The ifc file [MyBeam.ifc](../../files/MyBeam.ifc) is first uploaded to an EdgeDB instance. See below for the full 
code employed for both uploading IFC and subsequent queries.

```{literalinclude} resources/nested_object_links.py
:language: python
```

## Query 1 -> Basic Select

The basic select statement to get only the top level of the `IfcBeam` class can be written like this: 

```{literalinclude} resources/q1.esdl
:language: text
```

which generates the following output:

```{literalinclude} resources/q1_output.json
:language: json
```

## Query 2 -> Get properties of linked objects

```{literalinclude} resources/q2.esdl
:language: text
```

which returns the 

```{literalinclude} resources/q2_output.json
:language: text
```

In the outputted results you can notice that there is a lot of references to `"id": ".."`. This is EdgeDB's way of 
letting us know that this property is linked to another object.

And at the time of writing, there is no "automatic" way of getting all the linked object properties out from
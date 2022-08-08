# Nested Object links

A manual investigation of the complex nested object property links found in the IFC schema.
This manual query building exercise functions as a stepping stone towards building an 
automatic query generator for IFC in EdgeDB.

```{note}
The intention is that the query builder will in fact work on any EdgeDB schema, not only for IFC.
```

The rooted IFC element `IfcBeam` is used as a source for further investigation. 
See the [IfcBeam docs](https://standards.buildingsmart.org/IFC/RELEASE/IFC4_3/lexical/IfcBeam.htm) for more information
about the IfcBeam.

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

which returns the following output

```{literalinclude} resources/q2_output.json
:language: json
```

In the outputted results you can notice that there is a lot of elements with `"id": ".."`. This is EdgeDB's way of 
letting us know that this property is linked to another object.

At the time of writing, there is no "automatic" way of asking in a single query for all related object's and their 
properties without knowing upfront what exactly are the related object type's and the names of their properties.

As a consequence of this, it is necessary to explicitly define the entire path of every related object and their
properties. This will be the final step in this experiment

## Query 3 -> The completed query shape

As a final piece in this exercise, it will be attempted to write the entire query shape to return all related object
properties originating from the `IfcBeam` class. In other terms, the number of occurrences of `"id": ".."` in the
result should be kept as low as possible.


```{literalinclude} resources/q3.esdl
:language: text
```

which returns the following output 

```{literalinclude} resources/q3_output.json
:language: json
```

## Strategies for reducing the general IFC query shape complexity

Based on the observed results here are some proposals for further improving the efficiency and ergonomics of the
query shapes.

### IFC specific query modifications

The following will work only for IFC and would not apply for general query building using ESDL in general. 

* Exclude `OwnerHistory` in the general query builder and instead create a custom query for 
exporting all OwnerHistory related information
* Move `ObjectPlacement` query out of the general query builder and to its own custom query in order 
to resolve World Coordinates based on potentially nested `RelativePlacement` references.
 
### General query modifications
These options are more general and should apply to all esdl schemas. 

* Do an initial query to return all nested object links and object types without any non-link-property information.
In scenarios with objects being referred to multiple times, this strategy will reduce duplication of result data, and 
should improve things especially with shapes containing a lot of references to same objects.
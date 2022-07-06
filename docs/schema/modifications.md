# Necessary modifications to the IFC schema

In order for the IFC schema to work with EdgeDB, a few modifications were made to certain element types and 
specific elements/relationships of elements. 

## Base Types

All IFC schema objects that are wrapping base types only (i.e. string, float, integers, etc..) are replaced by their
respective base types. I.e. IfcLabel is never instantiated, rather it is stored as a string. 

Take an arbitrarily chosen class `IfcQuantityArea` which points to the IFC built-in types `IfcAreaMeasure` &
`IfcLabel`.

```text
ENTITY IfcQuantityArea
 SUBTYPE OF (IfcPhysicalSimpleQuantity);
	AreaValue : IfcAreaMeasure;
	Formula : OPTIONAL IfcLabel;
 WHERE
	WR21 : NOT(EXISTS(SELF\IfcPhysicalSimpleQuantity.Unit)) OR
   (SELF\IfcPhysicalSimpleQuantity.Unit.UnitType = IfcUnitEnum.AREAUNIT);
	WR22 : AreaValue >= 0.;
END_ENTITY;
```

These built-in types are in practice a `float` and `string`

```
TYPE IfcAreaMeasure = REAL;
END_TYPE;

TYPE IfcLabel = STRING(255);
END_TYPE;

```

Consequently, in the EdgeDB ESDL schema declaration, these IFC built-in types are replaced by the native types `float`
and `str` as shown here

```
type IfcQuantityArea extending IfcPhysicalSimpleQuantity {
    required property AreaValue -> float64;
    property Formula -> str;
}
```

```{note}
For any constraints associated with these base IFC classes, it is possible to assert them directly to the 
ESDL property statements. 

This means, that if the `IfcLabel` string limit must be enforced, it is possible to do so 
using the EdgeDB built-in `constraint` expression and the `max_len_value` function

```
type IfcQuantityArea extending IfcPhysicalSimpleQuantity {
    required property AreaValue -> float64;
    property Formula -> str {
        constraint max_len_value(255);
    };
}
```

```
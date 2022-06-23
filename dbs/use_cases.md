# IFC database scenarios 


## Query by element name(s)/GlobalId(s)

Query by element name(s)/GlobalId(s) and get back list of elements with all nested/related properties

## Query by name/GlobalId in the spatial hierarchy
Query by name/GlobalId in the spatial hierarchy and return list of all sub-elements (spatial elements and geometry elements) with all nested/related properties
This is especially important given that it makes it possible to work on specific parts of the model without having to load the entire model. 


## Updating elements 
Ideally there should be a good `diffing` mechanism on local IFC content. So that whatever you have modified on your local IFC content is what you send back to the database and check for differences. 
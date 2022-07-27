# Use Cases

To structure the ongoing work, here is the initial use cases of an IFC database.

* [x] Upload IFC file to empty Database
* [x] Download entire IFC model from IFC Database
* [ ] Download Partial IFC model from IFC Database
* [ ] Upload IFC model to existing IFC database

## Upload IFC file to empty Database

Done. This required primarily getting the database up and running, then start uploading elements. 


## Download entire IFC model from IFC Database

Done. A roundtrip of IFC file content has been completed demonstrating that this works for a few initial IFC file
examples. 
This is completed by simply exporting all classes found in the database and then assembled into an IFC file on
the client side.


## Download Partial IFC model from IFC Database

This proved to be a bit more challenging. It requires a more complex query building compared to the simpler "get_all()"
method in use for downloading the entire model.

The current strategy is to extract IfcOwnerHistory and IfcRepresentation data in separate queries to reduce query
complexity and result output redundancy.
from ifcopenshell.express import express_parser


def main(express_file):
    mapping = express_parser.parse(express_file)
    schema = mapping.schema
    entities = list(schema.all_entities.values())
    res = schema.all_entities["IfcTriangulatedFaceSet"]
    res2 = schema.all_entities["IfcBuildingElementProxy"]
    print(entities[0])


if __name__ == "__main__":
    main("../IFC4.3.x-development/reference_schemas/IFC4x1.exp")

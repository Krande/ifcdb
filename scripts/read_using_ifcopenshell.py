from ifcopenshell.express import express_parser


def main(express_file):
    mapping = express_parser.parse(express_file)
    schema = mapping.schema
    entities = list(schema.entities.values())
    res = schema.entities["IfcTriangulatedFaceSet"]
    print(entities[0])


if __name__ == "__main__":
    main("../IFC4.3.x-development/reference_schemas/IFC4x1.exp")

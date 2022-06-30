from rdflib import Graph


def main():
    # Create a Graph
    g = Graph()

    # Parse in an RDF file hosted on the Internet
    g.parse(
        "https://standards.buildingsmart.org/IFC/DEV/IFC4_1/OWL/ontology.xml",
        format="application/rdf+xml",
    )

    # Loop through each triple in the graph (subj, pred, obj)
    # for subj, pred, obj in g:
    #     # Check if there is at least one triple in the Graph
    #     if (subj, pred, obj) not in g:
    #         raise Exception("It better be!")

    # Print the number of "triples" in the Graph
    print(f"Graph g has {len(g)} statements.")
    # Prints: Graph g has 86 statements.

    # Print out the entire Graph in the RDF Turtle format
    serialized_data = g.serialize(format="turtle")
    print(serialized_data)
    print(g.serialize(format="turtle"))


if __name__ == "__main__":
    main()

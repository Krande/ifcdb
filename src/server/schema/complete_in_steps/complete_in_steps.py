from ifcdb import EdgeIO


def main():

    io = EdgeIO(ifc_schema="IFC4x1", database="stepwise")
    io.create_complete_schema_stepwise()


if __name__ == "__main__":
    main()

from ifcdb import EdgeIO


def main():
    io = EdgeIO(ifc_schema="IFC4x1", database="stepwise")
    io.em.modify_circular_deps = True
    entity_dep_map = dict()
    entity_name = "IfcBSplineSurface"
    io.em._find_dependencies(entity_name, entity_dep_map)
    entity = io.em.get_entity_by_name(entity_name)
    res_str = entity.to_str()
    print(res_str)


if __name__ == "__main__":
    main()

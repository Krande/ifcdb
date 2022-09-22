import ifcopenshell


def check_model_for_pipe_penetrations(ifc_obj: ifcopenshell.file):
    pipes = []
    for obj in ifc_obj.by_type("IfcPipeSegment"):
        pipes.append(obj)

    if len(pipes) == 0:
        return False

    return True


def add_penetration_detail(ifc_obj: ifcopenshell.file):
    ...

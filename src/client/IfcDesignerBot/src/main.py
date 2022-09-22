import os

from design_handler import check_model_for_pipe_penetrations
from event_handler import QueueHandler

from ifcdb import EdgeIO


def task(msg) -> dict:
    print(msg)
    with EdgeIO(database_name=os.getenv("IFCDB_NAME"), load_env=True) as io:
        ifc_obj = io.to_ifcopenshell_object()

    result = check_model_for_pipe_penetrations(ifc_obj)
    return dict(piping_penetration_found=result)


def main():
    qh = QueueHandler(task=task, load_env=True)
    qh.run()


if __name__ == "__main__":
    main()

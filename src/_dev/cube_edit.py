from enum import Enum

from cube_tools import run_model_update, upload, wipe_db


class DbOperation(Enum):
    UPLOAD = "upload"
    EDIT = "edit"
    ADD = "add"
    REVERT = "revert"
    WIPE = "wipe"


def main(db_op: DbOperation):
    if db_op == DbOperation.UPLOAD:
        upload()
    elif db_op == DbOperation.EDIT:
        run_model_update("MyCubeEdited.ifc")
    elif db_op == DbOperation.ADD:
        run_model_update("MyCubeAdded.ifc")
    elif db_op == DbOperation.REVERT:
        run_model_update("MyCube.ifc", "_revert")
    elif db_op == DbOperation.WIPE:
        wipe_db()
    else:
        raise ValueError(f"Unknown DB operation '{db_op}'")


if __name__ == "__main__":
    main(DbOperation.REVERT)


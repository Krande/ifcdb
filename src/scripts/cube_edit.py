from enum import Enum

from cube_tools import download, reset_db, run_model_update, upload, wipe_db


class DbOperation(Enum):
    RESET_DB = "reset_db"
    UPLOAD = "upload"
    DOWNLOAD = "download"
    EDIT = "edit"
    ADD = "add"
    REVERT = "revert"
    WIPE = "wipe"


def main(db_op: DbOperation):
    if db_op == DbOperation.RESET_DB:
        reset_db()
    elif db_op == DbOperation.UPLOAD:
        upload(in_sequence=True)
    elif db_op == DbOperation.EDIT:
        run_model_update("MyCubeEdited_Z.ifc")
    elif db_op == DbOperation.ADD:
        run_model_update("MyCubeAdded.ifc")
    elif db_op == DbOperation.REVERT:
        run_model_update("MyCube.ifc", "_revert")
    elif db_op == DbOperation.WIPE:
        wipe_db(in_sequence=True)
    elif db_op == DbOperation.DOWNLOAD:
        download()
    else:
        raise ValueError(f"Unknown DB operation '{db_op}'")


if __name__ == "__main__":
    # main(DbOperation.WIPE)
    # main(DbOperation.UPLOAD)
    # main(DbOperation.EDIT)
    main(DbOperation.DOWNLOAD)

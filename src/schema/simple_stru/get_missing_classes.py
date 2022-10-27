import os

from ifcdb.utils import db_ifc_diff_getter, top_dir


def main(ifc_file):
    db_diff = db_ifc_diff_getter("ifc001", ifc_file)

    all_classes = db_diff.get_all_classes()
    missing_classes = db_diff.get_missing_ifc_classes()

    os.makedirs("temp", exist_ok=True)
    with open("temp/missing_classes.txt", "w") as f:
        f.write("\n".join(missing_classes))

    with open("temp/all_classes.txt", "w") as f:
        f.write("\n".join(all_classes))


if __name__ == "__main__":
    main(ifc_file=top_dir() / "src/demos/simple_stru_poc/temp/model_00.ifc")

from ifcdb import EdgeIO
from ifcdb.utils import top_dir

CUBE_DIR = top_dir() / "files/MyCube"


def main():
    with EdgeIO("ifc001", load_env=True) as io:
        io.insert_ifc(CUBE_DIR / "MyCube.ifc")


if __name__ == "__main__":
    main()

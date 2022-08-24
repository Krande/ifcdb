import time
from dotenv import load_dotenv

from ifcdb import EdgeIO
from ifcdb.utils import top_dir

load_dotenv()  # take environment variables from .env.


def main(ifc_file: str, extra_ifc_classes: list[str] = None):
    ifc_path = top_dir() / "files" / ifc_file
    with EdgeIO(database="small") as io:
        io.create_schema_from_ifc_file(ifc_path=ifc_path, extra_entities=extra_ifc_classes)
        io.setup_database(delete_existing_migrations=True)


# CLI:      2.0.5+da7c868
# SERVER (Azure):   2.1+c600476 (uses an incredibly long time to respond)
# SERVER (local):   2.1+c600476 (works as expected)

if __name__ == "__main__":
    start = time.perf_counter()
    main("MyCube.ifc")
    end = time.perf_counter()
    print(f'This took {end-start:.1f} seconds')

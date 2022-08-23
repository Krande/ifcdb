from ifcdb.database.admin import DbMigration
from dotenv import load_dotenv

load_dotenv()  # take environment variables from .env.


def main(database: str, ifc_schema: str, batch_size: int):
    io = DbMigration(database)
    io.migrate_stepwise(ifc_schema=ifc_schema, batch_size=batch_size)

if __name__ == "__main__":
    main("test", "IFC4x1", 100)

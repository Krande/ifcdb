from dotenv import load_dotenv

from ifcdb.database.admin import DbMigration

load_dotenv()  # take environment variables from .env.


def main(database: str, batch_size: int):
    io = DbMigration(database)
    io.migrate_stepwise(batch_size=batch_size)


if __name__ == "__main__":
    main("test", 100)

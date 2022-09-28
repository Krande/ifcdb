from __future__ import annotations

import logging
import os
import pathlib
import shutil
import subprocess
import time
from dataclasses import dataclass
from datetime import datetime
from typing import Type

import edgedb

from ifcdb.config import IfcDbConfig
from ifcdb.schema.new_model import db_entity_model_from_schema_version


class MigrationCreateError(Exception):
    pass


class MigrationApplyError(Exception):
    pass


DB_CREATE = "CREATE DATABASE {database}"
DB_DROP = "DROP DATABASE {database}"


@dataclass
class DbAdmin:
    database: str = None

    def __post_init__(self):
        # All database creation/deletion/modification should happen using a client pointing to the "base" db.
        self.client = edgedb.create_client()

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.client.close()

    def database_exists(self):
        try:
            self.client.execute(DB_CREATE.format(database=self.database))
        except edgedb.errors.DuplicateDatabaseDefinitionError:
            return True
        self.delete_database()
        return False

    def create_database(self):
        print(f"Dropping existing database '{self.database}' and creating a new in its place")

        try:
            print(f"Dropping database {self.database}")
            self.delete_database()
        except edgedb.errors.UnknownDatabaseError as e:
            logging.debug(e)

        print(f"Creating database {self.database}\n")
        self.client.execute(DB_CREATE.format(database=self.database))

    def delete_database(self, database: str = None):
        db = self.database if database is None else database
        self.client.execute(DB_DROP.format(database=db))


@dataclass
class DbMigration:
    database: str
    db_config: IfcDbConfig = IfcDbConfig("IFC4x1")
    dbschema_dir: pathlib.Path = "dbschema"
    debug_logs: bool = False

    def __post_init__(self):
        self.dbschema_dir = pathlib.Path(self.dbschema_dir).resolve().absolute()

    def migrate_all_in_one(self, delete_existing_migrations=False):
        print("Migrating schema to fresh database")
        client = edgedb.create_client(database=self.database)
        migrations_dir = pathlib.Path(self.dbschema_dir / "migrations")

        if delete_existing_migrations is True and migrations_dir.exists():
            shutil.rmtree(migrations_dir)

        if migrations_dir.exists() is False:
            if self.dbschema_dir.exists() is False:
                raise NotADirectoryError()

            self.migration_create()

        for migration_file in os.listdir(migrations_dir):
            with open(migrations_dir / str(migration_file), "r") as f:
                migration_body = f.read()
                client.execute(migration_body)

    def migrate_stepwise(
        self,
        specific_entities: list[str] = None,
        batch_size=100,
        module_name: str = "default",
        begin_step: int = None,
        dry_run: bool = False,
        allow_unsafe=False,
    ):
        unwrap_enums = self.db_config.unwrapped_enums
        unwrap_selects = self.db_config.unwrapped_selects

        db_entities = db_entity_model_from_schema_version(
            self.db_config.ifc_schema_version, specific_entities, unwrap_enums, unwrap_selects
        )
        db_ents_names = [x.name for x in db_entities.get_entities_in_insert_order()]
        # Filter out all Enum's as they are not used in the EdgeDB representation

        chunks = []
        n_ents = len(db_ents_names)
        for i in range(0, n_ents, batch_size):
            chunks.append(db_ents_names[i : i + batch_size])

        current_schema_entities = []
        start = time.time()
        tmp_dir = self.dbschema_dir / "_temp_dir"
        esdl_file_path = self.dbschema_dir / "default.esdl"
        os.makedirs(tmp_dir, exist_ok=True)
        curr_size = 0

        for i, chunk in enumerate(chunks, start=1):
            current_schema_entities += chunk
            now = datetime.now().time().strftime("%H:%M:%S")
            curr_size += len(chunk)
            print(f"Starting step {i} of {len(chunks)} adding {len(chunk)} entities ({curr_size}/{n_ents}) @ {now}")
            db_entities.to_esdl_file(esdl_file_path, module_name)
            if begin_step is not None:
                if i < begin_step:
                    print(f"skipping step {i}")
                    continue

            shutil.copy(esdl_file_path, tmp_dir / f"esdl_file.{i}")
            with open(tmp_dir / f"chunk_{i}.txt", "w") as f:
                f.write("\n".join(chunk))

            if dry_run is False:
                self.migration_create(allow_unsafe=allow_unsafe)
                self.migration_apply()

            t_fin = time.time()
            print(f"Completed migration in {t_fin - start:.1f} s\n")
            start = t_fin

    def migration_create(self, allow_unsafe=False):
        in_str = "create --non-interactive"
        if allow_unsafe:
            in_str += " --allow-unsafe"
        self._migration_cmd(in_str, MigrationCreateError)
        print("migration create complete")

    def migration_apply(self):
        self._migration_cmd("apply", MigrationApplyError)
        print("migration apply complete")

    def _migration_cmd(self, migration_type: str, error_type: Type[Exception]):
        server_prefix = f"edgedb --database={self.database} migration {migration_type}"

        if self.schema_dir is not None:
            server_prefix += f"--schema-dir ./{self.schema_dir}"

        start_print = f'running: "{server_prefix}"'

        if self.debug_logs:
            start_print += f' "{server_prefix}" @"{self.dbschema_dir}"'

        print(start_print)
        self._run_edgedb_cli(server_prefix, error_type)

    def _run_edgedb_cli(self, cmd_str, error_type: Type[Exception]) -> None:
        res = subprocess.run(cmd_str, cwd=self.dbschema_dir.parent, shell=True, capture_output=True, encoding="utf8")
        if res.stderr == "":
            return None

        print(f'cli output -> "{res.stderr.strip()}"')
        if "error: " in res.stderr:
            raise error_type(res.stderr)

    @property
    def schema_dir(self):
        schema_dir = None
        if self.dbschema_dir.name != "dbschema":
            schema_dir = self.dbschema_dir.name
        return schema_dir

from __future__ import annotations

import logging
from typing import Type
import os
import pathlib
import shutil
import subprocess
import time
from dataclasses import dataclass

import edgedb

from ifcdb.schema.model import IfcSchemaModel


class MigrationCreateError(Exception):
    pass

class MigrationApplyError(Exception):
    pass

DB_CREATE = "CREATE DATABASE {database}"
DB_DROP = "DROP DATABASE {database}"


@dataclass
class DbConfig:
    client: edgedb.Client | edgedb.AsyncIOClient
    database: str = None

    def database_exists(self):
        try:
            self.client.execute(DB_CREATE.format(database=self.database))
        except edgedb.errors.DuplicateDatabaseDefinitionError:
            return True

        self.client.execute(DB_DROP.format(database=self.database))
        return False

    def setup_database(self):
        print(f"Dropping existing database '{self.database}' and creating a new in its place")

        try:
            print(f"Dropping database {self.database}")
            self.client.execute(DB_DROP.format(database=self.database))
        except edgedb.errors.UnknownDatabaseError as e:
            logging.debug(e)

        print(f"Creating database {self.database}")
        self.client.execute(DB_CREATE.format(database=self.database))


@dataclass
class DbMigration:
    database: str
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
        ifc_schema: str,
        entities: list[str] = None,
        batch_size=100,
        module_name: str = "default",
    ):
        schema_model = IfcSchemaModel(ifc_schema)
        schema_model.modify_circular_deps = True

        if entities is None:
            unique_entities = schema_model.get_all_entities()
        else:
            unique_entities = entities

        all_ents = schema_model.get_related_entities(unique_entities)

        # Filter out all Enum's as they are not used in the EdgeDB representation
        def filter_out_enums(name: str):
            if name.endswith("Enum"):
                return False
            return True

        filtered_ents = list(filter(filter_out_enums, all_ents))
        chunks = []
        for i in range(0, len(filtered_ents), batch_size):
            chunks.append(filtered_ents[i : i + batch_size])

        current_schema = []
        start = time.time()
        tmp_dir = self.dbschema_dir / "_temp_dir"
        esdl_file_path = self.dbschema_dir / "default.esdl"
        os.makedirs(tmp_dir, exist_ok=True)
        for i, chunk in enumerate(chunks, start=1):
            current_schema += chunk
            schema_model.to_esdl_file(esdl_file_path, current_schema, module_name)
            self.migration_create()
            self.migration_apply()
            t_fin = time.time()
            print(f"Finished with step {i} of {len(chunks)} in {t_fin-start:.1f} s adding {len(chunk)} entities")
            start = t_fin
            shutil.copy(esdl_file_path, tmp_dir / f"esdl_file.{i}")
            with open(tmp_dir / f"chunk_{i}.txt", "w") as f:
                f.write("\n".join(chunk))

    def migration_create(self):
        server_prefix = f"edgedb --database={self.database} migration create --non-interactive"
        if self.schema_dir is not None:
            server_prefix += f"--schema-dir ./{self.schema_dir}"
        start_print = "Create Migration using CLI command"
        if self.debug_logs:
            start_print += f' "{server_prefix}" @"{self.dbschema_dir}"'

        print(start_print)
        self._run_edgedb_cli(server_prefix, MigrationCreateError)
        print("CLI command 'migration create' complete")

    def migration_apply(self):
        server_prefix = f"edgedb --database={self.database} migration apply"

        if self.schema_dir is not None:
            server_prefix += f"--schema-dir ./{self.schema_dir}"

        start_print = "Applying Migration using CLI command"

        if self.debug_logs:
            start_print += f' "{server_prefix}" @"{self.dbschema_dir}"'

        print(start_print)
        self._run_edgedb_cli(server_prefix, MigrationApplyError)
        print("CLI command 'migration apply' complete")

    def _run_edgedb_cli(self, cmd_str, error_type: Type[Exception]):
        res = subprocess.run(
            cmd_str, cwd=self.dbschema_dir.parent, shell=True, capture_output=True, encoding="utf8"
        )
        if res.stderr != "":
            print(res.stderr)
            if "error: " in res.stderr:
                raise error_type(res.stderr)

    @property
    def schema_dir(self):
        schema_dir = None
        if self.dbschema_dir.name != "dbschema":
            schema_dir = self.dbschema_dir.name
        return schema_dir

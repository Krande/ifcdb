from __future__ import annotations

import os
import pathlib
import time
from dataclasses import dataclass
from io import StringIO
from typing import TYPE_CHECKING

import edgedb
from dotenv import load_dotenv

from ifcdb.config import IfcDbConfig
from ifcdb.database.admin import DbAdmin, DbMigration
from ifcdb.database.getters.get_bulk import BulkGetter
from ifcdb.database.inserts.file_inserts import INSERTS, insert_ifc_file
from ifcdb.database.remove import wipe_db
from ifcdb.diffing.overlinking.tool import OverlinkResolver
from ifcdb.diffing.tool import IfcDiffTool
from ifcdb.io.ifc import IfcIO
from ifcdb.schema.model import IfcSchemaModel
from ifcdb.schema.new_model import (
    db_entity_model_from_schema_model,
    db_entity_model_from_schema_version,
)

if TYPE_CHECKING:
    import ifcopenshell


@dataclass
class EdgeIO:
    database_name: str
    client: edgedb.Client | edgedb.AsyncIOClient = None
    db_schema_dir: str | pathlib.Path = "dbschema"
    ifc_schema: str = "IFC4x1"
    debug_log: bool = False
    schema_model: IfcSchemaModel = None
    load_env: bool = False
    use_new_schema_gen: bool = True

    db_config: IfcDbConfig = IfcDbConfig(ifc_schema)

    def __post_init__(self):
        self.db_schema_dir = pathlib.Path(self.db_schema_dir).resolve().absolute()
        self.schema_model = IfcSchemaModel(self.ifc_schema)

        if self.load_env:
            load_dotenv()

        if self.client is None:
            self.client = self.default_client()

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        if self.client is not None:
            self.client.close()

    def default_client(self) -> edgedb.Client:
        client = edgedb.create_client(database=self.database_name)
        return client

    def _create_migration_client(self) -> DbMigration:
        return DbMigration(
            database=self.database_name,
            db_config=self.db_config,
            dbschema_dir=self.db_schema_dir,
            debug_logs=self.debug_log,
            use_new_schema_gen=self.use_new_schema_gen,
        )

    def database_exists(self):
        with DbAdmin(self.database_name) as db_admin:
            return db_admin.database_exists()

    def create_database(self):
        with DbAdmin(self.database_name) as db_admin:
            db_admin.create_database()

    def setup_database(self, delete_existing_migrations=False, create_new_database=True):
        if create_new_database:
            self.create_database()

        db_migrate = self._create_migration_client()
        db_migrate.migrate_all_in_one(delete_existing_migrations=delete_existing_migrations)

    def wipe_database(self, max_attempts=3, delete_in_sequence=False):
        bg = self.to_bulk_getter()
        wipe_db(bg, delete_in_sequence, max_attempts)

    def stepwise_migration(self, ifc_schema_ver: str, entities: list[str] = None, batch_size=100, **kwargs):
        db_migrate = self._create_migration_client()
        db_migrate.migrate_stepwise(ifc_schema_ver, entities, batch_size, **kwargs)

    def get_entities_from_ifc_files(self, ifc_paths: list[str | pathlib.Path]) -> list[str]:
        return IfcIO.get_ifc_entities_from_multiple_ifcs(ifc_paths)

    def create_schema_from_ifc_file(
        self,
        ifc_path: str | pathlib.Path | list[str | pathlib.Path] = None,
        ifc_str: str = None,
        ifc_io_obj: IfcIO = None,
        extra_entities: list[str] = None,
        module_name="default",
    ):
        if isinstance(ifc_path, list):
            ifc_ents = self.get_entities_from_ifc_files(ifc_path)
        else:
            ifc_io = IfcIO(ifc_file=ifc_path, ifc_str=ifc_str) if ifc_io_obj is None else ifc_io_obj
            ifc_ents = ifc_io.get_unique_class_entities_of_ifc_content()

        if extra_entities is not None:
            ifc_ents += extra_entities

        self._write_to_file(ifc_ents, module_name)

    def create_schema(self, entities: list[str] = None, module_name="default"):
        if entities is None:
            unique_entities = self.schema_model.get_all_entities()
        else:
            unique_entities = entities

        self._write_to_file(unique_entities, module_name)

    def _write_to_file(self, unique_entities, module_name):
        related_entities = self.schema_model.get_related_entities(unique_entities)
        esdl_filepath = self.db_schema_dir / f"{module_name}.esdl"
        if self.use_new_schema_gen:
            dem = db_entity_model_from_schema_version(
                self.ifc_schema, related_entities, self.db_config.unwrapped_enums, self.db_config.unwrapped_selects
            )
            dem.to_esdl_file(esdl_filepath, module_name)
        else:
            self.schema_model.to_esdl_file(esdl_filepath, related_entities, module_name)

    def insert_ifc(
        self, ifc_file_path=None, ifc_file_str=None, method: INSERTS = INSERTS.SEQ, limit_ifc_ids: list[int] = None
    ) -> IfcIO:
        """Upload all IFC elements to EdgeDB instance"""
        ifc_io = IfcIO(ifc_file=ifc_file_path, ifc_str=ifc_file_str)
        ifc_items = ifc_io.get_ifc_objects_by_sorted_insert_order_flat()
        insert_ifc_file(ifc_items, self.client, method, self.ifc_schema, limit_ifc_ids=limit_ifc_ids)
        return ifc_io

    def update_from_diff_tool(self, diff_tool: IfcDiffTool, resolve_overlinking: bool = False) -> None | str:
        if diff_tool.contains_changes is False:
            print("No Changes to model detected")
            return None

        if resolve_overlinking:
            olr = OverlinkResolver(diff_tool)
            diff_tool = olr.resolve()

        bulk_entity_handler = diff_tool.to_bulk_entity_handler()

        start = time.time()
        for tx in self.client.transaction():
            with tx:
                query_str = bulk_entity_handler.to_edql_str()
                if query_str is None:
                    return
                print(query_str)
                return tx.query_single_json(query_str)
        end = time.time()

        print(f'Upload finished in "{end-start:.2f}" seconds')

    def update_db_from_ifc_delta(self, updated_ifc, original_ifc=None, save_diff_as=None, resolve_overlinking=False):
        def load_ifc_content(f: str | pathlib.Path | ifcopenshell.file) -> ifcopenshell.file:
            new_ifc = f if isinstance(f, ifcopenshell.file) else ifcopenshell.open(f)
            return new_ifc

        if original_ifc is not None:
            old_file = load_ifc_content(original_ifc)
        else:
            old_file = self.to_ifcopenshell_object()

        new_file = load_ifc_content(updated_ifc)
        diff_tool = IfcDiffTool(old_file, new_file)

        if save_diff_as is not None:
            diff_tool.to_json_file(save_diff_as)

        res = self.update_from_diff_tool(diff_tool, resolve_overlinking=resolve_overlinking)
        print(res)
        return res

    def to_bulk_getter(self) -> BulkGetter:
        return BulkGetter(self.client, self.schema_model)

    def to_ifcopenshell_object(self, specific_classes: list[str] = None, client=None) -> ifcopenshell.file:
        from ifcdb.database.getters.db_content import DbContent

        dem = db_entity_model_from_schema_model(
            self.schema_model,
            unwrap_enums=self.db_config.unwrapped_enums,
            unwrap_selects=self.db_config.unwrapped_selects,
        )

        dbc = DbContent(dem)
        return dbc.get_db_content_as_ifcopenshell_object(self.client)
        # bulk_g = self.to_bulk_getter()
        # res = bulk_g.get_all(entities=specific_classes, client=client)
        # res = bulk_g.get_all_2(entities=specific_classes, client=client)
        # return IfcIO.to_ifcopenshell_object(res, self.schema_model)

    def to_ifc_str(self, specific_classes: list[str] = None) -> str:
        f = self.to_ifcopenshell_object(specific_classes)
        return StringIO(f.wrapped_data.to_string()).read()

    def to_ifc_file(self, ifc_file_path: str | pathlib.Path, specific_classes: list[str] = None):
        ifc_file_path = pathlib.Path(ifc_file_path)
        res = self.to_ifc_str(specific_classes)

        os.makedirs(ifc_file_path.parent, exist_ok=True)
        with open(str(ifc_file_path), "w") as f:
            f.write(res)

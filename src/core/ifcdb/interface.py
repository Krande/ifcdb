from __future__ import annotations

import json
import os
import pathlib
from dataclasses import dataclass
from io import StringIO

import edgedb
import ifcopenshell
from dotenv import load_dotenv

from ifcdb.database.admin import DbConfig, DbMigration
from ifcdb.database.getters.get_bulk import GetBulk
from ifcdb.database.inserts.model import INSERTS
from ifcdb.database.inserts.sequentially import InsertSeq
from ifcdb.diffing.tool import IfcDiffTool
from ifcdb.io.ifc import IfcIO
from ifcdb.schema.model import IfcSchemaModel


@dataclass
class EdgeIO:
    database_name: str
    client: edgedb.Client | edgedb.AsyncIOClient = None
    db_schema_dir: str | pathlib.Path = "dbschema"
    ifc_schema: str = "IFC4x1"
    debug_log: bool = False
    schema_model: IfcSchemaModel = None
    load_env: bool = False

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
            dbschema_dir=self.db_schema_dir,
            debug_logs=self.debug_log,
        )

    def database_exists(self):
        with DbConfig(self.database_name) as db_config:
            return db_config.database_exists()

    def create_database(self):
        with DbConfig(self.database_name) as db_config:
            db_config.create_database()

    def setup_database(self, delete_existing_migrations=False, create_new_database=True):
        if create_new_database:
            self.create_database()

        db_migrate = self._create_migration_client()
        db_migrate.migrate_all_in_one(delete_existing_migrations=delete_existing_migrations)

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

        related_entities = self.schema_model.get_related_entities(ifc_ents)

        self.schema_model.to_esdl_file(self.db_schema_dir / "default.esdl", related_entities, module_name)

    def create_schema(self, entities: list[str] = None, module_name="default"):
        if entities is None:
            unique_entities = self.schema_model.get_all_entities()
        else:
            unique_entities = entities

        related_entities = self.schema_model.get_related_entities(unique_entities)

        self.schema_model.to_esdl_file(self.db_schema_dir / "default.esdl", related_entities, module_name)

    def insert_ifc(
        self, ifc_file_path=None, ifc_file_str=None, method=INSERTS.SEQ, limit_ifc_ids: list[int] = None
    ) -> IfcIO:
        """Upload all IFC elements to EdgeDB instance"""
        ifc_io = IfcIO(ifc_file=ifc_file_path, ifc_str=ifc_file_str)
        ifc_items = ifc_io.get_ifc_objects_by_sorted_insert_order_flat()

        for tx in self.client.transaction():
            with tx:
                if method == INSERTS.SEQ:
                    sq = InsertSeq(ifc_io.schema, specific_ifc_ids=limit_ifc_ids)
                    for item, insert_str in sq.create_bulk_insert_str(ifc_items):
                        single_json = tx.query_single_json(insert_str)
                        query_res = json.loads(single_json)
                        sq.uuid_map[item] = query_res["id"]
                else:
                    raise NotImplementedError(f'Unrecognized IFC insert method "{method}". ')
        return ifc_io

    def update_from_diff_tool(self, diff_tool: IfcDiffTool) -> None | str:
        if diff_tool.contains_changes is False:
            print("No Changes to model detected")
            return None
        bulk_entity_handler = diff_tool.to_bulk_entity_handler()

        for tx in self.client.transaction():
            with tx:
                query_str = bulk_entity_handler.to_edql_str()
                if query_str is None:
                    return
                print(query_str)
                return tx.query_single_json(query_str)

    def update_db_from_ifc_delta(self, original_ifc, modified_ifc, save_diff_as=None):
        old_file = original_ifc if isinstance(original_ifc, ifcopenshell.file) else ifcopenshell.open(original_ifc)
        new_file = modified_ifc if isinstance(modified_ifc, ifcopenshell.file) else ifcopenshell.open(modified_ifc)
        diff_tool = IfcDiffTool(old_file, new_file)
        if save_diff_as is not None:
            diff_tool.to_json_file(save_diff_as)
        res = self.update_from_diff_tool(diff_tool)
        print(res)
        return res

    def to_ifcopenshell_object(
        self, specific_classes: list[str] = None, only_ifc_entities=True, client=None
    ) -> ifcopenshell.file:

        gb = GetBulk(self.client, self.schema_model)
        res = gb.get_all(entities=specific_classes, limit_to_ifc_entities=only_ifc_entities, client=client)
        return IfcIO.to_ifcopenshell_object(res, self.schema_model)

    def to_ifc_str(self, specific_classes: list[str] = None, only_ifc_entities=True) -> str:
        f = self.to_ifcopenshell_object(specific_classes, only_ifc_entities)
        return StringIO(f.wrapped_data.to_string()).read()

    def to_ifc_file(
        self, ifc_file_path: str | pathlib.Path, specific_classes: list[str] = None, only_ifc_entities=True
    ):
        ifc_file_path = pathlib.Path(ifc_file_path)
        res = self.to_ifc_str(specific_classes, only_ifc_entities)

        os.makedirs(ifc_file_path.parent, exist_ok=True)
        with open(str(ifc_file_path), "w") as f:
            f.write(res)

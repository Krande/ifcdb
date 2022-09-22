import datetime
import json
import os
from dataclasses import dataclass, fields

from azure.storage.queue import QueueClient
from dotenv import load_dotenv


class DataClassUnpack:
    classFieldCache = {}

    @classmethod
    def instantiate(cls, class_to_instantiate, arg_dict):
        if class_to_instantiate not in cls.classFieldCache:
            cls.classFieldCache[class_to_instantiate] = {f.name for f in fields(class_to_instantiate) if f.init}

        field_set = cls.classFieldCache[class_to_instantiate]
        filtered_arg_dict = {k: v for k, v in arg_dict.items() if k in field_set}
        return class_to_instantiate(**filtered_arg_dict)


@dataclass
class IfcDbQueueMessage:

    diff: dict = None
    now_str: str = None

    def __post_init__(self):
        self.now_str = datetime.datetime.utcnow().strftime("%H:%M:%S [UTC]")

    def to_dict(self) -> dict:

        return dict(diff=self.diff, now_str=self.now_str)


@dataclass
class QueueHandler:
    interval_sec: int = 3
    load_env: bool = False

    def __post_init__(self):
        if self.load_env:
            load_dotenv()

        connect_str = os.getenv("AZURE_STORAGE_CONNECTION_STRING")
        queue_name = os.getenv("AZURE_QUEUE_NAME")
        self.queue_client = QueueClient.from_connection_string(connect_str, queue_name)

    def send_update(self, update_msg: IfcDbQueueMessage):
        self.queue_client.send_message(json.dumps(update_msg.to_dict()))

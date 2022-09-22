from __future__ import annotations

import json
import os
import time
from dataclasses import dataclass
from typing import Callable

from azure.core.paging import ItemPaged
from azure.storage.queue import QueueClient, QueueMessage
from dotenv import load_dotenv


@dataclass
class QueueHandler:
    task: Callable
    interval_sec: int = 3
    load_env: bool = False

    def __post_init__(self):
        if self.load_env:
            load_dotenv()

        connect_str = os.getenv("AZURE_STORAGE_CONNECTION_STRING")
        queue_name = os.getenv("AZURE_QUEUE_NAME")
        self.queue_client = QueueClient.from_connection_string(connect_str, queue_name)

    def run(self):
        while True:
            messages = self.queue_client.receive_messages(visibility_timeout=1)
            self.process_messages(messages)
            time.sleep(self.interval_sec)

    def process_messages(self, messages: ItemPaged[QueueMessage]):
        for msg_in in messages:
            msg_content = self.process_message(msg_in)
            if msg_content is None:
                continue

            self.perform_task(msg_content)
            self.queue_client.delete_message(msg_in.id, msg_in.pop_receipt)

    def send_update(self, update_msg: dict):
        update_block = dict(type="result", update_msg=update_msg)
        self.queue_client.send_message(json.dumps(update_block))

    def process_message(self, msg_in: QueueMessage) -> None | dict:
        msg_str = msg_in.content
        if msg_str == "null":
            print(f"deleting {msg_in}")
            self.queue_client.delete_message(msg_in.id, msg_in.pop_receipt)
            return None
        try:
            msg = json.loads(msg_str)
        except BaseException as e:
            print(f'Error "{e}" resulting in deletion of queue element')
            self.queue_client.delete_message(msg_in.id, msg_in.pop_receipt)
            return None

        if msg.get("type", None) == "result":
            return None

        return msg

    def perform_task(self, message: dict):
        result = self.task(message)
        self.send_update(result)

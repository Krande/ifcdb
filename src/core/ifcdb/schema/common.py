from dataclasses import dataclass
from typing import ClassVar


@dataclass
class CommonData:
    reserved_keys: ClassVar[dict] = dict(
        start="`Start`",
        union="`UNION`",
        group="`GROUP`",
        move="`MOVE`",
        check="`CHECK`",
        window="`WINDOW`",
    )

    @staticmethod
    def get_safe_key(key: str):
        return CommonData.reserved_keys.get(key.lower(), key)

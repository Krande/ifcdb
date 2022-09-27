from __future__ import annotations

import pytest

from ifcdb.schema.new_model import DbEntityResolver, db_entity_model_from_schema_version


@pytest.fixture
def schema_der() -> DbEntityResolver:
    der = db_entity_model_from_schema_version("IFC4x1")
    return der


@pytest.fixture
def schema_der_unwrapped_enums(schema_der) -> DbEntityResolver:
    schema_der.unwrap_enums()
    return schema_der

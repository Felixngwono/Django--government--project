"""One-off: create any model tables that exist in Django but are missing in the
dev database (the DB was restored from a SQL dump after migrations ran)."""
import os

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "FelloMarley.settings")

import django  # noqa: E402

django.setup()

from django.apps import apps  # noqa: E402
from django.db import connection  # noqa: E402

existing = set(connection.introspection.table_names())
created = []
for model in apps.get_models():
    table = model._meta.db_table
    if table not in existing and not model._meta.proxy:
        with connection.schema_editor() as se:
            se.create_model(model)
        created.append(table)

print("created:", created or "nothing missing")

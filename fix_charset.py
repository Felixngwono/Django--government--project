from django.db import connection

c = connection.cursor()
c.execute(
    "SELECT TABLE_NAME, COLUMN_NAME FROM information_schema.COLUMNS "
    "WHERE TABLE_SCHEMA='django-government' AND CHARACTER_SET_NAME='utf8mb3'"
)
rows = c.fetchall()
tables = sorted({r[0] for r in rows})
print("Tables with utf8mb3 columns:", tables)
for t in tables:
    c.execute(
        f"ALTER TABLE `{t}` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci"
    )
    print("converted", t)
print("done")

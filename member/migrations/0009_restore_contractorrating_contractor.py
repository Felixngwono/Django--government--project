from django.db import migrations


def add_contractor_field(apps, schema_editor):
    rating = apps.get_model('member', 'ContractorRating')
    field = rating._meta.get_field('contractor')
    columns = {
        column.name
        for column in schema_editor.connection.introspection.get_table_description(
            schema_editor.connection.cursor(),
            rating._meta.db_table,
        )
    }
    if field.column not in columns:
        schema_editor.add_field(rating, field)


def remove_contractor_field(apps, schema_editor):
    rating = apps.get_model('member', 'ContractorRating')
    field = rating._meta.get_field('contractor')
    columns = {
        column.name
        for column in schema_editor.connection.introspection.get_table_description(
            schema_editor.connection.cursor(),
            rating._meta.db_table,
        )
    }
    if field.column in columns:
        schema_editor.remove_field(rating, field)


class Migration(migrations.Migration):
    atomic = False

    dependencies = [
        ('member', '0008_restore_contractor_projects'),
    ]

    operations = [
        migrations.RunPython(add_contractor_field, remove_contractor_field),
    ]

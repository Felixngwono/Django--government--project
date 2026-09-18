from django.db import migrations


def add_contractor_field(apps, schema_editor):
    report = apps.get_model('member', 'StageReport')
    field = report._meta.get_field('contractor')
    columns = {
        column.name
        for column in schema_editor.connection.introspection.get_table_description(
            schema_editor.connection.cursor(),
            report._meta.db_table,
        )
    }
    if field.column not in columns:
        schema_editor.add_field(report, field)


def remove_contractor_field(apps, schema_editor):
    report = apps.get_model('member', 'StageReport')
    field = report._meta.get_field('contractor')
    columns = {
        column.name
        for column in schema_editor.connection.introspection.get_table_description(
            schema_editor.connection.cursor(),
            report._meta.db_table,
        )
    }
    if field.column in columns:
        schema_editor.remove_field(report, field)


class Migration(migrations.Migration):
    atomic = False

    dependencies = [
        ('member', '0009_restore_contractorrating_contractor'),
    ]

    operations = [
        migrations.RunPython(add_contractor_field, remove_contractor_field),
    ]

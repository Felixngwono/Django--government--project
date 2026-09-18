from django.db import migrations


def create_contractor_projects(apps, schema_editor):
    contractor = apps.get_model('member', 'Contractor')
    through = contractor._meta.get_field('projects').remote_field.through
    table_name = through._meta.db_table
    if table_name not in schema_editor.connection.introspection.table_names():
        schema_editor.create_model(through)


def remove_contractor_projects(apps, schema_editor):
    contractor = apps.get_model('member', 'Contractor')
    through = contractor._meta.get_field('projects').remote_field.through
    table_name = through._meta.db_table
    if table_name in schema_editor.connection.introspection.table_names():
        schema_editor.delete_model(through)


class Migration(migrations.Migration):
    atomic = False

    dependencies = [
        ('member', '0007_citizenevidence_category_citizenevidence_coordinates_and_more'),
    ]

    operations = [
        migrations.RunPython(create_contractor_projects, remove_contractor_projects),
    ]

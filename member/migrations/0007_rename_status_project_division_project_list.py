# Generated by Django 5.0.2 on 2024-03-14 16:14

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('member', '0006_remove_project_division_project_type_and_more'),
    ]

    operations = [
        migrations.RenameField(
            model_name='project_division',
            old_name='status',
            new_name='Project_list',
        ),
    ]

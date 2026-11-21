from django.db import migrations


def fix_contractor_rating_project_fk(apps, schema_editor):
    """Point contractor ratings at Django's actual Project table.

    Some deployed MySQL databases have a legacy FK to a table named `project`
    instead of the model table `member_project`, causing valid ratings to fail.
    """
    connection = schema_editor.connection
    if connection.vendor != 'mysql':
        return

    Rating = apps.get_model('member', 'ContractorRating')
    Project = apps.get_model('member', 'Project')
    rating_table = schema_editor.quote_name(Rating._meta.db_table)
    project_table = schema_editor.quote_name(Project._meta.db_table)

    with connection.cursor() as cursor:
        constraints = connection.introspection.get_constraints(
            cursor, Rating._meta.db_table
        )
    wrong_foreign_keys = []
    for name, details in constraints.items():
        foreign_key = details.get('foreign_key')
        if not foreign_key or details.get('columns') != ['project_id']:
            continue
        if foreign_key[0] == Project._meta.db_table:
            return
        wrong_foreign_keys.append(name)

    for name in wrong_foreign_keys:
        constraint_name = schema_editor.quote_name(name)
        schema_editor.execute(
            f'ALTER TABLE {rating_table} DROP FOREIGN KEY {constraint_name}'
        )

    # The legacy column was INT while Project.id is BIGINT; MySQL requires
    # matching types before it will accept the corrected foreign key.
    schema_editor.execute(
        f'ALTER TABLE {rating_table} MODIFY COLUMN `project_id` BIGINT NOT NULL'
    )
    constraint_name = schema_editor.quote_name('fk_contractor_rating_project')
    schema_editor.execute(
        f'ALTER TABLE {rating_table} ADD CONSTRAINT {constraint_name} '
        f'FOREIGN KEY (`project_id`) REFERENCES {project_table} (`id`) '
        'ON DELETE CASCADE'
    )


class Migration(migrations.Migration):
    atomic = False

    dependencies = [
        ('member', '0031_milestone_stage_description'),
    ]

    operations = [
        migrations.RunPython(fix_contractor_rating_project_fk, migrations.RunPython.noop),
    ]

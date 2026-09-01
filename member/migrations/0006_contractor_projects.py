from django.db import migrations, models


class Migration(migrations.Migration):
    """Create the missing member_contractor_projects table for Contractor.projects M2M field."""

    dependencies = [
        ('member', '0005_alter_project_project_status'),
    ]

    operations = [
        migrations.CreateModel(
            name='Contractor_projects',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('contractor', models.ForeignKey(db_column='contractor_id', on_delete=models.CASCADE, related_name='member_contractor_projects', to='member.contractor')),
                ('project', models.ForeignKey(db_column='project_id', on_delete=models.CASCADE, related_name='member_contractor_projects', to='member.project')),
            ],
            options={
                'db_table': 'member_contractor_projects',
                'unique_together': {('contractor', 'project')},
            },
        ),
    ]
# Generated by Django 5.0.2 on 2024-03-26 08:08

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('member', '0009_alter_user_profile'),
    ]

    operations = [
        migrations.CreateModel(
            name='PDF',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('project_title', models.CharField(max_length=100)),
                ('project_status', models.CharField(choices=[('ongoing', 'Ongoing'), ('upcoming', 'Upcoming'), ('completed', 'completed')], max_length=10)),
                ('project_description', models.TextField()),
                ('project_location', models.CharField(max_length=100)),
                ('implementing_agency', models.CharField(max_length=100)),
                ('project_Budget', models.CharField(max_length=100)),
                ('project_images', models.ImageField(blank=True, null=True, upload_to='images')),
                ('start_date', models.DateTimeField(auto_now_add=True, null=True)),
                ('end_date', models.DateField(auto_now=True, null=True)),
            ],
        ),
    ]

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ('member', '0030_mpesapayment'),
    ]

    operations = [
        migrations.AddField(
            model_name='milestone',
            name='stage_description',
            field=models.CharField(blank=True, max_length=255),
        ),
    ]

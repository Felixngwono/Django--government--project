from django.db import migrations, models
import django.core.validators


class Migration(migrations.Migration):
    dependencies = [('member', '0002_project_schema_repair')]

    operations = [
        migrations.AddField(model_name='testimonial', name='rating', field=models.PositiveSmallIntegerField(default=5, validators=[django.core.validators.MinValueValidator(1), django.core.validators.MaxValueValidator(5)])),
        migrations.AddField(model_name='testimonial', name='is_featured', field=models.BooleanField(default=False)),
        migrations.AddField(model_name='testimonial', name='moderation_note', field=models.TextField(blank=True)),
        migrations.AddField(model_name='testimonial', name='updated_at', field=models.DateTimeField(auto_now=True)),
    ]

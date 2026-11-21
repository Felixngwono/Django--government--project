from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):
    dependencies = [
        ('member', '0029_governmentagency_and_more'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.AddField(
            model_name='contractorpaymentrequest', name='disbursement_status',
            field=models.CharField(choices=[('not_started', 'Not started'), ('pending', 'Awaiting M-Pesa confirmation'), ('successful', 'Successful'), ('failed', 'Failed')], db_index=True, default='not_started', max_length=20),
        ),
        migrations.AddField(
            model_name='contractorpaymentrequest', name='mpesa_phone_number',
            field=models.CharField(blank=True, max_length=20),
        ),
        migrations.AddField(
            model_name='contractorpaymentrequest', name='mpesa_conversation_id',
            field=models.CharField(blank=True, max_length=100),
        ),
        migrations.AddField(
            model_name='contractorpaymentrequest', name='mpesa_originator_conversation_id',
            field=models.CharField(blank=True, max_length=100),
        ),
        migrations.AddField(
            model_name='contractorpaymentrequest', name='mpesa_result_code',
            field=models.IntegerField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='contractorpaymentrequest', name='mpesa_result_description',
            field=models.TextField(blank=True),
        ),
        migrations.CreateModel(
            name='MpesaCallback',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('callback_type', models.CharField(choices=[('result', 'Payment result'), ('timeout', 'Queue timeout')], max_length=10)),
                ('conversation_id', models.CharField(max_length=100)),
                ('originator_conversation_id', models.CharField(max_length=100)),
                ('result_code', models.IntegerField(blank=True, null=True)),
                ('result_description', models.TextField(blank=True)),
                ('transaction_receipt', models.CharField(blank=True, max_length=100)),
                ('received_at', models.DateTimeField(auto_now_add=True)),
                ('processed_at', models.DateTimeField(blank=True, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='MpesaPayment',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('amount', models.DecimalField(decimal_places=2, max_digits=10)),
                ('phone_number', models.CharField(max_length=20)),
                ('description', models.CharField(max_length=100)),
                ('status', models.CharField(choices=[('pending', 'Awaiting M-Pesa confirmation'), ('successful', 'Successful'), ('failed', 'Failed')], db_index=True, default='pending', max_length=20)),
                ('checkout_request_id', models.CharField(blank=True, max_length=100, null=True, unique=True)),
                ('merchant_request_id', models.CharField(blank=True, max_length=100)),
                ('receipt_number', models.CharField(blank=True, max_length=100)),
                ('result_code', models.IntegerField(blank=True, null=True)),
                ('result_description', models.TextField(blank=True)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='mpesa_payments', to=settings.AUTH_USER_MODEL)),
            ],
            options={'ordering': ['-created_at']},
        ),
        migrations.AddConstraint(
            model_name='mpesacallback',
            constraint=models.UniqueConstraint(fields=('callback_type', 'conversation_id', 'originator_conversation_id'), name='unique_mpesa_callback_event'),
        ),
    ]

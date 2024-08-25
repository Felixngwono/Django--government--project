
from django.db import models
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    email = models.EmailField(unique=True, null=True)
    username = models.CharField(max_length=20)
    name = models.CharField(max_length= 20, null=True)
    is_superuser = models.BooleanField(default=False)
    is_enduser = models.BooleanField(default=False)
    bio = models.TextField(null= True)
    avatar = models.ImageField(null=True, default="avatar.png")
    profile=models.ImageField(null=True,upload_to='profile',default="avatar.png")
    USERNAME_FIELD ='email'
    REQUIRED_FIELDS = []
    
class contact(models.Model):
    name= models.CharField(max_length=100)
    email=models.EmailField()
    message=models.TextField()
    def __str__(self):
        return self.name
    
    
class Feedback(models.Model):
    Full_name=models.CharField(max_length=30,null=True)
    email=models.EmailField()
    phone_number= models.IntegerField(null=True)
    feedback= models.TextField(null=True)
    def __str__(self):
            return self.name
            


class Project(models.Model):
    project_status=(
        ('ongoing', 'Ongoing'),
       ( 'upcoming', 'Upcoming'),
        ('completed', 'completed')
    )
    project_title= models.CharField(max_length=100)
    project_description=models.TextField()
    project_location=models.CharField(max_length=100)
    implementing_agency=models.CharField(max_length=100)
    project_Budget=models.CharField(max_length=100)
    project_images = models.ImageField(null=True, blank=True, upload_to='images')
    start_date=models.DateTimeField(auto_now_add=True,null=True)
    end_date=models.DateField(auto_now=True,null=True)
    project_status= models.CharField(max_length=10,choices=project_status)
    
    class Meta:
        ordering= ['-start_date']
    
    def __str__(self):
       return self.project_title
    
   
   
class Project_type(models.Model):
    name= models.CharField(max_length=100)
    def __str__(self):
           return self.name
   
    

class Project_Division(models.Model):
    name=models.CharField(max_length=100)
    project_type=models.ForeignKey(Project_type,on_delete=models.CASCADE, null=True)
    Project_list=models.ForeignKey(Project,on_delete=models.CASCADE, null=True)
    
    def __str__(self):
           return self.name
        
        
class PDF(models.Model):
    project_status=(
        ('ongoing', 'Ongoing'),
       ( 'upcoming', 'Upcoming'),
        ('completed', 'completed')
    )
    project_title = models.CharField(max_length=100)
    project_status= models.CharField(max_length=10,choices=project_status)
    project_description=models.TextField()
    project_location=models.CharField(max_length=100)
    implementing_agency=models.CharField(max_length=100)
    project_Budget=models.CharField(max_length=100)
    project_images = models.ImageField(null=True, blank=True, upload_to='images')
    start_date=models.DateTimeField(auto_now_add=True,null=True)
    end_date=models.DateField(auto_now=True,null=True)
 
    def __str__(self):
        return self.project_title
        
    

    
    
class PDF(models.Model):
    # Basic fields to store metadata about the PDF
    project_title = models.CharField(max_length=255, null=True)
    Project_status = models.CharField(max_length=100 ,null=True)
    implementing_agency = models.CharField(max_length=255, null=True)
    
    # Field to store the actual PDF file
    pdf_file = models.FileField(upload_to='pdfs/', blank=True, null=True)

    def __str__(self):
        return self.project_Title

    class Meta:
        verbose_name = "PDF"
        verbose_name_plural = "PDFs"
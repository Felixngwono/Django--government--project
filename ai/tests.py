from django.test import TestCase

from ai.views import visible_projects
from member.models import Project, User


class VisibleProjectsTests(TestCase):
    def setUp(self):
        self.public_project = Project.objects.create(
            project_title='Public works', project_status='ongoing', is_public=True
        )
        self.private_project = Project.objects.create(
            project_title='Internal draft', project_status='draft', is_public=False
        )
        self.citizen = User.objects.create_user(
            email='public@example.com', username='public-user', password='password123', role='citizen'
        )
        self.official = User.objects.create_user(
            email='official@example.com', username='official-user', password='password123', role='official'
        )

    def test_citizens_only_see_public_projects(self):
        projects = visible_projects(self.citizen)
        self.assertQuerySetEqual(projects.order_by('pk'), [self.public_project])

    def test_officials_can_see_public_and_private_projects(self):
        projects = visible_projects(self.official)
        self.assertCountEqual(projects, [self.public_project, self.private_project])

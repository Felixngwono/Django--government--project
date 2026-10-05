"""Only admins may delete projects (deleteProject view)."""
from django.test import TestCase
from django.urls import reverse

from .models import Project, User


class ProjectDeletePermissionTests(TestCase):
    @classmethod
    def setUpTestData(cls):
        cls.project = Project.objects.create(project_title="Delete Me", project_status="draft")
        cls.admin = User.objects.create_user(email="admin@example.com", username="admin1", password="x", role="admin")
        cls.official = User.objects.create_user(email="official@example.com", username="official1", password="x", role="official")
        cls.citizen = User.objects.create_user(email="citizen@example.com", username="citizen1", password="x")
        cls.superuser = User.objects.create_superuser(email="root@example.com", username="root1", password="x")

    def _client_for(self, user):
        from django.test import Client
        c = Client()
        c.force_login(user)
        return c

    def test_citizen_and_official_cannot_delete(self):
        for user in (self.citizen, self.official):
            with self.subTest(role=user.role or "citizen"):
                r = self._client_for(user).get(reverse("delete", args=[self.project.pk]))
                self.assertEqual(r.status_code, 403)
                self.assertTrue(Project.objects.filter(pk=self.project.pk).exists())

    def test_admin_sees_confirmation_and_deletes(self):
        c = self._client_for(self.admin)
        r = c.get(reverse("delete", args=[self.project.pk]))
        self.assertEqual(r.status_code, 200)
        self.assertContains(r, "Delete Me")
        r = c.post(reverse("delete", args=[self.project.pk]))
        self.assertEqual(r.status_code, 302)
        self.assertFalse(Project.objects.filter(pk=self.project.pk).exists())

    def test_superuser_can_delete(self):
        r = self._client_for(self.superuser).post(reverse("delete", args=[self.project.pk]))
        self.assertEqual(r.status_code, 302)
        self.assertFalse(Project.objects.filter(pk=self.project.pk).exists())

    def test_missing_project_redirects(self):
        r = self._client_for(self.admin).post(reverse("delete", args=[99999]))
        self.assertEqual(r.status_code, 302)

"""Seed lookup tables: Regions, Districts, and ProjectCategories."""
from django.core.management.base import BaseCommand
from member.models import Region, District, ProjectCategory


REGIONS = {
    "Nairobi": ["Nairobi"],
    "Central": ["Nyandarua", "Nyeri", "Kirinyaga", "Murang'a", "Kiambu"],
    "Coast": ["Mombasa", "Kwale", "Kilifi", "Tana River", "Lamu", "Taita Taveta"],
    "North Eastern": ["Garissa", "Wajir", "Mandera"],
    "Eastern": ["Marsabit", "Isiolo", "Meru", "Tharaka-Nithi", "Embu", "Kitui", "Machakos", "Makueni"],
    "Rift Valley": ["Turkana", "West Pokot", "Samburu", "Trans Nzoia", "Uasin Gishu", "Elgeyo-Marakwet", "Nandi", "Baringo", "Laikipia", "Nakuru", "Narok", "Kajiado", "Kericho", "Bomet"],
    "Western": ["Kakamega", "Vihiga", "Bungoma", "Busia"],
    "Nyanza": ["Siaya", "Kisumu", "Homa Bay", "Migori", "Kisii", "Nyamira"],
}

CATEGORIES = [
    ("Roads & Transport", "Road construction, bridges and public transport infrastructure.", "fa-road", "#3b82f6"),
    ("Water & Sanitation", "Water supply, drainage and sanitation projects.", "fa-droplet", "#06b6d4"),
    ("Health", "Hospitals, clinics and public health facilities.", "fa-hospital", "#ef4444"),
    ("Education", "Schools, colleges and educational infrastructure.", "fa-graduation-cap", "#8b5cf6"),
    ("Energy", "Power generation, transmission and rural electrification.", "fa-bolt", "#f59e0b"),
    ("Agriculture", "Irrigation, farming support and food security programs.", "fa-wheat-awn", "#22c55e"),
    ("Housing", "Affordable housing and urban settlement projects.", "fa-house", "#ec4899"),
    ("ICT", "Digital infrastructure, connectivity and e-government.", "fa-server", "#6366f1"),
    ("Environment", "Conservation, forestry, waste management and climate resilience.", "fa-leaf", "#10b981"),
    ("Trade & Markets", "Markets, trade centres and commercial infrastructure.", "fa-store", "#f97316"),
    ("Security", "Police posts, courts and public safety facilities.", "fa-shield-halved", "#64748b"),
]

REGION_CODES = {
    "Nairobi": "NBO", "Central": "CNT", "Coast": "CST", "North Eastern": "NEA",
    "Eastern": "EST", "Rift Valley": "RVT", "Western": "WST", "Nyanza": "NYZ",
}


# Keyword rules used to guess a category from a project title/description.
KEYWORD_CATEGORY_MAP = [
    (("road", "bridge", "highway", "transport", "bus", "junction"), "Roads & Transport"),
    (("water", "sanitation", "sewer", "drainage", "borehole", "well"), "Water & Sanitation"),
    (("hospital", "clinic", "health", "medical", "dispensary"), "Health"),
    (("school", "college", "education", "classroom", "university", "library"), "Education"),
    (("power", "electric", "energy", "solar", "grid", "transformer"), "Energy"),
    (("farm", "agricultur", "irrigation", "crop", "livestock", "market garden"), "Agriculture"),
    (("hous", "estate", "settlement", "apartment", "shelter"), "Housing"),
    (("ict", "digital", "internet", "fiber", "network", "data center", "e-govern"), "ICT"),
]

DEFAULT_CATEGORY = "Roads & Transport"
DEFAULT_DISTRICT = "Nairobi"


def guess_category(text):
    text = (text or "").lower()
    for keywords, category in KEYWORD_CATEGORY_MAP:
        if any(k in text for k in keywords):
            return category
    return None


class BackfillMixin:
    """Assign a category and district to every project that is missing one."""

    def backfill_projects(self):
        from member.models import Project

        projects = Project.objects.filter(district__isnull=True) | Project.objects.filter(category__isnull=True)
        district_default = District.objects.filter(name=DEFAULT_DISTRICT).first()
        category_by_name = {c.name: c for c in ProjectCategory.objects.all()}

        updated = 0
        for project in projects:
            changed = False
            text = f"{project.project_title or ''} {project.project_description or ''}"

            if project.category is None:
                guess = guess_category(text) or DEFAULT_CATEGORY
                project.category = category_by_name.get(guess)
                changed = True

            if project.district is None:
                project.district = district_default
                changed = True

            if changed:
                project.save(update_fields=["category", "district"])
                updated += 1

        self.stdout.write(self.style.SUCCESS(f"Backfilled category/district on {updated} project(s)."))
class Command(BackfillMixin, BaseCommand):
    help = "Seed Regions, Districts and ProjectCategories lookup tables."

    def handle(self, *args, **options):
        for region_name, districts in REGIONS.items():
            region, created = Region.objects.get_or_create(name=region_name, defaults={"code": REGION_CODES.get(region_name, region_name[:3].upper())})
            for district_name in districts:
                District.objects.get_or_create(name=district_name, region=region)
            if created:
                self.stdout.write(self.style.SUCCESS(f"Created region: {region_name}"))

        for name, description, icon, color in CATEGORIES:
            cat, created = ProjectCategory.objects.get_or_create(
                name=name,
                defaults={"description": description, "icon": icon, "color": color},
            )
            if created:
                self.stdout.write(self.style.SUCCESS(f"Created category: {name}"))

        self.stdout.write(self.style.SUCCESS(
            f"Done. Regions: {Region.objects.count()}, Districts: {District.objects.count()}, "
            f"Categories: {ProjectCategory.objects.count()}"
        ))

        self.backfill_projects()


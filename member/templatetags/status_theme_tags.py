from django import template

register = template.Library()

STATUS_THEME = {
    "completed": {"text": "text-green-700", "bg": "bg-green-100", "ring": "ring-green-200", "grad": "from-green-500 to-emerald-600", "icon": "fluent:checkmark-circle-24-filled"},
    "ongoing":   {"text": "text-blue-700",   "bg": "bg-blue-100",   "ring": "ring-blue-200",   "grad": "from-blue-500 to-indigo-600",   "icon": "eos-icons:loading"},
    "upcoming":  {"text": "text-violet-700", "bg": "bg-violet-100", "ring": "ring-violet-200", "grad": "from-violet-500 to-purple-600", "icon": "mdi:calendar-clock"},
    "delayed":   {"text": "text-orange-700", "bg": "bg-orange-100", "ring": "ring-orange-200", "grad": "from-orange-500 to-amber-600",  "icon": "mdi:clock-alert-outline"},
    "stalled":   {"text": "text-red-700",    "bg": "bg-red-100",    "ring": "ring-red-200",    "grad": "from-red-500 to-rose-600",      "icon": "mdi:pause-circle-outline"},
    "suspended": {"text": "text-amber-700",  "bg": "bg-amber-100",  "ring": "ring-amber-200",  "grad": "from-amber-500 to-yellow-600",  "icon": "mdi:shield-alert-outline"},
    "cancelled": {"text": "text-gray-700",   "bg": "bg-gray-200",   "ring": "ring-gray-300",   "grad": "from-gray-400 to-gray-600",     "icon": "mdi:close-circle-outline"},
    "draft":     {"text": "text-slate-700",  "bg": "bg-slate-100",  "ring": "ring-slate-200",  "grad": "from-slate-400 to-slate-600",   "icon": "mdi:pencil-ruler"},
}


@register.simple_tag
def status_theme(status):
    """Return the theme dict (text/bg/ring/grad/icon) for a project status."""
    return STATUS_THEME.get(status or "draft", STATUS_THEME["ongoing"])


@register.filter
def num(value):
    """Return a clean float without thousand separators (safe for JS)."""
    try:
        return float(value)
    except (TypeError, ValueError):
        return 0.0

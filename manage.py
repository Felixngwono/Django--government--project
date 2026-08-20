#!/usr/bin/env python
"""Django's command-line utility for administrative tasks."""
import os
import sys

# Patch for Python 3.14 compatibility with Django template Context.__copy__
try:
    import django.template.context as _dtc
    if not hasattr(_dtc.BaseContext, '__copy__'):
        _dtc.BaseContext.__copy__ = lambda self: self.__class__.__new__(self.__class__)
except Exception:
    pass


def main():
    """Run administrative tasks."""
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'FelloMarley.settings')
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    execute_from_command_line(sys.argv)


if __name__ == '__main__':
    main()

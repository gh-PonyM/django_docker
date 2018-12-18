#!/usr/bin/env bash
set -e

# start gunicorn
echo "exec starting gunicorn at ${GUNICORN_BIND} (RELOAD=${GUNICORN_RELOAD}, APP=${DJANGO_PROJECT})"
cd ${DJANGO_PROJECT}
python manage.py collectstatic --no-input

exec gunicorn -c /etc/gunicorn/gunicorn.conf "${DJANGO_PROJECT}.wsgi"

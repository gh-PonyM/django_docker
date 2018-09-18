#!/bin/bash
set -e
echo "starting dev server with docker"
image_tag="django-gunicorn-base:latest"
django_project_folder="django_docker"

# get the path of the file
dir="`dirname \"$0\"`"
basedir="`( cd \"$dir\" && pwd )`"

workdir="${basedir}/${django_project_folder}"

echo "workdir: $workdir"

docker run -it --rm -v "${workdir}:/code" -p "8000:8000" --name django-dev --network="host" $image_tag python manage.py runserver

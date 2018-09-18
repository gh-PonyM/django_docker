#!/bin/bash
set -e
echo "Building image and create default project."
image_tag="django-gunicorn-base:latest"
django_project_folder="django_docker"

# get the path of the file
dir="`dirname \"$0\"`"
basedir="`( cd \"$dir\" && pwd )`"
workdir="${basedir}/${django_project_folder}"

echo "Creating project $django_project_folder in $basedir"
docker build -t $image_tag ./images/django-gunicorn-base
docker run -it --rm -v "${basedir}:/code" -p "8000:8000" $image_tag django-admin startproject $django_project_folder
echo "Migrating"
docker run -it --rm -v "${basedir}:/code" -p "8000:8000" $image_tag django-admin migrate
echo
echo "Changing owner of $workdir to $SUDO_USER"
chown -R $SUDO_USER:$SUDO_USER $workdir
echo
echo "finished!"
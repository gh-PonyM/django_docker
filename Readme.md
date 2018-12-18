# How to setup django_docker
I assume that docker and docker compose is installed.

# About this starter template

This template is meant to facilitates starting with django/nginx/postgres stack using and docker-compose. The current template is suitable for a webapp also using email notifications. It features:

- Live reloading of the app with your source code mounted
- Easy switching between django projects by changing `DJANGO_PROJECT` environment variable
- Configuration handling for lauchning gunicorn using `GUNICORN_WORKERS`, `GUNICORN_BIND`, `GUNICORN_DEBUG` and `GUNICORN_LOGLEVEL` by using `start.sh`. The container will stop gracefully with exit code 0 on `SIGTERM`.
- With the above avoiding read/write permissions problems when executing django managment commands from inside the container with mounted source code if run under user root.
- environ variables used for different services centrally in `.env` files.  
- nginx serving static files from docker volumes connected to web service. When launching the webcontainer, static files are collected to the docker-volume automatically.

The django-base image features a user python with UUID 1000.

## Before you start

Make sure you have docker and docker-compose installed.

## Set up this repo

First, build/download and run the stack

    docker-compose up --build

Open a second command prompt and enter the container:

    docker-compose exec web bash

and run

    python manage.py makemigrations
    python manage.py migrate
    python manage.py createsuperuser

and visit `localhost/admin` on your browser.

## Todo

- create non-root user in images and handle file permissions elegantly with as gosu
entrypoint

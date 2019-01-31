# How to setup django_docker

It should not be a pony to have the advantages of docker-compose but not been able to
develop locally without live reloading or performing simple management commands from the
 shell....and then eventually run into file permission issues. Also entrypoints and
  custom start scripts are sometimes tricky because containers might not shutdown
   gracefully. This stack solves this issue with the aid of `gosu`.

# About this starter template

This template is meant to facilitates starting with django/nginx/postgres stack using and docker-compose. The current template is suitable for a webapp also using email notifications. It features:

- Live reloading of the app with your source code mounted.
- Easy switching between django projects by changing `DJANGO_PROJECT` environment variable.
- Configuration handling for lauchning gunicorn using `GUNICORN_WORKERS`, `GUNICORN_BIND`, `GUNICORN_DEBUG` and `GUNICORN_LOGLEVEL`(see `start.sh`).
- Containers stop gracefully with exit code 0 on `SIGTERM`.
- Launch containers with your `LOCAL_USER_ID` (UID) on Mac/Linux.
- environ variables used for different services centrally in `.env` files.  
- mounted `django-docker.conf` to make changes to nginx config without reloading the app.

## Set up this repo

First, build/download and run the stack

    docker-compose up --build

Open a second command prompt and enter the container with user UID 1000:

    docker-compose exec -u 1000 web bash

and run

    python manage.py makemigrations
    python manage.py migrate
    python manage.py createsuperuser

and visit `localhost/admin` on your browser. That's it!


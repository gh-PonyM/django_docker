# How to setup django_docker
I assume that docker and docker compose is installed.

# About this starter template

This template is meant to facilitates starting with django/nginx/postgres stack using and docker-compose. The current template is suitable for a webapp also using email notifications. It features:

- Live reloading of the app with your source code mounted
- Easy switching between django projects by changing `DJANGO_PROJECT` environment variable
- Configuration handling for lauchning gunicorn using `GUNICORN_WORKERS`, `GUNICORN_BIND`, `GUNICORN_DEBUG` and `GUNICORN_LOGLEVEL` by using `start.sh`. The container will stop gracefully with exit code 0 on `SIGTERM`.
- Custom entrypoint and start scripts to change default `root` user while graceful shutdown still works.
- Executing django management commands inside container without file permissions problems.
- Easy switching between django projects by changing `DJANGO_PROJECT` environment variable only.
- environ variables used for different services centrally in `.env` files.  
- Automatic static file collection when web container is launched.
- mounted `nginx.conf` to make changes without reloading the app.

## Set up this repo

First, build/download and run the stack

    docker-compose up --build

Open a second command prompt and enter the container with user UID 1000:

    docker-compose exec -u 1000 web bash

and run

    python manage.py makemigrations
    python manage.py migrate
    python manage.py createsuperuser

and visit `localhost/admin` on your browser.

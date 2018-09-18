# images/django-gunicorn-base/Dockerfile
FROM python:3
MAINTAINER dadadamotha@gmail.com
LABEL dockerfile_location="" \
      image_name=django-base:latest \
      base_image=python:3

RUN mkdir -p /var/www/static && mkdir -p /var/www/media && mkdir -p /etc/gunicorn && mkdir -p /code

ENV PYTHONUNBUFFERED 1
WORKDIR /code
RUN pip install --no-cache-dir django gunicorn psycopg2-binary

# volume can be used to serve these files with a webserver
VOLUME /var/www/static
VOLUME /var/www/media
# volume for live-reload during development, created in base image

# add gunicorn config
COPY gunicorn.conf /etc/gunicorn/
COPY logging.conf /etc/gunicorn/
# env can be overwritten by a compose file, this is default config
ENV GUNICORN_WORKERS=2
ENV GUNICORN_BIND=0.0.0.0:8000
ENV GUNICORN_LOGLEVEL="warning"
ENV GUNICORN_RELOAD="false"
ENV DJANGO_APP="django_docker"
ENV DJANGO_SETTINGS_MODULE="${DJANGO_APP}.settings"
COPY start.sh /
RUN chmod +x /start.sh
CMD ["/start.sh"]

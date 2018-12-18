# images/django-base/Dockerfile
FROM python:3.7.0
MAINTAINER dadadamotha@gmail.com
LABEL dockerfile_location="" \
      image_name=django-base:latest \
      base_image=python:3.7.0

# Copied from official node image
RUN groupadd --gid 1000 python \
  && useradd --uid 1000 --gid python --shell /bin/bash --create-home python

RUN mkdir -p /var/www/static && mkdir -p /var/www/media && mkdir -p /etc/gunicorn && mkdir -p /code

# add gunicorn config
COPY *.conf /etc/gunicorn/

ENV PYTHONUNBUFFERED 1
WORKDIR /code

# This needs improvement!
COPY requirements/default.txt .
RUN pip install --no-cache-dir -r default.txt


# volume can be used to serve these files with a webserver
VOLUME /var/www/static
VOLUME /var/www/media
# volume for live-reload during development, created in base image

# env can be overwritten by a compose file, this is default config
ENV GUNICORN_BIND=0.0.0.0:8000
ENV GUNICORN_LOGLEVEL="info"
ENV GUNICORN_RELOAD="false"

# Copy start script
COPY start.sh /
RUN chmod +x /start.sh
CMD ["/start.sh"]

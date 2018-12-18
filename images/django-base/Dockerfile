# images/django-base/Dockerfile
FROM python:3.7.0
MAINTAINER dadadamotha@gmail.com
LABEL dockerfile_location="" \
      image_name=django-base:latest \
      base_image=python:3.7.0

RUN mkdir -p /var/www/static && mkdir -p /var/www/media && mkdir -p /etc/gunicorn && mkdir -p /code

# Install gosu
RUN set -eux; \
	apt-get update; \
	apt-get install -y gosu; \
	rm -rf /var/lib/apt/lists/*; \
# verify that the binary works
	gosu nobody true

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
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /start.sh && chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/start.sh"]

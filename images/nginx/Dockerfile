FROM nginx:latest

# Install gosu
RUN set -eux; \
	apt-get update; \
	apt-get install -y gosu; \
	rm -rf /var/lib/apt/lists/*; \
# verify that the binary works
	gosu nobody true

RUN rm -f /etc/nginx/nginx.conf && rm -f /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/static && mkdir -p /var/www/media

COPY start_nginx.sh /
RUN chmod +x /start_nginx.sh

CMD ["/start_nginx.sh"]

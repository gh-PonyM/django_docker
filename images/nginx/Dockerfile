FROM nginx:latest

RUN rm -f /etc/nginx/nginx.conf && rm -f /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/static && chown -R nginx:nginx /var/www/static &&\
 mkdir -p /var/www/media && chown -R nginx:nginx /var/www/media

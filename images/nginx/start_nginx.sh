#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

USER_ID=${LOCAL_USER_ID:-9001}

echo "Changin UID of nginx to $USER_ID"
usermod -u $USER_ID nginx

echo "Changin GID of nginx to $USER_ID"
groupmod -g $USER_ID nginx

chown -R $USER_ID:$USER_ID /var/www/media
chown -R $USER_ID:$USER_ID /var/www/static

exec nginx -g "daemon off;"

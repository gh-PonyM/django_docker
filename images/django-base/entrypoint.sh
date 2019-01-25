#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

USER_ID=${LOCAL_USER_ID:-9001}

echo "Starting with UID : $USER_ID"
useradd --shell /bin/bash -u $USER_ID -o -c "" -m user
export HOME=/home/user

echo "changing ownership of static and media directory with UID ${USER_ID}"

chown -R $USER_ID:$USER_ID /var/www/media
chown -R $USER_ID:$USER_ID /var/www/static

exec gosu user "$@"
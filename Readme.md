# How to setup django_docker
I assume that docker and docker compose is installed.

## Starting using linux
If On Linux, start the script `create_default_project.sh` and the run test server.
    
    sudo ./create_default_project.sh
    ./start_dev_server.sh
    
Check the ip on the console and bring it to the browser.


## Starting using Windows / Mac

First, build the base image for Django using gunicorn and nginx proxy server from  the project main directory.

    docker build -t django-gunicorn-base:latest ./images/django-gunicorn-base

Mount the current directory you are in to `/code` inside the container and then run `django-admin startproject`.  
The container exits after the command and removes itself.

    # in the current directory of create_default_project.sh
    docker run -it --rm -v "<CURRENT DIRECTORY>:/code" django-gunicorn-base django-admin startproject django_docker

Since the container created `django_docker` as root in Linux, you eventually must change the file permissions in order
to make changes to your files.

As the default project is created now, launch a first try:

    docker run -it --rm django-gunicorn-base python manage.py runserver
    
## Adaptions to launch with gunicorn

Since settings for gunicorn have to be configured also inside our project's `django_docker.settings`.  
When launched with gunicorn and proxy nginx, we have to allow all ip's since they change for every launch.

Change the following in `django_docker.settings`:

```python
ALLOWED_HOSTS = ['*']

STATIC_URL = '/static/'
MEDIA_URL = '/media/'
STATIC_ROOT = '/var/www/static'

if DEBUG:
    # Static files (CSS, JavaScript, Images)
    # https://docs.djangoproject.com/en/2.1/howto/static-files/
    MEDIA_ROOT = os.path.join(BASE_DIR, 'media')
else:   
    # this for production    
    MEDIA_ROOT = '/var/www/media'
    
```

Copy the following in `django_docker.urls`:


```python
from django.contrib import admin
from django.urls import path

from django.conf import settings
from django.conf.urls.static import static  

urlpatterns = [
    path('admin/', admin.site.urls),
]

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

```

# Launch with docker compose

Assuming you have made the above adaptions, launch the services

    docker-compose up --build
    
Now we want to check the IP of the nginx and web container:

    docker network inspect django_docker_default
    
Enter **IP of nginx container** in the browser to go to the django admin page, e.g. `173.0.20.3/admin`
You should see the login form without CSS loading correctly as seen in the logs.
Open a different terminal and enter inside of the django container. We want now to collect static files
of the admin app to our location and serve them with nginx.  
We enter inside the container web:

    docker-compose exec -it web bash
    
    # Running as root
    python manage.py migrate
    python manage.py collectstatic --no-input
    
No check again your app at `173.0.20.3/admin`. The static files should load now.


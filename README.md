cargomedia/cm-application
=========================
Docker image with cm application dependencies.


Build:
```sh
docker build -t cargomedia/cm-application:latest .
```

Run a cm application's `Procfile` with foreman (in test mode):
```
docker run -it --rm -v /path/to/my-project:/opt/project cargomedia/cm-application:latest foreman start -d /opt/project
```

Run php-fpm (in test mode):
```
docker run -it --rm cargomedia/cm-application:latest /docker-run-php5-fpm
```

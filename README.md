cargomedia/cm-application
=========================
Docker image with cm application dependencies.

Build:
```sh
docker build -t cargomedia/cm-application:latest .
```

Run a cm application (services via [supervisord](http://supervisord.org/) + php5-fpm)
```
docker run -it --rm --workdir /opt/project -v /path/to/my-project:/opt/project cargomedia/cm-application:latest
```

*Note: the workdir must match with the project directory mounted in the container*

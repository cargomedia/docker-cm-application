cargomedia/cm-application
=========================
Docker image with cm application dependencies.

Build:
```sh
docker build -t cargomedia/cm-application:latest .
```

### Run

Commands:
- `start`: wait for all required services, setup the application if needed, then run all internal CM services + php5-fpm
- `test [phpunit-arguments]`: wait for all required services, setup the application if needed, then run `phpunit`

Run a cm application (services via [supervisord](http://supervisord.org/) + php5-fpm)
```
docker run -it --rm --workdir /opt/project -v /path/to/my-project:/opt/project cargomedia/cm-application:latest start
```

Notes: 
- the `workdir` must match with the project directory mounted in the container
- you must configure external services in `_local.docker.php` and/or `_test.docker.php`, those config files will be automatically copied in `resources/config/` without the leading underscore during the setup.

# Docker

Para generar las imágenes, levantar la aplicación y de ser necesario, instalar `Docker` y `docker-compose`:

* Instalar [Docker](https://docs.docker.com/engine/installation/linux/ubuntu/)
* Instalar [docker-compose](https://docs.docker.com/compose/install/)

Actualmente el repositorio contiene 1 archivo `Dockerfile` y 2 archivos `docker-compose`

* `Dockerfile`: Se usa para generar la imagen de la aplicación
* `dev.yml`: Archivo de `docker-compose` para levantar los servicios necesarios y generar la imagen de la aplicación.
* `latest.yml`: Archivo de `docker-compose` para levantar la aplicación en su última version. (ver [instalación](docs/setup/install.md))

Para levantar toda la aplicacion, se puede correr:

    $ docker-compose -f dev.yml up -d nginx
    
Si es la primera vez que se corre este comando, puede llegar a tardar bastante en descargar las imágenes.
Una vez terminado, esto dejará en el puerto `localhost:80` la aplicacion corriendo, pero antes se debe correr un comando para inicializar en desarrollo:

    $ docker-compose -f dev.yml exec portal /etc/ckan_init.d/init_dev.sh


También se pueden levantar los servicios por separado de la aplicación:

* Levantar los __servicios__:

```$ docker-compose -f dev.yml up --build --abort-on-container-exit db sol redis postfix```

* La aplicación tendrá el puerto `8080` la aplicación y en el `8800` el datapusher.
    
```$ docker-compose -f dev.yml up --abort-on-container-exit --build --no-deps portal```

* Nginx que estará en el puerto `80`:
    
```$ docker-compose -f dev.yml up -d --no-deps nginx```

Eso levantará la aplicación con el directorio actual (`$PWD`) disponible dentro del directorio `/dev-app` del container.

Para acceder a la aplicación, hacer modificaciones en `runtime`, basta con correr el comando:

    $ docker-compose -f dev.yml exec portal /bin/bash



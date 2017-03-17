# Instalación con Docker (WIP)

### Esta guía instala la última version _en desarrollo_ de andino, puede contener bugs o no funcionar

Esta clase de instalación no requiere que clones el repositorio, ya que usamos contenedores alojados en [DockerHub](https://hub.docker.com/r/datosgobar)

### Ubuntu 14.04

+ Requerimientos:
    - Docker: `sudo su -c "curl -sSL http://get.docker.com | sh"`
    - Docker compose: `https://docs.docker.com/compose/install/`

+ Buildear la imagen:
    - `git clone git@github.com:datosgobar/datos.gob.ar_docker.git datosgobar`
    - `cd datosgobar`
    - `docker build -t datosgobar/portal-datos.gob.ar:development .`
    
+ Preparar la configuracion:
    Para Configurar la aplicacion, debe tenerse un archivo `.env` con algunos parametros para la configuracion de la base de datos.
    La entrada `CKAN_HOST=datosgobar` es obligatoria. este archivo __tiene__ que estar en el mismo directorio que el archivo `latest.yml`
    
    
    POSTGRES_USER=database_user_name
    POSTGRES_PASSWORD=database_user_password
    CKAN_HOST=datosgobar
    
+ Entonces iniciamos la parte web de la aplicacion:
    - `docker-compose -f latest.yml up -d nginx`
    
+ Configuramos la aplicacion corriendo el script `/etc/ckan_init.d/init.sh`con los siguientes parametros:
    - error_email: Email donde se notificaran los errores
    - host o Ip: Host donde corre la aplicacion o la ip
    - database user: Usuario de la base de datos (el mismo que usamos en el `.env`)
    - database password: Clave de la base de datos (la misma que usamos en el `.env`)
    - datastore user: Usuario para la base de datos del datastore
    - datastore password: Clave para la base de datos del datastore
+ Ejemplo:


    docker exec -it datosgobar /etc/ckan_init.d/init.sh -e admin@example.com \
        -h datos.gob.ar \
        -p database_user_name -P database_user_password \
        -d datastore_user -D datastore_password
        
+ Corremos algunas inicializaciones propias de `datos.gob.ar`:

    docker exec -it datosgobar bash /etc/ckan_init.d/init_datosgobar.sh
    
    
+ Entonces inicialmos los procesos extras:
    - `docker-compose -f latest.yml up -d start_harvest start_search_update`
  
  
+ Customización

    - Vea la documentacion del [portal-base](https://github.com/datosgobar/portal-base/blob/master/docs/imagenes/base_portal.md)

    - Crear un usuario administrador (Cambiar `ckan_admin` por otro usuario si se desea):
    
            docker exec -it andino /etc/ckan_init.d/add_admin.sh ckan_admin

    - Cambiar la url del sitio (Cambiar `dev.example.com` por el correspondiente dominio):
    
            docker exec -it andino /etc/ckan_init.d/change_site_url.sh http://dev.example.com

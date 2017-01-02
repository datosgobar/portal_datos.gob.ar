#Datos.gob.ar-en-docker

Repositorio de la implementación de CKAN en Docker, desarrollada para la segunda versión del portal de datos de la [República Argentina](http://datos.gob.ar). 
También podés [ver el repositorio del tema visual](https://github.com/datosgobar/datos.gob.ar).

---
- [Contenido de instancia](#contenido-de-instancia)
- [Instalación:](#instalacion)
	- [Dependencias:](#dependencias)
	- [Instalación y ejecución de CKAN](#instalacion-y-ejecucion-de-ckan)
	- [Instalación simplificada de datos.gob.ar:](#instalacion-simplificada-de-datosgobar)
	- [Instalacion avanzada de datos.gob.ar](#instalacion-avanzada-de-datosgobar)
- [Uso de datos.gob.ar-en-docker](#uso)
	- [Cambiar URL's de la plataforma](#cambiar-urls-de-la-plataforma)
	- [Usuarios](#usuarios)
		- [Nuevo usuario](#nuevo-usuario)
		- [Nuevo usuario Admin](#nuevo-usuario-admin)
		- [Blanqueo de contraseña para un usuario](#blanqueo-de-contraseña-para-un-usuario)
	- [Backup](#backup)
		- [DB](#db)
		- [FS](#fs)
- [Créditos](#créditos)
- [Contacto](#contacto)



## Contenido de la instancia

- [CKAN 2.5.3](http://docs.ckan.org/en/ckan-2.5.3/)
- [Datastore](http://docs.ckan.org/en/latest/maintaining/datastore.html)
- [FileStore](http://docs.ckan.org/en/latest/maintaining/filestore.html)
- [Datapusher](https://github.com/ckan/datapusher)
- [Hierarchy](https://github.com/datagovuk/ckanext-hierarchy)
- [datajsonAR](https://github.com/datosgobar/ckanext-datajsonAR)
- [Harvest](https://github.com/ckan/ckanext-harvest)
- [GobAR theme](https://github.com/datosgobar/datos.gob.ar)
- [Apache2 & NginX](http://docs.ckan.org/en/ckan-2.5.2/maintaining/installing/deployment.html#install-apache-modwsgi-modrpaf)

## Instalación

### Dependencias

+ Docker: [Docker.docs](https://docs.docker.com/engine/installation/)
+ Github: [Github.docs](https://help.github.com/)	


### Instalación y ejecución de CKAN

_Teniendo en cuenta la dificultad de implementación e incluso, la cantidad de pasos a realizar para lograr un deploy exitoso, existen dos formas de instalar esta distribución de **CKAN**._
_Si no tenés muchos conocimientos de CKAN, Docker o de administración de servidores en general, te sugerimos usar la instalación [Simplificada  de CKAN](#instalacion-simplificada-de-ckan). Está pensada para que, en la menor cantidad de pasos y de manera sencilla, tengas un portal de datos funcional._
_Si ya conocés la plataforma, tenés experiencia con Docker o simplemente, querés entender cómo funciona esta implementación, te sugiero que revises la [Instalación avanzada de CKAN](#instalacion-avanzada-de-ckan)_

---

### Instalacion simplificada de datos.gob.ar

_Para instalar esta plataforma, sólo ejecutá los siguientes comandos:_

```bash
###################################################################################
#                                                                                 #
# Para poder ejecutar esta plataforma, necesitás tener instalado Docker.engine  #
# Si tenés un servidor con OS Linux, en cualquiera de sus dristros,            # 
# podés instalar fácilmente corriendo este comando:                    #
#                                                                                 #
# sudo su -c "curl -sSL http://get.docker.com | sh"                               #
# sudo usermod -aG docker $USER                                                   #
#                                                                                 #
###################################################################################

# Instalación contenedor de Solr:
# ===============================
docker run --restart=always \
		   -d --name solr-ckan \
		   datosgobar/solr-ckan:latest

# Instalación contenedor PostgreSQL:
# ==================================
docker run --restart=always \
		   -d -v /path/to/pg/data/:/var/lib/postgresql/data/ \
		   --name pg-ckan \
		   datosgobar/pg-ckan:latest

# Instalación contenedor CKAN web-app:
# ====================================
docker run --restart=always \
		   -d --name ckan \
		   -p 80:80 \
		   -p 8800:8800 \
		   -v /path/to/fs/data/:/var/lib/ckan \
		   --link pg-ckan:db \
		   --link solr-ckan:solr \
		   datosgobar/ckan:latest
```
---

### Instalación avanzada de datos.gob.ar

_Para instalar y ejecutar CKAN-Docker, seguí estos pasos:_

```bash
###################################################################################
#                                                                                 #
# Para poder ejecutar esta plataforma, se requiere tener instalado Docker.engine  #
# Si se posee un servidor con OS Linux, en cualquiera de sus dristros,            # 
# se puede instalar facilmente corriendo el siguiente comando:                    #
#                                                                                 #
# sudo su -c "curl -sSL http://get.docker.com | sh"                               #
# sudo usermod -aG docker $USER                                                   #
#                                                                                 #
###################################################################################

# Clonar el repositorio:
# Te recomendamos clonar el repo dentro de /tmp (o C:\temp en Windows X),
# dado que al finalizar la instalación, no usaremos más el repositorio

# /tmp en Linux, C:\temp en Windows 
git clone https://github.com/datosgobar/datos.gob.ar_docker /tmp/datos.gob.ar_docker

# Crear carpetas para volumenes de datos
mkdir -p /path/to/ckan_fs /path/to/pg_fs 


# Construir y lanzar el contenedor de PostgreSQL usando el Dockerfile ubicado en postgresql-img/ 
cd /tmp/datos.gob.ar_docker/postgresql-img/
docker build -t pg-ckan:latest .
docker run --restart=always -d \
		   -v /path/to/pg_fs/:/var/lib/postgresql/data/ \
		   --name pg-ckan \
		   datosgobar/pg-ckan:latest

# Construir y lanzar el contenedor de Solr usando el Dockerfile ubicado en solr-img/
cd /tmp/datos.gob.ar_docker/solr-img/ 
docker build -t solr:latest .
docker run -d \
		   --name solr
		   solr:latest

# Construir el contenedor de CKAN usando el Dockerfile ubicado en ckan-img/
cd /tmp/ckan_en_docker/ckan-img
docker build -t ckan:latest .

# Correr contenedor de CKAN
docker run --restart=always \
		   -d --name ckan \
		   -p 80:80 \
		   -p 8800:8800 \
		   -v /path/to/ckan_fs/:/var/lib/ckan \
		   --link pg-ckan:db \
		   --link solr-ckan:solr \
		   ckan:latest

```		
--- 

## Uso de datos.gob.ar-en-docker

### Cambiar URL's de la plataforma

```bash
docker exec -it ckan /bin/bash 
$CKAN_HOME/bin/paster --plugin=ckan config-tool /etc/ckan/default/production.ini -e \
		"ckan.site_url = http://{nueva_url}" \
		"ckan.datapusher.url = http://{nueva_url}:8800"

# Restart de servidores front para impactar los nuevos cambios
service nginx restart && service apache2 restart

```

### Usuarios

#### Nuevo usuario

```bash
docker exec -it ckan /bin/bash 
$CKAN_HOME/bin/paster --plugin=ckan user add {new_user} -c $CKAN_CONFIG/production.ini
```

#### Nuevo usuario Admin

```bash
docker exec -it ckan /bin/bash 
$CKAN_HOME/bin/paster --plugin=ckan sysadmin add {admin_user} -c $CKAN_CONFIG/production.ini
```

#### Blanqueo de contraseña para un usuario

```bash
docker exec -it ckan /bin/bash 
$CKAN_HOME/bin/paster --plugin=ckan user setpass {user} -c $CKAN_CONFIG/production.ini
```

### Backup

#### DB

```bash
# Esta tarea requiere tener instalado psql, pg-version: 9.5 o superior
# wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
# sudo apt-get -y update && sudo apt-get -y install pgadmin3
mkdir -p /path/to/backup/folder/sql
pg_dump -h {db_host} -U {ckan_default_user} -p {port} -f /path/to/backup/folder/sql/dump_ckan_default.sql ckan_default
pg_dump -h {db_host} -U {ckan_default_user} -p {port} -f /path/to/backup/folder/sql/dump_datastore_default.sql datastore_default
```

#### FS
```bash
docker exec -it ckan /bin/bash
mkdir -p /path/to/backup/folder/fs
tar -cv $CKAN_DATA | gzip > /path/to/backup/folder/path/to/backup/folder/fs/prod.data.tar.gz
```

## Créditos

Este trabajo está inspirado en el desarrollo hecho por:

- [CKAN.org](https://github.com/ckan/ckan/)
- [Eccenca](https://github.com/eccenca/ckan-docker)
- [Portal-Andino](https://github.com/datosgobar/portal-andino)

## Contacto

Te invitamos a [crearnos un issue](https://github.com/datosgobar/portal-andino/issues/new?title=Encontre un bug en datos.gob.ar_docker) en caso de que encuentres algún bug o tengas feedback de alguna parte de `datos.gob.ar-en-docker`.

Para todo lo demás, podés mandarnos tu comentario o consulta a [datos@modernizacion.gob.ar](mailto:datos@modernizacion.gob.ar).

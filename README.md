# Portal-datos.gob.ar

Repositorio de la implementación de CKAN en Docker, desarrollada para la segunda versión del portal de datos de la [República Argentina](http://datos.gob.ar). 

También podés [ver el repositorio del tema visual](https://github.com/datosgobar/datos.gob.ar).


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


## Qué contiene el paquete de datos.gob.ar

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

Ver documentación de [instalación](http://portal_datos.gob.ar.readthedocs.io/es/master/)

## Uso

Ver la documentacion [uso](http://portal_datos.gob.ar.readthedocs.io/es/master/)

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

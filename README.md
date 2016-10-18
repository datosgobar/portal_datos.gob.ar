# CKAN Docker
_El mismo **CKAN** de siempre pero.. bellamente dockerizado...:heart_eyes:_

---
### Indice:
+ [Que es CKAN?](#que-es-ckan)
+ [Que es DOCKER?](#que-es-docker)
+ [Porque CKAN en Docker?](#porque-ckan-en-docker)
+ [Features](#features)
+ [Prerequisitos](#prerequisitos)
    + [DOCKER](#docker)
    + [GIT TOOLs](#git-tools)
+ [Instalacion y Ejecucion de CKAN](#instalacion-y-ejecucion-de-ckan)
    + [Instalacion Simplificada de CKAN](#instalacion-simplificada-de-ckan)
    + [Instalacion Avanzada de CKAN](#instalacion-avanzada-de-ckan)

---

## Que es CKAN?
Comprehensive Knowledge Archive Network (CKAN) es una aplicación web de código abierto para el almacenamiento y la distribución de los datos, tales como hojas de cálculo y los contenidos de las bases de datos. Está inspirado en las capacidades de gestión de paquetes comunes para abrir sistemas operativos, como Linux, y está destinado a ser el "apt-get de Debian para los datos". _Fuente: [wikipedia](https://es.wikipedia.org/wiki/CKAN)_

_...Mas informacion sobre CKAN?... Obvio! [Documentacion Oficial de CKAN](http://docs.ckan.org/en/latest/)_

## Que es DOCKER?
es un proyecto de código abierto que automatiza el despliegue de aplicaciones dentro de contenedores de software, proporcionando una capa adicional de abstracción y automatización de Virtualización a nivel de sistema operativo en Linux. _Fuente: [wikipedia](https://es.wikipedia.org/wiki/Docker_(software))_

_...Deseas saber mas sobre docker? Genial! Docker posee una documentacion excelente y podes verla [aqui](https://docs.docker.com/)_

## Porque CKAN en Docker?

_Porque SI! :sunglasses:... Nah! esta en la TODO-LIST!_

## Con que cuenta esta version de CKAN?

Features:

+ CKAN 2.6.
+ Datastore.
+ FileStore.
+ Datapusher.
+ Apache2 & NGINX.
+ Extensiones:
	+ CKAN-Hierarchy. Mas informacion [aqui](https://github.com/datagovuk/ckanext-hierarchy)
	+ CKAN-GobArTheme. Ver [Demo](http://http://datos.gob.ar/). Mas Informacion [aqui](https://github.com/gobabiertoAR/datos.gob.ar/blob/master/docs/03_instalacion_tema_visual.md)
+ Ckan-tools

## Prerequisitos:

### DOCKER:

+ Docker para [OSX](https://docs.docker.com/docker-for-mac).
+ Docker para [Ubuntu/Debian](https://github.com/JoseSalgado1024/ckan_in_docker/blob/master/aux-docs/docker_Ubuntu-Debian.md).
+ Docker para [RHEL/CentOS](https://github.com/JoseSalgado1024/ckan_in_docker/blob/master/aux-docs/docker_rhel-centos.md).
+ Docker para [Windows](https://docs.docker.com/engine/installation/windows).


### GIT TOOLS
_(...All you need is Git...)_:
	
+ Windows:
_Descargar e Instalar desde:_

		https://github.com/git-for-windows/git/releases/tag/v2.10.0.windows.1

+ Ubuntu/Debian:

		$ sudo su -c "apt-get -y install git-core"

+ RHEL/CentOS:

		$ yum update && yum install -y curl-devel expat-devel gettext-devel openssl-devel zlib-devel
		$ yum install -y git-core

+ OSX:

	    $ sudo port install git-core +svn +doc +bash_completion +gitweb

## Instalacion y Ejecucion de CKAN

_En funcion a la probable dificultad de implementacion e incluso, la cantidad de pasos a realizar para lograr un deploy existoso, existen dos formas de instalar esta distribución de **CKAN**. Si no tenes muchos conocimientos de CKAN, Docker o de administracion de servidores en general, muy posiblemente, deberias utilizar la instalacion **[Simplificada  de CKAN](#instalacion-simplificada-de-ckan)**, la cual, esta pensada para que en la menor cantidad de pasos y de manera sencilla, tengas un Portal de Datos Funciona (Y muy bello :D). Ahora si por ejemplo, ya conoces la plataforma, tenes experiencia con Docker o simplemente, queres entender como es que funciona esta implementacion, te sugiero que revises la **[Instalacion Avanzada de CKAN](#instalacion-avanzada-de-ckan)**_

---

### Instalacion Simplificada de CKAN:

_La idea detras de esta implementacion de CKAN, es que **SOLO** te encargues de tus datos, nada mas, por tanto, dependiendo de que OS usas, podes seleccionar un script de auto-deploy. La misma, te guiara casi de manera automatica por todo el proceso de instalacion realizando minimas preguntas e incluso "explicando" que se realiza que cada paso._

+ Ubuntu|Debian:

		sudo su -c "cd /tmp && git clone https://github.com/JoseSalgado1024/ckan_in_docker.git && cd /tmp/ckan_in_docker/auto-deploy/ && ./ubuntu-debian_auto-deploy.sh; rm -f -r /tmp/ckan_in_docker"


+ RHEL|CentOS:

		sudo su -c "cd /tmp && git clone https://github.com/JoseSalgado1024/ckan_in_docker.git && cd /tmp/ckan_in_docker/auto-deploy/ && ./rhel-centos_auto-deploy.sh; rm -f -r /tmp/ckan_in_docker"

---

### Instalacion Avanzada de CKAN
+ Instalacion de CKAN con contenedores de Docker ya compilados:
	
	_Para esta clase de instalacion, no es necesario clonar el repo, dado que usaremos contenedores alojados en [DockerHub](https://hub.docker.com/) y el proceso de instalacion se divide en seis pasos.

+ Instalacion de CKAN usando Dockerfiles

_Para instalar y ejecutar CKAN-Docker, debemos seguir los siguientes pasos:_

+ Paso 1: Clonar Repositorio. 
_Es recomendable clonar el repo dentro de /tmp (o C:\temp en **Windows X**), dado que al finalizar la instalacion, no usaremos mas el repositorio_.
		
		$ cd /tmp # en Linux, en Windows, usar cd C:\temp
		$ git clone https://github.com/JoseSalgado1024/ckan_in_docker.git

+ Paso 2: _construir y lanzar el contenedor de **PostgreSQL** usando el Dockerfile hubicado en **postgresql-img/**._ 

		$ cd /tmp/ckan_in_docker/postgresql-img/
		$ docker build -t jsalgadowk/postgresql:latest .
		$ docker run -d  --name pg-ckan \
			jsalgadowk/pg-ckan:latest


+ Paso 3: _construir y lanzar el contenedor de **Solr** usando el Dockerfile hubicado en **solr-img/**._

		$ cd /tmp/ckan_in_docker/solr-img/ 
		$ docker build -t jsalgadowk/solr:latest .
		$ docker run -d  --name solr jsalgadowk/solr:latest

+ Paso 4: _construir el contenedor de **ckan** usando el Dockerfile hubicado en ckan-img/._

		$ cd /tmp/ckan_in_docker/ckan-img
		$ docker build -t jsalgadowk/ckan:latest .

+ Paso 5: _Correr contenedor  de **CKAN**_
		
		$ docker run -d \
			--link pg-ckan:db \
			--link solr:solr \
			-p 80:80 \
			-p 8800:8800 \
			--name ckan \
			jsalgadowk/ckan:latest

+ Paso 6(Opcional): _Crear usuario administrador **ckan_admin**_
		
		$ docker exec -it ckan \
			/usr/lib/ckan/default/bin/paster --plugin=ckan sysadmin add ckan_admin \
			-c /etc/ckan/default/development.ini

--- 
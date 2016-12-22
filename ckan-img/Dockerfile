FROM ubuntu:14.04
MAINTAINER Jose A. Salgado<jose.salgado.wrk@gmail.com>


# Crearemos algunas variables de entorno, que nos seran utiles mas tarde

ENV DATAPUSHER_HOME /usr/lib/ckan/datapusher
ENV CKAN_HARVEST_GCF /var/log/ckan/std
ENV DEBIAN_FRONTEND noninteractive
ENV CKAN_APACHE2_PORT 80
ENV CKAN_DATAPUSHER_PORT 8800
ENV CKAN_CONFIG_FILE produ          ction.ini
ENV HOME /root
ENV CKAN_VERSION 2.5.1  
ENV CKAN_HOME /usr/lib/ckan/default
ENV CKAN_CONFIG /etc/ckan/default
ENV CKAN_DATA /var/lib/ckan
ENV CKAN_INIT /etc/ckan_init.d

# Actualizamos las bases de apt-get!
RUN apt-get -y update && \
      apt-get install -y software-properties-common && \
      add-apt-repository universe

# Instalamos la Herramientas que vamos a requerir
RUN apt-get -y install \
            libevent-dev \
            libpq-dev \
            nginx \
            apache2 \
            libapache2-mod-rpaf \
            postfix \
            build-essential \
            libxslt1-dev \
            libxml2-dev \
            python-dev \
            libffi-dev \
            libssl-dev \
            python-minimal \
            python-virtualenv \
            python-pip \
            libapache2-mod-wsgi \
            wget \
            nano \
            ca-certificates \
            redis-server \
            rabbitmq-server \
            supervisor \
            inotify-tools \
            git-core

# Bajamos el .deb de ckan
RUN wget http://packaging.ckan.org/python-ckan_2.5-trusty_amd64.deb -P /tmp

# Instalamos psql
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
RUN apt-get -y update && apt-get -y install pgadmin3
RUN mkdir -p $CKAN_HOME $CKAN_CONFIG $CKAN_DATA
RUN virtualenv $CKAN_HOME
RUN ln -s $CKAN_HOME/src/ckan/ckan/config/who.ini $CKAN_CONFIG/who.ini
RUN mkdir -p $CKAN_HOME $CKAN_CONFIG $CKAN_DATA
RUN chown www-data:www-data $CKAN_DATA && chmod u+rwx $CKAN_DATA
RUN touch /tmp/ckan_service.log && chmod u+rw /tmp/ckan_service.log

# Instalamos CKAN
RUN dpkg -i /tmp/python-ckan_2.5-trusty_amd64.deb

# Actualizamos pip
RUN $CKAN_HOME/bin/pip install --upgrade pip 
RUN $CKAN_HOME/bin/pip install requests[security] pyyaml lepl jsonschema rfc3987

# Instalamos las extensiones de CKAN: GobAR-Theme & Hierarchy 
RUN $CKAN_HOME/bin/pip install -e "git+https://github.com/datosgobar/datos.gob.ar.git#egg=ckanext-gobar_theme"
RUN $CKAN_HOME/bin/pip install -e "git+https://github.com/datagovuk/ckanext-hierarchy.git#egg=ckanext-hierarchy"
RUN $CKAN_HOME/bin/pip install -e "git+https://github.com/ckan/ckanext-harvest.git#egg=ckanext-harvest"
RUN $CKAN_HOME/bin/pip install -r $CKAN_HOME/src/ckanext-harvest/pip-requirements.txt
RUN $CKAN_HOME/bin/pip install -e "git+https://github.com/datosgobar/ckanext-datajson.git#egg=ckanext-datajson"

# 
RUN mkdir -p  $CKAN_HARVEST_GCF /etc/service /var/log/supervisor /var/log/apache/
RUN touch $CKAN_HARVEST_GCF/fetch_consumer.log $CKAN_HARVEST_GCF/gather_consumer.log
RUN chown www-data:www-data $CKAN_DATA /tmp/ckan_service.log && chmod u+rwx -R $CKAN_DATA /tmp/ckan_service.log
ADD ./config/ckan_harvesting.conf /etc/supervisor/conf.d/
#COPY ./config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ./config/autoload/ /etc/service
ADD ./config/ckan_default.conf /etc/apache2/sites-enabled/ckan_default.conf 
ADD ./scripts $CKAN_INIT
ADD ./config/apache.wsgi $CKAN_CONFIG/apache.wsgi
ADD ./config/datapusher.wsgi /etc/ckan/datapusher.wsgi
RUN rm -f $CKAN_CONFIG/production.ini
ADD ./config/production.ini $CKAN_CONFIG/production.ini
RUN chmod +x -R $CKAN_INIT/
RUN chmod 777 -R $CKAN_CONFIG

# Script de inicializacion para ckan.
CMD ["/etc/ckan_init.d/start_ckan.sh"]

# Creo volumenes para las diferentes de CKAN.
VOLUME $CKAN_CONFIG CKAN_DATA CKAN_DATA

# Abro el puerto de 80(ad) para Apache y el puerto de 8800(dp) apache.datapusher.wsgi
EXPOSE $CKAN_APACHE2_PORT $CKAN_DATAPUSHER_PORT

# OK, Limpiamos y nos vamos
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
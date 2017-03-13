FROM datosgobar/portal-base:development
MAINTAINER Leandro Gomez<lgomez@devartis.com>

ENV CKAN_HOME /usr/lib/ckan/default
ENV CKAN_DIST_MEDIA /usr/lib/ckan/default/src/ckanext-gobar-theme/ckanext/gobar_theme/public/user_images
RUN $CKAN_HOME/bin/pip install -e git+https://github.com/datosgobar/datos.gob.ar.git#egg=ckanext-gobar_theme
ADD ./conf/config/datapusher.wsgi /etc/ckan/datapusher.wsgi
COPY ./conf/config/datapusher.conf /etc/apache2/sites-enabled/datapusher.conf
RUN mkdir -p $CKAN_DIST_MEDIA
RUN chown -R www-data:www-data $CKAN_DIST_MEDIA
RUN chmod u+rwx $CKAN_DIST_MEDIA

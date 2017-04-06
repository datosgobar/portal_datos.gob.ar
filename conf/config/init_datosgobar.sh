#!/usr/bin/env bash

current_dir="$(dirname "$0")"
"$current_dir/update_conf.sh" "ckan.site.title=Datos Argentina"
"$current_dir/update_conf.sh" "ckan.site.description=Datos Argentina. Portal de datos abiertos de la República Argentina. Encontrá datos públicos en formatos abiertos. Son tuyos: ¡usalos, modificalos y compartilos!"
"$current_dir/update_conf.sh" "ckan.owner=Datos Argentina"
"$current_dir/update_conf.sh" "ckan.owner.email=datos@modernizacion.gob.ar"
"$current_dir/update_conf.sh" "ckan.site_url=http://datos.gob.ar"
"$current_dir/update_conf.sh" "ckan.search.automatic_indexing=false"
"$current_dir/update_conf.sh" "ckan.search.solr_commit=false"
"$current_dir/update_conf.sh" "ckan.site_title=Datos Argentina"
"$current_dir/update_conf.sh" "email_to=datos@modernizacion.gob.ar"
"$current_dir/update_conf.sh" "error_email_from=datos@modernizacion.gob.ar"



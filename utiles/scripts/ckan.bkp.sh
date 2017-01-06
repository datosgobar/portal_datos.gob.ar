#!/bin/bash
# Crontab rule: 15 03 * * * /bin/bash /path/to/ckan_helpers/ckn.bkp.sh

BKPTIME=`date +%Y-%m-%dT%H-%M-%S`
CKNDDB="/path/to/ckan_helpers/tmp.sql/dump_ckan_default_db_$BKPTIME.sql"
CKNDSDB="/path/to/ckan_helpers/tmp.sql/dump_ckan_datastore_db_$BKPTIME.sql"

#Credenciales para la base de datos:
export PGUSER=<pg_user>;
export PGPASSWORD=<pg_user_password>;
export PGHOST=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' <pg_container>);
export PGPORT=<pg_port>;

# Realizo VACUUM a las bases
psql -c "VACUUM FULL;" 
psql -c "VACUUM FULL" datastore_default

# Hago dumps de las bases de datos de ckan
pg_dump -v -f $CKNDDB
pg_dump -v -f $CKNDSDB datastore_default

# comprimo y Muevo a capetas de BKP el dump de las bases
tar -cv /path/to/ckan_helpers/tmp.sql/ | gzip > "/path/to/backup/dga.$BKPTIME.sql.bkp.tar.gzip"

# Creo BKP del fs de CKAN
tar -cv /path/to/ckan_fs/storage/ | gzip > "/path/to/backup/dga.$BKPTIME.data.bkp.tar.gzip"

# Elimino archivos temporales de la generacion de bkp.
rm -rf $CKNDDB $CKNDSDB


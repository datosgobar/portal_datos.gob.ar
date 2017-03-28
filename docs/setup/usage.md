# Portal datos.gob.ar

Una vez finalizada la instalación, bajo cualquiera de los métodos, deberíamos:

### Crear usuario administrador
	
```bash		
# Agregar un admin
# Asumo que el contenedor de ckan es llamado "datosgobar"
ADMIN_USER=<my_admin>        
docker exec -it datosgobar /etc/ckan_init.d/add_admin.sh "$ADMIN_USER"
```

#### Nuevo usuario

```bash
docker exec -it datosgobar /etc/ckan_init.d/paster.sh --plugin=ckan user add {new_user}
```
#### Blanqueo de contraseña para un usuario

```bash
docker exec -it datosgobar /etc/ckan_init.d/paster.sh --plugin=ckan user setpass {user}
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
docker exec -it datosgobar /bin/bash
mkdir -p /path/to/backup/folder/fs
tar -cv $CKAN_DATA | gzip > /path/to/backup/folder/path/to/backup/folder/fs/prod.data.tar.gz
```


Extension de la plataforma `DatosGobAr`:

Plugins
---

La plataforma `CKAN` al ser instalada, por omisión, almacena todo su código fuente en la `PATH=/usr/lib/ckan/default/src`, homologamente, Andino X y DatosGobAr funcionan de la misma manera, por tanto dentro de su contenedor principal `datosgobar` y `andino` respectivamente, será dispuesto todo su código fuente.

Así mismo, las extensiones son guardadas con un formato particular, predefinido por el Framework utilizado para el desarrollo de CKAN(Pylons), siendo las mismas  almacenadas bajo la siguiente regla:

  /usr/lib/ckan/default/src/ckanext-{nombre_de_la_extension}/ckanext/{nombre_de_la_extension}

_Y responden al árbol:_

```
  ckanext-{nombre_de_la_extension}/
  ├── setup.py
  ├── pip-requirements.txt
  ├── README.md
  ├── ckanext
  │   └── {nombre_de_la_extension}
  │       ├── ...
  │       ├── plugin.py
  |       ├── Controller{Nombre_de_la_extension}.py
  │       └── tests
  └── ckanext_{nombre_de_la_extension}.egg-info
```
### Cambiar la Branch.

```bash
# Andino 1.X:
# docker exec -it app-ckan /bin/bash
# Andino 2.x:
# docker exec -it andino /bin/bash
#
# DatosGobAr X:
# docker exec -it andino /bin/bash
#
# CKAN X:
# cd /usr/lib/ckan/default/src/ckanext-{nombre_de_la_extension}
# Solo valido en Andino X y DatosGobAr X
cd $CKAN_HOME/src/ckanext_{nombre_de_la_extension}
git checkout {mi-otra-branch}
# En Andino o Datos:
# Luego del cambio de branch, debemos reiniciar el servidor APACHE
# Andino 1.x
service apache2 restart
# Andino 2.x
systemctrl reload apache2.service
```

## Problemas frecuentes:

_Es factible que, según las modificaciones que se realicen a el plugin en cuestión, al realizar un cambio de `git.branch`, automáticamente tengamos un error 500 en nuestro portal y por stdout el APACHE o el mismo CKAN, dependiendo del modo en el que se este corriendo la plataforma, nos informe que `{nombre_de_la_extension} Not Found!`, Esto ocurre a menudo al realizar cambios sobre el instalador de la extensión(`ckanext-{nombre_de_la_extension}/setup.py`), por tanto, para solucionarlo, solo debemos hacer:_

```bash
# Si se requiere hacer esto dentro de la plataforma Andino o DatosGobAr
# deberías adicionar el paso de "attach" al contenedor
#
# Andino 1.x:
# docker exec -it app-ckan /bin/bash
#
# Andino 2.x:
# docker exec -it andino /bin/bash
#
# DatosGobAr X:
# docker exec -it andino /bin/bash
$ cd /usr/lib/ckan/default/src/ckanext-{nombre_de_la_extension}
$ /usr/lib/ckan/default/bin/python setup.py install
```
Realizados estos pasos, habremos `reinstalado` la extensión y solucionado el error `ckan.core.plugin.NotFound`

Para mas informacion sobre plugins de `DatosGobAr` o `CKAN`, por favor consulte la [documentacion oficial del proyecto CKAN](http://docs.ckan.org/en/latest/extensions/index.html) e incluso el [tutorial](http://docs.ckan.org/en/latest/extensions/tutorial.html) provisto por `CKAN` para el desarrollo de la plataforma.

Extension de la plataforma `DatosGobAr`:

Plugins
---

Todo el código fuente de la app de CKAN vive en el path `/usr/lib/ckan/default/src`, incluyendo sus plugins.
Los mismos se encuentran en `/usr/lib/ckan/default/src/ckanext-{nombre_de_la_extension}`.

Así mismo, las extensiones son guardadas con un formato particular, predefinido por el Framework utilizado para el desarrollo de `CKAN(Pylons)`, siendo las mismas  almacenadas bajo la siguiente regla:

    /usr/lib/ckan/default/src/ckanext-{nombre_de_la_extension}/ckanext/{nombre_de_la_extension}
  
### Cómo testear cambios en los plugins.

+ Ingresar al contenedor correspondiente
  - Andino 1.0:
        
        docker exec -it app-ckan bash
        
  - Andino 2.x:
  
        docker exec -it andino bash
  
  - Datos.gob.ar:
  
        docker exec -it datosgobar bash

+ Ir al directorio de la extensión que se quiere testear
  
      cd /usr/lib/ckan/default/src/ckanext-{nombre_de_la_extension}

+ Hacer checkout de la branch a partir de la cual se quieren testear cambios

      git fetch
      git checkout {branch-que-se-desea-testear}

+ Reiniciar servidor de Apache
  
      service apache2 reload

## Problemas frecuentes:

En caso de que haya habido un cambio en el setup.py de la extensión, **CKAN** puede llegar a tener problemas para encontrarla, devolviendo un error ckan.core.plugin.NotFound.

Para resolver este problema, simplemente reinstalamos la extensión:

    cd /usr/lib/ckan/default/src/ckanext-{nombre_de_la_extension}
    /usr/lib/ckan/default/bin/python setup.py install

Realizados estos pasos, habremos `reinstalado` la extensión y solucionado el error `ckan.core.plugin.NotFound`

Para mas informacion sobre plugins de **DatosGobAr** o **CKAN**, por favor consulte la [documentacion oficial del proyecto CKAN](http://docs.ckan.org/en/latest/extensions/index.html) e incluso el [tutorial](http://docs.ckan.org/en/latest/extensions/tutorial.html) provisto por **CKAN** para la extesion de la plataforma.

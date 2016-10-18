#!/bin/bash
.mostrar_ayuda (){

printf \
"\n
+---------------------------------------------------+
|    Herramientas simplificadas de manetenimiento   |
+---------------------------------------------------+

USUARIOS:
Crear, listar o borrar usuarios de CKAN: --usuario=accion parametro o -u=accion parametro 

    Agregar usuario admin: --usuario=add nombre_de_usuario o -u=add nombre_de_usuario     
    Listar usuarios de CKAN: --usuario=listar o -u=listar     
    Borrar usuario: --usuario=del nombre_de_usuario o -u=del nombre_de_usuario    

CKAN:
Iniciar, detener, reiniciar o desinstalar CKAN: --ckan=accion o -ckan=accion 

    Iniciar CKAN: --ckan=start     
    Detener CKAN: --ckan=stop
    Reiniciar CKAN: --ckan=restart    
    Desinstalar CKAN: --ckan=remove

BASES DE DATOS:
Tareas de mantenimiento para las bases de datos de CKAN: --bases-de-datos=accion o -db=accion 

    Inicializar bases de datos de CKAN: --bases-de-datos=init o -db=init     
    Hacer dump de bases de CKAN: --bases-de-datos=dump /carpeta/dump.sql o -db=dump /carpeta/dump.sql 
    Limpiar Bases de Datos de CKAN: --bases-de-datos=clear o -db=clear

ACTUALIZACION:
Programar momento de actualizacion para contenedores de CKAN: --actualizacion=accion o -a=accion 

    Activar actualizacion: --actualizacion=start     
    Desactivar actualizacion: --actualizacion=stop

BACKUP:
Activar, desactivar backups automaticos para el contenido de CKAN: --backup=accion parametro o -bu=accion parametro 

    Activar backup: --backup=start /carpeta/de/destino o -bu=start /carpeta/de/destino      
    Desactivar backup: --backup=stop o -bu=stop
\n" 
}

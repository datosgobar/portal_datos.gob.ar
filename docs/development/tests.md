# Tests 

Para correr los test de la aplicación se deben levantar todos los servicios y luego inicializar la configuración de test.

### Tests de Ckan
    $ docker-compose -f dev.yml up --build -d andino
    $ docker exec datosgobar bash /etc/ckan_init.d/make_test_conf.sh
    $ docker exec datosgobar bash -c 'su -c "/etc/ckan_init.d/run_tests.sh" -l $USER'

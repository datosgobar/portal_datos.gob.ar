# Tests 

Para correr los test de la aplicación se deben levantar todos los servicios y luego inicializar la configuración de test.

### Tests de Ckan
    $ docker-compose -f dev.yml up --build -d portal
    $ docker exec portal bash /etc/ckan_init.d/tests/install_solr4.sh    
    $ docker exec portal bash /etc/ckan_init.d/tests/install_nodejs.sh    
    $ docker exec portal bash -c 'su -c "bash /etc/ckan_init.d/tests/run_all_tests.sh" -l $USER'


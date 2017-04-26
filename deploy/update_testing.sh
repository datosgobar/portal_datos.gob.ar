#!/usr/bin/env bash

set -ev

container_image=$(docker ps --format '{{ .Image }}' --filter 'name=portal_development')

if [ "$TRAVIS_BRANCH" == "master" ]; then
    tag="latest"
else
    tag="$TRAVIS_BRANCH"
fi

image_full_name="datosgobar/portal_datos.gob.ar:$tag"
docker tag "$container_image" "$image_full_name"

# Esta tarea podría tardar mucho, y según la documentación de Travis, las tareas que demoran más de 
# 10 minutos generan un timeout (https://docs.travis-ci.com/user/customizing-the-build/#Build-Timeouts).
# Para evitar este timeout forzamos un print cada 3 minutos indicando que el trabajo continua
# Si docker tuviese un flag verbose quizás esto no sería necesario.
docker push "$image_full_name" &

export PID=$!
while [[ `ps -p $PID | tail -n +2` ]]; do
  echo 'Deploying'
  sleep 540
done


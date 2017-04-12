#!/usr/bin/env bash

container_image=$(docker ps --format '{{ .Image }}' --filter 'name=portal_development')

if [ "$TRAVIS_BRANCH" == "master" ]; then
    tag="latest"
else
    tag="$TRAVIS_BRANCH"
fi

image_full_name="datosgobar/portal_datos.gob.ar:$tag"
docker tag "$container_image" "$image_full_name"
docker push "$image_full_name"

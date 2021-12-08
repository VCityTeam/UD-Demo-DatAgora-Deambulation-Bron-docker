#!/bin/bash

DOCKER_IMAGE_NAME=vcity/demo-datagora-deambulation-bron
HOST_PORT=8084
INTERNAL_PORT=80

echo 'Building the docker image:'
docker build -t $DOCKER_IMAGE_NAME . --no-cache
[ $? -ne 0 ] && echo 'Error during docker build.' && exit 1

echo 'Starting a new docker container:'
docker run -p $HOST_PORT:$INTERNAL_PORT/tcp -t --detach $DOCKER_IMAGE_NAME
[ $? -ne 0 ] && echo 'Error when starting container.' && exit 2

echo 'The demo should now be available at URL `http://localhost:8084/`.'
echo 'To stop the demo, you can use the script `stop.sh`.'

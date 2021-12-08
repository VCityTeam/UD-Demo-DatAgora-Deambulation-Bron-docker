#!/bin/bash

DOCKER_IMAGE_NAME=vcity/demo-datagora-deambulation-bron

echo 'Stopping the container:'
docker stop $(docker ps -a -q --filter ancestor=$DOCKER_IMAGE_NAME --format="{{.ID}}")

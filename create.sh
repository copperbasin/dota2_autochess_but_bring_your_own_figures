#!/bin/bash
DOCKER_ID=`docker run -it -d \
  -p 1337:1337 \
  autochess`
echo "DOCKER_ID = $DOCKER_ID"
echo -n $DOCKER_ID > DOCKER_ID

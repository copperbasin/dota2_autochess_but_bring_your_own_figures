#!/bin/bash
WALLET_ABS_PATH=`realpath ./wallet`
DOCKER_ID=`docker run -it -d \
  -v $WALLET_ABS_PATH:/src/build \
  -p 1337:1337 \
  -p 1338:1338 \
  autochess`
echo "DOCKER_ID = $DOCKER_ID"
echo -n $DOCKER_ID > DOCKER_ID

#!/bin/bash
COUNT=`cat COUNT`
for ((I=1;I<=COUNT;I++))
do
  WALLET_ABS_PATH=`realpath ./wallet_$I`
  DOCKER_ID=`docker run -it -d \
    -v $WALLET_ABS_PATH:/src/build \
    -p 1337$I:1337 \
    -p 1338$I:1338 \
    autochess`
  echo "DOCKER_ID = $DOCKER_ID"
  echo -n $DOCKER_ID > DOCKER_ID_$I
done

#!/bin/bash
./stop_all.sh
COUNT=`cat COUNT`
for ((I=1;I<=COUNT;I++))
do
  docker rm `cat DOCKER_ID_$I`
  echo "remove ok"
done

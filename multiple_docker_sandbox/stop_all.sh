#!/bin/bash
COUNT=`cat COUNT`
for ((I=1;I<=COUNT;I++))
do
  docker stop `cat DOCKER_ID_$I`
done

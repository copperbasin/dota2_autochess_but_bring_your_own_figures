#!/bin/bash
./stop.sh
docker rm `cat DOCKER_ID`
echo "remove ok"

#!/bin/bash
./_drop.sh && ./build.sh && ./create.sh
cd multiple_docker_sandbox
./_drop_all.sh
./create_all.sh

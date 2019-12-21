#!/bin/bash
# doesn't work
# source ~/.bashrc
source ~/.nvm/nvm.sh
export FIFTPATH=/src/ton/crypto/fift/lib
while true
do
  echo "restart"
  npm start
  sleep 1
done

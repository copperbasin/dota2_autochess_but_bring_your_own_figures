#!/bin/bash
screen -dmS ton ./ton_loop.sh
screen -dmS server ./server_loop.sh

echo "started"
# hang
while true
do
  sleep 60
done

#!/bin/bash
func -P -o build/game-code.fif contracts/stdlib.fc contracts/game-code.fc

screen -dmS lite-client ./ton_loop.sh
screen -dmS server ./server_loop.sh

echo "started"
# hang
while true
do
  sleep 60
done

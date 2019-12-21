#!/bin/bash
while true
do
  echo "restart"
  ./lite-client -C ./ton-global.config
  sleep 1
done

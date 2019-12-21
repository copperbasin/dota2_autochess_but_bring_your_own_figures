#!/bin/sh
fift -s fift_scripts/update-prices.fif
screen -S lite-client -p 0 -X stuff "sendfile ./build/update-prices-query.boc
"

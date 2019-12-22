#!/bin/sh
fift -s fift_scripts/update-prices.fif
./lite-client/lite-client -C ./lite-client/ton-global.config -c 'last'
./lite-client/lite-client -C ./lite-client/ton-global.config -c 'sendfile ./build/update-prices-query.boc'
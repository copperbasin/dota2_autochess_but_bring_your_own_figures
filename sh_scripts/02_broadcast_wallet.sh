#!/bin/sh
./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'last'
./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'sendfile ./build/new-wallet-query.boc'
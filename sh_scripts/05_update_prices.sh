#!/bin/sh
CONTRACT=`fift -s fift_scripts/show-bouceable-addr.fif build/new-game `
./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'last'
SEQNO=`./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -c  'runmethod '$CONTRACT' seqno' |  grep 'remote result' | cut -d "[" -f2 | cut -d "]" -f1`


fift -s fift_scripts/update-prices.fif $SEQNO
./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'last'
./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'sendfile ./build/update-prices-query.boc'
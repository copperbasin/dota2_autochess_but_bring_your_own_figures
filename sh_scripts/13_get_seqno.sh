#!/bin/sh
USER=`fift -s fift_scripts/show-bouceable-addr.fif build/new-wallet | cut -d ":" -f2`

./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'last'
./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'runmethod '$USER' seqno' 2>&1 |  grep result | cut -d "[" -f2 | cut -d "]" -f1 


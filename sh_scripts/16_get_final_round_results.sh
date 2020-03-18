#!/bin/sh
CONTRACT=`fift -s fift_scripts/show-bouceable-addr.fif build/new-game `
GAME_IDX=1
lite-client -v 0 -C ./ton-global.config -l /dev/null -c 'last'
lite-client -v 0 -C ./ton-global.config -l /dev/null -c 'runmethod '$CONTRACT' getfinalroundresults '$GAME_IDX 2>&1  


#!/bin/sh
CONTRACT=`fift -s fift_scripts/show-bouceable-addr.fif build/new-game `

lite-client -v 0 -C ./ton-global.config -l /dev/null -c 'last'
lite-client -v 0 -C ./ton-global.config -l /dev/null -c 'runmethod '$CONTRACT' getqueuelen' 2>&1 |  grep result | cut -d "[" -f2 | cut -d "]" -f1 


#!/bin/sh
# CONTRACT=`fift -s fift_scripts/show-bouceable-addr.fif build/new-game `
CONTRACT="kf-tRnWNAZDD8D3LNqFuSty8BIantwY2KqI6FBmo3Ac-yIfv"
user=`fift -s fift_scripts/show-addr.fif build/new-wallet | cut -d ":" -f2`
lite-client -C ./ton-global.config -l null -c 'last'
lite-client -v 0 -C ./ton-global.config -c "runmethod $CONTRACT getplayeridx -1 0x$user" 2>&1 |  grep result: | cut -d "[" -f2 | cut -d "]" -f1

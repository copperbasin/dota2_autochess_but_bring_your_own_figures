#!/bin/sh
CONTRACT=`fift -s fift_scripts/show-bouceable-addr.fif build/new-game `
for i in 0 1 2 3 4 5 6 7
do
    user=`fift -s fift_scripts/show-addr.fif build/new-wallet-0$i | cut -d ":" -f2`
    ./lite-client/lite-client -C ./lite-client/ton-global.config -l null -c 'last'
    player_idx=`./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'runmethod '$CONTRACT' getplayeridx -1 0x'$user' 2>&1 |  grep result | cut -d "[" -f2 | cut -d "]" -f1'`
    echo "Player idx for "$user" : "$player_idx
done
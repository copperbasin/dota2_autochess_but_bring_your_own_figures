#!/bin/sh
CONTRACT=`fift -s fift_scripts/show-addr.fif build/new-game | grep "Non-bounceable address (for init only):" | cut -d ' ' -f6`
fift -s fift_scripts/wallet.fif "build/new-wallet" $CONTRACT 14 0.5 "./build/wallet-query"
screen -S lite-client -p 0 -X stuff "sendfile ./build/wallet-query.boc
"
sleep 5
screen -S lite-client -p 0 -X stuff "last
"
screen -S lite-client -p 0 -X stuff "sendfile ./build/new-game-query.boc
"

#!/bin/sh
CONTRACT=`fift -s fift_scripts/show-addr.fif build/new-game | grep "Non-bounceable address (for init only):" | cut -d ' ' -f6`
fift -s fift_scripts/buy-unit.fif
fift -s fift_scripts/wallet.fif "build/new-wallet" $CONTRACT 6 0.5 "./build/wallet-query" -B "./build/buy-unit.boc"
screen -S lite-client -p 0 -X stuff "sendfile ./build/wallet-query.boc
# "

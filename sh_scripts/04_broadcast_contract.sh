#!/bin/sh
CONTRACT=`fift -s fift_scripts/show-init-addr.fif build/new-game `
fift -s fift_scripts/wallet.fif "build/new-wallet" $CONTRACT 34 0.5 "./build/wallet-query"
./lite-client/lite-client -C ./lite-client/ton-global.config -c 'last'
./lite-client/lite-client -C ./lite-client/ton-global.config -c 'sendfile ./build/wallet-query.boc'
sleep 5
./lite-client/lite-client -C ./lite-client/ton-global.config -c 'last'
./lite-client/lite-client -C ./lite-client/ton-global.config -c 'sendfile ./build/new-game-query.boc'
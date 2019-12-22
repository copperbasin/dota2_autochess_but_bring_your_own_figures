#!/bin/sh
CONTRACT=`fift -s fift_scripts/show-bouceable-addr.fif build/new-game `
fift -s fift_scripts/buy-unit.fif 10001 1 8
fift -s fift_scripts/wallet.fif "build/new-wallet" $CONTRACT 35 0.5 "./build/wallet-query" -B "./build/buy-unit.boc"
./lite-client/lite-client -C ./lite-client/ton-global.config -c 'sendfile ./build/wallet-query.boc'
sleep 3

fift -s fift_scripts/buy-unit.fif 20002 2 8
fift -s fift_scripts/wallet.fif "build/new-wallet" $CONTRACT 36 0.5 "./build/wallet-query" -B "./build/buy-unit.boc"
./lite-client/lite-client -C ./lite-client/ton-global.config -c 'sendfile ./build/wallet-query.boc'
sleep 3

fift -s fift_scripts/buy-unit.fif 30003 3 8
fift -s fift_scripts/wallet.fif "build/new-wallet" $CONTRACT 37 0.5 "./build/wallet-query" -B "./build/buy-unit.boc"
./lite-client/lite-client -C ./lite-client/ton-global.config -c 'sendfile ./build/wallet-query.boc'
sleep 3

fift -s fift_scripts/buy-unit.fif 40004 4 8
fift -s fift_scripts/wallet.fif "build/new-wallet" $CONTRACT 38 0.5 "./build/wallet-query" -B "./build/buy-unit.boc"
./lite-client/lite-client -C ./lite-client/ton-global.config -c 'sendfile ./build/wallet-query.boc'
sleep 3

fift -s fift_scripts/buy-unit.fif 50005 5 8
fift -s fift_scripts/wallet.fif "build/new-wallet" $CONTRACT 39 0.5 "./build/wallet-query" -B "./build/buy-unit.boc"
./lite-client/lite-client -C ./lite-client/ton-global.config -c 'sendfile ./build/wallet-query.boc'
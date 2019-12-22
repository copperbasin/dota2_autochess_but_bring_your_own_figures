#!/bin/sh
CONTRACT=`fift -s fift_scripts/show-bouceable-addr.fif build/new-game `
fift -s fift_scripts/buy-unit.fif 10001 1 8
fift -s fift_scripts/wallet.fif "build/new-wallet" $CONTRACT 26 0.5 "./build/wallet-query" -B "./build/buy-unit.boc"
screen -S lite-client -p 0 -X stuff "sendfile ./build/wallet-query.boc
 "
sleep 3

fift -s fift_scripts/buy-unit.fif 20002 2 8
fift -s fift_scripts/wallet.fif "build/new-wallet" $CONTRACT 27 0.5 "./build/wallet-query" -B "./build/buy-unit.boc"
screen -S lite-client -p 0 -X stuff "sendfile ./build/wallet-query.boc
 "
sleep 3

fift -s fift_scripts/buy-unit.fif 30003 3 8
fift -s fift_scripts/wallet.fif "build/new-wallet" $CONTRACT 28 0.5 "./build/wallet-query" -B "./build/buy-unit.boc"
screen -S lite-client -p 0 -X stuff "sendfile ./build/wallet-query.boc
 "
sleep 3

fift -s fift_scripts/buy-unit.fif 40004 4 8
fift -s fift_scripts/wallet.fif "build/new-wallet" $CONTRACT 29 0.5 "./build/wallet-query" -B "./build/buy-unit.boc"
screen -S lite-client -p 0 -X stuff "sendfile ./build/wallet-query.boc
 "
sleep 3

fift -s fift_scripts/buy-unit.fif 50005 5 8
fift -s fift_scripts/wallet.fif "build/new-wallet" $CONTRACT 30 0.5 "./build/wallet-query" -B "./build/buy-unit.boc"
screen -S lite-client -p 0 -X stuff "sendfile ./build/wallet-query.boc
 "
#!/bin/sh
CONTRACT=`fift -s fift_scripts/show-bouceable-addr.fif build/new-game `
fift -s fift_scripts/line-up-queue.fif
fift -s fift_scripts/wallet.fif "build/new-wallet" $CONTRACT 33 0.5 "./build/wallet-query" -B "./build/line-up.boc"
screen -S lite-client -p 0 -X stuff "sendfile ./build/wallet-query.boc
 "
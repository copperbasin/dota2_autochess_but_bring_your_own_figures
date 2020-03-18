#!/bin/sh
CONTRACT=`fift -s fift_scripts/show-bouceable-addr.fif build/new-game `
./lite-client/lite-client -C ./lite-client/ton-global.config -l null -c 'saveaccountdata ./build/contract.boc '$CONTRACT
fift -s fift_scripts/get-local-store.fif 1 2> null

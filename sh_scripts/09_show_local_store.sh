#!/bin/sh
# CONTRACT=`fift -s fift_scripts/show-bouceable-addr.fif build/new-game `
CONTRACT="kf-tRnWNAZDD8D3LNqFuSty8BIantwY2KqI6FBmo3Ac-yIfv"
lite-client -C ./ton-global.config -l null -c 'saveaccountdata ./build/contract.boc '$CONTRACT
fift -s fift_scripts/get-local-store.fif $CONTRACT 1 2> null

#!/bin/sh
mkdir -p build
fift -s fift_scripts/new-wallet-v2.fif -1 "build/new-wallet-00"
fift -s fift_scripts/new-wallet-v2.fif -1 "build/new-wallet-01"
fift -s fift_scripts/new-wallet-v2.fif -1 "build/new-wallet-02"
fift -s fift_scripts/new-wallet-v2.fif -1 "build/new-wallet-03"
fift -s fift_scripts/new-wallet-v2.fif -1 "build/new-wallet-04"
fift -s fift_scripts/new-wallet-v2.fif -1 "build/new-wallet-05"
fift -s fift_scripts/new-wallet-v2.fif -1 "build/new-wallet-06"
fift -s fift_scripts/new-wallet-v2.fif -1 "build/new-wallet-07"

./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'last'

WALLET=`fift -s fift_scripts/show-init-addr.fif build/new-wallet-00 `
fift -s ../Ton-Espace/scripts/wallet.fif "../Ton-Espace/build/main-wallet" $WALLET 72 50 "./build/main-wallet-query"
./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'sendfile ./build/main-wallet-query.boc'
sleep 2

WALLET=`fift -s fift_scripts/show-init-addr.fif build/new-wallet-01 `
fift -s ../Ton-Espace/scripts/wallet.fif "../Ton-Espace/build/main-wallet" $WALLET 72 50 "./build/main-wallet-query"
./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'sendfile ./build/main-wallet-query.boc'
sleep 2

WALLET=`fift -s fift_scripts/show-init-addr.fif build/new-wallet-02 `
fift -s ../Ton-Espace/scripts/wallet.fif "../Ton-Espace/build/main-wallet" $WALLET 74 50 "./build/main-wallet-query"
./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'sendfile ./build/main-wallet-query.boc'
sleep 2

WALLET=`fift -s fift_scripts/show-init-addr.fif build/new-wallet-03 `
fift -s ../Ton-Espace/scripts/wallet.fif "../Ton-Espace/build/main-wallet" $WALLET 75 50 "./build/main-wallet-query"
./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'sendfile ./build/main-wallet-query.boc'
sleep 2

WALLET=`fift -s fift_scripts/show-init-addr.fif build/new-wallet-04 `
fift -s ../Ton-Espace/scripts/wallet.fif "../Ton-Espace/build/main-wallet" $WALLET 76 50 "./build/main-wallet-query"
./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'sendfile ./build/main-wallet-query.boc'
sleep 2

WALLET=`fift -s fift_scripts/show-init-addr.fif build/new-wallet-05 `
fift -s ../Ton-Espace/scripts/wallet.fif "../Ton-Espace/build/main-wallet" $WALLET 77 50 "./build/main-wallet-query"
./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'sendfile ./build/main-wallet-query.boc'
sleep 2

WALLET=`fift -s fift_scripts/show-init-addr.fif build/new-wallet-06 `
fift -s ../Ton-Espace/scripts/wallet.fif "../Ton-Espace/build/main-wallet" $WALLET 78 50 "./build/main-wallet-query"
./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'sendfile ./build/main-wallet-query.boc'
sleep 2

WALLET=`fift -s fift_scripts/show-init-addr.fif build/new-wallet-07 `
fift -s ../Ton-Espace/scripts/wallet.fif "../Ton-Espace/build/main-wallet" $WALLET 79 50 "./build/main-wallet-query"
./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'sendfile ./build/main-wallet-query.boc'
sleep 2


./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'sendfile ./build/new-wallet-00-query.boc'
./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'sendfile ./build/new-wallet-01-query.boc'
./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'sendfile ./build/new-wallet-02-query.boc'
./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'sendfile ./build/new-wallet-03-query.boc'
./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'sendfile ./build/new-wallet-04-query.boc'
./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'sendfile ./build/new-wallet-05-query.boc'
./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'sendfile ./build/new-wallet-06-query.boc'
./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'sendfile ./build/new-wallet-07-query.boc' 
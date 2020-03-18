#!/bin/sh
CONTRACT=`fift -s fift_scripts/show-bouceable-addr.fif build/new-game `

for i in 0 1 2 3 4 5 6 7
do
    wallet_name="build/new-wallet-0"$i
    user=`fift -s fift_scripts/show-bouceable-addr.fif $wallet_name`
    fift -s fift_scripts/arrange-units.fif "./fift_scripts/locations/locations-source-0$i.fif"
    ./lite-client/lite-client -C ./lite-client/ton-global.config -l null -c 'last'
    seqno=`./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'runmethod '$user' seqno' 2>&1 |  grep result | cut -d "[" -f2 | cut -d "]" -f1`
    fift -s fift_scripts/wallet.fif "build/new-wallet-0"$i $CONTRACT $seqno 0.5 "./build/wallet-query" -B "./build/arrange-units.boc"
    ./lite-client/lite-client -C ./lite-client/ton-global.config -l null -c 'sendfile ./build/wallet-query.boc'
    sleep 3
done
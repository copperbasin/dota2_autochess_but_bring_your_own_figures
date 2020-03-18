#!/bin/sh
fift -s fift_scripts/line-up-queue.fif
CONTRACT=`fift -s fift_scripts/show-bouceable-addr.fif build/new-game `

for i in 0 1
do
    wallet_name="build/new-wallet-0"$i
    user=`fift -s fift_scripts/show-bouceable-addr.fif $wallet_name`
    ./lite-client/lite-client -C ./lite-client/ton-global.config -l null -c 'last'
    seqno=`./lite-client/lite-client -C ./lite-client/ton-global.config -c 'runmethod '$user' seqno' |  grep 'remote result' | cut -d "[" -f2 | cut -d "]" -f1`
    fift -s fift_scripts/wallet.fif "build/new-wallet-0"$i $CONTRACT $seqno 4.5 "./build/wallet-query" -B "./build/line-up.boc"
    # ./lite-client/lite-client -C ./lite-client/ton-global.config -l null -c 'sendfile ./build/wallet-query.boc'
    sleep 4
done

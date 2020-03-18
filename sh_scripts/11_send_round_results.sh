#!/bin/sh
CONTRACT=`fift -s fift_scripts/show-bouceable-addr.fif build/new-game `
GAME_IDX=1

for i in 0 1 2 3 4 5 6 7
do
    wallet_name="build/new-wallet-0"$i
    user=`fift -s fift_scripts/show-bouceable-addr.fif $wallet_name`
    user_hex=`fift -s fift_scripts/show-addr.fif $wallet_name | cut -d ":" -f2`

    ./lite-client/lite-client -C ./lite-client/ton-global.config -l null -c 'last'
    seqno=`./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'runmethod '$user' seqno' 2>&1 |  grep result | cut -d "[" -f2 | cut -d "]" -f1`
    player_idx=`./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c 'runmethod '$CONTRACT' getplayeridx -1 0x'$user_hex 2>&1 |  grep result | cut -d "[" -f2 | cut -d "]" -f1 `
    
    fift -s fift_scripts/send-round-results.fif $GAME_IDX $player_idx
    
    fift -s fift_scripts/wallet.fif $wallet_name $CONTRACT $seqno 3 "./build/wallet-query" -B "./build/send-round-results.boc"
    ./lite-client/lite-client -C ./lite-client/ton-global.config -l null -c 'sendfile ./build/wallet-query.boc'
    sleep 4
done
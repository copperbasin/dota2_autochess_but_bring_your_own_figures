#!/bin/sh
CONTRACT=`fift -s fift_scripts/show-bouceable-addr.fif build/new-game `

for i in 0 1
do
    wallet_name="build/new-wallet-0"$i
    user=`fift -s fift_scripts/show-bouceable-addr.fif $wallet_name`
    user_hex=`fift -s fift_scripts/show-addr.fif $wallet_name | cut -d ":" -f2`
    units=("10001 1 8" "20002 2 8" "30003 3 8" "40004 4 8" "50005 5 8")
    for unit in "${units[@]}"
    do
        unit_arr=($unit)
        type=${unit_arr[0]}
        level=${unit_arr[1]}
        counter=${unit_arr[2]}
        fift -s fift_scripts/buy-unit.fif $type $level $counter
        ./lite-client/lite-client -C ./lite-client/ton-global.config -l null -c 'last'
        seqno=`./lite-client/lite-client -C ./lite-client/ton-global.config -c 'runmethod '$user' seqno' |  grep 'remote result' | cut -d "[" -f2 | cut -d "]" -f1`
        fift -s fift_scripts/wallet.fif "build/new-wallet-0"$i $CONTRACT $seqno 1 "./build/wallet-query" -B "./build/buy-unit.boc" 2>&1
        res=` ./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c "runmethod $CONTRACT getunits -1 0x$user_hex $type $level" 2>&1 | grep result | cut -d "[" -f2 | cut -d "]" -f1`
        if [[ $res == " 0 " ]] 
        then
        ./lite-client/lite-client -C ./lite-client/ton-global.config -l null -c 'sendfile ./build/wallet-query.boc'
        sleep 5
        fi
    done
done


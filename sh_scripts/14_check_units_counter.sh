#!/bin/sh
CONTRACT=`fift -s fift_scripts/show-bouceable-addr.fif build/new-game `

for i in 0 1 2 3 4 5 6 7
do
    wallet_name="build/new-wallet-0"$i
    user=`fift -s fift_scripts/show-addr.fif $wallet_name | cut -d ":" -f2`

    echo "Units for $user:"
    units=("10001 1" "20002 2" "30003 3" "40004 4" "50005 5")
    for unit in "${units[@]}"
    do
        unit_arr=($unit)
        type=${unit_arr[0]}
        level=${unit_arr[1]}
        ./lite-client/lite-client -C ./lite-client/ton-global.config -l null -c 'last'
        echo "      number of $type with level $level"
        ./lite-client/lite-client -v 0 -C ./lite-client/ton-global.config -l /dev/null -c "runmethod $CONTRACT getunits -1 0x$user $type $level" 2>&1 | grep result | cut -d "[" -f2 | cut -d "]" -f1
    done
done

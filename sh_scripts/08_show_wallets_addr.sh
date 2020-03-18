#!/bin/sh
for i in 0 1 2 3 4 5 6 7
do
    fift -s fift_scripts/show-bouceable-addr.fif build/new-wallet-0$i
done
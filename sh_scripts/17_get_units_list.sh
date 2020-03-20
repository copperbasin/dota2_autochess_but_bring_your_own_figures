#!/bin/sh
CONTRACT="kf-tRnWNAZDD8D3LNqFuSty8BIantwY2KqI6FBmo3Ac-yIfv"
lite-client -l null -c 'saveaccountdata ./build/contract.boc '$CONTRACT
fift -s fift_scripts/get-units-list.fif $CONTRACT 1 2>/dev/null

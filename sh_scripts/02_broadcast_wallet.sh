#!/bin/sh
screen -S lite-client -p 0 -X stuff "last
"
screen -S lite-client -p 0 -X stuff "sendfile ./build/new-wallet-query.boc
"

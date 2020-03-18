#!/bin/sh
lite-client -v 0 -C ./ton-global.config -l /dev/null -c 'last'
lite-client -v 0 -C ./ton-global.config -l /dev/null -c 'sendfile ./build/new-wallet-query.boc'
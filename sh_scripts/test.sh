#!/bin/sh
./sh_scripts/create_contract.sh
fift -s tests/00_basic_tests.fif
fift -s tests/01_update_prices_tests.fif
fift -s tests/02_buy_units_tests.fif
#!/bin/sh
./sh_scripts/03_create_contract.sh
fift -s tests/00_basic_tests.fif
fift -s tests/01_update_prices_tests.fif
fift -s tests/02_buy_units_tests.fif
fift -s tests/03_line_up_to_match_tests.fif
fift -s tests/04_getters_tests.fif
fift -s tests/05_tick_tock_tests.fif
#!/bin/sh
func -P -o build/game-code.fif contracts/stdlib.fc contracts/game-code.fc
fift -s fift_scripts/new-game.fif
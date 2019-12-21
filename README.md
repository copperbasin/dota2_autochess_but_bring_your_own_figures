# It's dota2 autochess but bring your own figures
## What is it? ##

This is our freaky custom variation of dota2 autochess. We tried to make it works somehow on TON smart-contracts.
Key differences from original autochess:
  * Match can't be free (so we need some way users pay)
  * Figures' pool is dependent on what figures was in "players hand" they came with
  * Figures can be bought in shop
  * In-game rolls can't be requested from server frequently, so we split pool beyond players each round evenly for each level but random.
  * Player can't lock good roll
  * Player can see all figures he have access. Access to "next line" costs 2 gold same as original. But now you have "spy eye"
  * After player death in match his/her figures are not going back to pool.

## How to install and play? ##
Docker is highly recommended

    ./build.sh
    ./create.sh
    # go to your browser http://localhost:1337
    # you need fill your TON wallet inside docker container
    # autochess is 8-player game. You need 7 friends

## Development (You are dev and feeling lucky) ##
### How to launch front-end? ###

    npm i
    npm run dev

### How to go inside docker? ###

    ./ssh.sh

#### I'm inside docker. What is going on? ####

    # you can look what processes are inside screens
    screen -ls
    # note that you can't simply screen -R inside docker
    # use this first
    ./_ss.sh
    # then
    screen -R ton
    # OR
    screen -R server

#### How can I launch fift? ####

    # look inside your default folder
    ls
    # fift and func are just here
    ./fift -v
    ./func -v

### How to deploy smart-contracts? ###

    # TBD

### How to tell browser client connect to specific smart-contract? ###

    # TBD

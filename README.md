# It's dota2 autochess but bring your own figures
## How to install ##
Docker is highly recommended

    ./build.sh
    ./create.sh
    # go to your browser http://localhost:1337

## Development (You are dev and feeling lucky) ##
### How to launch front-end ###

    npm i
    npm run dev

### How to go inside docker ###

    ./ssh.sh

#### I'm inside docker, what is going on ####

    # you can look what processes are inside screens
    screen -ls
    # note that you can't simply screen -R inside docker
    # use this first
    ./_ss.sh
    # then
    screen -R ton
    # OR
    screen -R server

#### How can I launch fift ####

    # look inside your default folder
    ls
    # fift and func are just here
    ./fift -v
    ./func -v

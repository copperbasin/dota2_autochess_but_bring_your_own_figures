# ###################################################################################################
# generic my env
# ###################################################################################################

FROM ubuntu:18.04

SHELL ["/bin/bash", "-c"]

WORKDIR /src

# TODO for cache invalidation just change date
RUN echo "18.03.2020" && apt-get update

RUN apt-get install -y htop atop iotop screen tmux mc git nano curl wget g++ build-essential gcc make cmake autoconf automake psmisc pciutils lm-sensors ethtool

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.35.2/install.sh | bash

RUN source ~/.nvm/nvm.sh && nvm install 12 && node -v && npm i -g iced-coffee-script

# ###################################################################################################
# TON
# ###################################################################################################
RUN git clone https://github.com/ton-blockchain/ton.git --recursive

# extra deps
RUN apt-get install -y zlib1g-dev libssl-dev

RUN mkdir ton/liteclient-build
RUN cd ton/liteclient-build && cmake ..
RUN cd ton/liteclient-build && cmake --build . --target lite-client
RUN cd ton/liteclient-build && cmake --build . --target fift
RUN cd ton/liteclient-build && cmake --build . --target func

RUN cp ton/liteclient-build/crypto/fift /bin && \
  cp ton/liteclient-build/crypto/func /bin && \
  cp ton/liteclient-build/lite-client/lite-client /bin
# ###################################################################################################
# APP
# ###################################################################################################

RUN echo "export FIFTPATH=/src/ton/crypto/fift/lib" >> ~/.bashrc

VOLUME /src/build


# Keep names from Dich5 repo
COPY fift_scripts fift_scripts
COPY contracts contracts
COPY sh_scripts sh_scripts

COPY htdocs htdocs
COPY package.json .
COPY package-lock.json .
COPY loop.sh .
COPY server.coffee .
COPY wrapper.sh .
COPY ton_loop.sh .
COPY server_loop.sh .
COPY ton-global.config .
COPY config.json .
COPY _ss.sh .

RUN source ~/.nvm/nvm.sh && npm ci
RUN chmod +x ./sh_scripts/*

RUN func -P -o build/game-code.fif contracts/stdlib.fc contracts/game-code.fc

CMD /bin/bash ./wrapper.sh

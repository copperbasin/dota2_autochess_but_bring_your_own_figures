# ###################################################################################################
# generic my env
# ###################################################################################################

FROM ubuntu:18.04

SHELL ["/bin/bash", "-c"]

WORKDIR /src

# TODO for cache invalidation just change date
RUN echo "21.12.2019" && apt-get update

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

RUN cp ton/liteclient-build/crypto/fift . && \
  cp ton/liteclient-build/crypto/func . && \
  cp ton/liteclient-build/lite-client/lite-client .
# ###################################################################################################
# APP
# ###################################################################################################

COPY htdocs htdocs
COPY package.json .
COPY package-lock.json .
COPY loop.sh .
COPY server.coffee .
COPY wrapper.sh .
COPY ton_loop.sh .
COPY server_loop.sh .
COPY ton-global.config .
COPY _ss.sh .

RUN source ~/.nvm/nvm.sh && npm ci

CMD /bin/bash ./wrapper.sh
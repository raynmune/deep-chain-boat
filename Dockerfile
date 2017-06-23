FROM ubuntu:16.04
MAINTAINER raynmune

RUN apt-get update
RUN apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils
RUN apt-get install -y libboost-all-dev
RUN apt-get install -y git
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:bitcoin/bitcoin
RUN apt-get update
RUN apt-get install -y libdb4.8-dev libdb4.8++-dev
RUN apt-get install -y netcat-traditional

RUN set -x \
	&& git clone https://github.com/MultiChain/multichain.git \
	&& cd multichain \
	&& ./autogen.sh \
	&& ./configure \
	&& make \
	&& mv src/multichaind src/multichain-cli src/multichain-util /usr/local/bin \
	&& cd .. \
	&& rm -r multichain \
	&& git clone https://github.com/raynmune/deep-chain-boat.git \
	&& mv deep-chain-boat/first-node deep-chain-boat/second-node deep-chain-boat/node-description-listen /usr/local/bin \
	&& rm -r deep-chain-boat

RUN apt-get autoremove
RUN apt-get clean


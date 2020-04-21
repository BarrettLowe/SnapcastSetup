FROM debian:buster-slim

LABEL maintainer "barrett.lowe@gmail.com"

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install build-essential git wget && \
    apt-get -y install libasound2-dev libvorbisidec-dev libvorbis-dev libopus-dev libflac-dev libsoxr-dev alsa-utils libavahi-client-dev avahi-daemon expat && \
    cd /root && \
    wget https://dl.bintray.com/boostorg/release/1.72.0/source/boost_1_72_0.tar.gz && \
    tar -xf boost_1_72_0.tar.gz && \
    git clone http://github.com/badaix/snapcast /snapcast && \
    cd /snapcast/externals && git submodule update --init --recursive

RUN apt-get -y install cargo && cargo install librespot

RUN cd /snapcast && ADD_CFLAGS="-I/root/boost_1_72_0/" make && make installserver && \
    apt-get -qq autoremove && apt-get -qq clean

ENV PATH="/root/.cargo/bin:$PATH"


CMD snapserver --config /etc/snapserver.conf
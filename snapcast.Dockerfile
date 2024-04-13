FROM debian:trixie-slim

LABEL maintainer "barrett.lowe@gmail.com"

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install build-essential git wget cmake && \
    apt-get -y install libasound2-dev libpulse-dev libvorbisidec-dev libvorbis-dev libopus-dev libflac-dev libsoxr-dev alsa-utils libavahi-client-dev avahi-daemon libexpat1-dev && \
    cd /root && \
    wget https://boostorg.jfrog.io/artifactory/main/release/1.74.0/source/boost_1_74_0.tar.gz && \
    tar -xf boost_1_74_0.tar.gz && \
    git clone http://github.com/badaix/snapcast /snapcast && \
    mkdir /snapcast/build && cd /snapcast/build && \
    cmake .. -DBOOST_ROOT=/root/boost_1_74_0/ -DBUILD_CLIENT=no -DBUILD_SERVER=yes -DBUILD_WITH_PULSE=yes && \
    cd /snapcast/build && cmake --build . && \
    apt-get -y install cargo && cargo install librespot && \
    apt-get -qq autoremove && apt-get -qq clean

ENV PATH="/root/.cargo/bin:/snapcast/bin:$PATH"


CMD snapserver --config /etc/snapserver.conf
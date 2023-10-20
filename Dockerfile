FROM ubuntu:latest

RUN apt update

RUN apt-get install -y git cmake g++ pkg-config libspdlog-dev libzmq3-dev libpng-dev libfreetype-dev libsdl2-dev libluajit-5.1-dev libfontconfig-dev libpango1.0-dev luarocks libsqlite3-dev libargh-dev libgtest-dev

# Required by cppzmq
RUN git clone https://github.com/zeromq/libzmq /tmp/libzmq
WORKDIR /tmp/libzmq
RUN mkdir build
WORKDIR /tmp/libzmq/build
RUN cmake ..
RUN make -j 8 install

# No such a package in ubuntu repos
RUN git clone https://github.com/zeromq/cppzmq /tmp/cppzmq
WORKDIR /tmp/cppzmq
RUN cmake .
RUN make -j 8 install
RUN rm -rf /tmp/cppzmq

# Ubuntu is forgets about C++ headers when installing ffmpeg/ffmpeg-dev
RUN git clone https://github.com/ffmpeg/ffmpeg /tmp/ffmpeg
WORKDIR /tmp/ffmpeg
RUN apt-get install -y nasm
RUN ./configure
RUN make -j 8 install
RUN rm -rf /tmp/ffmpeg

# No package in repos
RUN git clone https://github.com/adishavit/argh /tmp/argh
WORKDIR /tmp/argh
RUN cmake .
RUN make -j 8 install
RUN rm -rf /tmp/argh

# Package is available via apt but too old
RUN git clone https://github.com/google/googletest.git /tmp/gtest
WORKDIR /tmp/gtest
RUN cmake .
RUN make -j 8 install
RUN rm -rf /tmp/gtest

# Abseil doesn't work neither from here or from the apt
RUN git clone https://github.com/abseil/abseil-cpp.git /tmp/abseil
WORKDIR /tmp/abseil
RUN cmake .
RUN make -j 8 install
RUN rm -rf /tmp/abseil

COPY . /abyssengine
WORKDIR /abyssengine
RUN cmake .
RUN make

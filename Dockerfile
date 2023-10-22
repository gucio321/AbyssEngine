FROM ubuntu:latest

RUN apt update

RUN apt-get install -y git cmake g++ pkg-config python3 python3-distutils bison nasm autoconf autoconf-archive

RUN mkdir -p /opt
RUN git clone https://github.com/microsoft/vcpkg /opt/vcpkg
RUN apt-get install -y curl zip unzip tar # required by bootstrap-vcpkg.sh
RUN /opt/vcpkg/bootstrap-vcpkg.sh
RUN ln -s /opt/vcpkg/vcpkg /usr/local/bin/vcpkg

COPY . /abyssengine
WORKDIR /abyssengine
RUN vcpkg install
RUN cmake -DCMAKE_TOOLCHAIN_FILE=/opt/vcpkg/scripts/buildsystems/vcpkg.cmake .
RUN make

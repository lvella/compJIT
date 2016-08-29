# compJIT
#
# VERSION       1.1

FROM ubuntu:14.04
MAINTAINER júlia caroline <jcarduini@gmail.com>

ADD readme /root/
RUN apt-get update && apt-get install -y \
        build-essential \
        cmake \
        gfortran \
        git \
        python \
        wget \
        openssl libssl-dev \
&& apt-get clean

# CMake
RUN wget -p /root/ https://cmake.org/files/v3.6/cmake-3.6.1.tar.gz \
        && tar -xzvf cmake-3.6.1.tar.gz \
        && cd cmake-3.6.1 \
        && ./configure
        && make && make install

WORKDIR /root/
RUN git clone https://github.com/karies/cling-all-in-one.git \
&& git clone https://github.com/jcarduini/compjit.git
RUN cd cling-all-in-on && ./clone.sh

ENV prefix=/root/cling-all-in-one/inst
ENV path=$prefix/bin:$path
ENV ld_library_path=$prefix/lib:$ld_library_path
ENV include=$prefix/include:$include


FROM ubuntu:latest
MAINTAINER Chance Hudson

WORKDIR /root
ENV TMPDIR=/tmp

# Build dependencies, can be removed
RUN apt-get update && \
  apt-get install -y \
  build-essential \
  libtool \
  autotools-dev \
  automake \
  libmicrohttpd-dev \
  bsdmainutils \
  gcc \
  g++ \
  git

# Runtime dependencies
RUN apt-get install -y \
  libcurl4-gnutls-dev \
  nettle-dev \
  libjson-c-dev \
  libuv1-dev

RUN git clone https://github.com/Storj/libstorj.git

WORKDIR /root/libstorj

RUN ./autogen.sh && \
  ./configure && \
  make && \
  make install && \
  ./test/tests

WORKDIR /

RUN rm -rf /root/libstorj

CMD ["/usr/local/bin/storj"]

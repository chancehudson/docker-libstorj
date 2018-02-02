FROM ubuntu:latest
MAINTAINER Chance Hudson

WORKDIR /root
ENV TMPDIR=/tmp

# Build dependencies to be removed after build
ENV BUILD_DEPS="build-essential autotools-dev automake bsdmainutils gcc g++ git"

RUN apt-get update && \
  apt-get install -y $BUILD_DEPS \
  libtool \
  libmicrohttpd-dev \
  libcurl4-gnutls-dev \
  nettle-dev \
  libjson-c-dev \
  libuv1-dev && \
  git clone https://github.com/Storj/libstorj.git

WORKDIR /root/libstorj

RUN ./autogen.sh && \
  ./configure && \
  make && \
  make install && \
  apt-get remove -y $BUILD_DEPS && \
  apt-get autoremove && \
  ./test/tests

WORKDIR /

# Clean up the image, just leave the storj executable
RUN rm -rf /root/libstorj

CMD ["/usr/local/bin/storj"]

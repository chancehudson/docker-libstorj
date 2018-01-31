FROM alpine:latest
MAINTAINER Chance Hudson

WORKDIR /root
ENV TMPDIR=/tmp

# Build dependencies, removed after build
RUN apk add --no-cache --virtual .build-deps \
  libtool \
  automake \
  make \
  git \
  autoconf \
  g++

# Runtime dependencies
RUN apk add --no-cache \
  libmicrohttpd-dev \
  curl-dev \
  nettle-dev \
  json-c-dev \
  libuv-dev

RUN git clone https://github.com/Storj/libstorj.git

WORKDIR /root/libstorj

RUN ./autogen.sh && \
  ./configure && \
  make && \
  ./test/tests && \
  make install

WORKDIR /

RUN rm -rf /root/libstorj && \
  apk del .build-deps

CMD ["/usr/local/bin/storj"]

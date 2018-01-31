FROM alpine:latest
MAINTAINER Chance Hudson

WORKDIR /root
ENV TMPDIR=/tmp

RUN apk add --no-cache \
  libtool \
  automake \
  libmicrohttpd-dev \
  make \
  git \
  curl-dev \
  nettle-dev \
  json-c-dev \
  libuv-dev \
  autoconf \
  g++ && \
  git clone https://github.com/Storj/libstorj.git

WORKDIR /root/libstorj

RUN ./autogen.sh && \
  ./configure && \
  make && \
  ./test/tests && \
  make install

WORKDIR /

RUN rm -rf /root/libstorj

CMD ["/bin/ash"]
  

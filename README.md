# docker-libstorj

[![Docker Build Status](https://img.shields.io/docker/build/jchancehud/libstorj.svg)](https://hub.docker.com/r/jchancehud/libstorj/)

This is a prebuilt docker image including the compiled [libstorj](https://github.com/Storj/libstorj) executable.

## Usage

This image is primarily intended for use inside docker swarms to provide a persistent storage that can be authenticated by environment variables provided at runtime as [secrets](https://docs.docker.com/engine/swarm/secrets/).

Configurations for various services (mongo, redis, custom servers) can be stored securely in storj and accessed at runtime via authentication stored in the network in a custom entrypoint script.

## Command line use

This docker image can be used to play with the storj executable without installing onto your local machine.

```
docker run --rm jchancehud/libstorj storj --help
```

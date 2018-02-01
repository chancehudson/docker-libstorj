# docker-libstorj

[![CircleCI](https://circleci.com/gh/JChanceHud/docker-libstorj.svg?style=svg)](https://circleci.com/gh/JChanceHud/docker-libstorj)
[![Storj.io](https://storj.io/img/storj-badge.svg)](https://storj.io)

[jchancehud/libstorj](https://hub.docker.com/r/jchancehud/libstorj/) is a docker image with the [libstorj](https://github.com/Storj/libstorj) executable built and tested on top of alpine linux.

Use the `1.0.0` tag if you want to peg the release.

## Usage

This image is primarily intended for use inside docker swarms to provide a persistent storage that can be authenticated by environment variables provided at runtime as [secrets](https://docs.docker.com/engine/swarm/secrets/).

Configurations for various services (mongo, redis, custom servers) can be stored securely in storj and accessed at runtime via authentication stored in the network in a custom entrypoint script.

## Command line use

This docker image can be used to play with the storj executable without installing onto your local machine.

```
docker run --rm jchancehud/libstorj storj --help
```

### Interactive shell

To enter an interactive shell invoke `/bin/ash` as the command.

```
docker run -it --rm jchancehud/libstorj /bin/ash
```

Now you have a shell into a virtual machine with the `storj` executable in the path.

```
/ # storj --help
usage: storj [<options>] <command> [<args>]

These are common Storj commands for various situations:

setting up users profiles
  register                  setup a new storj bridge user
  import-keys               import existing user
  export-keys               export bridge user, password and encryption keys

working with buckets and files
  list-buckets
  list-files <bucket-id>
  remove-file <bucket-id> <file-id>
  add-bucket <name>
  remove-bucket <bucket-id>
  list-mirrors <bucket-id> <file-id>

downloading and uploading files
  upload-file <bucket-id> <path>
  download-file <bucket-id> <file-id> <path>
bridge api information
  get-info

options:
  -h, --help                output usage information
  -v, --version             output the version number
  -u, --url <url>           set the base url for the api
  -p, --proxy <url>         set the socks proxy (e.g. <[protocol://][user:password@]proxyhost[:port]>)
  -l, --log <level>         set the log level (default 0)
  -d, --debug               set the debug log level

environment variables:
  STORJ_KEYPASS             imported user settings passphrase
  STORJ_BRIDGE              the bridge host (e.g. https://api.storj.io)
  STORJ_BRIDGE_USER         bridge username
  STORJ_BRIDGE_PASS         bridge password
  STORJ_ENCRYPTION_KEY      file encryption key
```

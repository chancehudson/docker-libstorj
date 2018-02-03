# docker-libstorj

[![CircleCI branch](https://img.shields.io/circleci/project/github/JChanceHud/docker-libstorj/master.svg)](https://circleci.com/gh/JChanceHud/docker-libstorj)
[![Storj.io](https://storj.io/img/storj-badge.svg)](https://storj.io)

[jchancehud/libstorj](https://hub.docker.com/r/jchancehud/libstorj/) is a docker image with the [libstorj](https://github.com/Storj/libstorj) executable built, tested and installed.

## Available tags

- [jchancehud/libstorj:latest](https://github.com/JChanceHud/docker-libstorj/blob/master/ubuntu/Dockerfile) - libstorj on ubuntu
- [jchancehud/libstorj:ubuntu](https://github.com/JChanceHud/docker-libstorj/blob/master/ubuntu/Dockerfile) - 202 MB
- [jchancehud/libstorj:ubuntu-1.0.0](https://github.com/JChanceHud/docker-libstorj/blob/1.0.0/ubuntu/Dockerfile) - 201 MB
- [jchancehud/libstorj:alpine](https://github.com/JChanceHud/docker-libstorj/blob/master/alpine/Dockerfile) - libstorj on alpine - currently unstable, some commands do not work - 89 MB
- [jchancehud/libstorj:alpine-1.0.0](https://github.com/JChanceHud/docker-libstorj/blob/master/alpine/Dockerfile) - libstorj 1.0.0 on alpine - 90 MB

## Command line use

This docker image can be used to play with the storj executable without installing onto your local machine.

```
docker run --rm jchancehud/libstorj storj --help
```

### Interactive shell

To enter an interactive shell invoke `ash` (the default alpine shell) as the command with the `-it` flags. The `--rm` flag destroys the container after exit.

```
docker run -it --rm jchancehud/libstorj ash
/ #
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

## Swarm Use

This image can be used inside docker swarms to provide a persistent storage that can be authenticated by secure variables provided at runtime as [secrets](https://docs.docker.com/engine/swarm/secrets/) at `/run/secrets/`.

Configurations for various services (mongo, redis, custom servers) can be stored securely in storj and accessed at runtime via authentication stored in the network in a custom entrypoint script.

Example `entrypoint.sh` that securely retrieves an environment file for a nodejs server.

`DOTENV_BUCKET_ID` and `DOTENV_FILE_ID` are supplied as environment variables to download the file from storj. These parameters are less sensitive as they don't contain authentication information.

```
#! /bin/sh

# Secrets are configured at the swarm level and are provided via files at /run/secrets
# See the docker secrets documentation for more information
# https://docs.docker.com/engine/swarm/secrets/
SECRETS=/run/secrets/

# Load libstorj env config options if they are present
[ -f $SECRETS/STORJ_KEYPASS ] && STORJ_KEYPASS=$(cat $SECRETS/STORJ_KEYPASS)
[ -f $SECRETS/STORJ_BRIDGE ] && STORJ_BRIDGE=$(cat $SECRETS/STORJ_BRIDGE) # This defaults to https://api.storj.io
[ -f $SECRETS/STORJ_BRIDGE_USER ] && STORJ_BRIDGE_USER=$(cat $SECRETS/STORJ_BRIDGE_USER)
[ -f $SECRETS/STORJ_BRIDGE_PASS ] && STORJ_BRIDGE_PASS=$(cat $SECRETS/STORJ_BRIDGE_PASS)
[ -f $SECRETS/STORJ_ENCRYPTION_KEY ] && STORJ_ENCRYPTION_KEY=$(cat $SECRETS/STORJ_ENCRYPTION_KEY)

# Assuming this is a node server that is retrieving a .env file with authentication info
storj download-file $DOTENV_BUCKET_ID $DOTENV_FILE_ID ./.env

exec npm start
```

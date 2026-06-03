# git-scripts

This repository contains several useful scripts written in Bash, that allows easier management of repositories between two devices.

Note this is somewhat personal, so you will have to tweak it a little bit before using.

## Motivation

In the current days, relying on the many git remote providers is not really a great deal, specially if you want to host some more sensitive data or code, which should have the least breaches as possible. This is specially true with proprietary providers, which you already know that uses your data for training AI, house holding your private data without consent and so on.

This is a simple approach without dependence on anything else but `ssh` and `git`, so that we can have a git server in one device and them work with it.

You are encouraged to read all scripts.

## Standalone Scripts

`bulk.sh`

Run bulk operations (local) in all repositories.

`single.sh`

Run a single operation (local) in a chosen repository.

`repo_to_bare.sh`

Makes a bare repository from a normal.

`bare_to_repo.sh`

Makes a normal repository from a bare.

## How to use

You will have to configure `repo.ini` before using. The `client_name` and `server_name` are assumed to be defined in your ssh `.config` file.

```ini
current=client

# Absolute path
client=/home/aoc/.secrets/unencrypted
server=/data/data/com.termux/files/home

client_name=desktop
server_name=phone
```

```ssh
# .ssh/config
Host desktop
    User username
    HostName <IP ADDRESS / LOCAL ADDRESS>
    Port 22
    IdentityFile ~/.ssh/id_rsa
Host phone
    HostName <IP ADDRESS / LOCAL ADDRESS>
    Port 8022
    IdentityFile ~/.ssh/id_rsa
```

After that, in your server, you must turn all repositories into a bare repository using the `repo_to_bare.sh`, which will create them in `~/git/server`. Then you can use `configure_server` to add a `server` remote in all repositories in `./repos` to your own server, and `configure_remote` to do the same.

After that you can operate as usual. To interact with your server you would do: `git fetch server`, `git push server`...

# License

This repository is licensed under the Unlicense license.

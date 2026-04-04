# git-scripts

This repository contains several useful scripts written in Bash, that allows easier management of repositories between two devices.

Note this is somewhat personal, so you will have to tweak it a little bit before using.

## Motivation

In the current days, relying on the many git remote providers is not really a great deal, specially if you want to host some more sensitive data or code, which should have the least breaches as possible. This is specially true with proprietary providers, which you already know that uses your data for training AI, house holding your private data without consent and so on.

This is a simple approach without dependence on anything else but `ssh` and `git`, so that we can have a local server in each of our devices to pull and push, and than truly synchronize using the bare repositories.

Nonetheless, this is more of a workflow, rather than any tool. See a scheme of what I mean.

```console
        ┌──────────────────────┐
        │   Device 1 Repos     │
        │  /home/.../repos     │
        └─────────┬────────────┘
                  │ Device 1 -> push (git push local)
                  ▼
        ┌──────────────────────┐
        │  Device 1 Git Server │
        │  /home/.../server    │
        └─────────┬────────────┘
                  │ Device 2 -> network (ssh / git pull)
                  ▼
        ┌──────────────────────┐
        │    Device 2 Repos    │
        │  ~/git/repos/...     │
        └─────────┬────────────┘
                  │ Device 2 -> push (git push local)
                  ▼
        ┌──────────────────────┐
        │ Device 2 Git Server  │
        │   (local remote)     │
        └──────────────────────┘
                   Device 1 -> network (ssh / git pull)
```

## Scripts

`sync.sh`

Configures `remote.origin.url` for bare repositories only.

`clone.sh`

Clones all repositories listed in `git.repos`.

`bulk.sh`

Run bulk operations (local) in all repositories.

`single.sh`

Run a single operation (local) in a chosen repository.

`repo_to_bare.sh`

Makes a bare repository from a normal.

`bare_to_repo.sh`

Makes a normal repository from a bare.

## How to use

In `vars.sh` you will have to modify these lines:

```bash
current=$(sh ./ini_parser.sh get current repo.ini)
phone_home=$(sh ./ini_parser.sh get phone repo.ini)
desktop_home=$(sh ./ini_parser.sh get desktop repo.ini)

if [ "$current" = "desktop" ]; then
  GIT_REPO="${desktop_home}/git"

  TARGET="phone"
  TARGET_GIT_REPOS="${phone_home}/git/repos"
  TARGET_GIT_SERVER="${phone_home}/git/server"
elif [ "$current" = "phone" ]; then
  GIT_REPO="${phone}/git"

  TARGET="desktop"
  TARGET_GIT_REPOS="${desktop_home}/git/repos"
  TARGET_GIT_SERVER="${desktop_home}/git/server"
fi
```

The changes will have to reflect what you configure in `repo.ini`. For instance it's like this:

```ini
current=desktop
desktop=/home/aoc
phone=/data/data/com.termux/files/home
```

You can rename "desktop" and "phone" to whatever you want, and they are primary entries to your ssh configuration file

```ssh
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

After you have setup this, you can start using it. Take all your cloned repositories and place them into your `~/git/repos`. Also take this opportunity to fill the `git.repos` file, for example:

```txt
neostow-c
neostow-rs
neostow-sh
```

After that, you must turn all repositories into a bare repository using the `repo_to_bare.sh`, which will create them in `~/git/server`. And finally you have to configure all bare repositories to use your second device with the `sync.sh` script.

Taking the example you don't have any repository in your second device, you can clone all of these scripts to it. Here, we assume you have your `git.repos` already, so then you can call the `clone.sh` script which will clone all bare repositories from your first device into `~/git/repos`, and so you can repeat the `repo_to_bare.sh` process.

Once you have the two devices with the same repositories in place, you can work in the `~/git/repos` and push/merge/rebase locally with your server, and once you are ready to sync, you push from the bare repository to your second device bare repository and pull afterwards from your normal repository.

Visually digested bash for the lazy:

```bash
# Device 1

# Move repositories to ~/git/repos
mv ~/dev/repos/* ~/git/repos/

# Setup your git.repos
for filename in */; do echo "$filename" >> git.repos; done

# Generate the bare repos
bash ./repo_to_bare.sh.sh

# Configure repos to point to your second device
bash ./sync.sh

# Device 2

# sftp get git.repos

# Clone all repos from device 1
bash ./clone.sh

# Don't forget to update your repo.ini

# Generate the bare repos
bash ./repo_to_bare.sh

# Configure repos to point to your second device
bash ./sync.sh

# Done
```

# License

This repository is licensed under the Unlicense license.

---
title: About passwordless ssh
date: 2023-03-27
summary: test
---
## `ssh-copy-id`

Using `ssh-copy-id` feels good.

## About Permissions

Make sure the permissions of the two files **on the server side** are as below:

1. `~/.ssh`: 700
2. `~/.ssh/authorized_keys`: 600

If not, `chmod` them to be so.

## Algorithm

Make sure the algorithm is supported **on the local side** i.e. have the option `PubkeyAcceptedKeyTypes +ssh-rsa`.

## Git Servers

If it's about a git server, make sure the setting is related to the right host e.g.

```sshconfig
Host github.com
 Hostname github.com
 User Yuan-Ru-Lin
 IdentityFile ~/.ssh/github
```

where `~/.ssh/github` is the identity whose [pubkey are added to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).

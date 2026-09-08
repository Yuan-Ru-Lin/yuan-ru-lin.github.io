#import "../template.typ": note

= `ssh-copy-id`
<ssh-copy-id>
Using `ssh-copy-id` feels good.

= About Permissions
<about-permissions>
Make sure the permissions of the two files #strong[on the server side] are as below:

+ `~/.ssh`: 700
+ `~/.ssh/authorized_keys`: 600

If not, `chmod` them to be so.

= Algorithm
<algorithm>
Make sure the algorithm is supported #strong[on the local side] i.e.~have the option `PubkeyAcceptedKeyTypes +ssh-rsa`.

= Git Servers
<git-servers>
If it's about a git server, make sure the setting is related to the right host e.g.

```sshconfig
Host github.com
 Hostname github.com
 User Yuan-Ru-Lin
 IdentityFile ~/.ssh/github
```

where `~/.ssh/github` is the identity whose #link("https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account")[pubkey are added to your GitHub account].

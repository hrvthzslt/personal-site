+++
date = '2026-02-18T17:54:53Z'
draft = false
title = 'Two Keys One Hub'
+++

This is perhaps the most uninteresting post I've created recently, but because I'm either the main character of Memento or a starfish, I have to chronicle the process of setting up multiple SSH keys for GitHub. It's the third time I've done this, it's easy, but I still managed to forget it.

<!--more-->

The usual situation, which we may share, is having a personal account and another account related to an organization. (Alternatively, your personal account could be invited to an organization, making you look like a contribution beast, and make this write-up useless.) But let's stick to the first scenario.

First, generate as many keys as you need. GitHub recommends using the `ed25519` algorithm, and I do too:

```bash
ssh-keygen -t ed25519 -C "main-email@example.com" -f ~/.ssh/id_main
ssh-keygen -t ed25519 -C "work-email@example.com" -f ~/.ssh/id_work
```

Then, add the public keys to the corresponding GitHub accounts in their settings. You can also add the private keys to the ssh-agent:

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_main
ssh-add ~/.ssh/id_work
```

This will make you type the passphrase every time. If that is undesirable (and believe me, it is) you can add the keys to a keychain. That differs between operating systems, so good luck! (On Linux, the `keychain` command will help, and on macOS, `ssh-add` has a `--apple-use-keychain` flag, but psst!)

All that remains is the SSH configuration, which is presented here in its full glory:

```bash
Host *
    UseKeychain yes
    AddKeysToAgent yes

Host github.com
    HostName github.com
    IdentityFile ~/.ssh/id_main
    IdentitiesOnly yes

Host work.github.com
    HostName github.com
    IdentityFile ~/.ssh/id_work
    IdentitiesOnly yes
```

For all hosts entered passphrases will be remembered, and for MacOS `UseKeychain` has to be enabled for using the keychain (I know the cognitive load is getting heavy). Also this config will make the `github.com` host use the main key, and the `work.github.com` host use the work key. So, when you want to clone a repository from the work account, you can use:

```bash
git clone git@work.github.com:username/repository.git
```

Voila! That is all. I'm looking forward to forgetting this, but at least I'll have this post. Or maybe I did this because of my very distasteful sense of humor... as always, who can tell.

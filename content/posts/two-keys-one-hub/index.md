+++
date = '2026-02-18T17:54:53Z'
draft = false
title = 'Two Keys One Hub'
+++

This is the most uninteresting post I created recently, but because I'm either the main character of Memento or a starfish, I have to write the chronicle of setting up multiple SSH keys for GitHub. I did this the third time, it's easy, still failed at first.

<!--more-->

The usual situation, which we may share, that we have a personal and another accounts related to an organization. (Or your personal account could be invited to an organization, which makes you look like a contribution-beast.) But we stay with the first scenario.

First, generate as many keys as you need, GitHub recommends using the `ed25519` algorithm, I do too:

```bash
ssh-keygen -t ed25519 -C "main-email@example.com" -f ~/.ssh/id_main
ssh-keygen -t ed25519 -C "work-email@example.com" -f ~/.ssh/id_work
```

Then add the public keys to the corresponding GitHub accounts in the settings. You can also add the private keys to the ssh-agent.

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_main
ssh-add ~/.ssh/id_work
```

This will make you type the passphrase every time, if that is undesirable, and believe me it is, you can add the keys to a keychain. That is different for different operating systems, so good luck! (On Linux `keychain` command will help and on MacOS `ssh-add` has a  `--apple-use-keychain` flag, but psst!)

All that remain is the ssh configuration, which will be presented here with an example in it's full glory:

```bash
```


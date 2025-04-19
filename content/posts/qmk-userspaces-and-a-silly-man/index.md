---
title: "QMK, Userspaces and a Silly Man"
date: 2025-04-19T05:34:28Z
draft: false
---

Last year, I had a "beautiful" experience programming my own [**QMK** layout for my keyboards](/posts/create-custom-keyboard-layout-with-qmk-for-no-reason/). I was really proud of myself, but shame was on its way...

<!--more-->

I started this overly dramatically, but there was one thing that I missed as a given feature. In **QMK**, there is a way to organize your keyboard and layout sources; this is called _userspace_. This means that you can have your own version under your user, which is conventionally a GitHub username.

This is something that I did understand, so compiling my keymap happens with the following command:

```bash
qmk compile -kb keychron/q8/iso_encoder -km hrvthzslt
```

`km` stands for keymap and `hrvthzslt` stands for me on GitHub.

This is nice, but the questionable part is how I created this _userspace_. You can fork the whole **QMK** repository to keep your changes, but I did not want the whole bonanza. So I created a repository with my custom sources, and I hardcore _"unixed"_ the problem. I symlinked my keymaps to the **QMK** firmware source and compiled that.

This works technically, but it was causing one very annoying little warning. Since this symlink causes changes in the **QMK** sources, which is a git repository, every update yells at me with a `QMK is ready to go, but minor problems were found` message. Yuck! ...And overall, it feels like a hacky solution among hacks.

When I was checking out the documentation, I found out that everything I tried to do is already available as a feature. I don't have to fork the whole firmware repository; I can create an external _userspace_ repository.

Credit to me: because of the symlinking method, I had already structured the files as needed, so my _userspace_-wide changes and custom _layouts_ were in the right place. The repository needed a `qmk.json` file, which contains information that helps the repository to be recognized as a _userspace_.

Configuring and adding the _userspaces_ looks like this:

```shell
qmk config user.overlay_dir=$(pwd)
qmk userspace-add -kb keychron/q8/iso_encoder -km hrvthzslt
qmk userspace-add -kb keychron/q11/iso_encoder -km hrvthzslt
```

Certainly looks better than triple the symlinks I had done. And no pesky warnings either.

And we have a **side adventure**! While checking out the example [repository](https://github.com/qmk/qmk_userspace), I found a **GitHub Action** that builds all the firmware in a _userspace_. That is really convenient, and creating binaries with automation is a good practice because distributing handmade ones can result in an [**xz** backdoor](https://en.wikipedia.org/wiki/XZ_Utils_backdoor).

So the **moral** of the story is: really read the friendly manual.

_(This post mentions "userspace" and "repository" eight-, "QMK" seven times —not including references and commands— and "symlink" four times. Maybe I'm not a writer. Interesting.)_

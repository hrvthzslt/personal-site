---
title: "Replicate My Developer Environment Like an Almost Modern Caveman"
date: 2023-10-01T11:58:51Z
draft: true
---

I am simple man, therefore I like simple solutions for simple problems. My problem was the replication of my developer environment. It is simple because I only care about the shell environment, I don't need an army of dotfiles or desktop applications to make my workflow viable.

## Installation.

I wanted to make this portable, which means it would work on Linux, MAC or even in WSL. If it's up to me I use the first, but life can bring surprises that you have to live with. Lucky for me there is a tool which makes this very easy.\
**Nix** itself is an OS, a home environment manager, a developer environment manager, a loving wife and the mother of your packages. There are three main benefits that it brings to the table: it's **Reproducible**, **Declarative** and **Reliable**.\
This is a perfect time to throw the baby with the bathwater and use it like _another_ package management tool just like a Cavemen. It's time to point it out that this is the "Almost Modern" part of this magnificent setup.\
But there are two reason for this: the systems I use are working in an _imperative_ manner so installing nix packages this way makes sense for me, the other reason is that I don't have enough experience for setting up a _declarative_ environment for myself and currently there is no need for it.\
Installing my packages in practice will look like this:

```shell
nix-env -iA nixpkgs.fzf\
    nixpkgs.ripgrep\
    nixpkgs.eza\
    nixpkgs.fd\
    nixpkgs.sd\
    ...
```

## Config management.

This is an another topic that has a tendency for needing sophisticated and well thought out solution. Spoiler: it won't get one.\
If I had a lot of configuration that I want differentiate between different environment and populate my credentials as well, I could use something like Ansible Playbook. I mostly use a shell function.

```shell
link_config() {
    rm -rf "$HOME"/.config/"$1"
    ln -s "$DOTFILES"/"$1" "$HOME"/.config/"$1"
}
```

The `DOTFILES` environment variable holds my path to the dotfiles repository which stores my, well dotfiles. You know what `HOME` is, don't lie to me!\
Most configurations are found in `~/.config/a-program-with-config` folder, I simply create symlink that point to that path. So I can call the method like:

```shell
link_config tmux
```

This creates a symlink between `/path/to/my/dotfiles/tmux` and `~/.config/tmux`. There exceptions to this path structure that I handle in my install script and yet I still live.

## The Result.

This two component is enough me to replicate my developer environment, or at least the things I find important. I only need my config files and an install script.\
I'm not trying to be ignorant on purpose, if this would scale badly in the future I would reconsider my approach, learn and prosper, but at the same time I really like **good enough** solutions.

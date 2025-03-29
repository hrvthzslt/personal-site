---
title: "Birth of a Minimalistic CLI Development Environment"
date: 2025-03-29T19:49:39Z
draft: false
---

Most of us have one or more automation to set up our machine and/or development environment. This solutions grow over time and with it the time to set up a new machine. But no more! Time has come to create a leaner solution because I don't want to wait 20 minutes. Period.

<!--more-->

## Origin Story

I have two huge projects that are responsible for automating my machine setup. One deals with the desktop environment and the other is my "dotfiles" which sets up everything I need for my professional and hobby development endeavors.

That contains setting up programming languages, like **PHP** (the best), **Python**, **Go**, **NodeJs** for javascript, and tools like **Docker**. And next to this it installs the **CLI** programs that I love to use like **Neovim** (which has it's own automated plugin setup), **Lazygit**, **Lazydocker**, **Lazyman** (one of this is made up) with the **nix** package manager. Speaking of **nix** of course the installation of it is automated as well, _and no I don't use nix home manager and I won't, leave me alone mother!_ And the top of the iceberg is that this whole setup in orchestrated with **Ansible**.

This sounds like a work of a mad man, which is. **But** it's very comfortable to maintain, and run.

I use this setup on my personal computer and the config files on my work computer. But when I want to interact with my home server or virtual machines, I don't need this much.

So I broke down the bare minimums I would need: **vim** for text editing, **tmux** for session management and automation with **shell** scripts (no **bash** mind you), which will be organized in a **Makefile**. And most importantly **NO FREAKING PLUGINS**!

If you work with a lot of remote machines I imagine you shrug your shoulder and roll with the defaults, I respect you, but I'm a web developer, so joke on me.

## Text Editing

## Session Management

## Automation

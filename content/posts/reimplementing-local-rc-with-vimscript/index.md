+++
date = '2026-05-17T18:00:38Z'
draft = false
title = 'Reimplementing Local RC With Vimscript'
+++

This title may seem strange, so let's break it down. **Reimplementing** means implementing again, **Local** means not remote, **RC** stands for "Run Commands", and **Vimscript** is something to look at if you want to blind yourself.

<!--more-->

Fabulous old **Vim** has an option called `exrc` (legacy alert!), which allows the execution of a configuration file that is located in the current directory. This is basically poor mans project-specific configuration. For a time I did not know that this option existed, I had some **Vimscript** do this dirty work for me: looking for a `.vimrc.local` file in the current directory and sourcing it.

So I happened to find out about `exrc` and I was ready to drop my silly little code until I inspected the situation. When `exrc` option is set a list of files is checked for existence and will be executed without any question or resistance. This is very similar to what I did, but further investigation led me to another option called `secure`. So big surprise: if you execute files willy-nilly, that is a security concern.

So what is `secure`?

> When on, ":autocmd", shell and write commands are not allowed in ".vimrc" and ".exrc" in the current directory and map commands are displayed. 
>
> -- <cite>VIM - Vi IMproved 9.1 (2024 Jan 02, compiled May 23 2025 00:48:59)</cite>

This poses at least some problems. Dude I may want to execute shell commands. There can be a version of **Vim** which has `exrc` but not `secure`. Also **Neovim** has these options but handles them with a trust mechanism, I want that!

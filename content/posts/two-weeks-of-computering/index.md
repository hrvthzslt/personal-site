+++
date = '2026-04-11T12:39:27Z'
draft = false
title = 'Two Weeks of Computering™'
+++

There is no one particular topic for today's heroic tale, but rather a collection of small things I did in the past two weeks. Some Neovim related, some QMK related, all _computering™_ related.

<!--more-->

## Vim Configuration File for Neovim

I am a quite big fan or **Termux** on Android (yes, even with the existence of an official virtualized Linux environment), and I use a frugal dev environment on it. I wanted to try **Neovim** on it, but with the already existing **Vim** configuration. Despite the possibility of handling **Neovim**'s configuration with **Lua**, it still supports the legacy **Vim** way. There is multiple way to handle this, `.vimrc` could be a symlink to `init.vim`, but I created a `init.vim` that sources the `.vimrc` file.

So the contents if `~/.config/nvim/init.vim` is:

```vim
if filereadable(expand("~/.vimrc"))
  source ~/.vimrc
endif
colorcheme retrobox
```

I mostly use **grep** and **ctags** for code navigation, linters and compilers as **makeprg**s, and formatters as external commands. All that works wonderfully in **Neovim** as well. Which is not surprising at all, but still cool.

## QMK Layouts Chores

A couple of months ago, I had to revise my **QMK** layout for my **Keychron K11**, because I was a dumdum and deleted/repurposed the default Win/Mac layers. Now I use a Mac as well, it became a problem. I handled this but I still had two other layouts to update. I thought this work is way beneath me, so I started to write a markdown file with the steps, planning to force agents to deal with this issue.

Then the magic happened, when I finished the markdown file, I realized that I can do the whole thing by hand from the top of my head. So I brew a coffee and spent a hour just editing the layouts. It could be argued that this was a waste of time, but it was chill as heck, and I still love to use computers, sue me. And personally for me, doing things by hand is still an important skill.

## I Should Sit on this Tree

The new release of **Neovim** (0.12) came, and I wanted to check, how my config holds up. Since 0.9, I never remake my configuration, I usually handle only errors and deprecation warnings. There is a reason for this, since 0.11, more and more features are being added, that makes a minimal setup more and more viable. So I want to wait out a release which will have mostly everything I need out of the box, and then I will rethink my configuration.

**Treesitter** is a programming language parser, it gives the ability to **Neovim** to understand the structure of the code, making syntax highlighting, indentation, code folding, blah blah blah, much better. There is a plugin which handles the integration, but it is rewritten and the new version is only compatible with **Neovim** 0.12.

The old version had the capability to automatically install parsers from a list, or when opening a file with a filetype that does not have a parser yet. Also it started automatically if there was a parser for the filetype. The new version does not have these features, and it won't because the maintainer got tired of maintaining. These changes made some people angry, for a time I just used the old version, but now I had to update.

I set up the treesitter plugin by the documentation, and added what I missed:

- `ts-install` plugin to install parsers
- added an autocommand to automatically start treesitter

For my surprise `treesitter-context` (showing method/class context at the top of the window) and `treesitter-textobjects` (text objects based on the syntax tree) still work without any changes.

Also my setup got a new tool in the form of `tree-sitter-cli`, which is a command line tool to manage parsers, and needed to be installed separately.

## Death by a Thousand Dependency

After this two weeks, the environment I work in can feel like something that made from a thousand pieces that can break at any moment. In the bright side it makes me mindful of what I'm using. My automation for setting up **QMK** needs to consider what version will compile with my layouts. Lockfiles needs to be kept for **Neovim** for plugins. These are self-inflicted problems by software developers to software developers. I could be sour about this, but I'm sweet.

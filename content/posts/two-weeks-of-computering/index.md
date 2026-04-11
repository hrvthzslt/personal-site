+++
date = '2026-04-11T12:39:27Z'
draft = false
title = 'Two Weeks of Computering™'
+++

There is no single topic for today's heroic tale, but rather a collection of small things I did over the past two weeks. Some are Neovim-related, some QMK-related, all _computering™_-related.

<!--more-->

## Vim Configuration File for Neovim

I am quite a big fan of **Termux** on Android (yes, even with the existence of an official virtualized Linux environment), and I use a frugal dev environment on it. I wanted to try **Neovim** with my existing **Vim** configuration. Although it's possible to configure **Neovim** with **Lua**, it still supports the legacy **Vim** approach. There are multiple ways to handle this: `.vimrc` could be a symlink to `init.vim`, but I created a separate `init.vim` that sources the `.vimrc` file.

The contents of `~/.config/nvim/init.vim` are:

```vim
if filereadable(expand("~/.vimrc"))
  source ~/.vimrc
endif
colorscheme retrobox
```

I mostly use **grep** and **ctags** for code navigation, linters and compilers as **makeprg**s, and formatters as external commands. All that works wonderfully in **Neovim** as well, which is not surprising at all, but still cool.

## QMK Layout Chores

A couple of months ago, I had to revise my **QMK** layout for my **Keychron K11**, because I was a dumdum and deleted/repurposed the default Win/Mac layers. Now that I use a Mac as well, it became a problem. I handled this, but I still had two other layouts to update. I thought this work was beneath me, so I started to write a markdown file with the steps, planning to force agents to deal with this issue.

Then the magic happened, when I finished the markdown file, I realized that I could do the whole thing by hand from the top of my head. So I brewed a coffee and spent an hour just editing the layouts. It could be argued that this was a waste of time, but it was chill as heck, and I still love to use computers, sue me. Personally, doing things by hand is still an important skill for me.

## I Should Sit on this Tree

When the new release of **Neovim** (0.12) came out, I wanted to check how my config held up. Since 0.9, I've never remade my configuration, I usually handle only errors and deprecation warnings. There's a reason for this: since 0.11, more and more features are being added that make a minimal setup more and more viable. So I want to wait for a release that has almost everything I need out of the box, and then I'll rethink my configuration.

**Treesitter** is a programming language parser, giving **Neovim** the ability to understand the structure of code, improving syntax highlighting, indentation, code folding, blah blah blah. There's a plugin that handles the integration, but it's been rewritten, and the new version is only compatible with **Neovim** 0.12.

The old version had the capability to automatically install parsers from a list, or when opening a file with a filetype that didn't yet have a parser. It also started automatically if there was a parser for the filetype. The new version does not have these features, and it won't, because the maintainer got tired of maintaining them. For a time I just used the old version, but now I had to update.

I set up the Treesitter plugin according to the documentation and added back what I missed:

- `ts-install` plugin to install parsers
- added an autocommand to automatically start treesitter

To my surprise, the treesitter-context (which shows method/class context at the top of the window) and treesitter-textobjects (which provides text objects based on the syntax tree) plugins still work without any changes.

My setup also got a new tool: `tree-sitter-cli`, a command-line utility to manage parsers, which needed to be installed separately.

Looking back at what I've done, it doesn't seem too complicated (and it isn't), but I did have to spend some time navigating waves of GitHub issues to gather context and figure out what to do.

...

Most of these problems were chores, self-inflicted problems by software developers for software developers. I could be sour about this, but I'm sweet.

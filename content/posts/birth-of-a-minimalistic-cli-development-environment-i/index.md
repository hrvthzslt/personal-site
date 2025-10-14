---
title: "Birth of a Minimalistic CLI Development Environment - Part I"
date: 2025-03-29T19:49:39Z
draft: false
---

Most of us have one or more automated processes to set up our machine and/or development environment. These solutions grow over time, and with them, the time required to set up a new machine. But no more! The time has come to create a leaner solution because I don't want to wait 20 minutes. Period.

<!--more-->

## Origin Story

I have two large projects responsible for automating my machine setup. One deals with the desktop environment, and the other is my "dotfiles," which set up everything I need for my professional and hobby development endeavors.

This includes setting up programming languages like **PHP** (the best), **Python**, **Go**, **NodeJs** for JavaScript, and tools like **Docker**. Additionally, it installs the **CLI** programs that I love to use, such as **Neovim** (which has its own automated plugin setup), **Lazygit**, **Lazydocker**, **Lazyman** (one of these is made up) with the **nix** package manager. Speaking of **nix**, of course, the installation of it is automated as well, _and no, I don't use nix home manager, and I won't, leave me alone, mother!_ And the tip of the iceberg is that this whole setup is orchestrated with **Ansible**.

This sounds like the work of a madman, which it is. **But** it's very comfortable to maintain and run.

I use this setup on my personal computer and the config files on my work computer. However, when I want to interact with my home server or virtual machines, I don't need this much.

So I broke down the bare minimums I would need: **vim** for text editing, **tmux** for session management, and automation with **shell** scripts (no **bash**, mind you), which will be organized in a **Makefile**. And most importantly, **NO PLUGINS**!

_If you work with a lot of remote machines, I imagine you shrug your shoulders and roll with the defaults. I respect you, but I'm a web developer, so joke's on me._

## Text Editing

So why don't I want to use plugins? Let's inspect an example: For getting language support in **Neovim**, I would install the language toolchain, a **Language Server**, and possibly some plugins for easier management. That's a lot of _stuff_ per language.

_I need to note that you **can** set up **Neovim** with a very minimalistic config, please read this [post](https://bread-man88.github.io/blog/programming/2025/03/14/simple-nvim-config.html), it's great._

For this setup, I chose to use **vim** without plugins to keep dependencies minimal. Here, I'll try to explain what I found important and how I solved it, without explaining the whole `.vimrc`.

### File navigation

For navigation, there is a built-in file explorer called **Netrw**. I set up shortcuts for four global marks to be created and used, which adds a "bookmark" functionality for easier navigation.

### File search

For this, I set up search to work from the working directory and search in subfolders. With this setting, when the `:find` command is used, it's a very similar experience to using a fuzzy finder tool. I also enable **wildmenu** and set it to appear as a vertical menu for scrolling through results. The vertical menu, called **pum**, has horrible base colors, so I change them, but I don't change anything else regarding the color scheme.

```vim
" Search subfolders
set path=$PWD/**

" Set wildmode
set wildmenu
set wildoptions=pum
set wildmode=longest:full,full
```

Looks like this in action:

![Vim pum](vim-pum.png)

### Code navigation

Without the help of **LSP**, navigation can be done with the built-in `tags` functionality and searching. For tagging, I use **universal ctags**. From its name, you can assume its origins and that it's expanded to multiple languages. That tool creates an index file with the following command:

```bash
ctags -R .
```

There is a **go to definition** functionality in vim already, but it works within a file by default. I created a method that jumps to a tag if there is one, otherwise, the original behavior applies.

```vim
function! GoToTagOrDefinition()
    try
        execute 'tag ' . expand('<cword>')
    catch
        execute 'normal! gd'
    endtry
endfunction
nnoremap gd :call GoToTagOrDefinition()<CR>
```

The other side of this coin is **go to reference**. This is done by searching for the word under the cursor and showing all results in a quick fix list.

```vim
nnoremap gr :grep! --exclude=tags --exclude-dir=.git -si "\<<cword>\>" . -r<CR>:copen<CR>
```

And the quickfix list looks fabulous:

![Vim quickfix](vim-quickfix.png)

### Code completion

This will also use the built-in method, which is the `CTRL` + `n` and `CTRL` + `p` key combinations. This will show the completion menu, and you can select the one you want. I changed the completion source order so the first priority is the current file, the second is the tags, and after that, all the others.

```vim
set completeopt=menuone,longest,preview
set complete=.,t,w,b,u
```

Here, I type "pr," and the first suggestion is from the current buffer, the second is from the tags, and the third is another buffer:

![Vim autocomplete](vim-comp.png)

This can be further improved with the usage of omni completion, but I have not explored that yet.

## Summary

These are the most important features for text editing, in my opinion, but I have to mention two things:

- This can scale poorly in large codebases since text-based search will result in a lot of false positives.
- The knowledge to do this comes from this great video: [How to Do 90% of What Plugins Do (With Just Vim)](https://www.youtube.com/watch?v=XA2WjJbmmoM).

Next time we'll check out, **session/screen management** and **automation**, the other two pillars of this holy trinity.

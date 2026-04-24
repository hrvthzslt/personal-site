+++
date = '2026-04-23T18:12:07Z'
draft = false
title = 'Modernizing Vim Without Plugins as a Liar'
+++

After the unbelievable chronicles of [Minimalist CLI Development Environment](/posts/birth-of-a-minimalistic-cli-development-environment-i), and the earth shattering writing about how to utilize the [Edit-Compile-Edit cycle](/posts/edit-compile-edit-cycle-in-classic-vim), one last mission remains: integrate some modern tooling for faster workflow. This is a tale of **fzf** and **ripgrep**.

<!--more-->

## Problem

The main commands in **Vim** for file and code navigation that I choose to use are `:find` and `:vimgrep`. `:find` is really really good, but it is slow if there are a lot of files in the project. You can offset that problem with creative usage of wildcards, and showing completion options at any time with `C-d`.

x=gif= file previews

`:vimgrep` is also slow. The reason why I like it is that it is available from Vim 7.0, that is the oldest version that I need compatibility with. Also it is independent from a system command, so the lack of a `grep` command or the fact that it has multiple implementations with different flags won't cause any problems.

So there is a general scaling issue, the bigger the project, the slower these commands will be. And this **Development Environment** is meant to be used in restricted environments, with modest performance, where these problems will be more pronounced.

## fzf the Stupid Way

First, what the heck is **fzf**?

> fzf is a general-purpose command-line fuzzy finder.
>
> -- junegunn

I hope this is enough context to understand. We are going to use it to search files and open them.

There is an elegant way to integrate **fzf** with Vim, I was concerned about portability so I solved the problem at first with some horrible Vimscript. I'm only sharing the important part.

And for the record, at this point, I'm not even ashamed that I did not come up with this. It runs a shell command which finds files excluding the `.git` directory, and then pipes the output to **fzf**. The result is written to a temporary file, which is read back into **Vim**, and then the first line is opened.

```vim
let l:tmp = tempname()
silent execute '!find . -type f -not -path "*/.git/*" | fzf > ' . shellescape(l:tmp)
redraw!
if !filereadable(l:tmp) | return | endif
let l:choice = readfile(l:tmp)
call delete(l:tmp)
if !empty(l:choice)
    execute 'edit' fnameescape(l:choice[0])
endif
```

This is only just a segment, for demonstrating that I was not really content with this solution. And it did break another compatibility, up until this time, this config was compatible with **Neovim** as well, and I was not up for figuring out how to fix that.

x=gif= fzf the stupid way

## fzf like a Normal Person

The really cool thing that **fzf** comes packaged with a vim plugin, so yes, you cannot trust me there is a plugin, but it is not handled by a plugin manager. It provides a command `:FZF`, I'm sure you can figure out its purpose.

There are still two things that need to be handled: Setting up a command for **fzf** to ignore the `.git` directory, and adding the plugin path to the `runtimepath`. That is path for runtime files, _the more you know_...

```vim
set rtp+=/usr/share/doc/fzf/examples,/opt/homebrew/opt/fzf
let $FZF_DEFAULT_COMMAND = 'find . -type f -not -path "*/.git/*"'

function! SearchFiles()
    if exists(':FZF') && g:modern_tools
        execute 'FZF'
    else
        call feedkeys(":find ", "n")
    endif
endfunction

nnoremap <leader>sf :call SearchFiles()<CR>
```

Let us digest this beautiful piece of code.

`rtp` stands for `runtimepath`, there are two paths, the first is the plugin path in Debian (and I guess on other distros as well), and the second is the plugin path for Homebrew on Mac (Silicon). I do not check their existence, life is unfair, grow up.

The `FZF_DEFAULT_COMMAND` environment variable is set to the same command we used in the previous section, but now it is used by the plugin, so we don't have to deal with temporary files and all that jazz.

The `SearchFiles` function checks if the `:FZF` command exists, and if the `modern_tools` variable is set to true. I introduced an additional variable to provide the ability to disable this whole craziness.

Finally, there is a keybinding, because in the end of the day, we want to press keys.

x=gif= fzf the normal way

## ripgrep

The wonderful thing about **ripgrep** is that you type `rg printf` and you get a list of all occurrences without having time to blink, and you should blink, it is good for your eyes.

I use it for searching for word under the cursor in selected file types and for general search, let's inspect the latter:

```vim
function! SearchInFiles()
    if executable('rg') && g:modern_tools
        set grepprg=rg\ --vimgrep\ --hidden\ --no-ignore\ -g\ '!tags'\ -g\ '!.git/**'
        set grepformat=%f:%l:%c:%m
        call feedkeys(":silent grep!  | redraw!\<C-Left>\<C-Left>\<Left>", "n")
    else
        call feedkeys(":vimgrep //g **\<Left>\<Left>\<Left>\<Left>\<Left>", "n")
    endif
endfunction
nnoremap <leader>sg :call SearchInFiles()<CR>
```

Looks like a lot, but hold on to your pants. If the `rg` executable is present on the system the glass is half full, for the second half we have the `modern_tools` variable again.

`grepprg` is the option for the grep program that will be used by the `:grep` Vim command which is by default the `grep -n` system command. Yes this is a sentence. Also the `grepformat` is set for compatible output parsing.

In the end, the `:grep` command will be typed and the cursor will be positioned and wait for our search term. The TUI falls apart after searches, so I added `redraw!` to fix that, and indeed it fixes that.

If the conditions are not met, similar story, but with `:vimgrep` and no fancy features.

x=gif= ripgrep

## Conclusion

So there you have it, modern tools in **Vim** without plugins and with use of a plugin. I am quite happy that I managed to integrate these tools while keeping the compatibility, good for me.

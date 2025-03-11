---
title: "Changing Between Window Managers Without a Display Manager"
date: 2025-03-11T15:48:17Z
draft: false
---

This is my **BTW** moment. I use **Debian** with **dwm**, without any desktop environment. I don't want to change, but if I want to experiment it can be annoying without a Display Manager.

<!--more-->

There is a good chance, that you live a well adjusted life and don't know what half of these words mean.

- **Window Manager**: The program that manages the windows on your screen. It's responsible for drawing the borders, moving the windows, etc.
- **Display Manager**: A very bad name for login screen.

Display Managers comes with a Desktop Environment. Speaking of which:

- **Desktop Environment**: A collection of programs that work together to provide a consistent user experience. It includes a Window Manager, a File Manager, a Panel, etc.

The main thing is that Display Managers have the capability to switch between Desktop Environments and Window Managers.

## How My Current Setup Works

I login on a _tty_, and if that is _tty1_, `startx` run automatically. This starts the X server, and runs the `~/.xinitrc` script. This script starts `dwm`. Then `dwm` starts the other programs that are needed for a functional graphical environment.

```
TTY1 -> X server -> dwm -> programs
```

The important thing to understand here is X server is started with one config which starts **a** Window Manager. If I want to change the Window Manager, I need to restart the X server with a different config.

## Handling Multiple Window Managers

One way is to have different configs for different Window Managers. For example, I can have `~/.xinitrc-dwm` and `~/.xinitrc-i3`. Then I can run `startx ~/.xinitrc-i3` to start `i3`.

I don't have a huge problem with this, but I still prefer to handle this in one configuration file, which keeps the standard `~/.xinitrc` file.

Since the contents of `~/.xinitrc` are just shell commands, I can use a shell `case` statement to select the Window Manager.

```sh
session=${1:-dwm}

case $session in
    dwm) exec dwm ;;
    i3) exec i3 ;;
    *) exec $1 ;;
esac
```

This way `startx` can be run without any arguments to start `dwm`, or with an argument to start another Window Manager, like `startx "$HOME"/.xinitrc i3` 

This is a really simple way to run different Window Managers in different tty's, if I want to experiment with them.

Thank you for reading this quickie, don't prepare for longer content!

---
title: "Make GNOME hella efficient"
date: 2024-07-14T12:42:37Z
draft: false
---

In only a couple of steps we can make GNOME an efficiency beast. Follow me on this short but sweet adventure.

<!--more-->

## The base GNOME experience

Let's start with the good news. GNOME wants to be your friend, and your spouse's friend, and your dog's friend. It wants to be everyone's friend. It is designed to be highly usable and accessible. It is fully usable with only one input device (keyboard, mouse, touch) or with all of them.

But I needed to be more efficient with the keyboard.

## Looking nice or moving fast?

The first thing I usually do when I use GNOME: I disable the animations. I know, they look good, but I use my computer as I would play a video game, I need that fast response time. (And I play video games like using a shitty computer, because I really like the Switch, I guess joke on me.)

In newer versions of GNOME, you can disable animations in the settings, or you can use `gsettings` like an old school hacker.

## Navigating windows

We're entering the tweaking with plugins territory. There are a couple of tools that is needed:

- `gnome-tweaks` - for advanced settings
- `gnome-shell-extensions` - for switching plugins on and off, you still have to install or build the plugins separately
- `gnome-shell-extension-manager` - for installing and managing plugins, it can replace `gnome-shell-extensions`

According to System76, the Pop!_OS developers, 40% of their users use tiling. For window navigation and management this is the way to go, at least for me. GNOME has some tiling like features, they are good, you can live with stock, but I don't want to.

I prefer autotiling, there is two plugins which can help with that.

- [Forge](https://github.com/forge-ext/forge) - you can install it trough the GNOME Extensions website.
- [Pop Shell](https://github.com/pop-os/shell) - you can install it by following their instructions, you have to build it yourself, but it's quite easy.

## Workspace management

By default `Super + number` shortcut is switching between the pinned applications on the dock. I do like this beahviour, but with tiling it is more useful to switch between workspaces. 

My ideal setup is using a finite number of workspaces, and I switch between them with `Super + number`. Luckily this can be achived by GNOMEs settings.

## Conclusion

So this is how I make myself moving faster than light in GNOME. Otherwise I use [dwm](/posts/the-many-lessons-of-building-dwm/) (by the way.)

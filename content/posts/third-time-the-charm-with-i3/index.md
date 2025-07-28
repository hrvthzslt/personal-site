+++
date = '2025-07-27T11:00:23Z'
draft = true
title = 'Third Time the Charm With i3'
+++

I had three topics in my mind that could have been worked out and presented here, but instead I created an **i3** config, to prove myself that I still love **dwm**.

<!--more-->

The _improved improved improved window manager_ always bugged me, I tried to fall for it two times already. As I mentioned I have one _true_ love among window managers, but I think now I understand **i3**.

There are some benefits to using **i3**, it's widely accessible, easy to configure, and has very good documentation. The one thing that is important to understand, that although, new windows are taking the most space in the screen, this is still a manual tiler. Instead of having a set layout, you manage it on the fly. And this is the most distinct feature of **i3**, and this is the one that I like the least. It's a usual practice to make **i3** an auto tiler, with scripts, but I did not want that route. I just want to use it as it's meant to by by design. And honestly I can use any kind of tiling, because usually I have one or two windows per workspace.

So as you can guess visually I did not change much, mostly kept the default colors, lessened the information on the **i3status** bar.

The most time consuming part was setting up the keybindings, because I already has a lot of expectations regarding that. I use `sxhkd` with **dwm**, but I made my i3 config more simple, so I said goodbye to it.

My intention is that this will be my fast and dirty graphical environment, when needed, so it is missing some features that I have in **dwm**. For example, there are keybindings for a clipboard manager, which I don't use in **i3**.

Another driving force was that the only **wayland** compositor that looks good to me and seems to be stable is **sway**, when I want to jump it would be easier to switch to it, if I already have a working **i3** config.

![i3](i3.png)

So fifteen years late to the party but here is my [config](https://github.com/hrvthzslt/i3-config).

+++
date = '2026-03-01T13:07:38Z'
draft = false
title = 'Calling a Truce With MacOS'
+++

Once, I used MacOS like any common person, but it had an Intel chip. Later, I wanted to use it as a kind of Linux cosplay, but it was restricted. After two unpleasant experiences, the third time brought the salvation this operating system needed in my eyes.

<!--more-->

We need to clear up two things. First, this post won't be a **MacOS** shaming campaign (at least not intentionally). Second, there is no way in hell that I would buy a computer at this price range (although changing hardware prices may result in a different opinion in the future).

## Personal History

I don't have a real personal history with **Apple computers**. Unlike the **Amiga** or **x86 PCs**, I only used my first MacBook when those machines were long forgotten and I was much older. This is a very complicated way to say I only had a MacBook from companies I worked for.

The first one was a MacBook Pro, of the last ones with an Intel chip. That is a great laptop if you like the sound profile of a helicopter in your room. (To be fair, this issue persists with current laptops as well. I'm looking at you, Dell Latitude. If the Earth were flat, I would place you in a latitude where you would fall to Hell.)

I used it like any other machine at the time: **IntelliJ** at full throttle, **Docker** on full cylinders, and a lot of Chrome tabs. It was loud, it was hot, but not attractive. At this point, my own computers rolled Windows like there was no tomorrow... And there really is none with that OS.

Then, after some time, I changed, some of the cells in my body were replaced, just like the primary operating system I used. I switched to **Linux** because the only thing I liked about **Windows** was **WSL** (I mean, in the end, I used to like Windows plenty some years ago).

I became a man of taste and needs, so when I got a new MacBook, the realization that you cannot fully turn off animations was devastating. And this is the central problem: I think **MacOS** has a horrible desktop environment. To fix this issue, my dear friend and colleague and I created a ticket to request a laptop with Ubuntu, and we got it. Now, that is what we call a life hack. (We got Dell Latitudes, so joke's on us.)

## Salvation

But then the third time came. I got a new job, with a new MacBook and new problems to solve. You could say these are self-inflicted wounds, which is fair, but at the same time, I (like everyone) needed to figure out how to use this machine productively.

Let's start with the great news. **MacOS** is a certified **Unix** operating system, and my workflow is mostly terminal-based. This is a great match, even though it feels like Apple tries to hide its Unix roots from the customers.

I made a decision to change as little as I could on the system, and this applied to CLI tools as well. I kept **zsh** just because it's the default, my config is very similar to how I use **bash**. But after a little time, I broke my decision and installed **GNU coreutils**, because I had compatibility issues with my scripts and configs. I chose **Homebrew** as a package manager because it can install graphical applications as well, and that is very handy for automation.

I still had to solve the problem of window management and navigation. I did not go on a _try every option_ world tour. I did my homework and found that **AeroSpace** would be the best fit for me. It handles window and workspace management and keybinding in one place in a non-intrusive manner, with one configuration file. It is very similar to **i3**, which is not the best (**dwm** has my heart), but it's really good. For workspace management, it has its own implementation: it places windows out of focus if they are not in the current workspace. This has a really interesting side effect: at least some pixels of the window have to be on screen, so those pixels are visible in the corner. Still, it's too easy to use to get hung up on this issue.

![MacOS Rice](mac_rice.png)

For software keyboard remapping, I use **Karabiner-Elements**. It's a great tool, but I don't really like it because it's more complicated to operate. One config file won't do the trick. I chose it because it was easy to port my existing **keyd** keymap, and I really did not understand **Kanata** at the time. (I'll be back.)

My physical keyboard with **QMK** should have worked if I had not removed the Mac layer in my custom layout. Now that **was** a self-inflicted wound! Don't worry, I fixed it, and I'm regenerating.

## Making Peace

Don't get me wrong, nothing beats the flexibility of a **Linux** distro. But I've reached the point where I can say that when a company gives me a very powerful machine, with a very impressive battery life, and a very good screen, I don't want to throw it into the Danube. The holy trinity of **CLI tooling**, **window management**, and **keyboard remapping** can save even a horrendously expensive computer.

And of course, the details of the workflow can be found in the [repository](https://github.com/hrvthzslt/mac-conf). Happy _computering™_!

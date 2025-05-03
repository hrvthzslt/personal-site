---
title: "Power Management Adventures of Linux Desktop"
date: 2025-05-01T15:12:48Z
draft: false
---

If you are a normal well balanced person, you possibly install a distro with a desktop environment, and when you want to change your power settings you search for the menu and just do it. In this part of the world this is not how we do things, sorry.

I did archived [what I lost when I changed for a **window manager**](/posts/the-many-lessons-of-building-dwm/) and [how did I create a new status bar with **dwmblocks**](/posts/replace-slstatus-with-dwmblocks-while-contemplating-performance/). Now the time has come to implement a power management feature.

<!--more-->

## Power!

For some time I managed cpu fequency by setting the desired **governor** manually, such as `performance` or `powersave`.

```shell
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
```

I'm not an animal, I did not type this command all the time, I used a script that collects the available governors and the could be selected from a list with the beloved **fzf** command line tool.

I did not have any problems per se, but another topic came into my attention.

## Battery!

I found another tool called **tlp**, which optimizes laptop battery life automatically. It uses two profiles, **ac** and **bat** (I'll let you find out what they mean). And it does cool stuffs like changing cpu power when there is no work done. And it can be configures which **governor** should be used with said profiles. Aaand it optimizes power consumption of other devices as well. It is neat!

It's really easy to set up and it has great [documentation](https://linrunner.de/tlp/index.html).

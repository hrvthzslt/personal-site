+++
date = '2026-09-19T15:04:15Z'
draft = false
title = 'Changing Brightness of External Monitors on Linux'
+++

Somebody wants to rule the world and somebody wants to change the brightness of external monitors without touching said monitor's buttons. The second somebody is me.

<!--more-->

For a couple of months, I've used a [MacBook which, to my utmost surprise, was a delight](/posts/calling-a-truce-with-macos). While fine-tuning my experience with that machine, I found a piece of software called **MonitorControl**, and it does what it says. Most importantly, it gives me the ability to change the brightness of the focused external monitor by using the designated keys on the keyboard. By default, those keys only control the built-in display, what a shame.

![Shame](shame.png)

Like every sane person, I use a ThinkPad with Linux, and I set up the desktop experience with my own automation instead of using a desktop environment. [See this example.](/posts/power-management-adventures-on-the-linux-desktop)

Short story long: The control of the internal display brightness setting is already duct-taped together with the associated tool and a hotkey daemon. This means I had to bind a command to the "brightness up" and "brightness down" keys which calls `brightnessctl` with the appropriate arguments, and that changes the internal display's brightness. The aforementioned commands are handled by `sxhkd`, whose configuration binds the keys and the command calls together.

```text
XF86MonBrightnessUp
    brightnessctl set 5%+

XF86MonBrightnessDown
    brightnessctl set 5%-
```

I'm sure this is information you did not need, but buckle up, because we need more than a simple command.

The external monitor can be controlled with a tool called `ddcutil`, which is a command line utility that can read and change the settings of monitors that support **DDC/CI**, which is the **Display Data Channel/Command Interface**, I just learned that, very nice.

Instead of the `brightnessctl` command, `sxhkd` will call a script that increments or decrements the brightness of the external **and** internal monitor by 5% at the same time. This is not the most elegant solution, changing only the focused display would be better, but I usually use one display at a time and this way the script remains simple.

```bash
change_brightness() {
  # Internal display
  brightnessctl set 5%"$1"

  # External displays
  displays=$(ddcutil detect 2>/dev/null | awk '/^Display/ {print $2}')

  for disp in $displays; do
    ddcutil --display "$disp" setvcp 10 "$1" 5
  done
}
```

Failures are ignored, baby, baby it's a wild world. Call it like this:

```bash
change_brightness +
```

Calling this a satisfactory solution would be an overstatement: the protocol is quite slow, so the experience is not smooth. But this is still much better than touching my monitor twice a day like a crazy lover. Also, brightness keys are mapped to the rotary encoder on my keyboard, so I can feel like a space ship pilot. I do like that.

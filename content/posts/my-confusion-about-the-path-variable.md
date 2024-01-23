---
title: "My Confusion About the Path Variable"
date: 2024-01-23T20:35:18Z
draft: false
---

This is a topic which I should have understood a long time ago but I never really thought about it until I printed out my PATH variables. The horror or the output made me realize that I am on an unholy path, meaning there were several duplicated entries.

The reason for this is I exported the PATH variable in my `.bashrc` file. The rc file is read every time when a new terminal session is started, so the additional PATH values will be appended every time.

The proper place for PATH variables would be the `.profile` file (there are other options depending on the interactive shell, for example `.bash_profile` and `.bash_login`). This file is read only once when the user logs in.

For clarification, the order and the precedence of the files are the following in my case:
- `/bin/bash` - shell executable
- `/etc/profile` - system wide, executed for login shell
- `~/.profile` - personal, executed for login shell
- `~/.bashrc` - personal, executed for interactive non-login shell

But there is a catch. I use `.bashrc` because its portable, but I did not wanted to do the same with `.profile` because that will be written by the OS. (And I don't want to maintain a shell specific profile file like `.bash_profile`).

Time for a good old **compromise**. With the help of some bashism (provided by interweb surfing) I remove the value before I add it.

```bash
# method for removing a path from the PATH variable
pathremove() {
  PATH=${PATH//:"$1:"/:}
  PATH=${PATH/#"$1:"/}
  PATH=${PATH/%":$1"/}
}
export pathremove

# method for adding a path to the PATH variable
pathprepend() {
  for arg in "$@"; do
    pathremove "$arg"
    export PATH="$arg${PATH:+":${PATH}"}"
  done
}
export pathprepend

# Adding local bin and personal scripts to the PATH variable
pathprepend \
  "$HOME/.local/bin/toolbox" \
  "$HOME/.local/bin"
```

Following this logic I can prioritize my own paths over the system paths. This is a good way to keep the PATH variable clean and tidy, even if it means this has to run every time I start a new session.

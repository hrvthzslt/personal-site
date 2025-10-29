+++
date = '2025-10-29T15:14:40Z'
draft = false
title = 'The War Against Shell File Extensions'
+++

I see what you did there, you created a file called `script.sh`. Why do you have to be like this? How can we wash off this shame?

<!--more-->

## Pedantic Explanation

Extensions don't matter. Executable files are recognized by the **executable file permission bit** (`x`) and, for compiled binaries, by the **ELF** header. Scripts use an **interpreter** defined in the **shebang** line (`#!`). There are a lot of terms here, and you have no way to know how much I truly understand them, so you might say: "It's just for providing context in the file name."

But I have a more pedantic answer. Let's say you name your script `script.sh`, but the shebang is:

```bash
#!/usr/bin/env bash
```

The interpreter is not **sh**, and with this **shebang**, we can't even be sure that it's really **bash**.

Moreover, the interpreter may not even be what it seems:

```bash
$ ls -la /usr/bin/sh
lrwxrwxrwx 1 root root 4 Feb  4  2025 /usr/bin/sh -> dash
```

For example, in the Debian 13 installation that I use, **sh** is symlinked to **dash**, which is a POSIX-compliant shell just like **sh**. So should the script be called `script.dash`? On another system, it might use a different interpreter.

## Silver Lining

So a lot of _pedanticims_ happened here, but I have a guide on how to use shell script extensions if you really want to be a baby.

If it's a POSIX-compliant script, you can use `.sh`. If it's for a specific shell, use that shell's extension, for example, `.bash`. But the important thing is: **never use extensions if it's a command that will be available system-wide**.

## Less Pedantic Explanation

So let's say I have a rare condition that causes a love for creating **sha1** hashes from text, so I create a script called `hshr`:

```bash
#!/usr/bin/env bash

main() {
  if [ -z "$1" ]; then
    echo "No argument provided."
    exit 1
  fi
  echo -n "$1" | sha1sum | awk '{print $1}'
}

main "$1"
```

Maybe I want it to be accessible throughout the whole system, so I symlink it to the appropriate path. Then I can run it just like any other command.

```bash
$ sudo ln -sf "$PWD"/hshr /usr/local/bin/hshr
$ hshr "example text"
d9e989f651cdd269d7f9bb8a215d024d8d283688
```

You're still not convinced.

One day I realize that I want to rewrite this in C, so I whip up method like this, which will be called with the first argument which is the text, and will print out the **sha1** hash:

```c
void sha1(char *s)
{
    unsigned char hash[SHA_DIGEST_LENGTH];
    SHA1((unsigned char *)s, strlen(s), hash);

    for (int i = 0; i < SHA_DIGEST_LENGTH; i++) {
        printf("%02x", hash[i]);
    }

    printf("\n");
}
```

I build it and create a symlink to the same place, and try it out again:

```bash
$ gcc -o hshr hshr.c -lcrypto
$ sudo ln -sf "$PWD"/hshr /usr/local/bin/hshr
$ hshr "example text"
d9e989f651cdd269d7f9bb8a215d024d8d283688
```

The command implementation has been completely switched, but the command output and usage remain the same. _Voilà, this is my point._

I rest my case, dear jury. Please protect your ears while the mic hits the floor.

Then, while I’m enjoying my well-earned victory, you step up to me and whisper in my ear: _"Technically, it's enough to not use the extension in the symlink target."_

![Reverse Uno](reverse.png)

+++
date = '2025-11-16T12:29:41Z'
draft = false
title = 'One Polymorphic Executable, Multiple Commands'
+++

Let me present you a very interesting concept: shipping a single executable that will gift the system multiple commands. We are going to UNIX this topic very much!

<!--more-->

## Inspiration

Of course, I met this concept in a [video](https://www.youtube.com/watch?v=dv6NP7qjMS0), which explains it, and shows the most famous example: **BusyBox**. It is a single binary that provides **POSIX** commands like `ls`, `cp`, `mv`, `gg` (one is not real) etc. It has two advantages:

- It has low footprint.
- If it is used on Linux, you don't have to call it GNU/Linux.

I was quite happy because I already know Mr. Non-Idle Square-Body from **Alpine Linux**, the OS for embedded systems, containers and frugal people.

The most sensible reaction after getting inspired, to create something like this. Since I'm learning the one and holy **C** programming language, this was the perfect opportunity.

## Mechanism

How this is coming to fruition is very simple, and only needs two things.

In the source code, we have to check, what is the name that the program was called with. In **C**, and in other languages as well, this means inspecting the zeroth argument. But that begs the question, how can one executable have multiple names, and of course with **symlinks**!

In the case of **BusyBox**, the executable is called `busybox`, and there is symlink for every utility it provides.

```bash
mv -> /bin/busybox
netstat -> /bin/busybox
nice -> /bin/busybox
pidof -> /bin/busybox
ping -> /bin/busybox
```

## SysPerc

With all this knowledge, I started to build my own polymorphic executable, called **SysPerc**. It is supposed to provide system information in percentages, like CPU usage, memory usage, general mood and so on.

Two example of a command call that it provides:

```bash
batp -r
memp -r
```

This two command will yield the battery percentage and memory usage percentage, respectively, as a rounded number.

The simplifed source of deciding which command to run is the following:

```c
int main(int argc, char *argv[])
{
    Options options = get_options(argc, argv);
    return bus(argv[0], options, argc, argv);
}

int bus(char *command, Options options, int argc, char *argv[])
{
    if (!strcmp(command, "memp")) {
        return memp(options);
    } else if (!strcmp(command, "batp")) {
        return batp(argc, argv, options);
    }

    fprintf(stderr, "Unknown command in sysperc executeable: %s\n", command);
    return EXIT_FAILURE;
}
```

Yes, this is is a "command bus", you cannot stop me! And there is nothing in the world that a condition cannot solve.

You as a very perceptive reader may have noticed, that the commands used the same options. Since we have one source, option parsing is also unified. Since options are affecting printing out results, that is unified as well.

This was the most fun in recent time I had with my mini projects. For more explanation, you check my attempt at **C** programming: [SysPerc](https://github.com/hrvthzslt/sysperc).

And as always, keep _computering™_!

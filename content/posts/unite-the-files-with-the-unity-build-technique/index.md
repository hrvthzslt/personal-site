+++
date = '2025-12-27T20:12:07Z'
draft = false
title = 'Unite the Files With the Unity Build Technique'
+++

Since I don't really know how to program in C and I only have one small pet project, I'm the perfect candidate to preach about build methods. Saving those microseconds will go a long way!

<!--more-->

## Propeller-Head Build Method

The current (and possibly remaining) build method, for my [project](/posts/one-polymorphic-executable-multiple-commands/) is as follows:

```make
build:
    gcc -Wall -Wextra -c src/sysperc.c -o build/sysperc.o
    gcc -Wall -Wextra -c src/modules/common.c -o build/modules/common.o
    gcc -Wall -Wextra -c src/modules/cpu.c -o build/modules/cpu.o
    gcc -Wall -Wextra -c src/modules/memory.c -o build/modules/memory.o
    gcc -Wall -Wextra -c src/modules/disk.c -o build/modules/disk.o
    gcc -Wall -Wextra -c src/modules/battery.c -o build/modules/battery.o
    gcc build/*.o build/modules/*.o -o sysperc -lm
    chmod +x sysperc
```

This is a lot of steps for a small program, so what is happening here? The source files are being compiled one by on into object files. Object files are machine code files that are not yet linked together. Finally, all the object files are linked together into a single executable file.

The main reason why I did this that I read this in the book I learn C from, but besides my fanaticism there are some advantages to this method:

The object files can be disassembled and inspected individually, which means we can see the machine instructions generated for each source file.

```bash
$ objdump -da build/modules/common.o

build/modules/common.o:     file format elf64-x86-64
build/modules/common.o


Disassembly of section .text:

0000000000000000 <print_output>:
   0:	55                   	push   %rbp
   1:	48 89 e5             	mov    %rsp,%rbp
   4:	48 83 ec 30          	sub    $0x30,%rsp
   8:	f2 0f 11 45 e8       	movsd  %xmm0,-0x18(%rbp)
   d:	48 89 fa             	mov    %rdi,%rdx
...
```

Another advantage is that we could have different builds for different implementations of a module. For example, the current implementation only can work with Linux, but we could have BSD-specific modules that could be swapped in during the build process. And the expectations for the modules are already defined in header files.

The build takes `0.254s`, which is almost nothing, but lets try to make it faster anyway. The bottleneck in these build steps are the repeated invocations of the compiler, which means we are facing process and I/O overhead. (I mean we would if this project would have more lines than 278...)

## Unity Build Method

Unity builds are a technique where all source files are included into a single source file, like one big happy family. This is usually done by creating a separate source file that includes **EVERYONE**!

![everyone!](everyone.png)

```c
#include "src/modules/battery.c"
#include "src/modules/common.c"
#include "src/modules/cpu.c"
...
```

That's the whole file: only includes. One problem that it is poses that the header files will be included multiple times, which will cause redefinition errors. Fortunately include guards are coming to rescue us! It can be done by checking a macros existence and defining it if it's non-existent. We can use the `#ifndef` keyword, which sound like an IKEA furniture so that's a plus. (Also we could use `#pragma once`, which is more modern and possibly faster, but I had no joke for it.) I'm pretty sure it can cause other issues as well, but I did not face them demons.

From the compilers' perspective, this source file is virtually the same as having one huge file with all the source code, so we can compile it in one go:

```bash
$ time gcc -Wall -Wextra everyone.c -o sysperc -lm
real	0m0.121s
```

Look at that speed, it tore my eyes out! For a small project it does not look much, but here is an [example for building Inkscape](https://hereket.com/posts/cpp-unity-compile-inkscape/), which goes from thirty minutes to about three.

But don't throw out the build steps with the bathwater, we lost some modularity, but we gained speed. And in fact we can keep _some_ modularity by having multiple unity files, for different platforms or different parts of the project. In the end for my project I won't change the build method, but it was fun to experiment.

The irony of it all if I would never learned about how to build with a C compiler, I would have automatically just include everything in the file where the entry point is defines. Maybe that makes me a genius or maybe stupid, who can tell.

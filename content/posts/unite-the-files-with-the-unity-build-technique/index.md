+++
date = '2025-12-27T20:12:07Z'
draft = false
title = 'Unite the Files With the Unity Build Technique'
+++

Since I don’t really know how to program in C and I only have one small pet project, I’m the perfect candidate to preach about build methods. Saving those microseconds will go a long way!

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

That’s a lot of steps for a small program, so what is happening here? The source files are being compiled one by one into object files. Object files are machine code files that are not yet linked together. Finally, all the object files are linked into a single executable, which can be executed without a trial.

The main reason I did this is that I read about it in the book I learned C from, but besides my fanaticism, there are some advantages to this method:

The object files can be disassembled and inspected individually, so we can see the machine instructions generated for each source file.

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

Another advantage is that we could have different builds for different implementations of a module. For example, the current implementation only works on Linux, we could make a BSD specific build compiling other modules. All the expectations for the modules are already defined in header files, it only needs implementations. (This is big boy programming!)

The build takes `0.254s`, which is almost nothing, but let’s try to make it even faster. The bottleneck in these steps are the repeated invocations of the compiler, causing process and I/O overhead. (Well, we would have that if this project had more than 278 lines of code…)

## Unity Build Method

Unity builds are a technique where all source files are included in a single source file, like one big happy family. This is usually done by creating a separate source file that includes **EVERYONE**!

![everyone!](everyone.png)

```c
#include "src/modules/battery.c"
#include "src/modules/common.c"
#include "src/modules/cpu.c"
...
```

That’s the whole file: only includes. One problem is that the header files will be included multiple times, which causes redefinition errors. Fortunately, include guards come to the rescue! This can be handled by checking whether a macro exists and defining it if it’s not present. We can use the `#ifndef` keyword, which sounds like an IKEA furniture, so that’s a plus. (We could also use `#pragma once`, which is more modern and possibly faster, but I have no joke for it.) I’m pretty sure this can cause other issues as well, but I haven’t faced those demons.

From the compiler’s perspective, this source file is virtually the same as having one huge file with all the source code, so we can compile it in one go:

```bash
$ time gcc -Wall -Wextra everyone.c -o sysperc -lm
real	0m0.121s
```

Look at that speed, it tore my eyes out! For a small project it doesn’t look like much, but here is an [example for building Inkscape](https://hereket.com/posts/cpp-unity-compile-inkscape/), which goes from thirty minutes to about three.

But don’t throw out the build steps with the bathwater, we lost some modularity. In fact, we can keep _some_ modularity by having multiple unity files for different platforms or different parts of the project. In the end, for my project I won’t change the build method, but it was fun to experiment.

The irony of it all is that if I’d never learned about how to build with a C compiler, I would have automatically just included everything in the file where the entry point is defined. Maybe that makes me a genius, or maybe stupid, who can tell.

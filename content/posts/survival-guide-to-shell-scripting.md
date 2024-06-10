---
title: "Survival Guide to Shell Scripting"
date: 2024-02-29T15:22:06Z
draft: false
---

Let me present you the (I don't know how many, because I'm still writing this) points to survive in the world of shell scripting.

<!--more-->

## 1. Shhhh...

If you're new to shell scripting, and did not script any bash, you should consider not to do it, at least for a while. Bash has many wonderful advanced techniques, but it's also an advanced experience to read it.

Use that `#!/bin/sh` shbang, and write your scripts in "**P**ortable **O**perating **S**ystem **I**nterface for uni**X**" shell. This is what you should learn first, and it will give you the most portable scripts.

## 2. Use ShellCheck

I like to make fun of _ShellCheck_, with it's not-so-verbose output and identifiers like SC1234, but it's a great tool.

**It's a great tool**, for learning and for security as well. When you write shell scripts, you're automating your whole system with text manipulation. You should be careful.

## 3. Use shfmt if you're lazy to format your scripts

As the title says, just do it.

**Pro tip**: If you are a dork and want to follow the [Google Style Guide](https://google.github.io/styleguide/shellguide.html), call it like:

```shell
shfmt -i 2 -ci
```

## 2. and 3. addendum

You can use _bashls_ if you need a fully functional language server for a shell scripting language.

You can use ShellCheck and _shfmt_ in your CI/CD pipelines, and you maybe you should.

You can read the last point hoping you will learn something, but you won't.

## 4. or 5. The nitpick

Do not use `#!/usr/bin/env sh`.

You do not need an additional process for calling `sh`. Use `#!/bin/sh` instead. If you're `sh` executable is in some other path, you're not reading this guide.

From a security standpoint, you should always know which exact interpreter you're using.

---

As I predicted, you're not learning shell scripting from this 4 or 5 points, but now you can start learning it. Good luck!

---
title: "minimalist Note management"
date: 2023-11-10T14:41:49Z
draft: true
---

I was an Obsidian user for some time and I still really like it, but it was too much for my needs.
There is only two function I need:

- Creating a note to a destination
- Searching in notes

And do this with markdown files, because there is nothing better on Earth if you are not a print editor.

## Markdown

At primary school we was hard into editing Word documents, and the main dogma of this process was the following: Children, first type the raw text than format it!\
This causes two problems, the context of the text is only changeable in the dedicated editor. And this not scale at all, changing the formatted text with raw text and formatting it again is just a nuance.

The reason I love markdown is that the text and its context in one place, and rendering it is decoupled from the file itself. You can render it as **html**, convert it into **pdf**, or just use a viewer/editor you like, but the most important you can edit it with any editor that can open a text file.

I kept the most important reason last: **It is dead simple** (like me).

## Note management

So I technically can provide myself the two functionalities with gnu tools in the cli like a _komputer scientist_, and I did that but this needed to be more convenient, So I made a (accidentally) hundred line **shell script** solving this "problem".

[![asciicast](https://asciinema.org/a/UciUDOINZTiRMLnESDB96gByr.svg)](https://asciinema.org/a/UciUDOINZTiRMLnESDB96gByr)

If you want to check it out I won't stop you: [https://github.com/hrvthzslt/mnm](https://github.com/hrvthzslt/mnm)

You find all the information that you would need about it's usage.

## Go to Shell

The more important thing is I did this because I wanted to do some good old **POSIX** complaint shell scripting like the cool kids (or like not cool old people, same thing). I choose shell because it has the most universal compatibility, then I used **fzf** and **rg** so I made requirements that won't be available in all machines. Did I made a mistake? I don't know, I don't care writing shell script this way was fun enough on itself.

The primary knowledge source I used is: [https://www.shellscript.sh/](www.shellscript.sh), it's a beautiful site I highly recommend it if you're interested in this topic.

And my mentor was [https://www.shellcheck.net/](shellcheck) a static analysis tool for (prepare yourself) shell scripts. It throws you error codes similar to `SC2086` like there is no tomorrow, it's a really great time, as long as you like to suffer. Most of the time I had to check the wiki to understand what is the problem, at least it has really good examples.

## You shall not pass

Since a made a serious software It needs a serious pipeline. Yes you guessed it, I made a github action for one sh file.

It runs shellcheck which is great, that is a neat protection, but there are more important concerns...

If you recall I said this script turned out to be one hundred line long, so:

```shell
[ $(wc -l < mnm.sh) -eq 100 ] && exit 0 || exit 1
```

## PS

Oh and I used `act` for testing github actions locally, it's one of the greatest tools in the world, you're welcome!

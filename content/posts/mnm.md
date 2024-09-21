---
title: "minimalist Note management"
date: 2023-11-10T14:41:49Z
draft: false
---

I was an Obsidian user for some time and I still dig it, but it was too much for my needs. Additionally, the fact that it's a GUI program did not jive well with my desire to move my workflow to the mighty Command Line.

<!--more-->

There are only two functionalities I need:

- Creating a note at a destination
- Searching in notes

And do this with markdown files because there is nothing better on Earth if you are not a print editor.

## Markdown

At primary school, we were hard into editing Word documents, and the main dogma of this process was the following: Children, first type the raw text, then format it!

This causes two problems: the context of the text is only changeable in the dedicated editor. Changing the formatted text with raw text and formatting it again is just a nuisance.

The reason I love markdown is that the text and its context are in one place, and rendering it is decoupled from the file itself. You can render it as **html**, convert it into **pdf**, or just use a viewer/editor you like, but most importantly, you can edit it with any editor that can open a text file.

I kept the most important reason for last: **It is dead simple** (like me).

## Note management

So I technically can provide myself with the two functionalities using GNU utilities in the CLI like a _komputer scientist_, and I did that, but this needed to be more convenient. So I made an (accidentally) hundred-line **shell script** solving this "problem".

[![asciicast](https://asciinema.org/a/UciUDOINZTiRMLnESDB96gByr.svg)](https://asciinema.org/a/UciUDOINZTiRMLnESDB96gByr)

If you want to check it out I won't stop you: [https://github.com/hrvthzslt/mnm](https://github.com/hrvthzslt/mnm)

You will find all the information that you need about its usage.

## Go to Shell

The more important thing is I did this because I wanted to do some good old **POSIX** compliant shell scripting like the cool kids (or like not cool old people, same thing). I chose shell because it has the most universal compatibility. Then I used **fzf** and **rg**, so I made requirements that won't be available on all machines; they are not core utils... Did I make a mistake? Yes.

The primary knowledge source I used is: [https://www.shellscript.sh/](www.shellscript.sh). It's a beautiful site; I highly recommend it if you're interested in this topic.

And my mentor was [https://www.shellcheck.net/](shellcheck), a static analysis tool for (prepare yourself) shell scripts. It throws you error codes similar to `SC2086` like there is no tomorrow. It's a really great time, as long as you like to suffer. Most of the time, I had to check the wiki to understand what the problem was. At least it has really good examples.

## You shall not pass

Since I made a serious software, it needs a serious pipeline. Yes, you guessed it, I made a GitHub action for one sh file.

It runs shellcheck, which is great; that is a neat protection, but there are more important concerns...

If you recall, I said this script turned out to be one hundred lines long, so:

```shell
[ $(wc -l < mnm.sh) -eq 100 ] && exit 0 || exit 1
```

Oh, and I used `act` for testing GitHub actions locally. It's one of the greatest tools in the world. You're welcome!

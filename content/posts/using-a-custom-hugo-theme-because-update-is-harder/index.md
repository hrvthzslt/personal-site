+++
date = '2025-07-10T14:28:56Z'
draft = true
title = 'Using a Custom Hugo Theme Because Update Is Harder'
+++

About every six months, it occurs to me to update the **HUGO** version which breaths life to this site. I thought it was upgraded, but I was very, very wrong. So I started to do the work, got fed up with it, and solved this issue with some more work.

<!--more-->

## Local Environment

Until now I used a docker image from dockerhub for running **HUGO** locally, I checked if there is a new version, and updated it. The deployment is handled by **Netlify** for that I define the **HUGO** version in a config file. All works all nice.

But a couple of days ago I realized that the latest tag of the docker image was older then a year. So I checked out what should be really the current **HUGO** version and I was lagging behind.

## Let's Update

This should not be a problem, I searched for a new docker image with new **HUGO** version. Spin it up locally, and of course it does not work.

I was using a theme (a really nice one) which was made by someone else, it was living in a git submodule ...don't worry this is normal. I also had some layout changes by me, but that should be alright, handling that is a feature of **HUGO**.

So I updated the submodule as well, and template rendering still fails. I fix my custom layouts because they were offenders for sure, aaand it still does not work. And after having the best twenty minutes of my life, swimming in github issues, I said:

![this cannot continue](nier-automata-this-cannout-continue.gif)

## Time for a Change

I decided I will get rid of these pesky dependencies. They will always break! They are the apocalyptic horsemen of modern software development!!! Why cannot be everything **one binary** running on **DOS**!?

I had a lot ideas what to do:

- Create a static site by hand
- Create my own static site generator with **go**
- Create my own static site generator with and server with **shell**
- Try out **11ty**
- Create a new **HUGO** site with a custom theme

For not my fun but my luck, I started with the last option. This was quite a good idea because, I do like **HUGO** and it was much easier than I anticipated.

```shell
hugo new site homepage
hugo new theme hometheme
```

And it's done, this produces a functional site. I had to do some configuration on the page and theme and migrate the content (which means copying files in that case) but that's all, one _dependency_ gone.

Now it would be nice to run it, so time for get rid of my other _dependency_ and create my own `Dockerfile`.

```Dockerfile
FROM debian:bookworm

RUN apt-get update && apt-get -y install wget

RUN wget -O /tmp/hugo.deb https://github.com/gohugoio/hugo/releases/download/v0.147.9/hugo_0.147.9_linux-amd64.deb \
    && apt install -y ./tmp/hugo.deb

WORKDIR /homepage

EXPOSE 1313

CMD ["hugo", "server", "--buildDrafts", "--buildFuture", "--bind", "0.0.0.0"]
```

You can judge me, but this is basically how you install **HUGO** by the documentation. Added some commands in a **Makefile** for easier management, and it's done. Next time I need to update, I only need to change this image and the deployment configuration.

## Theme

I tried to introduce only little changes to the default theme, I made some arrangements in the header and footer, and added pagination, nothing too complicated. I expect easier compatibility issue-resolution in the future because of it.

But the default styling of the css looked like this:

![default theme](default.png)

Honestly, I don't think this is bad at all, but I have a soft spot for classless **css**, so I wanted check out some ready to use ones. Now you can scream at me that it's another _dependency_, but in reality it will be one file frozen in time, never updated. And the last time I did work with **css** `flexbox` was a hot new thing...

So there are three classless css stuff (i don't want to call them a framework), I really like, and it's not a trade secret: [Pico](https://picocss.com/), [Simple.css](https://simplecss.org/) and [sakura](https://oxal.org/projects/sakura/).

The first one is really well rounded, but I liked the second one more, but the third one is the most elegant, so I used the second one with the third ones colors. I hope you could follow.



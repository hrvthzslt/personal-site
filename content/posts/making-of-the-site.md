---
title: "Making of the site"
date: 2023-02-11T12:01:37Z
draft: false
---

I had a resume site with the content of the [resume](/resume/) page. I built a simple HTML site with the help of
[materializecss](https://materializecss.com/) and hosted it on Heroku.

I was happy with it, but it soon became a pain to edit. So when Heroku stopped hosting my site for free, I decided to
make a new one. I wanted to make one that is easier to edit and maintain. I also wanted to learn a bit
about [Hugo](https://gohugo.io/), so I decided to make this site with it.

<!--more-->

The ability to edit the content in markdown was really important for me, but it's a topic for another day.

## So what did I do?

Well, I tried to port my whole static site to Hugo, which almost came to fruition, and I learned a lot about the
structure of a Hugo project. But since I used a CSS library, I would have to add some custom CSS to make it look as it
did before.

The problem I faced was that I was unable to add every class for the markup elements that I needed. There
could be a solution that I didn't know about, but I didn't want to spend more time on it.
So I decided to choose a Hugo theme that would render the contents of the `content/_index.md` and call it a day.
I found a theme that I liked, you can check it in the footer :). After trying to set up my own layout, using a theme was
a breeze.

I started to think about where and how I could host my site. I knew about [Netlify](https://www.netlify.com/) but had never used
it, so I decided to give it a try. It was a very good call because the whole operation of setting up a GitHub repo and
deploying it with Netlify did not take even five minutes. I was really happy with the result, and the build integration
is great. I can check the preview from a pull request, and merging the PR will automatically deploy the site.

**That is super neat!**

## Some extra work!

I did overwrite some layouts, the most baffling one was the `render-link.html` markup element. The link target was not
`_blank` by default, and I'm deeply offended by that.

```docker-compose.yml
version: '3'

services:
  hugo:
    image: jakejarvis/hugo-extended:0.101.0
    ports:
      - 1313:1313
    volumes:
      - ./:/src
    command: server --buildDrafts --buildFuture --bind 0.0.0.0
```

It starts the hugo server on port 1313, and it also builds drafts and future posts.

## Monitoring

I wanted to try [UptimeRobot](https://uptimerobot.com/) which has a free tier with 5-minute checks for 50 monitors,
which is very generous. I'm happy to report that Netlify is quite stable and I did not have any downtime in the last 60
days. Not too surprising, but still nice to know.

## Conclusion

I'm really satisfied with the result, it's easy to change, and I'm happy that I learned a bit of hugo.

+++
date = '2026-07-10T10:40:53Z'
draft = false
title = 'Semantic Searches Against Codebase'
+++

A local model and a vector database goes in to the bar and the bartender asks, _"How do we construct the authorization rules for an admin user?"_.

<!--more-->

In the past month I was experimenting on setting up a local LLM workflow, which is for now is quite a [bust](https://github.com/hrvthzslt/lllm-playground), but there was one tool that I kept, and still using it. It accepts questions like the one before, and it will provide a list of code positions that are relevant to the question.

This tool is called **grepai**, which you would assume is pronounced like _"grep AI"_, but since it is not written like that, it must be pronounced like _"gre-pai"_ _(Arrigato, senpai)_.

It can build a local **vector database** with the help of an **embedding model**, both can be local, and I indeed keep them local. There would be good cases to build a shared database for a lot of codebases, but for now, I set it up per project. (I mean i did build a shared one, once, took 3 hours to build, and I never used it...).

This **vector database** will be queried by a CLI tool that you will conjure with the following keyword in your interactive terminal session: `grepai`. Huge surprise!

But before usage it needs some setup. The local model can be run with **ollama**, so install it, however you want, I'm not your mother. Same goes for **grepai** itself.

```bash
grepai init
```

Running this command in the current path, which path should be your project root, will ask embedding provider, aka the tool running the model and a storage backend, aka the vector database. I use **ollama** and **gob** which will store the database in a local file.

```bash
grepai watch
```

This command builds the database and keeps it up to date with the changes in the codebase. If you want to keep it up to date, this needs to be running.

```bash
grepai search 'where do we define the authorization rules for an admin user?'
grepai trace callers 'Login'
grepai trace callees 'Login'
```

And viola, we can use these commands to search our codebase, trace the callers and callees of a function.

![grepai sequence](grepai-sequence.png)

At this point you could ask, _"This is fine, but it does not feel like it is for me.", and it is not! Stand aside puny human, and let the robots do the work. Yes this tool it quite useful for agents. There are multiple way that **grepai** provides for agents, most notably a dedicated skill, and an mcp server. I personally use the skill, which details the usage of **grepai** and can be called with `/deep-explore`. The main thing is that you have to find a way to make the agent use the tool for code exploration.

As a final point, I started to use **grepai** because if the agent uses `grep` or `rg`, that would use more tokens, a semantic search possibly provides the correct answer in less calls. Altough this claim seems logical, I hove no evidence to support it, I use it because code discovery is faster with it.

Thank you for participating in this heroic hipster tale of a local LLM workflow, and I hope you find it useful.

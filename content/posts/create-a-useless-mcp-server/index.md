+++
date = '2026-07-29T10:22:24Z'
draft = false
title = 'Create a Useless MCP Server'
+++

Despite aiming to be productive, to reach the stars, we need to learn. And learning does not have to be productive.

So I created an MCP server to interface with my notes.

<!--more-->

Soon I will have to work on an MCP server with the holy power of Typescript. So the logical step is create a small scale project with the language I'm going to use. The important part is that I usually choose something shamefully simple and waste time on the experience and the details.

At this point I could write litanies about the technical details, but to be honest you can do it without my explanation. The cheatcode is: Do the example from the official documentation but with a change from the get go.

The [example server](https://modelcontextprotocol.io/docs/2026-07-28/develop/build-server) provides **tools** for agents for retrieving weather forecast data. I created **tools** that can read my notes.

The first tool is called `search_notes`, which reads. It goes trough every markdown file recursively searching for a match, it is horrible.

You think it would make more sense to let the agent `grep` whit a shell tool. You're right and you clearly did not pay attention at the beginning!

The other tool is called `read_note`, I don't know what more to say.

So this two tools will help the agent when I prompt "summarize my todo list from the last week". It can discover said tools when the MCP is connected and use them. Nice!

The whole thing is really similar to building any server, there is a communication protocol and some sort of routing, and you provide the implementations. For example if you would have multiple endpoints for statistics, you could create a tool that collects them in an aggregated manner, providing the important information only and saving context at the same time.

Fun things:

- When communicating through [stdio](https://modelcontextprotocol.io/specification/2025-06-18/basic/transports#stdio) `stdout` is an exclusive channel for transmitting JSON-RPC. So logging goes to `stderr`, how curious.
- There is user-friendly [Inspector](https://modelcontextprotocol.io/docs/2026-07-28/tools/inspector#npm-package), a good first step for trying out what you've cooked.
- The SDK has an [in-memory transport](https://csharp.sdk.modelcontextprotocol.io/v1/concepts/transports/transports.html#in-memory-transport) implementation as well, which can be used for testing.

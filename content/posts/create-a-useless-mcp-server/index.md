+++
date = '2026-07-29T10:22:24Z'
draft = false
title = 'Create a Useless MCP Server'
+++

Despite aiming to be productive, to reach the stars, we need to learn. And learning does not have to be productive.

So I created an MCP server to interface with my notes.

<!--more-->

Soon I will have to work on an MCP server with the holy power of TypeScript. So the logical step is to create a small-scale project with the language I'm going to use. The important part is that I usually choose something shamefully simple and waste time on the experience and the details.

At this point I could write litanies about the technical details, but to be honest, you can do it without my explanation. The cheat code is: do the example from the official documentation, but with a change from the get-go.

The [example server](https://modelcontextprotocol.io/docs/2026-07-28/develop/build-server) provides **tools** for agents to retrieve weather forecast data. I created **tools** that can read my notes.

The first tool is called `search_notes`. It goes through every Markdown file recursively, searching for a match. It is horrible.

You might think it would make more sense to let the agent `grep` with a shell tool. You're right, and you clearly did not pay attention at the beginning!

The other tool is called `read_note`. I don't know what more to say.

So these two tools will help the agent when I prompt, "summarize my todo list from the last week". It can discover the tools exposed by the connected MCP server and invoke them when appropriate. Nice!

The whole thing is similar to building any server: there is a communication protocol, request handlers, and you provide the implementations. For example, if your application exposed multiple APIs for statistics, you could create a tool that collects them in an aggregated manner, providing only the important information and saving context at the same time.

Fun things:

- When communicating through [stdio](https://modelcontextprotocol.io/specification/2025-06-18/basic/transports#stdio), `stdout` is an exclusive channel for transmitting JSON-RPC. So logging goes to `stderr`. How curious.
- There is a user-friendly [Inspector](https://modelcontextprotocol.io/docs/2026-07-28/tools/inspector#npm-package), a good first step for trying out what you've cooked.
- The SDK has an [in-memory transport](https://csharp.sdk.modelcontextprotocol.io/v1/concepts/transports/transports.html#in-memory-transport) implementation as well, which can be used for testing.

Be brave and [witness the code](https://github.com/hrvthzslt/markdown-mcp)!

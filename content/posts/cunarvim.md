---
title: "Cunarvim"
date: 2023-05-01T17:03:49Z
draft: false
---

[Lunarvim](https://www.lunarvim.org/) is a collection of configurations that add IDE-like functions to Neovim. It's really helpful if you (and indeed I) don't have any experience with configuring Neovim.

<!--more-->

Another really nice thing about Lunarvim is that it uses a different folder, so it won't conflict with existing configurations.

Usually, I prefer to use containerized development environments, but I still prefer to install language toolchains locally. I like to keep them close. If something breaks in my own system, I want to fix it, not just build a new container.

All that said, creating a containerized Lunarvim setup is something I wanted to try, just to see how it would work. I wanted to see it as one independent delivered unit, which I can run anywhere.

## Cunarvim

Cunarvim is a containerized Lunarvim. Who would have thought?
It's a simple Dockerfile that installs Lunarvim and its essential and optional dependencies as well, but only for the base configuration. There is a chance that some language servers would need more dependencies. For example, Lunarvim comes with a plugin called Mason which makes LSP setup really easy, but for running phpactor (_a free PHP language server alternative to Intelephense_), this container would need PHP and Composer installed.

## The Dockerfile

```dockerfile
FROM alpine:3.17.3
```

The base is Alpine; it is lightweight and has somewhat fresh packages, which makes the remaining steps of this Dockerfile very comfortable.

```dockerfile
RUN apk add bash curl git lazygit \
    make cmake clang build-base \
    python3 py3-pip \
    npm nodejs \
    cargo \
    neovim

RUN apk update && apk upgrade
```

Here come the base dependencies, most of them self-explanatory. The `cmake clang build-base` triangulum gave me some grief, but it's needed for the `nvim-lspinstall` plugin. I found a thread where someone had the same problem and listed at least ten packages I needed. Fortunately, I shrank the list to these three. I don't exactly understand the reasons, but I'm very proud of myself.

There are some more dependencies, PATH export, and the installation of Lunarvim itself, but the next important step is the following:

```dockerfile
COPY config/config.lua /root/.config/lvim
```

I copied the base configuration to the git repo, and it will be copied when the image is built. This is how I can customize my configuration, and I can keep it in the git repo. This means every config change needs a new build, but that is, in fact, another version of the image, so I don't see a problem with that.

## Build and run

I just need to build and run this image, and I can use Lunarvim in a container. Building is as simple as: `docker build -t cunarvim .`. This command builds an image with the cunarvim tag.

The next step is to run it with `docker run -it --rm -v $(pwd):/project cunarvim`. This command is a bit more interesting; it runs the container and attaches the working directory as a volume. This way, I can edit files in the container. I would also add an alias to my `.bashrc` or `.zshrc` file:

```bash
alias cvim='docker run -it --rm -v $(pwd):/project cunarvim'
```

## Source

The source of this project is available on [GitHub](https://github.com/hrvthzslt/cunarvim). Check it out if you are interested in the details.

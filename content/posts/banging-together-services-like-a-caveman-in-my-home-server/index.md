+++
date = '2025-09-26T18:02:01Z'
draft = false
title = 'Banging Together Services Like a Caveman in My Home Server'
+++

Feeling lazy? **Portainer** is too hard to spell? Pick up your club and beat **Docker** until you have a Home Server.

<!--more-->

Last year I set up my home server ([bloody details here](/posts/installing-softwares-instead-of-developing-them-while-nuc-keeps-yelling-at-me)), mostly for **Jellyfin** and **Transmission** (and those two are definitely not related). They were defined in a single **compose yaml** and that was all. That setup is still basically the same, but I made some minor changes for more satisfaction.

In the future I plan to define every service that I would like to run on my Home Server (or Servers) in this **compose yaml**. So, **modularity** is preferred. For my utmost pleasure, **profiles** can be defined in the **compose** file. I give two **profiles** for every service: the first is its name, and the second is its purpose, so by purpose, multiple services can be grouped.

```shell
docker compose --profile media up -d --remove-orphans
```

Above is an example for starting all services under the `media` profile in **detached** mode, while removing **containers** that are no longer defined in the **compose** file (or removing children without parents, I'm not sure).

I also contemplated using multiple **compose** files, but I want to stretch this setup as far as it's viable. Just for fun. Yes, this is fun.

Another issue I wanted to resolve was that all the **volumes** were in different places, so backing them up would have been a pain. Now, all **volumes** are collected under `/docker/volumes/`.

A simplified example:

```yml
services:
  jellyfin:
    image: lscr.io/linuxserver/jellyfin:10.10.7
    container_name: jellyfin
    volumes:
      - /docker/volumes/jellyfin/config:/config
      - /docker/volumes/media:/data/media
    ports:
      - 8096:8096
    profiles:
      - jellyfin
      - media
  transmission:
    image: lscr.io/linuxserver/transmission:4.0.6
    container_name: transmission
    env_file: .env
    volumes:
      - /docker/volumes/transmission/config:/config
      - /docker/volumes/media:/downloads/complete
      - /docker/volumes/pending:/downloads/incomplete
    ports:
      - 9091:9091
      - 51413:51413/udp
    profiles:
      - transmission
      - media
```

I also had to move the old volumes to the new place. Moving multiple hundreds of gigabytes of data can be time consuming, so I highly recommend **rsync** in these cases. It's usually used for copying between machines, but it's great for local copying as well. It's faster, can be resumed, and has really nice output if you want to stare at characters on a computer screen for 20 minutes. (I don't know how long it took, I left the computer and went outside. You should try it.)

And of course, a party is not a party without a **Makefile**, so I collected the commonly used commands into one. In this example, the **start** target can run with or without the **profile** argument: `make start` or `make start profile=media`, so only the desired services will start.

```shell
ifeq ($(DC_EXITS),0)
    DOCKER_COMPOSE = docker compose
else
    DOCKER_COMPOSE = docker-compose
endif

start:
    @if [ ! -f .env ]; then \
        echo "ERROR: .env file not found. Check .env.example"; \
        exit 1; \
    fi

    @if [ -z "$(profile)" ]; then \
        $(DOCKER_COMPOSE) --profile "*" up -d --remove-orphans; \
    else \
        $(DOCKER_COMPOSE) --profile "$(profile)" up -d --remove-orphans; \
    fi
```

So that's all, easy peasy. Thank you for reading this ode to primitivity. And I don't know why I'm still considering `docker-compose`, it's not the 15th century...

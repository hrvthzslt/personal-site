+++
date = '2025-09-26T18:02:01Z'
draft = false
title = 'Banging Together Services Like a Caveman in My Home Server'
+++

Feeling lazy? **Portainer** is to hard to spell? Pick up you club and beat **Docker** until you have a Home Server.

<!--more-->

Last year I set up my home server ([bloody details here](/posts/installing-softwares-instead-of-developing-them-while-nuc-keeps-yelling-at-me)) for mostly **Jellyfin** and **Transmission**, and those two are definitely not related. They were defined in one **compose yaml** and that is all. And that is still the same but I made some minor changes for more satisfaction.

In the future I plan to define every service that I would like to run or my Home Server or Servers. So **modularity** would be preferred. For my utmost pleasure, **profiles** can be defined in the **compose** file. So I give two **profiles** for every service, the first its name and second is its purpose, so by purpose multiple services can be grouped.

```shell
docker compose --profile media up -d --remove-orphans
```

Above, an example for starting all services under the `media` profile in **detached** mode. While removing **containers** that are no longer defined in the **compose** file _or_ removing children without parents, I'm not sure.

I also contemplated using multiple **compose** files, but I want to stretch this until it's viable. Just for fun. Yes, this is fun.

Another issue I wanted to resolve is that all the **volumes** were in different places, so backing them up would have been a pain. So all **volumes** will be collected under `/docker/volumes/`.

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

I also had to move the old volumes to the new place. Moving multiple hundreds of gigabyte of data can be time consuming, so I highly recommend in this cases **rsync**, it usually used for copying between machines, but it can be nice for local copying as well. It is faster, can be continued, and has really nice output if you want to stare at characters on a computer screen for 20 minutes. (I don't know how long it took, I left the computer and went outside, you should try it.)

And of course a party is not party without a **Makefile** so I collected the commonly used commands in one. In this example the **start** target can run with or without the **profile** argument: `make start` or `make start profile=media`, so only the desired services will start.

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

So that is all, easy peasy. Thank you for reading this ode to primitivity. And I don't know why am I still considering `docker-compose` its not the 15th century...

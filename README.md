# Personal site for my personal interests.

Personal site for my **resume** and **blog** posts with questionable quality, about my ...personal interests. Created with **Hugo** and **beautifulhugo** theme, hosted on **Netfily**.

[https://zsolthorvath.xyz/](https://zsolthorvath.xyz/).

If you want to know it about more this [post](https://zsolthorvath.xyz/posts/making-of-the-site/) will tell the story of how I made it.

## Setup for development

```shell
make start
```

Or you can do the steps manually:

Initialize submodule for the _beautifulhugo_ theme

```shell
git submodule update --init --recursive
```

Start hugo server for development

```shell
docker compose up -d
```

## Stop development container

```shell
make stop
```

## Observe logs

```shell
make log
```

## Create new post

```shell
make create-post
```

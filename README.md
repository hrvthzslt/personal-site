# Personal site for my personal interests.

This is the source of my personal website which is hosted
on [https://zsolthorvath.xyz/](https://zsolthorvath.xyz/).
If you want to know it about more this [post](https://zsolthorvath.xyz/posts/making-of-the-site/) will tell the
story of how I made it.

## Setup for development

```shell
make start
```

Or you can do the steps manually:

Initialize submodule for the *beautifulhugo* theme

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

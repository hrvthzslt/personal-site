# Personal site for my personal interests.

This is the source of my personal website which is hosted
on [https://zsolthorvath.netlify.com/](https://zsolthorvath.netlify.com/).
If you want to know it about more this [post](https://zsolthorvath.netlify.app/posts/making-of-the-site/) will tell the
story of how I made it.

## Setup for development

Run start-dev.sh to start the development server.

```shell
./start-dev.sh
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

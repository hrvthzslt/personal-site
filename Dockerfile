FROM debian:bookworm

RUN apt-get update && apt-get -y install wget

RUN wget -O /tmp/hugo.deb https://github.com/gohugoio/hugo/releases/download/v0.147.9/hugo_0.147.9_linux-amd64.deb \
    && apt install -y ./tmp/hugo.deb

WORKDIR /homepage

EXPOSE 1313

CMD ["hugo", "server", "--buildDrafts", "--buildFuture", "--bind", "0.0.0.0"]

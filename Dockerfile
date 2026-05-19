FROM ubuntu:noble

RUN apt-get update && apt-get -y install wget

ARG HUGO_VERSION=0.161.1

RUN arch="$(dpkg --print-architecture)" \
    && wget -O /tmp/hugo.deb "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_linux-${arch}.deb" \
    && apt install -y /tmp/hugo.deb

WORKDIR /homepage

EXPOSE 1313

CMD ["hugo", "server", "--buildDrafts", "--buildFuture", "--bind", "0.0.0.0"]

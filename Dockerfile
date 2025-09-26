FROM debian:trixie

RUN apt-get update && apt-get -y install wget

RUN arch="$(dpkg --print-architecture)" \
    && wget -O /tmp/hugo.deb "https://github.com/gohugoio/hugo/releases/download/v0.150.1/hugo_0.150.1_linux-${arch}.deb" \
    && apt install -y /tmp/hugo.deb

WORKDIR /homepage

EXPOSE 1313

CMD ["hugo", "server", "--buildDrafts", "--buildFuture", "--bind", "0.0.0.0"]

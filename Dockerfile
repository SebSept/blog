ARG GO_VERSION="1.20"
ARG NODE_VERSION="18"
ARG HUGO_VERSION="0.115.4"

FROM busybox AS hugo
WORKDIR /tmp/
ARG HUGO_VERSION
RUN wget "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz"
RUN tar xf "hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz"
# l'interet de faire 2 build est limité mais bon, j'ai expérimenté.

FROM golang:${GO_VERSION}-bullseye AS final-image
ARG NODE_VERSION

RUN apt update -y
RUN apt install tar gzip build-essential -y
RUN set -uex; \
    apt-get update; \
    apt-get install -y ca-certificates curl gnupg; \
    mkdir -p /etc/apt/keyrings; \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
     | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg; \
    NODE_MAJOR=$NODE_VERSION; \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_VERSION.x nodistro main" \
     > /etc/apt/sources.list.d/nodesource.list; \
    apt-get -qy update; \
    apt-get -qy install nodejs;
RUN npm i -g yarn pnpm

# pour lancer les commandes avec user qui génère des fichiers écrivable sur le host.
# eg : docker exec -u seb -it blog-hugo-1 hugo new note/2023-11-09/nimp5.md
RUN groupadd seb -g 1000
RUN useradd seb -u 1000 -g 1000 -s /bin/bash

COPY --from=hugo /tmp/hugo /usr/bin/hugo
WORKDIR /home/app
# USER seb
ENTRYPOINT [ "hugo", "serve", "--bind", "0.0.0.0", "-p", "1313", "-D", "1>", "/dev/null", "&", "hugo", "--watch" ]
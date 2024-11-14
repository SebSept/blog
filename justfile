docker := "docker compose exec -w /home/node/ astro-node "
sh := "docker compose exec -w /home/node/ astro-node /bin/sh "
npx := "docker compose exec -w /home/node/ astro-node npx "
yarn := docker + " yarn"

start:
	docker compose up --detach --remove-orphans

shell:
    {{docker}} /bin/bash

dev: start
    {{yarn}}  dev

preview:
    {{yarn}}  preview

build:
    {{yarn}}  build

lint:
    {{yarn}}  format
    {{yarn}}  eslint

fixrights:
    sudo chown -R seb:seb .
    sudo chmod u+w . -R

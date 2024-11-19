docker := "docker compose exec -w /home/node/ astro-node "
sh := "docker compose exec -w /home/node/ astro-node /bin/sh "
npx := "docker compose exec -w /home/node/ astro-node npx "
yarn := docker + " yarn"

# docker up
start:
	docker compose up --detach --remove-orphans

shell:
    {{docker}} /bin/bash

# serveur local de dev
dev: start
    {{yarn}} dev

preview:
    {{yarn}} preview

build:
    {{yarn}} build
    sudo cp .htaccess ./dist

lint:
    {{yarn}} format
    {{yarn}} eslint

# git push
push:
	git push origin

# mise en ligne
publish:
    rsync --recursive --compress --delete dist/ dev.seb7.fr:/var/www/seb7.fr/blog
    firefox https://blog.seb7.fr

fixrights:
    sudo chown -R seb:seb .
    sudo chmod u+w . -R

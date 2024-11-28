docker := "docker compose exec -w /home/node/ astro-node "
yarn := docker + " yarn"

# docker up
start:
	docker compose up --detach --remove-orphans

shell: start
    {{docker}} /bin/bash

# serveur local de dev
dev: start
    {{yarn}} dev

preview: start
    {{yarn}} preview

build: start
    {{yarn}} build

check: start
    {{yarn}} astro check

lint:
    {{yarn}} format
    {{yarn}} eslint

# git push
push:
	git push origin

#git pull
update:
    git pull --merge
    # appel du script start
    just start
    {{yarn}} install

# build + mise en ligne
publish: build
    rsync --recursive --compress --delete dist/ dev.seb7.fr:/var/www/seb7.fr/blog
    firefox https://blog.seb7.fr

fixrights:
    sudo chown -R seb:seb .
    sudo chmod u+w . -R

.PHONY: serve new_note new_post git_push publish stop_serve list_notes

help:
	# Commandes
	# make git_pull
	# make new_post : création d'un nouveau post
	# make new_note : création d'une nouvelle note
	# make git_push: pousser sur github
	# make git_add_and_push: versionner, pousser sur github, suivi de publish normalement
	# make serve : afficher le blog : lance le serveur local et ouvre firefox
	# make publish : rsync sur blog.seb7.fr
	# make list_notes : liste les notes par date de récence (url)

serve:
	docker compose -f compose_serve.yml up --detach
	firefox http://localhost:1313/

new_post:
	docker ps | grep blog_hugo || docker compose -f compose_serve.yml up --detach
	@read -p "Titre du nouveau post : " title;\
	DIR="post/"$$(date +"%Y-%m-%d");\
	SLUG=$$title;\
	SLUG=$$(echo "$$title" | sed -e 's/[^[:alnum:]]/-/g' | tr -s '-' | tr A-Z a-z); \
	FULL_PATH="$${DIR}/$${SLUG}.md";\
	docker exec -it blog_hugo hugo new "$$FULL_PATH"; \
	docker exec -it blog_hugo chown 1000:1000 -R "/home/app/content"; \
	vim "content/$${FULL_PATH}";
#	vim (fd $${SLUG})

new_note:
	docker ps | grep blog_hugo || docker compose -f compose_serve.yml up --detach
	@read -p "Titre de la nouvelle note : " title;\
	DIR="note/"$$(date +"%Y-%m-%d");\
	SLUG=$$title;\
	SLUG=$$(echo "$$title" | sed -e 's/[^[:alnum:]]/-/g' | tr -s '-' | tr A-Z a-z); \
	FULL_PATH="$${DIR}/$${SLUG}.md";\
	docker exec -it blog_hugo hugo new "$$FULL_PATH"; \
	docker exec -it blog_hugo chown 1000:1000 -R "/home/app/content"; \
	vim "content/$${FULL_PATH}";
	# build & serve
	docker compose -f compose_build.yml up
	docker compose -f compose_serve.yml up --detach

git_add_and_push:
	git add .
	git status
	@read -p "message du commit : " message;\
	git commit -m "$$message"
	git push github

git_push:
	git push github

publish:
	docker compose -f compose_build.yml up
	rsync --recursive --compress --delete public/ dev.seb7.fr:/var/www/seb7.fr/blog
	firefox https://blog.seb7.fr

stop_serve:
	docker stop blog_hugo

git_pull:
	git pull github --rebase

list_notes:
	fd --type file --search-path content/note/ --extension md  |  sort --reverse
